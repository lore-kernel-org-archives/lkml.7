Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F01DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111692075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFDRyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:54:39 -0400
Received: from verein.lst.de ([213.95.11.211]:37806 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfFDRyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:54:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2EF3368B05; Tue,  4 Jun 2019 19:54:12 +0200 (CEST)
Date:   Tue, 4 Jun 2019 19:54:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/3] x86/fpu: don't use current->mm to check for a kthread
Message-ID: <20190604175411.GA27477@lst.de>
References: <20190604071524.12835-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604071524.12835-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current->mm can be non-NULL if a kthread calls use_mm.  Check for
PF_KTHREAD instead to decide when to store user mode FP state.

Fixes: 2722146eb784 ("x86/fpu: Remove fpu->initialized")
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/fpu/internal.h | 6 +++---
 arch/x86/kernel/fpu/core.c          | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 9e27fa05a7ae..4c95c365058a 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -536,7 +536,7 @@ static inline void __fpregs_load_activate(void)
 	struct fpu *fpu = &current->thread.fpu;
 	int cpu = smp_processor_id();
 
-	if (WARN_ON_ONCE(current->mm == NULL))
+	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
@@ -567,11 +567,11 @@ static inline void __fpregs_load_activate(void)
  * otherwise.
  *
  * The FPU context is only stored/restored for a user task and
- * ->mm is used to distinguish between kernel and user threads.
+ * PF_KTHREAD is used to distinguish between kernel and user threads.
  */
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
-	if (static_cpu_has(X86_FEATURE_FPU) && current->mm) {
+	if (static_cpu_has(X86_FEATURE_FPU) && !(current->flags & PF_KTHREAD)) {
 		if (!copy_fpregs_to_fpstate(old_fpu))
 			old_fpu->last_cpu = -1;
 		else
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 5e0240d029fd..12c70840980e 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -91,7 +91,8 @@ void kernel_fpu_begin(void)
 
 	this_cpu_write(in_kernel_fpu, true);
 
-	if (current->mm && !test_thread_flag(TIF_NEED_FPU_LOAD)) {
+	if (!(current->flags & PF_KTHREAD) &&
+	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 		/*
 		 * Ignore return value -- we don't care if reg state
-- 
2.20.1

