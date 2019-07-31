Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3129C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEB420693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfGaNH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:07:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55514 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfGaNH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:07:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so60741488wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 06:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=z5r4sBmJb9oX16QVH9jJowtuaCAUrU9XIcNtMnKFLD4=;
        b=T51qGVVmeTWCci+c+NL9HGxz3r8QJ+bAhmwZl1J9YO/bA3MR23Vyek5i1f6G9Q8BLW
         kWA7fD8NbDg4PgpZxokEspzUHDGmI+kJOTPAnSg7aZWUBtVTM793E1IPSq9d07dBFrty
         bph/7F4wiXKL7YexH72J6IfDX4Z5x/aWtZPWLA+RxeS3bYBZCI3JKPOIs8eqLwJ0r77W
         KTyErLQDbgRMFhEBcneYps8efpV445pUtPjM8t/xefi+LfoqH90vleLOCaSzBDxFq92Z
         0ycu56V8AvQXYEVuMb9rLCxD+FqVDm9aEay7+2OZp77EiKYaQQjdYjBOYMY0lo7vlVd7
         OyOw==
X-Gm-Message-State: APjAAAVCQi7f6gVPooB9xQWME5Qh7v8VkkD2HUgVbqeHNPAFCq5/ryKx
        aHDYTm05F3VHpyjp3wkurvhXxg==
X-Google-Smtp-Source: APXvYqwe2oEYTnfJ6jxmNu0QNXzvIZWVoVfnd8dcdUDRAF0bacdup6iaj13/5tTgAPU14u6Yg6rdBg==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr38372531wmg.155.1564578445517;
        Wed, 31 Jul 2019 06:07:25 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q10sm69757513wrf.32.2019.07.31.06.07.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 06:07:24 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH RFC 4/5] x86: KVM: add xsetbv to the emulator
In-Reply-To: <a86ca8b7-0333-398b-7bf6-90cb79366226@redhat.com>
References: <20190620110240.25799-1-vkuznets@redhat.com> <20190620110240.25799-5-vkuznets@redhat.com> <a86ca8b7-0333-398b-7bf6-90cb79366226@redhat.com>
Date:   Wed, 31 Jul 2019 15:07:24 +0200
Message-ID: <87lfwe73oz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 20/06/19 13:02, Vitaly Kuznetsov wrote:
>> To avoid hardcoding xsetbv length to '3' we need to support decoding it in
>> the emulator.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Can you also emulate it properly?  The code from QEMU's
> target/i386/fpu_helper.c can help. :)
>

(Had a chance to get back to this just now, sorry)

Assuming __kvm_set_xcr() is also a correct implementation, would the
code below do the job? (Just trying to figure out why you suggested
me to take a look at QEMU's variant):

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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c6d951cbd76c..9512cc38dfe9 100644
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
Vitaly
