Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7767DC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4233221D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240043;
	bh=cJ6t2TafyczZEuNkVhNQTkIyWqNQmIOm7Mg0qAcJHPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=shRQX43dLFGyZdUn5uZBPSmt9wAB9d8olpKXgH1JIBe1OFyZNlmyJDmRzuVY3k36P
	 2/slctHZKwbDQSk5XrOL9y22VzRpUbLxOHwuRv6U/DnjxT55ZKAzDGvUm8ffjOdBBB
	 a91dHR4mDu1feNLbL/4T+Uv0ImBQynJrs/6WndSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390399AbfKHTHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:07:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391425AbfKHTHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:07:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B26A82196F;
        Fri,  8 Nov 2019 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240038;
        bh=cJ6t2TafyczZEuNkVhNQTkIyWqNQmIOm7Mg0qAcJHPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDcpwX1/OMflu4QwjK2r/vPvKeU2wZLAiSUJSqe42lJme5mNSReer6uzhiktKMEBN
         BXlq0BBr2BUxsRLLv7nBsd1fE8ruoQovWDsQZmMmVAsAl373tjakOIGaobRl2+3Sf+
         y6n1paAQ65zjlNIeIu9ycsdCwOebV5qdyFMGCtAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 065/140] selftests: kvm: vmx_set_nested_state_test: dont check for VMX support twice
Date:   Fri,  8 Nov 2019 19:49:53 +0100
Message-Id: <20191108174909.315506364@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 700c17d9cec8712f4091692488fb63e2680f7a5d ]

vmx_set_nested_state_test() checks if VMX is supported twice: in the very
beginning (and skips the whole test if it's not) and before doing
test_vmx_nested_state(). One should be enough.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/kvm/x86_64/vmx_set_nested_state_test.c       | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
index 853e370e8a394..a6d85614ae4d6 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
@@ -271,12 +271,7 @@ int main(int argc, char *argv[])
 	state.flags = KVM_STATE_NESTED_RUN_PENDING;
 	test_nested_state_expect_einval(vm, &state);
 
-	/*
-	 * TODO: When SVM support is added for KVM_SET_NESTED_STATE
-	 *       add tests here to support it like VMX.
-	 */
-	if (entry->ecx & CPUID_VMX)
-		test_vmx_nested_state(vm);
+	test_vmx_nested_state(vm);
 
 	kvm_vm_free(vm);
 	return 0;
-- 
2.20.1



