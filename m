Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8A5C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6160C24672
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578408152;
	bh=cjW3VpEhanSDswDdaLUFwMz9ERKCfJDfRsdtFI71+44=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CIukMlid+Zsyj4SoWjTVbuhDK28SOj9hW01wc7DSKkULFt8B2nddzkIiKrDViB3/1
	 37GMd1rF4V00zvg7lERzCluir6utzAjiag1693gPRr0isgPDqb/IbYDQNDgDzfrI9i
	 z/bEhk6yaGZBM6YePFZZZXao8asWRc/4Mh5TK0SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgAGOmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgAGOmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:42:31 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0540020715;
        Tue,  7 Jan 2020 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578408149;
        bh=cjW3VpEhanSDswDdaLUFwMz9ERKCfJDfRsdtFI71+44=;
        h=From:To:Cc:Subject:Date:From;
        b=IOsSr1YWp5IM6PBsDfKTfKQefUs5X3Un5Y/MlPoY2wQetzIV5AiIFWrH1bmGgEzoF
         nC+AG17GnzvFZ7rm0GjGf1HamA3fisnuebWNUs+bPullSwEHh1Iw9mXrftw0ZmKXJg
         qz//K2gOHmKzkWVAE3d4H9VcP+fTOHB+rXeZ+BM8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUGFIX PATCH] kprobes: Fix to cancel optimizing/unoptimizing kprobes correctly
Date:   Tue,  7 Jan 2020 23:42:24 +0900
Message-Id: <157840814418.7181.13478003006386303481.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

optimize_kprobe() and unoptimize_kprobe() cancels if given kprobe
is on the optimizing_list or unoptimizing_list. However, since
commit f66c0447cca1 ("kprobes: Set unoptimized flag after
unoptimizing code") modified the update timing of the
KPROBE_FLAG_OPTIMIZED, it doesn't work as expected anymore.

The optimized_kprobe could be following states.

- [optimizing]: Before inserting jump instruction
  op.kp->flags has KPROBE_FLAG_OPTIMIZED and
  op->list is not empty.

- [optimized]: jump inserted
  op.kp->flags has KPROBE_FLAG_OPTIMIZED and
  op->list is empty.

- [unoptimizing]: Before removing jump instruction (including unused
  optprobe)
  op.kp->flags has KPROBE_FLAG_OPTIMIZED and
  op->list is not empty.

- [unoptimized]: jump removed
  op.kp->flags doesn't have KPROBE_FLAG_OPTIMIZED and
  op->list is empty.

Current code mis-expects [unoptimizing] state doesn't have
KPROBE_FLAG_OPTIMIZED, and that can cause wrong results.

This introduces optprobe_queued_unopt() to distinguish [optimizing]
and [unoptimizing] states and fixes logics in optimize_kprobe() and
unoptimize_kprobe().

Fixes: f66c0447cca1 ("kprobes: Set unoptimized flag after unoptimizing code")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   65 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 34e28b236d68..d898b633f1d6 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -612,6 +612,16 @@ void wait_for_kprobe_optimizer(void)
 	mutex_unlock(&kprobe_mutex);
 }
 
+static bool optprobe_queued_unopt(struct optimized_kprobe *op)
+{
+	struct optimized_kprobe *_op;
+
+	list_for_each_entry(_op, &unoptimizing_list, list)
+		if (op == _op)
+			return true;
+	return false;
+}
+
 /* Optimize kprobe if p is ready to be optimized */
 static void optimize_kprobe(struct kprobe *p)
 {
@@ -633,17 +643,21 @@ static void optimize_kprobe(struct kprobe *p)
 		return;
 
 	/* Check if it is already optimized. */
-	if (op->kp.flags & KPROBE_FLAG_OPTIMIZED)
+	if (op->kp.flags & KPROBE_FLAG_OPTIMIZED) {
+		if (optprobe_queued_unopt(op)) {
+			/* This is under unoptimizing. Just dequeue the probe */
+			list_del_init(&op->list);
+		}
 		return;
+	}
 	op->kp.flags |= KPROBE_FLAG_OPTIMIZED;
 
-	if (!list_empty(&op->list))
-		/* This is under unoptimizing. Just dequeue the probe */
-		list_del_init(&op->list);
-	else {
-		list_add(&op->list, &optimizing_list);
-		kick_kprobe_optimizer();
-	}
+	/* On unoptimizing/optimizing_list, op must have OPTIMIZED flag */
+	if (WARN_ON_ONCE(!list_empty(&op->list)))
+		return;
+
+	list_add(&op->list, &optimizing_list);
+	kick_kprobe_optimizer();
 }
 
 /* Short cut to direct unoptimizing */
@@ -665,30 +679,33 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 		return; /* This is not an optprobe nor optimized */
 
 	op = container_of(p, struct optimized_kprobe, kp);
-	if (!kprobe_optimized(p)) {
-		/* Unoptimized or unoptimizing case */
-		if (force && !list_empty(&op->list)) {
-			/*
-			 * Only if this is unoptimizing kprobe and forced,
-			 * forcibly unoptimize it. (No need to unoptimize
-			 * unoptimized kprobe again :)
-			 */
-			list_del_init(&op->list);
-			force_unoptimize_kprobe(op);
-		}
+	if (!kprobe_optimized(p))
 		return;
-	}
 
 	if (!list_empty(&op->list)) {
-		/* Dequeue from the optimization queue */
-		list_del_init(&op->list);
+		if (optprobe_queued_unopt(op)) {
+			/* Queued in unoptimizing queue */
+			if (force) {
+				/*
+				 * Forcibly unoptimize probe here, and queue it
+				 * in freeing list for release probe afterwards.
+				 */
+				force_unoptimize_kprobe(op);
+				list_move(&op->list, &freeing_list);
+			}
+		} else {
+			/* Dequeue from the optimizing queue */
+			list_del_init(&op->list);
+			op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
+		}
 		return;
 	}
+
 	/* Optimized kprobe case */
-	if (force)
+	if (force) {
 		/* Forcibly update the code: this is a special case */
 		force_unoptimize_kprobe(op);
-	else {
+	} else {
 		list_add(&op->list, &unoptimizing_list);
 		kick_kprobe_optimizer();
 	}

