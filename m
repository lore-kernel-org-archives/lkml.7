Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2FEC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A372183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JyKOyNdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbfDRM2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:28:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44130 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388175AbfDRM2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:28:54 -0400
Received: from zn.tnic (p200300EC2F112E003868EF36058F9C84.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:3868:ef36:58f:9c84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D96BB1EC0380;
        Thu, 18 Apr 2019 14:28:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555590533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pkbUN/H8ZRnM+HXO1jSXBdqdH3IhPIyO8z6vAoQ/gk=;
        b=JyKOyNdKufYb8HpgSNYLonZW/9RwxakCxOswGEpk6uPZiJA/0gpj1rX3x0CgHlG3DwBJWF
        deli0eNI2ziJSpBYD7yQz0OC+0KF4lkqbKiNSA84RJY5oBTbVcNduHAPBL3MMoX91VlpY2
        Ub1iIkAewxwLEwWn9xBgKnOZZMeYm9E=
Date:   Thu, 18 Apr 2019 14:28:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     KVM <kvm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: [PATCH -v5.1] x86/kvm: Implement HWCR support
Message-ID: <20190418122842.GF27160@zn.tnic>
References: <20190408090946.GA2315@zn.tnic>
 <20190408144115.GA25880@linux.intel.com>
 <20190408145716.GG15689@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190408145716.GG15689@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

ok here's v5.1 with most of Sean's feedback addressed. The function
checking whether HWCR[18] is set, I've renamed to can_set_mci_status()
and left it to return bool because it really is used in boolean context,
answering the question "Can I set MCi_STATUS MSRs?"

And now it all looks simple and clean, just how I like it! :-)

Thx.

---
From: Borislav Petkov <bp@suse.de>

The hardware configuration register has some useful bits which can be
used by guests. Implement McStatusWrEn which can be used by guests when
injecting MCEs with the in-kernel mce-inject module.

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
 arch/x86/kvm/x86.c              | 33 +++++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

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
index 099b851dabaf..10f6acc6494c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2273,6 +2273,18 @@ static void kvmclock_sync_fn(struct work_struct *work)
 					KVMCLOCK_SYNC_PERIOD);
 }
 
+/*
+ * On AMD, HWCR[McStatusWrEn] controls whether setting MCi_STATUS results in #GP.
+ */
+static bool can_set_mci_status(struct kvm_vcpu *vcpu)
+{
+	/* McStatusWrEn enabled? */
+	if (guest_cpuid_is_amd(vcpu))
+		return !!(vcpu->arch.msr_hwcr & BIT_ULL(18));
+
+	return false;
+}
+
 static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	u64 mcg_cap = vcpu->arch.mcg_cap;
@@ -2304,9 +2316,13 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			if ((offset & 0x3) == 0 &&
 			    data != 0 && (data | (1 << 10)) != ~(u64)0)
 				return -1;
-			if (!msr_info->host_initiated &&
-				(offset & 0x3) == 1 && data != 0)
-				return -1;
+
+			/* MCi_STATUS */
+			if ((offset & 0x3) == 1 && !msr_info->host_initiated) {
+				if (!can_set_mci_status(vcpu))
+					return -1;
+			}
+
 			vcpu->arch.mce_banks[offset] = data;
 			break;
 		}
@@ -2455,8 +2471,11 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -2730,7 +2749,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_K8_SYSCFG:
 	case MSR_K8_TSEG_ADDR:
 	case MSR_K8_TSEG_MASK:
-	case MSR_K7_HWCR:
 	case MSR_VM_HSAVE_PA:
 	case MSR_K8_INT_PENDING_MSG:
 	case MSR_AMD64_NB_CFG:
@@ -2894,6 +2912,9 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
