Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C15C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5BF208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZfvFzV82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfHNIYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:24:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42913 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfHNIX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:23:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so4431637pfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=355/fM8G6OID12UiIjtTxx4G3WOw7wrHVjqcAOVdVjM=;
        b=ZfvFzV82vpyyn+70V/08TU9H+meQN6zQkx8KP1zphiFbhxeeSxdBYZf8SGiM2El89/
         VaGw1EczgJ2KWru4TAyQEKsc6cCufq6NsaqtrZAkXM10TrzDPzz2TxDee6VQI+sRB99/
         1Rp5NtJyscgRoFzyuFG+ujdvNWzsKUyXGQlWT5FyX/L31Yu4Zj3g/4UyObiOlVkijRen
         lCragje8ySbRcq/IRtDGeEiWQ+c1A2QEspRdnzkB5iyrqx5MBV6JXnR+8/zWbaQt0r0R
         2ROiYSEovMAVEYGeYf69soEIq5t5rorhMUenmWnDQjyRHcvzW2HAkW4zNPXzMTRz96B6
         HhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=355/fM8G6OID12UiIjtTxx4G3WOw7wrHVjqcAOVdVjM=;
        b=APD37mUkkmxx9jSMsco5azyNEGgSb+4Wfy5vJsrbija1vZh8Nw3aL7H+YVXUzSJoz0
         tzzCFszjh+NDLb+l3PMgI3lL0tDqZ39T4jaZJmiBJl/ICriaK3xNltjmkIEoxy8FPlEj
         INA0GiFoLNxRR9JY56ive2lQ8UbEGTJN+lGejmImwbl1OdWVh8vEuL87e7TNoX/uD00i
         8//v2FIKKmD6ysKTHV8I91kmfKDOgACKn3UDMPGwmtK3fdyznRVi7URa0NfXM+PPUWkP
         JcwItrEgBN6tnoZci/64kacmQ1eBG4sh0+MB15+6c/uqtcUJi4DjArjTrXPXRBY/pKnh
         OEUw==
X-Gm-Message-State: APjAAAUMaAVrlb9/ipaO3/xus6DG54O67T2x1XjJ6HlHBblgDPtCFZZR
        cjs0fkqXol2qWyJxUPWbTDrVzg==
X-Google-Smtp-Source: APXvYqywRx18R0hMG2RnROTtsgpH40TUafc/j8X3By4v7TBusOlcABsMHZE9qz0KUcqdzr7Mh5i54w==
X-Received: by 2002:a63:61cd:: with SMTP id v196mr38524614pgb.263.1565771039143;
        Wed, 14 Aug 2019 01:23:59 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id f205sm12359152pfa.161.2019.08.14.01.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Aug 2019 01:23:58 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v2 1/2] riscv: Correct the initialized flow of FP register
Date:   Wed, 14 Aug 2019 16:23:52 +0800
Message-Id: <1565771033-1831-2-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565771033-1831-1-git-send-email-vincent.chen@sifive.com>
References: <1565771033-1831-1-git-send-email-vincent.chen@sifive.com>
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

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---
 arch/riscv/include/asm/switch_to.h |  6 ++++++
 arch/riscv/kernel/process.c        | 11 +++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 853b65e..0575b8a 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -19,6 +19,12 @@ static inline void __fstate_clean(struct pt_regs *regs)
 	regs->sstatus |= (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
 }
 
+static inline void fstate_off(struct task_struct *task,
+			       struct pt_regs *regs)
+{
+	regs->sstatus = (regs->sstatus & ~SR_FS) | SR_FS_OFF;
+}
+
 static inline void fstate_save(struct task_struct *task,
 			       struct pt_regs *regs)
 {
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index f23794b..fb3a082 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -64,8 +64,14 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	unsigned long sp)
 {
 	regs->sstatus = SR_SPIE;
-	if (has_fpu)
+	if (has_fpu) {
 		regs->sstatus |= SR_FS_INITIAL;
+		/*
+		 * Restore the initial value to the FP register
+		 * before starting the user program.
+		 */
+		fstate_restore(current, regs);
+	}
 	regs->sepc = pc;
 	regs->sp = sp;
 	set_fs(USER_DS);
@@ -75,10 +81,11 @@ void flush_thread(void)
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

