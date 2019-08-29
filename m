Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECD3C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F532189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102613;
	bh=CKyadd5oos7cAu41Ww1xXGPEYoofd2Y6aSlkbogwEdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d7ZzY5O1Tg1v+dSCuut319Z1H4TWNopy9OQ02fsB7XNlpD2GzipsOd/D4wNORT30o
	 OGmL+E+W2MksXPK34xxbtJ92lWro0t+UgqYRQKurQNPh9X2zpEqnznCutorKuaFGAq
	 /x8tbwxL1O/c2EGbFWnKEcpM35OeklipPWV2GoT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfH2SQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729849AbfH2SQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:16:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C82C233FF;
        Thu, 29 Aug 2019 18:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102605;
        bh=CKyadd5oos7cAu41Ww1xXGPEYoofd2Y6aSlkbogwEdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYQ4dk5eT05jxY6+s7EM38VCbSC4aFkaMazh5GrR1hPXRVRTfNsdJ7eD9z7oHDqFF
         1eHcivQwrNqKv6pV3EBnPPrriOELy9rscZdi5A2B6gYihxjn7hCTXKTHcbWDZ0gV04
         nufM7pQYv+CUEweJcuBwC7QTXBq+tcbRUVM3Hz9g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 39/45] selftests/kvm: make platform_info_test pass on AMD
Date:   Thu, 29 Aug 2019 14:15:39 -0400
Message-Id: <20190829181547.8280-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181547.8280-1-sashal@kernel.org>
References: <20190829181547.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

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

