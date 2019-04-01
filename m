Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C942C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E78B206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139142;
	bh=kEseISCP+yGsX1LPRod45qFdiySK380oQZjyMx/2lrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Il/OT+wpFsoayFOiFdLt5g9LgSebuDe95oNoeVb2F9Xu5sszJLe62jsmvzr4rbjjS
	 +dJwwXwUNo540087sPx7ZLPt8cssvpeMFxXYjG2fir6TkkunFUHeA7qQWgrwjJFzgu
	 +eP7QTonY3PoNelIOly0NAUoNnCk+rlDWyaBZHXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfDARTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730625AbfDARS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:18:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA13020883;
        Mon,  1 Apr 2019 17:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139138;
        bh=kEseISCP+yGsX1LPRod45qFdiySK380oQZjyMx/2lrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qfGbLkJf932Kv6u+nhmRyUk61BVUVfJeolbhKBwpV8eq1elUpPySfAgjkD5kM46iE
         KtyC/4K6UwUoBrpyKc1QjH3/tO4HABizwU4+RpWG2oyxG3Rsbhs3idqkFvFD+xgy4I
         7ZJYi3/NKUciegi/QQYghOe/fQBF/BQlN0lF971k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 125/134] KVM: x86: Emulate MSR_IA32_ARCH_CAPABILITIES on AMD hosts
Date:   Mon,  1 Apr 2019 19:02:41 +0200
Message-Id: <20190401170055.958446457@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 0cf9135b773bf32fba9dd8e6699c1b331ee4b749 upstream.

The CPUID flag ARCH_CAPABILITIES is unconditioinally exposed to host
userspace for all x86 hosts, i.e. KVM advertises ARCH_CAPABILITIES
regardless of hardware support under the pretense that KVM fully
emulates MSR_IA32_ARCH_CAPABILITIES.  Unfortunately, only VMX hosts
handle accesses to MSR_IA32_ARCH_CAPABILITIES (despite KVM_GET_MSRS
also reporting MSR_IA32_ARCH_CAPABILITIES for all hosts).

Move the MSR_IA32_ARCH_CAPABILITIES handling to common x86 code so
that it's emulated on AMD hosts.

Fixes: 1eaafe91a0df4 ("kvm: x86: IA32_ARCH_CAPABILITIES is always supported")
Cc: stable@vger.kernel.org
Reported-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/kvm_host.h |    1 +
 arch/x86/kvm/vmx.c              |   14 --------------
 arch/x86/kvm/x86.c              |   12 ++++++++++++
 3 files changed, 13 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -528,6 +528,7 @@ struct kvm_vcpu_arch {
 	bool tpr_access_reporting;
 	u64 ia32_xss;
 	u64 microcode_version;
+	u64 arch_capabilities;
 
 	/*
 	 * Paging state of the vcpu
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -970,7 +970,6 @@ struct vcpu_vmx {
 	u64 		      msr_guest_kernel_gs_base;
 #endif
 
-	u64 		      arch_capabilities;
 	u64 		      spec_ctrl;
 
 	u32 vm_entry_controls_shadow;
@@ -4104,12 +4103,6 @@ static int vmx_get_msr(struct kvm_vcpu *
 
 		msr_info->data = to_vmx(vcpu)->spec_ctrl;
 		break;
-	case MSR_IA32_ARCH_CAPABILITIES:
-		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
-			return 1;
-		msr_info->data = to_vmx(vcpu)->arch_capabilities;
-		break;
 	case MSR_IA32_SYSENTER_CS:
 		msr_info->data = vmcs_read32(GUEST_SYSENTER_CS);
 		break;
@@ -4271,11 +4264,6 @@ static int vmx_set_msr(struct kvm_vcpu *
 		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap, MSR_IA32_PRED_CMD,
 					      MSR_TYPE_W);
 		break;
-	case MSR_IA32_ARCH_CAPABILITIES:
-		if (!msr_info->host_initiated)
-			return 1;
-		vmx->arch_capabilities = data;
-		break;
 	case MSR_IA32_CR_PAT:
 		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
 			if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
@@ -6666,8 +6654,6 @@ static void vmx_vcpu_setup(struct vcpu_v
 		++vmx->nmsrs;
 	}
 
-	vmx->arch_capabilities = kvm_get_arch_capabilities();
-
 	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
 
 	/* 22.2.1, 20.8.1 */
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2350,6 +2350,11 @@ int kvm_set_msr_common(struct kvm_vcpu *
 		if (msr_info->host_initiated)
 			vcpu->arch.microcode_version = data;
 		break;
+	case MSR_IA32_ARCH_CAPABILITIES:
+		if (!msr_info->host_initiated)
+			return 1;
+		vcpu->arch.arch_capabilities = data;
+		break;
 	case MSR_EFER:
 		return set_efer(vcpu, data);
 	case MSR_K7_HWCR:
@@ -2654,6 +2659,12 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case MSR_IA32_UCODE_REV:
 		msr_info->data = vcpu->arch.microcode_version;
 		break;
+	case MSR_IA32_ARCH_CAPABILITIES:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
+			return 1;
+		msr_info->data = vcpu->arch.arch_capabilities;
+		break;
 	case MSR_IA32_TSC:
 		msr_info->data = kvm_scale_tsc(vcpu, rdtsc()) + vcpu->arch.tsc_offset;
 		break;
@@ -8501,6 +8512,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(st
 
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
+	vcpu->arch.arch_capabilities = kvm_get_arch_capabilities();
 	kvm_vcpu_mtrr_init(vcpu);
 	vcpu_load(vcpu);
 	kvm_vcpu_reset(vcpu, false);


