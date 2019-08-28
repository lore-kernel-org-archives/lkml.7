Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96A7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAB722DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DQgpMf8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfH1Tip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:38:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39809 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfH1Tip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:38:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id g8so1292202edm.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v6I0NxJQJkD1JgL9Whr1E8kXbKnnwerSju7V9v+AMdA=;
        b=DQgpMf8ao0gcsEtBQ7MRr/p3CHj1R5lHbOEo69FnLPGYitpp4vCxTy9KpNSIGqPaHS
         FukOT0+NWkJm2PbBnj1hhcvBTdsWnKOnM6V+aF1EQ/b267OOWqzKVlprsDDJEEMg19e+
         9VMRsZyhg5YF1lEupwdc0HAhuXSCI+n7hxm3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v6I0NxJQJkD1JgL9Whr1E8kXbKnnwerSju7V9v+AMdA=;
        b=SyLXsxZDWfyg+eWNs0d9ALfwSDWKpt0C7z4wPgpqnV6h9dkFnOPgtkYQAvNNRfHp+e
         a9GLKmcJYNdrizpoJGNjJSm4ndgl9RurcN3WfOf0BxaN63lDHsxRgPSxSitQwkBIzyzJ
         WHP3Mzrs12lyQ3QdyAbARQgG3n996yEFZDEzO/THAenO/saNpdyLbJzjc9klH8lZILPP
         DieZ5htDF3QDSn7DUYfqWtYEkQLUdKNizHYC8cPTNHU6Ed93vtbYRx0PElwQq2r0ow7o
         l6YH25Jv7pqrfJGJ2Da2DGbhOfGk7O5RFEX4kOcrXbaj9AGPkLQb2kgium89OSdHFLwr
         s/KA==
X-Gm-Message-State: APjAAAVvDPVk6lUvMtpr6FrB/47NKBcaQI4An9cSgSeqPd2ykE+hKsJK
        4hwsFH92eDdhdfHSizY4W796Xw==
X-Google-Smtp-Source: APXvYqwBlQWZhg2J452zDKYW5Hy49ik9wm4fiM1ibr/NRl10YSHYjbPZQkOkBKGwDg9H98uus9/xsQ==
X-Received: by 2002:a50:b825:: with SMTP id j34mr6104619ede.58.1567021123668;
        Wed, 28 Aug 2019 12:38:43 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id ni7sm38990ejb.57.2019.08.28.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 12:38:43 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86: mmu.h: move mm_context_t::lock member inside CONFIG_MODIFY_LDT_SYSCALL
Date:   Wed, 28 Aug 2019 21:38:35 +0200
Message-Id: <20190828193836.16791-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The placement of the lock member in mm_context_t suggests that it is
used to protect the vdso* members, but AFAICT, it is only ever used
under #ifdef CONFIG_MODIFY_LDT_SYSCALL. So guarding the member by the
same config option is a cheap way to reduce sizeof(mm_struct) by 32
bytes (only for !CONFIG_MODIFY_LDT_SYSCALL kernels, of course).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/include/asm/mmu.h         | 11 ++++++++---
 arch/x86/include/asm/mmu_context.h |  3 +--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index e78c7db87801..b1bb47a3577b 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -30,14 +30,13 @@ typedef struct {
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	struct rw_semaphore	ldt_usr_sem;
 	struct ldt_struct	*ldt;
+	struct mutex		lock;
 #endif
-
 #ifdef CONFIG_X86_64
 	/* True if mm supports a task running in 32 bit compatibility mode. */
 	unsigned short ia32_compat;
 #endif
 
-	struct mutex lock;
 	void __user *vdso;			/* vdso base address */
 	const struct vdso_image *vdso_image;	/* vdso image in use */
 
@@ -56,10 +55,16 @@ typedef struct {
 #endif
 } mm_context_t;
 
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+#define INIT_MM_CONTEXT_LOCK(mm) .lock = __MUTEX_INITIALIZER(mm.context.lock),
+#else
+#define INIT_MM_CONTEXT_LOCK(mm)
+#endif
+
 #define INIT_MM_CONTEXT(mm)						\
 	.context = {							\
 		.ctx_id = 1,						\
-		.lock = __MUTEX_INITIALIZER(mm.context.lock),		\
+		INIT_MM_CONTEXT_LOCK(mm)				\
 	}
 
 void leave_mm(int cpu);
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 9024236693d2..ac8e3ef8a774 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -82,6 +82,7 @@ static inline void init_new_context_ldt(struct mm_struct *mm)
 {
 	mm->context.ldt = NULL;
 	init_rwsem(&mm->context.ldt_usr_sem);
+	mutex_init(&mm->context.lock);
 }
 int ldt_dup_context(struct mm_struct *oldmm, struct mm_struct *mm);
 void destroy_context_ldt(struct mm_struct *mm);
@@ -186,8 +187,6 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
-	mutex_init(&mm->context.lock);
-
 	mm->context.ctx_id = atomic64_inc_return(&last_mm_ctx_id);
 	atomic64_set(&mm->context.tlb_gen, 0);
 
-- 
2.20.1

