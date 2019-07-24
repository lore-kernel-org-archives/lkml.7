Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42451C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189AE21849
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999021;
	bh=9z12M3NR1JmOFdoKut93zTpfZ7qByVglUvcwz/Orc0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oydy0QHKdvaF0ONXA6ZVkaOMHQlyUD8tFohcz5kp9Go5uGwUMd43Zm55YWD/n8e3U
	 xSVPe5X5GWsf0W1fNb8J71DcjzSK6L2nLNUQTqRscItUbInUVx+3WUa7qigSYwGKTl
	 otW5o7d+jwXGphq9/lagQCiMKIMU/tOE7Q+mytVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404718AbfGXT7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:59:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392205AbfGXT7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:59:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C00AA22ADC;
        Wed, 24 Jul 2019 19:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998358;
        bh=9z12M3NR1JmOFdoKut93zTpfZ7qByVglUvcwz/Orc0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QF1j8EHF2gR3V+gcAk54tovVH8TFtjZCpI4KOGIX7iXn3aw1UbmI4ABPDChDEAmdN
         JQVymNgVfjR/eaKs6peWo+oOPESRtrkjGR4lu57MYGpEmMIyHeRpAbjJ86XIiWFoXU
         EB4r9+a0j4ORp+sNQCvSa0KR5xYBirl9X/6CQtzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.1 300/371] KVM: VMX: Fix handling of #MC that occurs during VM-Entry
Date:   Wed, 24 Jul 2019 21:20:52 +0200
Message-Id: <20190724191746.855697478@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit beb8d93b3e423043e079ef3dda19dad7b28467a8 upstream.

A previous fix to prevent KVM from consuming stale VMCS state after a
failed VM-Entry inadvertantly blocked KVM's handling of machine checks
that occur during VM-Entry.

Per Intel's SDM, a #MC during VM-Entry is handled in one of three ways,
depending on when the #MC is recognoized.  As it pertains to this bug
fix, the third case explicitly states EXIT_REASON_MCE_DURING_VMENTRY
is handled like any other VM-Exit during VM-Entry, i.e. sets bit 31 to
indicate the VM-Entry failed.

If a machine-check event occurs during a VM entry, one of the following occurs:
 - The machine-check event is handled as if it occurred before the VM entry:
        ...
 - The machine-check event is handled after VM entry completes:
        ...
 - A VM-entry failure occurs as described in Section 26.7. The basic
   exit reason is 41, for "VM-entry failure due to machine-check event".

Explicitly handle EXIT_REASON_MCE_DURING_VMENTRY as a one-off case in
vmx_vcpu_run() instead of binning it into vmx_complete_atomic_exit().
Doing so allows vmx_vcpu_run() to handle VMX_EXIT_REASONS_FAILED_VMENTRY
in a sane fashion and also simplifies vmx_complete_atomic_exit() since
VMCS.VM_EXIT_INTR_INFO is guaranteed to be fresh.

Fixes: b060ca3b2e9e7 ("kvm: vmx: Handle VMLAUNCH/VMRESUME failure properly")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/vmx.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6102,28 +6102,21 @@ static void vmx_apicv_post_state_restore
 
 static void vmx_complete_atomic_exit(struct vcpu_vmx *vmx)
 {
-	u32 exit_intr_info = 0;
-	u16 basic_exit_reason = (u16)vmx->exit_reason;
-
-	if (!(basic_exit_reason == EXIT_REASON_MCE_DURING_VMENTRY
-	      || basic_exit_reason == EXIT_REASON_EXCEPTION_NMI))
+	if (vmx->exit_reason != EXIT_REASON_EXCEPTION_NMI)
 		return;
 
-	if (!(vmx->exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY))
-		exit_intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
-	vmx->exit_intr_info = exit_intr_info;
+	vmx->exit_intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
 
 	/* if exit due to PF check for async PF */
-	if (is_page_fault(exit_intr_info))
+	if (is_page_fault(vmx->exit_intr_info))
 		vmx->vcpu.arch.apf.host_apf_reason = kvm_read_and_reset_pf_reason();
 
 	/* Handle machine checks before interrupts are enabled */
-	if (basic_exit_reason == EXIT_REASON_MCE_DURING_VMENTRY ||
-	    is_machine_check(exit_intr_info))
+	if (is_machine_check(vmx->exit_intr_info))
 		kvm_machine_check();
 
 	/* We need to handle NMIs before interrupts are enabled */
-	if (is_nmi(exit_intr_info)) {
+	if (is_nmi(vmx->exit_intr_info)) {
 		kvm_before_interrupt(&vmx->vcpu);
 		asm("int $2");
 		kvm_after_interrupt(&vmx->vcpu);
@@ -6526,6 +6519,9 @@ static void vmx_vcpu_run(struct kvm_vcpu
 	vmx->idt_vectoring_info = 0;
 
 	vmx->exit_reason = vmx->fail ? 0xdead : vmcs_read32(VM_EXIT_REASON);
+	if ((u16)vmx->exit_reason == EXIT_REASON_MCE_DURING_VMENTRY)
+		kvm_machine_check();
+
 	if (vmx->fail || (vmx->exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY))
 		return;
 


