Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65995C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F43321902
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962296;
	bh=qngFFHZ2SQ9w9v6kUVMUKUePoEZlcPSTmI8gIwu10zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MHtBRKCvOQ3YTTS1pMqU02OsknS+VuQDxjHGYat1Wu654w0yMMVv8geVWxddt/y0p
	 bGbl5AnKGziMzSW9E3Bjq6C6omApxK2MDjrmsBO1EytDDgbRvM873o5f13HKBtefeP
	 ftFb1HM9oanDBDQcQZ8uDitf3sNFpRZTO/K1ZiMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfDVToz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbfDVTox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6259A218B0;
        Mon, 22 Apr 2019 19:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962293;
        bh=qngFFHZ2SQ9w9v6kUVMUKUePoEZlcPSTmI8gIwu10zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1lV0EfZQ46WNCoAQSvXt3djLpwSivgRS+H98KJ7d9KntOSDs+0/KtBRrWqDjfAOP
         orajTDcjJx0WNg0hUIZqkWpmZ3jgzTg9JOqozo7TXcrbDUK0S4v8pmE+L1x4Pz8cHy
         2P80i/UwEvcugci3PNsp4fjycDWWNte5uNg9+n+Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 86/98] KVM: selftests: complete IO before migrating guest state
Date:   Mon, 22 Apr 2019 15:41:53 -0400
Message-Id: <20190422194205.10404-86-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

[ Upstream commit 0f73bbc851ed32d22bbd86be09e0365c460bcd2e ]

Documentation/virtual/kvm/api.txt states:

  NOTE: For KVM_EXIT_IO, KVM_EXIT_MMIO, KVM_EXIT_OSI, KVM_EXIT_PAPR and
        KVM_EXIT_EPR the corresponding operations are complete (and guest
        state is consistent) only after userspace has re-entered the
        kernel with KVM_RUN.  The kernel side will first finish incomplete
        operations and then check for pending signals.  Userspace can
        re-enter the guest with an unmasked signal pending to complete
        pending operations.

Because guest state may be inconsistent, starting state migration after
an IO exit without first completing IO may result in test failures, e.g.
a proposed change to KVM's handling of %rip in its fast PIO handling[1]
will cause the new VM, i.e. the post-migration VM, to have its %rip set
to the IN instruction that triggered KVM_EXIT_IO, leading to a test
assertion due to a stage mismatch.

For simplicitly, require KVM_CAP_IMMEDIATE_EXIT to complete IO and skip
the test if it's not available.  The addition of KVM_CAP_IMMEDIATE_EXIT
predates the state selftest by more than a year.

[1] https://patchwork.kernel.org/patch/10848545/

Fixes: fa3899add1056 ("kvm: selftests: add basic test for state save and restore")
Reported-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 tools/testing/selftests/kvm/include/kvm_util.h |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c     | 16 ++++++++++++++++
 .../testing/selftests/kvm/x86_64/state_test.c  | 18 ++++++++++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index a84785b02557..07b71ad9734a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -102,6 +102,7 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva);
 struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
 int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
+void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_set_mp_state(struct kvm_vm *vm, uint32_t vcpuid,
 		       struct kvm_mp_state *mp_state);
 void vcpu_regs_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_regs *regs);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b52cfdefecbf..efa0aad8b3c6 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1121,6 +1121,22 @@ int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
 	return rc;
 }
 
+void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	vcpu->state->immediate_exit = 1;
+	ret = ioctl(vcpu->fd, KVM_RUN, NULL);
+	vcpu->state->immediate_exit = 0;
+
+	TEST_ASSERT(ret == -1 && errno == EINTR,
+		    "KVM_RUN IOCTL didn't exit immediately, rc: %i, errno: %i",
+		    ret, errno);
+}
+
 /*
  * VM VCPU Set MP State
  *
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index 4b3f556265f1..30f75856cf39 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -134,6 +134,11 @@ int main(int argc, char *argv[])
 
 	struct kvm_cpuid_entry2 *entry = kvm_get_supported_cpuid_entry(1);
 
+	if (!kvm_check_cap(KVM_CAP_IMMEDIATE_EXIT)) {
+		fprintf(stderr, "immediate_exit not available, skipping test\n");
+		exit(KSFT_SKIP);
+	}
+
 	/* Create VM */
 	vm = vm_create_default(VCPU_ID, 0, guest_code);
 	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
@@ -156,8 +161,6 @@ int main(int argc, char *argv[])
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		memset(&regs1, 0, sizeof(regs1));
-		vcpu_regs_get(vm, VCPU_ID, &regs1);
 		switch (get_ucall(vm, VCPU_ID, &uc)) {
 		case UCALL_ABORT:
 			TEST_ASSERT(false, "%s at %s:%d", (const char *)uc.args[0],
@@ -176,6 +179,17 @@ int main(int argc, char *argv[])
 			    uc.args[1] == stage, "Unexpected register values vmexit #%lx, got %lx",
 			    stage, (ulong)uc.args[1]);
 
+		/*
+		 * When KVM exits to userspace with KVM_EXIT_IO, KVM guarantees
+		 * guest state is consistent only after userspace re-enters the
+		 * kernel with KVM_RUN.  Complete IO prior to migrating state
+		 * to a new VM.
+		 */
+		vcpu_run_complete_io(vm, VCPU_ID);
+
+		memset(&regs1, 0, sizeof(regs1));
+		vcpu_regs_get(vm, VCPU_ID, &regs1);
+
 		state = vcpu_save_state(vm, VCPU_ID);
 		kvm_vm_release(vm);
 
-- 
2.19.1

