Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDBCC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F14721920
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946919;
	bh=+ViCpTWVPKWPysN1s86/uNEgSImk78bymXGcG1jnfZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N8dP7GUe/a9P6zjYspQNyAxpksZ6v3NpXdsVxnNQ1y/s1lN9pzZJQBsmMLdvlv45q
	 j9aOXQzONqKTSpp07CTCfWIIkkbFTfij8aRCxceCuXk0TgA6AmtB55iBxkD05WZ/AZ
	 AHnuV11GC3mIuacj/DE/qek5f2NfXvx3aMIKSpdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfIHMsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731069AbfIHMsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:48:32 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7BB8218AC;
        Sun,  8 Sep 2019 12:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946912;
        bh=+ViCpTWVPKWPysN1s86/uNEgSImk78bymXGcG1jnfZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuyCT+X5jhO3KXJ0tc4TMOeCbKE9NSQBCHWuFnnUeKcXJQvg/dDYfIgnrHYZl5k2N
         ntyJsfsUT4FWn6BYUPJ9HVlYN1rRsw3ZMFjiEdlPIFlojwem8zwwWIGlu5d7Czt8B0
         q62X1rFdS4QY9OFgPkQvlXs45Sd6AfpFWptdntv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 48/57] selftests/kvm: make platform_info_test pass on AMD
Date:   Sun,  8 Sep 2019 13:42:12 +0100
Message-Id: <20190908121145.741948715@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121125.608195329@linuxfoundation.org>
References: <20190908121125.608195329@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e4427372398c31f57450565de277f861a4db5b3b ]

test_msr_platform_info_disabled() generates EXIT_SHUTDOWN but VMCB state
is undefined after that so an attempt to launch this guest again from
test_msr_platform_info_enabled() fails. Reorder the tests to make test
pass.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/platform_info_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/platform_info_test.c b/tools/testing/selftests/kvm/platform_info_test.c
index 3764e71212650..65db510dddc34 100644
--- a/tools/testing/selftests/kvm/platform_info_test.c
+++ b/tools/testing/selftests/kvm/platform_info_test.c
@@ -100,8 +100,8 @@ int main(int argc, char *argv[])
 	msr_platform_info = vcpu_get_msr(vm, VCPU_ID, MSR_PLATFORM_INFO);
 	vcpu_set_msr(vm, VCPU_ID, MSR_PLATFORM_INFO,
 		msr_platform_info | MSR_PLATFORM_INFO_MAX_TURBO_RATIO);
-	test_msr_platform_info_disabled(vm);
 	test_msr_platform_info_enabled(vm);
+	test_msr_platform_info_disabled(vm);
 	vcpu_set_msr(vm, VCPU_ID, MSR_PLATFORM_INFO, msr_platform_info);
 
 	kvm_vm_free(vm);
-- 
2.20.1



