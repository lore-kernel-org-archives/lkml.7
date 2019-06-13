Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46515C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2EA21721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MLGchTjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfFMTId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:08:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfFMTId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:08:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5DJ7DmZ1314171
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 13 Jun 2019 12:07:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5DJ7DmZ1314171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560452834;
        bh=agiqwfohILXjIImlF3CLGf5swTtJl1GxmhuS2kIPfEI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MLGchTjn5cspHXoUZ6XRKkwn7NiVjtKWQIqPuvmN4svsovldsNVyiwcVqk26uDl39
         y0V9nab27SLfXRWcBt5t65k8pfEsgmqTlavw7pCg8hYUOA7ICGjwjatTcH76u7GGpZ
         KLhI4fExnY606XyMA7bQD/5zyHrTiOoKd65dXBaZtY+pUxPwJuVB/6LGEj2McTMmpf
         jnlVJUmpRxWRFfFgJJ/o2hMHSgtqpyU4jxnDTR0i1+u+FvY9gdY6Zk5H7fPoLTJHKV
         7HJDTXh2xherMPQpWgXKHolVYfRbeZOMdfKd+lRH3E4HdNxDb+uKKN2sC0LlwIWaxO
         DNz0+3X4Ik8ig==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5DJ7D2p1314168;
        Thu, 13 Jun 2019 12:07:13 -0700
Date:   Thu, 13 Jun 2019 12:07:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-8d3289f2fa1e0c7e2f72c7352f1efb75d2ad7c76@git.kernel.org>
Cc:     bigeasy@linutronix.de, hch@lst.de, jannh@google.com, bp@suse.de,
        mingo@redhat.com, aubrey.li@intel.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org,
        tglx@linutronix.de, riel@surriel.com, mingo@kernel.org,
        nstange@suse.de, peterz@infradead.org
Reply-To: tglx@linutronix.de, riel@surriel.com, x86@kernel.org,
          nstange@suse.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, peterz@infradead.org, hch@lst.de,
          jannh@google.com, bp@suse.de, bigeasy@linutronix.de,
          dave.hansen@intel.com, mingo@redhat.com, aubrey.li@intel.com
In-Reply-To: <20190604175411.GA27477@lst.de>
References: <20190604175411.GA27477@lst.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/fpu: Don't use current->mm to check for a
 kthread
Git-Commit-ID: 8d3289f2fa1e0c7e2f72c7352f1efb75d2ad7c76
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8d3289f2fa1e0c7e2f72c7352f1efb75d2ad7c76
Gitweb:     https://git.kernel.org/tip/8d3289f2fa1e0c7e2f72c7352f1efb75d2ad7c76
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Tue, 4 Jun 2019 19:54:12 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 13 Jun 2019 20:57:49 +0200

x86/fpu: Don't use current->mm to check for a kthread

current->mm can be non-NULL if a kthread calls use_mm(). Check for
PF_KTHREAD instead to decide when to store user mode FP state.

Fixes: 2722146eb784 ("x86/fpu: Remove fpu->initialized")
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190604175411.GA27477@lst.de
---
 arch/x86/include/asm/fpu/internal.h | 6 +++---
 arch/x86/kernel/fpu/core.c          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

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
index 466fca686fb9..649fbc3fcf9f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -102,7 +102,7 @@ static void __kernel_fpu_begin(void)
 
 	kernel_fpu_disable();
 
-	if (current->mm) {
+	if (!(current->flags & PF_KTHREAD)) {
 		if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
 			set_thread_flag(TIF_NEED_FPU_LOAD);
 			/*
