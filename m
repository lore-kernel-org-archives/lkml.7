Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00F2C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFED821743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404400AbfHHRbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:31:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33950 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404391AbfHHRbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:31:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so95767563wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OrZlb/PPDCv83pS8OZEyWscfXBkK3tF0dI829N03AEg=;
        b=mk0u2CLDSPdjq5FifX0u0Pa/GyhSssqe83R2jn/RysyR1wc0huDdyI/pFOm81g4FET
         GqPzbUCjg6ihZBGcq34hRWiTIZtEhWAj3BRRdBc8s1Kmuo8u+ToCrRX1Be1zIVhnxNY4
         3TkkynFDroTMsXHmi1SedUGBwnF3x2wDFiKr+fRkJGIfigF6ypxHBdA3JdRk2obr5Z4A
         z08uaTDfQQmNwskJnNar34m4G+U8ECjVGSaeFYie9kw2KjGSF+FvmK3nmNR4ZihIrb4R
         stphwDh8B7r9MO+Y7AQQVYZFs6MUcxCY/dS0G/Lil7KQIzr6E+A9FkVetPwg54lX51Jh
         fuvQ==
X-Gm-Message-State: APjAAAWM4jkZE5/Vm5hRY6QTtb3ab7ZrxGTXPPHZEHRTMfTM+e/7uwcN
        quW1s2VVFrM+DdZJHFALOXh1Lw==
X-Google-Smtp-Source: APXvYqwZsjo1q2VLIRF5Vw3WvB1AeiVm0PcY9HQk4DrPeZZQgC8w8+NUWQC1Yp1eN6Ric9+VH+8FBA==
X-Received: by 2002:adf:eac5:: with SMTP id o5mr5554602wrn.140.1565285461828;
        Thu, 08 Aug 2019 10:31:01 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g25sm2136859wmk.39.2019.08.08.10.30.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 10:31:01 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 4/7] x86: KVM: add xsetbv to the emulator
Date:   Thu,  8 Aug 2019 19:30:48 +0200
Message-Id: <20190808173051.6359-5-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808173051.6359-1-vkuznets@redhat.com>
References: <20190808173051.6359-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid hardcoding xsetbv length to '3' we need to support decoding it in
the emulator.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_emulate.h |  3 ++-
 arch/x86/kvm/emulate.c             | 23 ++++++++++++++++++++++-
 arch/x86/kvm/svm.c                 |  1 +
 arch/x86/kvm/x86.c                 |  6 ++++++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
index feab24cac610..77cf6c11f66b 100644
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -229,7 +229,7 @@ struct x86_emulate_ops {
 	int (*pre_leave_smm)(struct x86_emulate_ctxt *ctxt,
 			     const char *smstate);
 	void (*post_leave_smm)(struct x86_emulate_ctxt *ctxt);
-
+	int (*set_xcr)(struct x86_emulate_ctxt *ctxt, u32 index, u64 xcr);
 };
 
 typedef u32 __attribute__((vector_size(16))) sse128_t;
@@ -429,6 +429,7 @@ enum x86_intercept {
 	x86_intercept_ins,
 	x86_intercept_out,
 	x86_intercept_outs,
+	x86_intercept_xsetbv,
 
 	nr_x86_intercepts
 };
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 718f7d9afedc..f9e843dd992a 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4156,6 +4156,20 @@ static int em_fxrstor(struct x86_emulate_ctxt *ctxt)
 	return rc;
 }
 
+static int em_xsetbv(struct x86_emulate_ctxt *ctxt)
+{
+	u32 eax, ecx, edx;
+
+	eax = reg_read(ctxt, VCPU_REGS_RAX);
+	edx = reg_read(ctxt, VCPU_REGS_RDX);
+	ecx = reg_read(ctxt, VCPU_REGS_RCX);
+
+	if (ctxt->ops->set_xcr(ctxt, ecx, ((u64)edx << 32) | eax))
+		return emulate_gp(ctxt, 0);
+
+	return X86EMUL_CONTINUE;
+}
+
 static bool valid_cr(int nr)
 {
 	switch (nr) {
@@ -4409,6 +4423,12 @@ static const struct opcode group7_rm1[] = {
 	N, N, N, N, N, N,
 };
 
+static const struct opcode group7_rm2[] = {
+	N,
+	II(ImplicitOps | Priv,			em_xsetbv,	xsetbv),
+	N, N, N, N, N, N,
+};
+
 static const struct opcode group7_rm3[] = {
 	DIP(SrcNone | Prot | Priv,		vmrun,		check_svme_pa),
 	II(SrcNone  | Prot | EmulateOnUD,	em_hypercall,	vmmcall),
@@ -4498,7 +4518,8 @@ static const struct group_dual group7 = { {
 }, {
 	EXT(0, group7_rm0),
 	EXT(0, group7_rm1),
-	N, EXT(0, group7_rm3),
+	EXT(0, group7_rm2),
+	EXT(0, group7_rm3),
 	II(SrcNone | DstMem | Mov,		em_smsw, smsw), N,
 	II(SrcMem16 | Mov | Priv,		em_lmsw, lmsw),
 	EXT(0, group7_rm7),
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 8299b0de06e2..858feeac01a4 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6067,6 +6067,7 @@ static const struct __x86_intercept {
 	[x86_intercept_ins]		= POST_EX(SVM_EXIT_IOIO),
 	[x86_intercept_out]		= POST_EX(SVM_EXIT_IOIO),
 	[x86_intercept_outs]		= POST_EX(SVM_EXIT_IOIO),
+	[x86_intercept_xsetbv]		= PRE_EX(SVM_EXIT_XSETBV),
 };
 
 #undef PRE_EX
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 50e0b25092c7..2f4a4d0967f3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6068,6 +6068,11 @@ static void emulator_post_leave_smm(struct x86_emulate_ctxt *ctxt)
 	kvm_smm_changed(emul_to_vcpu(ctxt));
 }
 
+static int emulator_set_xcr(struct x86_emulate_ctxt *ctxt, u32 index, u64 xcr)
+{
+	return __kvm_set_xcr(emul_to_vcpu(ctxt), index, xcr);
+}
+
 static const struct x86_emulate_ops emulate_ops = {
 	.read_gpr            = emulator_read_gpr,
 	.write_gpr           = emulator_write_gpr,
@@ -6109,6 +6114,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.set_hflags          = emulator_set_hflags,
 	.pre_leave_smm       = emulator_pre_leave_smm,
 	.post_leave_smm      = emulator_post_leave_smm,
+	.set_xcr             = emulator_set_xcr,
 };
 
 static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
-- 
2.20.1

