Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F864C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1112C2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfLQSee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:34:34 -0500
Received: from foss.arm.com ([217.140.110.172]:44814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbfLQSe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:34:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5426D30E;
        Tue, 17 Dec 2019 10:34:26 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF1B43F67D;
        Tue, 17 Dec 2019 10:34:24 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, dave.martin@arm.com, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org, christoffer.dall@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 6/7] arm64: signal: nofpsimd: Handle fp/simd context for signal frames
Date:   Tue, 17 Dec 2019 18:34:01 +0000
Message-Id: <20191217183402.2259904-7-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217183402.2259904-1-suzuki.poulose@arm.com>
References: <20191217183402.2259904-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure we try to save/restore the vfp/fpsimd context for signal
handling only when the fp/simd support is available. Otherwise, skip
the frames.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/signal.c   | 17 +++++++++++++++--
 arch/arm64/kernel/signal32.c | 11 +++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index dd2cdc0d5be2..c648f7627035 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -173,6 +173,10 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 		&current->thread.uw.fpsimd_state;
 	int err;
 
+	/* This must not be called when FP/SIMD support is missing */
+	if (WARN_ON(!system_supports_fpsimd()))
+		return -EINVAL;
+
 	/* copy the FP and status/control registers */
 	err = __copy_to_user(ctx->vregs, fpsimd->vregs, sizeof(fpsimd->vregs));
 	__put_user_error(fpsimd->fpsr, &ctx->fpsr, err);
@@ -191,6 +195,10 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 	__u32 magic, size;
 	int err = 0;
 
+	/* This must not be called when FP/SIMD support is missing */
+	if (WARN_ON(!system_supports_fpsimd()))
+		return -EINVAL;
+
 	/* check the magic/size information */
 	__get_user_error(magic, &ctx->head.magic, err);
 	__get_user_error(size, &ctx->head.size, err);
@@ -261,6 +269,9 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	struct user_fpsimd_state fpsimd;
 	struct sve_context sve;
 
+	if (WARN_ON(!system_supports_fpsimd()))
+		return -EINVAL;
+
 	if (__copy_from_user(&sve, user->sve, sizeof(sve)))
 		return -EFAULT;
 
@@ -371,6 +382,8 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			goto done;
 
 		case FPSIMD_MAGIC:
+			if (!system_supports_fpsimd())
+				goto invalid;
 			if (user->fpsimd)
 				goto invalid;
 
@@ -506,7 +519,7 @@ static int restore_sigframe(struct pt_regs *regs,
 	if (err == 0)
 		err = parse_user_sigframe(&user, sf);
 
-	if (err == 0) {
+	if (err == 0 && system_supports_fpsimd()) {
 		if (!user.fpsimd)
 			return -EINVAL;
 
@@ -623,7 +636,7 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 
 	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
 
-	if (err == 0) {
+	if (err == 0 && system_supports_fpsimd()) {
 		struct fpsimd_context __user *fpsimd_ctx =
 			apply_user_offset(user, user->fpsimd_offset);
 		err |= preserve_fpsimd_context(fpsimd_ctx);
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 12a585386c2f..97ace6919bc2 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -100,6 +100,9 @@ static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *frame)
 	compat_ulong_t fpscr, fpexc;
 	int i, err = 0;
 
+	/* This must not be called when the FP/SIMD is missing */
+	if (WARN_ON(!system_supports_fpsimd()))
+		return -EINVAL;
 	/*
 	 * Save the hardware registers to the fpsimd_state structure.
 	 * Note that this also saves V16-31, which aren't visible
@@ -149,6 +152,10 @@ static int compat_restore_vfp_context(struct compat_vfp_sigframe __user *frame)
 	compat_ulong_t fpscr;
 	int i, err = 0;
 
+	/* This must not be called when the FP/SIMD is missing */
+	if (WARN_ON(!system_supports_fpsimd()))
+		return -EINVAL;
+
 	__get_user_error(magic, &frame->magic, err);
 	__get_user_error(size, &frame->size, err);
 
@@ -223,7 +230,7 @@ static int compat_restore_sigframe(struct pt_regs *regs,
 	err |= !valid_user_regs(&regs->user_regs, current);
 
 	aux = (struct compat_aux_sigframe __user *) sf->uc.uc_regspace;
-	if (err == 0)
+	if (err == 0 && system_supports_fpsimd())
 		err |= compat_restore_vfp_context(&aux->vfp);
 
 	return err;
@@ -419,7 +426,7 @@ static int compat_setup_sigframe(struct compat_sigframe __user *sf,
 
 	aux = (struct compat_aux_sigframe __user *) sf->uc.uc_regspace;
 
-	if (err == 0)
+	if (err == 0 && system_supports_fpsimd())
 		err |= compat_preserve_vfp_context(&aux->vfp);
 	__put_user_error(0, &aux->end_magic, err);
 
-- 
2.23.0

