Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8194AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4668220870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="H33xsCsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfDHJJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:09:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52308 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfDHJJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:09:58 -0400
Received: from zn.tnic (p200300EC2F07270078D24834D7DDA826.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2700:78d2:4834:d7dd:a826])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A5021EC0ACA;
        Mon,  8 Apr 2019 11:09:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554714596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ZMVZnM7ljBzN2Eei8FN8tIHdEnCOJXSwDaUu/v9qEe4=;
        b=H33xsCsXMmAc6exE4o5PrzK1G26VtLyKY1k2CFzbdaX7cOfWs2toGZtfrnMa0Sth9EdUVt
        ME8N6XdmGgYnM8hFmbwiR45gXF8yQOGooV2dUU6dWJE6KmoZ43RN9IZt++IWtLw94DYdxG
        tZ5ywWRfKvAfVIObs6XuEuYFD4q7+IA=
Date:   Mon, 8 Apr 2019 11:09:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     KVM <kvm@vger.kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: [PATCH -v5] x86/kvm: Implement HWCR support
Message-ID: <20190408090946.GA2315@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

here's v5 which keeps the HWCR functionality in kvm/x86.c so that
emulation of AMD guests on Intel hw still can work.

--
From: Borislav Petkov <bp@suse.de>

The AMD hardware configuration register has some useful bits which can
be used by guests. Implement McStatusWrEn which can be used by guests
when injecting MCEs with the in-kernel mce-inject module.

For that, we need to set bit 18 - McStatusWrEn - first, before writing
the MCi_STATUS registers (otherwise we #GP).

Add the required machinery to do so.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Jim Mattson <jmattson@google.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/x86.c              | 45 ++++++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 159b5988292f..541c431df806 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -780,6 +780,9 @@ struct kvm_vcpu_arch {
 
 	/* Flush the L1 Data cache for L1TF mitigation on VMENTER */
 	bool l1tf_flush_l1d;
+
+	/* AMD MSRC001_0015 Hardware Configuration */
+	u64 msr_hwcr;
 };
 
 struct kvm_lpage_info {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 099b851dabaf..e07f21c1d2d4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2273,6 +2273,30 @@ static void kvmclock_sync_fn(struct work_struct *work)
 					KVMCLOCK_SYNC_PERIOD);
 }
 
+/*
+ * On AMD, HWCR[McStatusWrEn] controls whether setting MCi_STATUS results in #GP.
+ */
+static bool __set_mci_status(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+{
+	if (guest_cpuid_is_amd(vcpu)) {
+		struct msr_data tmp;
+
+		tmp.index = MSR_K7_HWCR;
+
+		if (kvm_get_msr_common(vcpu, &tmp))
+			return false;
+
+		/* McStatusWrEn enabled? */
+		if (tmp.data & BIT_ULL(18))
+			return true;
+	}
+
+	if (msr_info->data != 0)
+		return false;
+
+	return true;
+}
+
 static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	u64 mcg_cap = vcpu->arch.mcg_cap;
@@ -2304,9 +2328,13 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			if ((offset & 0x3) == 0 &&
 			    data != 0 && (data | (1 << 10)) != ~(u64)0)
 				return -1;
-			if (!msr_info->host_initiated &&
-				(offset & 0x3) == 1 && data != 0)
-				return -1;
+
+			/* MCi_STATUS */
+			if ((offset & 0x3) == 1 && !msr_info->host_initiated) {
+				if (!__set_mci_status(vcpu, msr_info))
+						return -1;
+			}
+
 			vcpu->arch.mce_banks[offset] = data;
 			break;
 		}
@@ -2455,8 +2483,11 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		data &= ~(u64)0x40;	/* ignore flush filter disable */
 		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
 		data &= ~(u64)0x8;	/* ignore TLB cache disable */
-		data &= ~(u64)0x40000;  /* ignore Mc status write enable */
-		if (data != 0) {
+
+		/* Handle McStatusWrEn */
+		if (data == BIT_ULL(18)) {
+			vcpu->arch.msr_hwcr = data;
+		} else if (data != 0) {
 			vcpu_unimpl(vcpu, "unimplemented HWCR wrmsr: 0x%llx\n",
 				    data);
 			return 1;
@@ -2730,7 +2761,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_K8_SYSCFG:
 	case MSR_K8_TSEG_ADDR:
 	case MSR_K8_TSEG_MASK:
-	case MSR_K7_HWCR:
 	case MSR_VM_HSAVE_PA:
 	case MSR_K8_INT_PENDING_MSG:
 	case MSR_AMD64_NB_CFG:
@@ -2894,6 +2924,9 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_MISC_FEATURES_ENABLES:
 		msr_info->data = vcpu->arch.msr_misc_features_enables;
 		break;
+	case MSR_K7_HWCR:
+		msr_info->data = vcpu->arch.msr_hwcr;
+		break;
 	default:
 		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
 			return kvm_pmu_get_msr(vcpu, msr_info->index, &msr_info->data);
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
