Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7112DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217A32073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355676;
	bh=gaBmqIDeN6ywm83XEAwRBmVKngKeB9uRIsQJaHtpDNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iJHCQd6EFkC2u7o+gkPYV9YFi4sD+ELsNhwZfXPIGTVA2StKy3P2G2IrSFlpTiZQR
	 dN9gzQcYJCoiv+G9LlY/dg9qzEAJP5f7tMDlp/64jPUc/m528f77QrhVPGGyiEQgbu
	 Po8WlG54TH56dD+jvoMn7wAv2w4mahdifIOWi9p0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfDOTOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731761AbfDOTOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:14:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0449E218A1;
        Mon, 15 Apr 2019 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355669;
        bh=gaBmqIDeN6ywm83XEAwRBmVKngKeB9uRIsQJaHtpDNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSFi0JNQHV6hxIpIFF0c916GiMSKp4WIY8iaYFDvCPnbsI9/lbHxXMrxGE5GR8KGf
         XmupZ4CygwEqqSHVjRQGKoiaCCroVxWHC5CrV8n52Azs0PlLdaqDf2IxjoAKXyhVxJ
         q64Mi8EVw/ReyrJ0Sa03XR/fcUy1nOZobzWGGq7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Orr <marcorr@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 115/117] KVM: x86: nVMX: close leak of L0s x2APIC MSRs (CVE-2019-3887)
Date:   Mon, 15 Apr 2019 21:01:25 +0200
Message-Id: <20190415183750.601949838@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Orr <marcorr@google.com>

commit acff78477b9b4f26ecdf65733a4ed77fe837e9dc upstream.

The nested_vmx_prepare_msr_bitmap() function doesn't directly guard the
x2APIC MSR intercepts with the "virtualize x2APIC mode" MSR. As a
result, we discovered the potential for a buggy or malicious L1 to get
access to L0's x2APIC MSRs, via an L2, as follows.

1. L1 executes WRMSR(IA32_SPEC_CTRL, 1). This causes the spec_ctrl
variable, in nested_vmx_prepare_msr_bitmap() to become true.
2. L1 disables "virtualize x2APIC mode" in VMCS12.
3. L1 enables "APIC-register virtualization" in VMCS12.

Now, KVM will set VMCS02's x2APIC MSR intercepts from VMCS12, and then
set "virtualize x2APIC mode" to 0 in VMCS02. Oops.

This patch closes the leak by explicitly guarding VMCS02's x2APIC MSR
intercepts with VMCS12's "virtualize x2APIC mode" control.

The scenario outlined above and fix prescribed here, were verified with
a related patch in kvm-unit-tests titled "Add leak scenario to
virt_x2apic_mode_test".

Note, it looks like this issue may have been introduced inadvertently
during a merge---see 15303ba5d1cd.

Signed-off-by: Marc Orr <marcorr@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/nested.c |   72 ++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -500,6 +500,17 @@ static void nested_vmx_disable_intercept
 	}
 }
 
+static inline void enable_x2apic_msr_intercepts(unsigned long *msr_bitmap) {
+	int msr;
+
+	for (msr = 0x800; msr <= 0x8ff; msr += BITS_PER_LONG) {
+		unsigned word = msr / BITS_PER_LONG;
+
+		msr_bitmap[word] = ~0;
+		msr_bitmap[word + (0x800 / sizeof(long))] = ~0;
+	}
+}
+
 /*
  * Merge L0's and L1's MSR bitmap, return false to indicate that
  * we do not use the hardware.
@@ -541,39 +552,44 @@ static inline bool nested_vmx_prepare_ms
 		return false;
 
 	msr_bitmap_l1 = (unsigned long *)kmap(page);
-	if (nested_cpu_has_apic_reg_virt(vmcs12)) {
-		/*
-		 * L0 need not intercept reads for MSRs between 0x800 and 0x8ff, it
-		 * just lets the processor take the value from the virtual-APIC page;
-		 * take those 256 bits directly from the L1 bitmap.
-		 */
-		for (msr = 0x800; msr <= 0x8ff; msr += BITS_PER_LONG) {
-			unsigned word = msr / BITS_PER_LONG;
-			msr_bitmap_l0[word] = msr_bitmap_l1[word];
-			msr_bitmap_l0[word + (0x800 / sizeof(long))] = ~0;
-		}
-	} else {
-		for (msr = 0x800; msr <= 0x8ff; msr += BITS_PER_LONG) {
-			unsigned word = msr / BITS_PER_LONG;
-			msr_bitmap_l0[word] = ~0;
-			msr_bitmap_l0[word + (0x800 / sizeof(long))] = ~0;
-		}
-	}
 
-	nested_vmx_disable_intercept_for_msr(
-		msr_bitmap_l1, msr_bitmap_l0,
-		X2APIC_MSR(APIC_TASKPRI),
-		MSR_TYPE_W);
+	/*
+	 * To keep the control flow simple, pay eight 8-byte writes (sixteen
+	 * 4-byte writes on 32-bit systems) up front to enable intercepts for
+	 * the x2APIC MSR range and selectively disable them below.
+	 */
+	enable_x2apic_msr_intercepts(msr_bitmap_l0);
+
+	if (nested_cpu_has_virt_x2apic_mode(vmcs12)) {
+		if (nested_cpu_has_apic_reg_virt(vmcs12)) {
+			/*
+			 * L0 need not intercept reads for MSRs between 0x800
+			 * and 0x8ff, it just lets the processor take the value
+			 * from the virtual-APIC page; take those 256 bits
+			 * directly from the L1 bitmap.
+			 */
+			for (msr = 0x800; msr <= 0x8ff; msr += BITS_PER_LONG) {
+				unsigned word = msr / BITS_PER_LONG;
+
+				msr_bitmap_l0[word] = msr_bitmap_l1[word];
+			}
+		}
 
-	if (nested_cpu_has_vid(vmcs12)) {
-		nested_vmx_disable_intercept_for_msr(
-			msr_bitmap_l1, msr_bitmap_l0,
-			X2APIC_MSR(APIC_EOI),
-			MSR_TYPE_W);
 		nested_vmx_disable_intercept_for_msr(
 			msr_bitmap_l1, msr_bitmap_l0,
-			X2APIC_MSR(APIC_SELF_IPI),
+			X2APIC_MSR(APIC_TASKPRI),
 			MSR_TYPE_W);
+
+		if (nested_cpu_has_vid(vmcs12)) {
+			nested_vmx_disable_intercept_for_msr(
+				msr_bitmap_l1, msr_bitmap_l0,
+				X2APIC_MSR(APIC_EOI),
+				MSR_TYPE_W);
+			nested_vmx_disable_intercept_for_msr(
+				msr_bitmap_l1, msr_bitmap_l0,
+				X2APIC_MSR(APIC_SELF_IPI),
+				MSR_TYPE_W);
+		}
 	}
 
 	if (spec_ctrl)


