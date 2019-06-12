Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3FDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B632082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfFLLWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:22:16 -0400
Received: from sym2.noone.org ([178.63.92.236]:57166 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbfFLLWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:22:15 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jun 2019 07:22:15 EDT
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 45P47J10YMzvjc1; Wed, 12 Jun 2019 13:16:11 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] csky: remove unsued thread_saved_pc and *_segments functions/macros
Date:   Wed, 12 Jun 2019 13:16:11 +0200
Message-Id: <20190612111611.13058-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are used nowhere in the tree (except for some architectures which
define them for their own use) and were already removed in:

commit 6474924e2b5d ("arch: remove unused macro/function thread_saved_pc()")
commit c17c02040bf0 ("arch: remove unused *_segments() macros/functions")

Remove them from arch/csky as well.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/csky/include/asm/processor.h |  6 ------
 arch/csky/kernel/process.c        | 10 ----------
 2 files changed, 16 deletions(-)

diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index 21e0bd5293dd..464575156f0f 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -83,12 +83,6 @@ static inline void release_thread(struct task_struct *dead_task)
 
 extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-#define forget_segments()		do { } while (0)
-
-extern unsigned long thread_saved_pc(struct task_struct *tsk);
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index e555740c0be5..adeb6b1bdb42 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -24,16 +24,6 @@ asmlinkage void ret_from_kernel_thread(void);
  */
 void flush_thread(void){}
 
-/*
- * Return saved PC from a blocked thread
- */
-unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
-
-	return sw->r15;
-}
-
 int copy_thread(unsigned long clone_flags,
 		unsigned long usp,
 		unsigned long kthread_arg,
-- 
2.20.0

