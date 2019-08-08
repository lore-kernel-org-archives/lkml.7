Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2314EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BCC218B8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WUCvD+Z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbfHHIAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:00:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34906 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731548AbfHHIAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:00:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id n4so1899279pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZHlCvq7/QD+QdgO5YTqMsg9cOi9AJNwYVG4K7E83oZY=;
        b=WUCvD+Z2nlkFGqFW9gFc+esjtiW6+94cevALoUxafT0ex4G3R3j/dvQyEQoovv9RFQ
         QKiJ7rpP/A7MoxlKyQiWm9oacx6cakmmR6Fz3ywEiSUh9hF0t7EvdbPsRLWbJkj/NpNP
         ofDEH9bdClywPe4X68Wk8c44VasA5ZvcQWmH3BqNb1eur82/4EVQbEyttfzbxJyCXxEK
         iGpOtSwsAB7bJN35Zlzq5anhrPNN80u+702QXtmkrLGfs0te9OagqTlnLuMdzn3MtlY8
         RJKY1lUlio+EG+uPnzSe768J3j8VJWGbqScoOZLeK4Uiv+ClF4sjToKBUebjiDsjn9Q3
         RSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZHlCvq7/QD+QdgO5YTqMsg9cOi9AJNwYVG4K7E83oZY=;
        b=iPmnnvzRFq99ZhgjCCo8Yj6YMTIfSygE8inG7b4sfalCFKCX7bdJ8qcEm77+Vrx3tA
         TM2iJuzp6Y3Da/C144y4a1uSVEvQD2cnZJNM7lS5MlyF2V/t0ZNXMwwz1cuubYK6w3ca
         oZg/0GJWTXyrHif9gd4N1gqOfAawYC5PKMAVvl5FcmJFwgiCgyQmLNcBfabU0d2xyshs
         cpC/snks/8pRI309QxvUZiK7QZEv+1NoUH6usFYBOgAkGJtR6/x21Yr7OvHAWMyDsUOs
         EO87in1v3OP/fxdJ+Bv5gTzf1eoEn1gyU32YQyDQPo69cbZDUsXPvLKQKq7XibvupYsb
         skcQ==
X-Gm-Message-State: APjAAAUuAoHG+/BaXojqE3l/dHNOP31fNZFsZx4sIWEOGHSRsafn7njV
        h4mj2FUZb2yzZs0t8LbbGI1i7w==
X-Google-Smtp-Source: APXvYqxz+Hz/5FrdhT1hx2qiHg7uaLX2nAEztIwQvYM9zGM4AC1xpxSjX5jKuSP2txI1IC+YmgjZfQ==
X-Received: by 2002:a17:90a:23ce:: with SMTP id g72mr2717106pje.77.1565251203056;
        Thu, 08 Aug 2019 01:00:03 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id t8sm107697374pfq.31.2019.08.08.01.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 01:00:02 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH 1/2] riscv: Correct the initialized flow of FP register
Date:   Thu,  8 Aug 2019 15:58:40 +0800
Message-Id: <1565251121-28490-2-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com>
References: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  The following two reasons cause FP registers are sometimes not
initialized before starting the user program.
1. Currently, the FP context is initialized in flush_thread() function
   and we expect these initial values to be restored to FP register when
   doing FP context switch. However, the FP context switch only occurs in
   switch_to function. Hence, if this process does not be scheduled out
   and scheduled in before entering the user space, the FP registers
   have no chance to initialize.
2. In flush_thread(), the state of reg->sstatus.FS inherits from the
   parent. Hence, the state of reg->sstatus.FS may be dirty. If this
   process is scheduled out during flush_thread() and initializing the
   FP register, the fstate_save() in switch_to will corrupt the FP context
   which has been initialized until flush_thread().

  To solve the 1st case, the initialization of the FP register will be
completed in start_thread(). It makes sure all FP registers are initialized
before starting the user program. For the 2nd case, the state of
reg->sstatus.FS in start_thread will be set to SR_FS_OFF to prevent this
process from corrupting FP context in doing context save. The FP state is
set to SR_FS_INITIAL in start_trhead().

Tested on both QEMU and HiFive Unleashed using BBL + Linux.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/include/asm/switch_to.h |  6 ++++++
 arch/riscv/kernel/process.c        | 13 +++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 853b65e..d5fe573 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -19,6 +19,12 @@ static inline void __fstate_clean(struct pt_regs *regs)
 	regs->sstatus |= (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
 }
 
+static inline void fstate_off(struct task_struct *task,
+			       struct pt_regs *regs)
+{
+	regs->sstatus = (regs->sstatus & ~(SR_FS)) | SR_FS_OFF;
+}
+
 static inline void fstate_save(struct task_struct *task,
 			       struct pt_regs *regs)
 {
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index f23794b..e3077ee 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -64,8 +64,16 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	unsigned long sp)
 {
 	regs->sstatus = SR_SPIE;
-	if (has_fpu)
+	if (has_fpu) {
 		regs->sstatus |= SR_FS_INITIAL;
+#ifdef CONFIG_FPU
+		/*
+		 * Restore the initial value to the FP register
+		 * before starting the user program.
+		 */
+		fstate_restore(current, regs);
+#endif
+	}
 	regs->sepc = pc;
 	regs->sp = sp;
 	set_fs(USER_DS);
@@ -75,10 +83,11 @@ void flush_thread(void)
 {
 #ifdef CONFIG_FPU
 	/*
-	 * Reset FPU context
+	 * Reset FPU state and context
 	 *	frm: round to nearest, ties to even (IEEE default)
 	 *	fflags: accrued exceptions cleared
 	 */
+	fstate_off(current, task_pt_regs(current));
 	memset(&current->thread.fstate, 0, sizeof(current->thread.fstate));
 #endif
 }
-- 
2.7.4

