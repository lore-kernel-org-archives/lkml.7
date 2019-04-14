Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945BFC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD9320870
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfDNUje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:39:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42495 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNUjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:39:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKcrh62689345
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:38:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKcqsO2689342;
        Sun, 14 Apr 2019 13:38:52 -0700
Date:   Sun, 14 Apr 2019 13:38:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-4f3bd6ca310b594df09c8f1e319cda9baf502ec8@git.kernel.org>
Cc:     James.Bottomley@HansenPartnership.com, hpa@zytor.com,
        glider@google.com, mingo@kernel.org, rostedt@goodmis.org,
        luto@kernel.org, tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, deller@gmx.de
Reply-To: glider@google.com, James.Bottomley@HansenPartnership.com,
          hpa@zytor.com, rostedt@goodmis.org, deller@gmx.de,
          peterz@infradead.org, mingo@kernel.org, luto@kernel.org,
          tglx@linutronix.de, jpoimboe@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190410103644.308534788@linutronix.de>
References: <20190410103644.308534788@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] parisc/stacktrace: Remove the pointless
 ULONG_MAX marker
Git-Commit-ID: 4f3bd6ca310b594df09c8f1e319cda9baf502ec8
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

Commit-ID:  4f3bd6ca310b594df09c8f1e319cda9baf502ec8
Gitweb:     https://git.kernel.org/tip/4f3bd6ca310b594df09c8f1e319cda9baf502ec8
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:28:02 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:29 +0200

parisc/stacktrace: Remove the pointless ULONG_MAX marker

Terminating the last trace entry with ULONG_MAX is a completely pointless
exercise and none of the consumers can rely on it because it's
inconsistently implemented across architectures. In fact quite some of the
callers remove the entry and adjust stack_trace.nr_entries afterwards.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Link: https://lkml.kernel.org/r/20190410103644.308534788@linutronix.de

---
 arch/parisc/kernel/stacktrace.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/parisc/kernel/stacktrace.c b/arch/parisc/kernel/stacktrace.c
index ec5835e83a7a..6f0b9c8d8052 100644
--- a/arch/parisc/kernel/stacktrace.c
+++ b/arch/parisc/kernel/stacktrace.c
@@ -29,22 +29,17 @@ static void dump_trace(struct task_struct *task, struct stack_trace *trace)
 	}
 }
 
-
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
  */
 void save_stack_trace(struct stack_trace *trace)
 {
 	dump_trace(current, trace);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace);
 
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
 	dump_trace(tsk, trace);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
