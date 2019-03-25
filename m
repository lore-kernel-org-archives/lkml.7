Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA9620879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RjA2qzBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfCYRQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:16:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35964 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbfCYRQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:16:52 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A22111EC0B71;
        Mon, 25 Mar 2019 18:16:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553534210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALqGJPug/HGIB1xOJWUsDco1hoeDYMgNF072hjz22dg=;
        b=RjA2qzBRrzwbNlSXmRazJjQvz0nfjGRi+lit7PdPS9wFB8AWIrMLtQJrJbVyf+Zz8ke2HC
        1FyIdFFRptmrmHycNaX4eNTT4A59fkWK+X6jKqQ2R01PcpBLTINXjGPgxXFDV/kbB+CXf0
        M9j5ZcCExAwVeApwogEV+0sTqCiKzKU=
From:   Borislav Petkov <bp@alien8.de>
To:     KVM <kvm@vger.kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 2/2] x86/kvm: Implement MSR_HWCR support
Date:   Mon, 25 Mar 2019 18:16:49 +0100
Message-Id: <20190325171649.7311-3-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325171649.7311-1-bp@alien8.de>
References: <20190325171649.7311-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The hardware configuration register has some useful bits which can be
used by guests. Implement McStatusWrEn which can be used by guests when
injecting MCEs with the in-kernel mce-inject module.

For that, we need to set bit 18 - McStatusWrEn - first, before writing
the MCi_STATUS registers (otherwise we #GP).

Add the required machinery to do so.

Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kvm/svm.c | 12 +++++++++---
 arch/x86/kvm/x86.c | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 00eb44a2a377..e5dfa00afe55 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -251,6 +251,9 @@ struct vcpu_svm {
 
 	/* which host CPU was used for running this vcpu */
 	unsigned int last_cpu;
+
+	/* MSRC001_0015 Hardware Configuration */
+	u64 msr_hwcr;
 };
 
 /*
@@ -4202,7 +4205,7 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = svm->msr_decfg;
 		break;
 	case MSR_K7_HWCR:
-		msr_info->data = 0;
+		msr_info->data = svm->msr_hwcr;
 		break;
 	default:
 		return kvm_get_msr_common(vcpu, msr_info);
@@ -4412,8 +4415,11 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		data &= ~(u64)0x40;	/* ignore flush filter disable */
 		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
 		data &= ~(u64)0x8;	/* ignore TLB cache disable */
-		data &= ~(u64)0x40000;  /* ignore Mc status write enable */
-		if (data != 0) {
+
+		/* Handle McStatusWrEn */
+		if (data == BIT_ULL(18)) {
+			svm->msr_hwcr = data;
+		} else if (data != 0) {
 			vcpu_unimpl(vcpu, "unimplemented HWCR wrmsr: 0x%llx\n",
 				    data);
 			return 1;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e53d13cfceba..dda7e1abb593 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2272,6 +2272,30 @@ static void kvmclock_sync_fn(struct work_struct *work)
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
+		if (kvm_x86_ops->get_msr(vcpu, &tmp))
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
@@ -2303,9 +2327,13 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
-- 
2.21.0

