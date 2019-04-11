Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52160C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1112146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnW9svk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDKQsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:48:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36558 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKQsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:48:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so8291380wrd.3;
        Thu, 11 Apr 2019 09:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y1bNEQrFPt2iL/+wZ3D8SG7GZHY85BQUTeJ4wL0X56k=;
        b=AnW9svk+wmqET+tBsqHW5UYF2W01dQg4V+XZ6zoAKW7XaD7k9VxPBpqsvpjVZqP1gM
         QiZYcplca7Ruxm/6viZ23Seeru8YCExFD/EbMgRovWw4CkselSTNUeMo9VbSvbHjdOKD
         RcSaWZBmyNM6X8wEGDKrT/kiA13EuAs7OiV1fE7TIKLSeMjfU5K56kBilk0SCBlfetxO
         FjuQQLkEZPOj8QEFQ8R7cutYDhN/eUxGkidb831m0/oz5viCm+ADoi5Ab+K0Bf2PixhH
         h4C3Dl/x93p7NgmW7KTDxFgoSUuqNij7X54pW5yUO0Bgie6FcvV3u4d/4W5kGBUV4PeI
         yGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=y1bNEQrFPt2iL/+wZ3D8SG7GZHY85BQUTeJ4wL0X56k=;
        b=mRxiZbfbTwHaSISdxkVwrOeXZ+1/uFu+bBmJ9w6jVzV9USJf6P4hgbO3i1r21Tbo/u
         DDXpqfDQ//v4iP5/2sA9nPvZjY0m1EyEJDvDAu38gK7Q8MRHF42IA3R5Zg0u7+lKptp8
         qlicUDiDJ5z8CnuOfmA82R7eAQJLzMEztev/kcjsxdio5gh1k20FO7aUWjIR49QQ8jJT
         2ql9pXq2kMjtRsVNbhmZIOVu8D5v6E86yYeVRWGugYZQO4e3HePx7BtohNklIx/0zJKb
         ooI9E8m+E2Q6CkbceKF06gtxioL0LoqTrt/6yShM4V3wOQPVYX62pph8Muv2Cw8mSZz5
         htMQ==
X-Gm-Message-State: APjAAAXv2GrMraT6f7NKJOZ4+7L6X3bMVX9GAscP2XN+MtT0n5OzvmVG
        dClZ1FSMzUAkxhVpvIq01838Adzy
X-Google-Smtp-Source: APXvYqx/5BGwNEjPXnJigabp0FQH4k41cByxCbWs99fGEqQnZPtYXhOK5N1Org0Hsa3WOMlpEh3qig==
X-Received: by 2002:adf:d84d:: with SMTP id k13mr32177917wrl.154.1555001312946;
        Thu, 11 Apr 2019 09:48:32 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f10sm46386134wrs.17.2019.04.11.09.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:48:32 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 3/3] selftests: kvm: add a selftest for SMM
Date:   Thu, 11 Apr 2019 18:48:28 +0200
Message-Id: <1555001308-36016-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555001308-36016-1-git-send-email-pbonzini@redhat.com>
References: <1555001308-36016-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Add a simple test for SMM, based on VMX.  The test implements its own
sync between the guest and the host as using our ucall library seems to
be too cumbersome: SMI handler is happening in real-address mode.

This patch also fixes KVM_SET_NESTED_STATE to happen after
KVM_SET_VCPU_EVENTS, in fact it places it last.  This is because
KVM needs to know whether the processor is in SMM or not.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile               |   1 +
 .../selftests/kvm/include/x86_64/processor.h       |  27 ++++
 tools/testing/selftests/kvm/lib/x86_64/processor.c |  12 +-
 tools/testing/selftests/kvm/x86_64/smm_test.c      | 157 +++++++++++++++++++++
 4 files changed, 191 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/smm_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 2d2e10b219d5..f8588cca2bef 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -19,6 +19,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/state_test
 TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_close_while_nested_test
+TEST_GEN_PROGS_x86_64 += x86_64/smm_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index e2884c2b81ff..6063d5b2f356 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -778,6 +778,33 @@ void vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index,
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
 #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
 
+#define APIC_BASE_MSR	0x800
+#define X2APIC_ENABLE	(1UL << 10)
+#define	APIC_ICR	0x300
+#define		APIC_DEST_SELF		0x40000
+#define		APIC_DEST_ALLINC	0x80000
+#define		APIC_DEST_ALLBUT	0xC0000
+#define		APIC_ICR_RR_MASK	0x30000
+#define		APIC_ICR_RR_INVALID	0x00000
+#define		APIC_ICR_RR_INPROG	0x10000
+#define		APIC_ICR_RR_VALID	0x20000
+#define		APIC_INT_LEVELTRIG	0x08000
+#define		APIC_INT_ASSERT		0x04000
+#define		APIC_ICR_BUSY		0x01000
+#define		APIC_DEST_LOGICAL	0x00800
+#define		APIC_DEST_PHYSICAL	0x00000
+#define		APIC_DM_FIXED		0x00000
+#define		APIC_DM_FIXED_MASK	0x00700
+#define		APIC_DM_LOWEST		0x00100
+#define		APIC_DM_SMI		0x00200
+#define		APIC_DM_REMRD		0x00300
+#define		APIC_DM_NMI		0x00400
+#define		APIC_DM_INIT		0x00500
+#define		APIC_DM_STARTUP		0x00600
+#define		APIC_DM_EXTINT		0x00700
+#define		APIC_VECTOR_MASK	0x000FF
+#define	APIC_ICR2	0x310
+
 #define MSR_IA32_TSCDEADLINE		0x000006e0
 
 #define MSR_IA32_UCODE_WRITE		0x00000079
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index b363c9611bd6..dc7fae9fa424 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1101,12 +1101,6 @@ void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_x86_state *s
 	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
 	int r;
 
-	if (state->nested.size) {
-		r = ioctl(vcpu->fd, KVM_SET_NESTED_STATE, &state->nested);
-		TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_NESTED_STATE, r: %i",
-			r);
-	}
-
 	r = ioctl(vcpu->fd, KVM_SET_XSAVE, &state->xsave);
         TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_XSAVE, r: %i",
                 r);
@@ -1138,4 +1132,10 @@ void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_x86_state *s
 	r = ioctl(vcpu->fd, KVM_SET_REGS, &state->regs);
         TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_REGS, r: %i",
                 r);
+
+	if (state->nested.size) {
+		r = ioctl(vcpu->fd, KVM_SET_NESTED_STATE, &state->nested);
+		TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_NESTED_STATE, r: %i",
+			r);
+	}
 }
diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
new file mode 100644
index 000000000000..436227c2ea39
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018, Red Hat, Inc.
+ *
+ * Tests for SMM.
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+
+#include "vmx.h"
+
+#define VCPU_ID	      1
+
+#define PAGE_SIZE  4096
+
+#define SMRAM_SIZE 65536
+#define SMRAM_MEMSLOT ((1 << 16) | 1)
+#define SMRAM_PAGES (SMRAM_SIZE / PAGE_SIZE)
+#define SMRAM_GPA 0x1000000
+#define SMRAM_STAGE 0xfe
+
+#define STR(x) #x
+#define XSTR(s) STR(s)
+
+#define SYNC_PORT 0xe
+#define DONE 0xff
+
+/*
+ * This is compiled as normal 64-bit code, however, SMI handler is executed
+ * in real-address mode. To stay simple we're limiting ourselves to a mode
+ * independent subset of asm here.
+ * SMI handler always report back fixed stage SMRAM_STAGE.
+ */
+uint8_t smi_handler[] = {
+	0xb0, SMRAM_STAGE,    /* mov $SMRAM_STAGE, %al */
+	0xe4, SYNC_PORT,      /* in $SYNC_PORT, %al */
+	0x0f, 0xaa,           /* rsm */
+};
+
+void sync_with_host(uint64_t phase)
+{
+	asm volatile("in $" XSTR(SYNC_PORT)", %%al \n"
+		     : : "a" (phase));
+}
+
+void self_smi(void)
+{
+	wrmsr(APIC_BASE_MSR + (APIC_ICR >> 4),
+	      APIC_DEST_SELF | APIC_INT_ASSERT | APIC_DM_SMI);
+}
+
+void guest_code(struct vmx_pages *vmx_pages)
+{
+	uint64_t apicbase = rdmsr(MSR_IA32_APICBASE);
+
+	sync_with_host(1);
+
+	wrmsr(MSR_IA32_APICBASE, apicbase | X2APIC_ENABLE);
+
+	sync_with_host(2);
+
+	self_smi();
+
+	sync_with_host(4);
+
+	if (vmx_pages) {
+		GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+
+		sync_with_host(5);
+
+		self_smi();
+
+		sync_with_host(7);
+	}
+
+	sync_with_host(DONE);
+}
+
+int main(int argc, char *argv[])
+{
+	struct vmx_pages *vmx_pages = NULL;
+	vm_vaddr_t vmx_pages_gva = 0;
+
+	struct kvm_regs regs;
+	struct kvm_vm *vm;
+	struct kvm_run *run;
+	struct kvm_x86_state *state;
+	int stage, stage_reported;
+
+	/* Create VM */
+	vm = vm_create_default(VCPU_ID, 0, guest_code);
+
+	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+
+	run = vcpu_state(vm, VCPU_ID);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, SMRAM_GPA,
+				    SMRAM_MEMSLOT, SMRAM_PAGES, 0);
+	TEST_ASSERT(vm_phy_pages_alloc(vm, SMRAM_PAGES, SMRAM_GPA, SMRAM_MEMSLOT)
+		    == SMRAM_GPA, "could not allocate guest physical addresses?");
+
+	memset(addr_gpa2hva(vm, SMRAM_GPA), 0x0, SMRAM_SIZE);
+	memcpy(addr_gpa2hva(vm, SMRAM_GPA) + 0x8000, smi_handler,
+	       sizeof(smi_handler));
+
+	vcpu_set_msr(vm, VCPU_ID, MSR_IA32_SMBASE, SMRAM_GPA);
+
+	if (kvm_check_cap(KVM_CAP_NESTED_STATE)) {
+		vmx_pages = vcpu_alloc_vmx(vm, &vmx_pages_gva);
+		vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
+	} else {
+		printf("will skip SMM test with VMX enabled\n");
+		vcpu_args_set(vm, VCPU_ID, 1, 0);
+	}
+
+	for (stage = 1;; stage++) {
+		_vcpu_run(vm, VCPU_ID);
+		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+			    "Stage %d: unexpected exit reason: %u (%s),\n",
+			    stage, run->exit_reason,
+			    exit_reason_str(run->exit_reason));
+
+		memset(&regs, 0, sizeof(regs));
+		vcpu_regs_get(vm, VCPU_ID, &regs);
+
+		stage_reported = regs.rax & 0xff;
+
+		if (stage_reported == DONE)
+			goto done;
+
+		TEST_ASSERT(stage_reported == stage ||
+			    stage_reported == SMRAM_STAGE,
+			    "Unexpected stage: #%x, got %x",
+			    stage, stage_reported);
+
+		state = vcpu_save_state(vm, VCPU_ID);
+		kvm_vm_release(vm);
+		kvm_vm_restart(vm, O_RDWR);
+		vm_vcpu_add(vm, VCPU_ID, 0, 0);
+		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+		vcpu_load_state(vm, VCPU_ID, state);
+		run = vcpu_state(vm, VCPU_ID);
+		free(state);
+	}
+
+done:
+	kvm_vm_free(vm);
+}
-- 
1.8.3.1

