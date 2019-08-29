Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D12C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3212189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102453;
	bh=9J6tgIBdn5EzmWaOuyi4pYjxZ4aRUf4lrRb3sOcTqBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bjR5Jra/vMEQkhaSUcefdoIu58vG1BW5bDBkaxebSgjZ5ip3nzVfJx5qgVmYD+IAo
	 2iRQrIYajRMpCggLM2ER9w4C+cetf1vM5AmIxDklkk/dJCXrzuYoBBadFKakH7d4t+
	 lCjIoixhfQZpNz6EI2lPHnpEvT+95PDLftMaVY4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfH2SOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbfH2SOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:14:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB24233FF;
        Thu, 29 Aug 2019 18:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102448;
        bh=9J6tgIBdn5EzmWaOuyi4pYjxZ4aRUf4lrRb3sOcTqBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPCPXPvyCbnUgyqiPg/WW6t8FczwS0dAMtlEpjbzpbGRwU+bcycAm9NjWAX53dQwl
         HtwxhDgV3h36+BeqxTvYEbFqtAX3GIKpq3gm26XcVgl9W11cYgBd8KGFK9vtHt+257
         3L9Vr+8roDqU0R/nigzhy9Rtr55ouv3Kke/ZfDYQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 32/76] selftests: kvm: do not try running the VM in vmx_set_nested_state_test
Date:   Thu, 29 Aug 2019 14:12:27 -0400
Message-Id: <20190829181311.7562-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 92cd0f0be3d7adb63611c28693ec0399beded837 ]

This test is only covering various edge cases of the
KVM_SET_NESTED_STATE ioctl.  Running the VM does not really
add anything.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../kvm/x86_64/vmx_set_nested_state_test.c        | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
index ed7218d166da6..a99fc66dafeb6 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
@@ -27,22 +27,13 @@
 
 void test_nested_state(struct kvm_vm *vm, struct kvm_nested_state *state)
 {
-	volatile struct kvm_run *run;
-
 	vcpu_nested_state_set(vm, VCPU_ID, state, false);
-	run = vcpu_state(vm, VCPU_ID);
-	vcpu_run(vm, VCPU_ID);
-	TEST_ASSERT(run->exit_reason == KVM_EXIT_SHUTDOWN,
-		"Got exit_reason other than KVM_EXIT_SHUTDOWN: %u (%s),\n",
-		run->exit_reason,
-		exit_reason_str(run->exit_reason));
 }
 
 void test_nested_state_expect_errno(struct kvm_vm *vm,
 				    struct kvm_nested_state *state,
 				    int expected_errno)
 {
-	volatile struct kvm_run *run;
 	int rv;
 
 	rv = vcpu_nested_state_set(vm, VCPU_ID, state, true);
@@ -50,12 +41,6 @@ void test_nested_state_expect_errno(struct kvm_vm *vm,
 		"Expected %s (%d) from vcpu_nested_state_set but got rv: %i errno: %s (%d)",
 		strerror(expected_errno), expected_errno, rv, strerror(errno),
 		errno);
-	run = vcpu_state(vm, VCPU_ID);
-	vcpu_run(vm, VCPU_ID);
-	TEST_ASSERT(run->exit_reason == KVM_EXIT_SHUTDOWN,
-		"Got exit_reason other than KVM_EXIT_SHUTDOWN: %u (%s),\n",
-		run->exit_reason,
-		exit_reason_str(run->exit_reason));
 }
 
 void test_nested_state_expect_einval(struct kvm_vm *vm,
-- 
2.20.1

