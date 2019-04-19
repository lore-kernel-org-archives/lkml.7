Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5C9C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6039D20643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pwG/ClYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfDSTEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:04:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729248AbfDSTEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:04:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JCsTv9276779
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 05:54:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JCsTv9276779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555678469;
        bh=Iqaor1cbvLtRWJMnWDJmRtYIP+w7qS/RRzkzMK/1D+E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pwG/ClYyIxs09sUGJekfggTWuM3yNnrQghXevMa5OdHqW6geGTs+xS96vDx9tUEPs
         kHSwzxh9Y9VWdiJjsPc64GTENvVAq/4gUu/fKE2IHCBDv1VISNC8kYcEm+NbvnTYLg
         V1KTSlGySKsbBGEcuAhbxPwquJWfq6LFHCiog7WhFBrF0RlRJ76Qt1csKgZZJCgFwx
         Y+j3ovmm9IuVK8Y8FN19s6h/iEB2ZhMDwsgqx79qLMp39LMn/1F5G2LKATrlhFTSs2
         6UvPzamN68ogTZ1K9nElsCxFRw4sUcgpE4O1Su4Ood1ewv1AW2RRchcoYNFxhvKMd0
         bmELSo/Y3LPPg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JCsSok276776;
        Fri, 19 Apr 2019 05:54:28 -0700
Date:   Fri, 19 Apr 2019 05:54:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-b191fa96ea6dc00d331dcc28c1f7db5e075693a0@git.kernel.org>
Cc:     mhiramat@kernel.org, mingo@kernel.org, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, torvalds@linux-foundation.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, righi.andrea@gmail.com, hpa@zytor.com
Reply-To: hpa@zytor.com, righi.andrea@gmail.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, rostedt@goodmis.org,
          torvalds@linux-foundation.org, mingo@kernel.org,
          mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
          peterz@infradead.org
In-Reply-To: <155094064889.6137.972160690963039.stgit@devbox>
References: <155094064889.6137.972160690963039.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] x86/kprobes: Avoid kretprobe recursion bug
Git-Commit-ID: b191fa96ea6dc00d331dcc28c1f7db5e075693a0
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

Commit-ID:  b191fa96ea6dc00d331dcc28c1f7db5e075693a0
Gitweb:     https://git.kernel.org/tip/b191fa96ea6dc00d331dcc28c1f7db5e075693a0
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Sun, 24 Feb 2019 01:50:49 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 14:26:07 +0200

x86/kprobes: Avoid kretprobe recursion bug

Avoid kretprobe recursion loop bg by setting a dummy
kprobes to current_kprobe per-CPU variable.

This bug has been introduced with the asm-coded trampoline
code, since previously it used another kprobe for hooking
the function return placeholder (which only has a nop) and
trampoline handler was called from that kprobe.

This revives the old lost kprobe again.

With this fix, we don't see deadlock anymore.

And you can see that all inner-called kretprobe are skipped.

  event_1                                  235               0
  event_2                                19375           19612

The 1st column is recorded count and the 2nd is missed count.
Above shows (event_1 rec) + (event_2 rec) ~= (event_2 missed)
(some difference are here because the counter is racy)

Reported-by: Andrea Righi <righi.andrea@gmail.com>
Tested-by: Andrea Righi <righi.andrea@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: c9becf58d935 ("[PATCH] kretprobe: kretprobe-booster")
Link: http://lkml.kernel.org/r/155094064889.6137.972160690963039.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 18fbe9be2d68..fed46ddb1eef 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -749,11 +749,16 @@ asm(
 NOKPROBE_SYMBOL(kretprobe_trampoline);
 STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
 
+static struct kprobe kretprobe_kprobe = {
+	.addr = (void *)kretprobe_trampoline,
+};
+
 /*
  * Called from kretprobe_trampoline
  */
 static __used void *trampoline_handler(struct pt_regs *regs)
 {
+	struct kprobe_ctlblk *kcb;
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head, empty_rp;
 	struct hlist_node *tmp;
@@ -763,6 +768,17 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 	void *frame_pointer;
 	bool skipped = false;
 
+	preempt_disable();
+
+	/*
+	 * Set a dummy kprobe for avoiding kretprobe recursion.
+	 * Since kretprobe never run in kprobe handler, kprobe must not
+	 * be running at this point.
+	 */
+	kcb = get_kprobe_ctlblk();
+	__this_cpu_write(current_kprobe, &kretprobe_kprobe);
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+
 	INIT_HLIST_HEAD(&empty_rp);
 	kretprobe_hash_lock(current, &head, &flags);
 	/* fixup registers */
@@ -838,10 +854,9 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 		orig_ret_address = (unsigned long)ri->ret_addr;
 		if (ri->rp && ri->rp->handler) {
 			__this_cpu_write(current_kprobe, &ri->rp->kp);
-			get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
 			ri->ret_addr = correct_ret_addr;
 			ri->rp->handler(ri, regs);
-			__this_cpu_write(current_kprobe, NULL);
+			__this_cpu_write(current_kprobe, &kretprobe_kprobe);
 		}
 
 		recycle_rp_inst(ri, &empty_rp);
@@ -857,6 +872,9 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 
 	kretprobe_hash_unlock(current, &flags);
 
+	__this_cpu_write(current_kprobe, NULL);
+	preempt_enable();
+
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
 		kfree(ri);
