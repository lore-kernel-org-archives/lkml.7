Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87273C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537132146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX5FR+Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDKQsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:48:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38865 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfDKQsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:48:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so8276971wro.5;
        Thu, 11 Apr 2019 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4I9ht2ugAVMxxvYhXxwgiVyrNJB/MGjea8ueig4ihEY=;
        b=AX5FR+ZkCDxlrpLIKYg419nFx9z9NGBpxvUr+tIXRu0/43rqHxBLLqs7s/XU1oevoW
         MHFCdqiR1Xv2mR7uiUzFkP0aan2y9FwHi4Dc/IZgpDsJVgBgH6EtMSqPbftO5trpvpyj
         I/jZ1H23TcEfQM0ZfsjA9Znik3TemS02M9HPFNhdZ273y/MglXHP6op1REjZkytpFIB5
         1FUOqqFzPHl1vcpSjyWSNDcMmWjGFSo0KGpmJgggbsW2zjsGGAMre0qn86gS5ncrQ+jE
         aQ3ebkWvmMtuEfOGd43L15itLEPojlLIrK65PZH4DJRE7WtYFcPc2KQyFALnUZb+rETG
         rZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4I9ht2ugAVMxxvYhXxwgiVyrNJB/MGjea8ueig4ihEY=;
        b=ahTxOnFafLO4nr+DF2ai+UK27+iey+4OqSJSTkVs0wN5ir57pLy7zzJF+gcRFiH2ah
         AFoqUaNGt9nfnrtGYaB7OV2QbmkV+bOgIdfkPFZLBfjd1YHNJrZ51rxCGQuESkZX3PZ+
         khWruYVqJwxOTq4fmkYDSeKpDomfvhY3E5EbhcEJ+nFM9pt7562PItiZkNkTMgU360LJ
         2PIsiOquNSwlu1l9+UyrGTU3MdKa8hSCfOG6oytVro+fDKY/YpklEAGKeX/07ReDdOvZ
         KCnzX/8YCT6sSFgk38NdgZduml8HISUuRDUe7yLRSHDZwNwM3wYQpWBLVai8tUusL+Kl
         8WOg==
X-Gm-Message-State: APjAAAX3REycovE3v4+ME97sfI66IZidKgeVS51CYorITt+0pRSmjY3o
        rc0aZ0XO/xwFWh4L+Yl3gmLZCLqn
X-Google-Smtp-Source: APXvYqxUcxBzKf0KO4E5bv9kkpd7K3jIB943dGrhpda3JNGy7Yvm7i904BnA3Gc2G5wvhDJn5P1Iog==
X-Received: by 2002:adf:f78d:: with SMTP id q13mr31874402wrp.194.1555001310847;
        Thu, 11 Apr 2019 09:48:30 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f10sm46386134wrs.17.2019.04.11.09.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:48:30 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 1/3] selftests: kvm/evmcs_test: complete I/O before migrating guest state
Date:   Thu, 11 Apr 2019 18:48:26 +0200
Message-Id: <1555001308-36016-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555001308-36016-1-git-send-email-pbonzini@redhat.com>
References: <1555001308-36016-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting state migration after an IO exit without first completing IO
may result in test failures.  We already have two tests that need this
(this patch in fact fixes evmcs_test, similar to what was fixed for
state_test in commit 0f73bbc851ed, "KVM: selftests: complete IO before
migrating guest state", 2019-03-13) and a third is coming.  So, move the
code to vcpu_save_state, and while at it do not access register state
until after I/O is complete.
---
 tools/testing/selftests/kvm/lib/kvm_util.c         |  5 +++++
 tools/testing/selftests/kvm/lib/x86_64/processor.c |  8 ++++++++
 tools/testing/selftests/kvm/x86_64/evmcs_test.c    |  5 +++--
 tools/testing/selftests/kvm/x86_64/state_test.c    | 15 +--------------
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index efa0aad8b3c6..4ca96b228e46 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -91,6 +91,11 @@ static void vm_open(struct kvm_vm *vm, int perm, unsigned long type)
 	if (vm->kvm_fd < 0)
 		exit(KSFT_SKIP);
 
+	if (!kvm_check_cap(KVM_CAP_IMMEDIATE_EXIT)) {
+		fprintf(stderr, "immediate_exit not available, skipping test\n");
+		exit(KSFT_SKIP);
+	}
+
 	vm->fd = ioctl(vm->kvm_fd, KVM_CREATE_VM, type);
 	TEST_ASSERT(vm->fd >= 0, "KVM_CREATE_VM ioctl failed, "
 		"rc: %i errno: %i", vm->fd, errno);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index f28127f4a3af..b363c9611bd6 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1030,6 +1030,14 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
 			    nested_size, sizeof(state->nested_));
 	}
 
+	/*
+	 * When KVM exits to userspace with KVM_EXIT_IO, KVM guarantees
+	 * guest state is consistent only after userspace re-enters the
+	 * kernel with KVM_RUN.  Complete IO prior to migrating state
+	 * to a new VM.
+	 */
+	vcpu_run_complete_io(vm, vcpuid);
+
 	nmsrs = kvm_get_num_msrs(vm);
 	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
 	list->nmsrs = nmsrs;
diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index c49c2a28b0eb..36669684eca5 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -123,8 +123,6 @@ int main(int argc, char *argv[])
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		memset(&regs1, 0, sizeof(regs1));
-		vcpu_regs_get(vm, VCPU_ID, &regs1);
 		switch (get_ucall(vm, VCPU_ID, &uc)) {
 		case UCALL_ABORT:
 			TEST_ASSERT(false, "%s at %s:%d", (const char *)uc.args[0],
@@ -144,6 +142,9 @@ int main(int argc, char *argv[])
 			    stage, (ulong)uc.args[1]);
 
 		state = vcpu_save_state(vm, VCPU_ID);
+		memset(&regs1, 0, sizeof(regs1));
+		vcpu_regs_get(vm, VCPU_ID, &regs1);
+
 		kvm_vm_release(vm);
 
 		/* Restore state in a new VM.  */
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index 30f75856cf39..e0a3c0204b7c 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -134,11 +134,6 @@ int main(int argc, char *argv[])
 
 	struct kvm_cpuid_entry2 *entry = kvm_get_supported_cpuid_entry(1);
 
-	if (!kvm_check_cap(KVM_CAP_IMMEDIATE_EXIT)) {
-		fprintf(stderr, "immediate_exit not available, skipping test\n");
-		exit(KSFT_SKIP);
-	}
-
 	/* Create VM */
 	vm = vm_create_default(VCPU_ID, 0, guest_code);
 	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
@@ -179,18 +174,10 @@ int main(int argc, char *argv[])
 			    uc.args[1] == stage, "Unexpected register values vmexit #%lx, got %lx",
 			    stage, (ulong)uc.args[1]);
 
-		/*
-		 * When KVM exits to userspace with KVM_EXIT_IO, KVM guarantees
-		 * guest state is consistent only after userspace re-enters the
-		 * kernel with KVM_RUN.  Complete IO prior to migrating state
-		 * to a new VM.
-		 */
-		vcpu_run_complete_io(vm, VCPU_ID);
-
+		state = vcpu_save_state(vm, VCPU_ID);
 		memset(&regs1, 0, sizeof(regs1));
 		vcpu_regs_get(vm, VCPU_ID, &regs1);
 
-		state = vcpu_save_state(vm, VCPU_ID);
 		kvm_vm_release(vm);
 
 		/* Restore state in a new VM.  */
-- 
1.8.3.1


