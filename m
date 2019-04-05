Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB48C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538EE2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWBorbOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDEWrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:47:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34656 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDEWrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:47:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so9748814wrq.1;
        Fri, 05 Apr 2019 15:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p3D3FHj2GlWOrfpVfWFqRiKyecJhwp7Sph6x9E7wt28=;
        b=DWBorbOi65ADAWyUG7n0f9XnvC18DqU6dIb8IhbMUZfkjit++TnYercaLge9uRBXhp
         w+W76XAO4x/WdhtQJkStUwGWtzZhUEWXzYug+NdhsbxO8Ar/e4HjEsAy0d65sAZZ9zmm
         kVuabpAhvLh06swfImV2LzC/hq4bWC18MJ9foOwDE99PhzgbPUnGtmfaafCCXE/9HTq8
         KpIZCN/V2rI/sEeVT0jF2yQvMYmmf0UY6ZuO1wcNEu+3Jt3290Ywuo0jftvfsLFWAiYT
         lCcQTgyxkIPL99NF4Ctav7QkK0ceW54lXRUIxo0spcJ5ivF+TlBI6AUItKYm1jObLw78
         OgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=p3D3FHj2GlWOrfpVfWFqRiKyecJhwp7Sph6x9E7wt28=;
        b=QeulmQsijgQdzU1d2GOVEINOFsFK0FGOdsD6Bod4FwXt7dR/LGSMj/crOvfXyCer4X
         ARyiUzSXnCkv2D18svBZKnVZoLkN749eKetwOqI+Ag8wzbakXJQb0TNeMsO5y+SDrGnl
         yvRn0pc9tZ07r4zBPQPKwZCMZ3wS+AcYybf3pRLxtK6JqcioRPd/ginNMQ2ar8JHhLMT
         r7p+56GYHYXB9D0dUT/uHc4oY+HFL/yzG9skvehDW0+Q6sT0FelFjfgmln3nKU/6osdM
         Gvn0mdWv0Y9gam14F1KAwf/MKaaaTWUiaeyyC+3V2xHX3iLkEjhBkKpa02eunsYyb9Ss
         2T2w==
X-Gm-Message-State: APjAAAUIwi4443WWLN9J6oBZk8Eiy7ym0c9t+GYMhMktFjRfdJafAb+B
        BFOsKEa3Gl2/NJZXe9Bu2gF3FP3x
X-Google-Smtp-Source: APXvYqwPBdo9Mz8IQO3mKotAnESZ1t0llUYuR5JoAfy2oMj8Hyur8YRIDshoAx8uZAd4ipFSZxaMuQ==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr10087748wrw.156.1554504418896;
        Fri, 05 Apr 2019 15:46:58 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id 7sm81190791wrc.81.2019.04.05.15.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 15:46:58 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Marc Orr <marcorr@google.com>
Subject: [PATCH 1/2] KVM: x86: nVMX: close leak of L0's x2APIC MSRs (CVE-2019-3887)
Date:   Sat,  6 Apr 2019 00:46:55 +0200
Message-Id: <1554504416-8720-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554504416-8720-1-git-send-email-pbonzini@redhat.com>
References: <1554504416-8720-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Orr <marcorr@google.com>

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
---
 arch/x86/kvm/vmx/nested.c | 72 +++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 153e539c29c9..897d70e3d291 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -500,6 +500,17 @@ static void nested_vmx_disable_intercept_for_msr(unsigned long *msr_bitmap_l1,
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
@@ -541,39 +552,44 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
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
-- 
1.8.3.1


