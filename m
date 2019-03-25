Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D57AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE01F20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ljZm29gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfCYRQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:16:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35938 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729572AbfCYRQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:16:51 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B2F21EC0B68;
        Mon, 25 Mar 2019 18:16:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553534209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXc67hbJyhqER9Lo8aYUSf/IFllx63dSCy29QkVzqIM=;
        b=ljZm29gcv3nxWoxyhjJT/+yVBF//almOEUo0pdNy3plo1ovVDqGqno/kmtYysp9hSyyGpX
        79FkAVn8uouA0laEGQ4BLb7meH6M+bI3YAymH2SQtuI0ZFVPvW10QyPhXyM7BSqbP46TJT
        heZwo90KtxnTioZ39XYq6XBKlJJTmxA=
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
Subject: [PATCH 1/2] kvm/x86: Move MSR_K7_HWCR to svm.c
Date:   Mon, 25 Mar 2019 18:16:48 +0100
Message-Id: <20190325171649.7311-2-bp@alien8.de>
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

This is an AMD-specific MSR. Put it where it belongs.

Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kvm/svm.c | 14 ++++++++++++++
 arch/x86/kvm/x86.c | 12 ------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index b5b128a0a051..00eb44a2a377 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4201,6 +4201,9 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_F10H_DECFG:
 		msr_info->data = svm->msr_decfg;
 		break;
+	case MSR_K7_HWCR:
+		msr_info->data = 0;
+		break;
 	default:
 		return kvm_get_msr_common(vcpu, msr_info);
 	}
@@ -4405,6 +4408,17 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		svm->msr_decfg = data;
 		break;
 	}
+	case MSR_K7_HWCR:
+		data &= ~(u64)0x40;	/* ignore flush filter disable */
+		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
+		data &= ~(u64)0x8;	/* ignore TLB cache disable */
+		data &= ~(u64)0x40000;  /* ignore Mc status write enable */
+		if (data != 0) {
+			vcpu_unimpl(vcpu, "unimplemented HWCR wrmsr: 0x%llx\n",
+				    data);
+			return 1;
+		}
+		break;
 	case MSR_IA32_APICBASE:
 		if (kvm_vcpu_apicv_active(vcpu))
 			avic_update_vapic_bar(to_svm(vcpu), data);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 65e4559eef2f..e53d13cfceba 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2445,17 +2445,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_EFER:
 		return set_efer(vcpu, data);
-	case MSR_K7_HWCR:
-		data &= ~(u64)0x40;	/* ignore flush filter disable */
-		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
-		data &= ~(u64)0x8;	/* ignore TLB cache disable */
-		data &= ~(u64)0x40000;  /* ignore Mc status write enable */
-		if (data != 0) {
-			vcpu_unimpl(vcpu, "unimplemented HWCR wrmsr: 0x%llx\n",
-				    data);
-			return 1;
-		}
-		break;
 	case MSR_FAM10H_MMIO_CONF_BASE:
 		if (data != 0) {
 			vcpu_unimpl(vcpu, "unimplemented MMIO_CONF_BASE wrmsr: "
@@ -2724,7 +2713,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_K8_SYSCFG:
 	case MSR_K8_TSEG_ADDR:
 	case MSR_K8_TSEG_MASK:
-	case MSR_K7_HWCR:
 	case MSR_VM_HSAVE_PA:
 	case MSR_K8_INT_PENDING_MSG:
 	case MSR_AMD64_NB_CFG:
-- 
2.21.0

