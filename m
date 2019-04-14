Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20439C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3DD2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfDNUhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:37:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44683 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNUhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:37:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKaD0I2689172
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:36:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKaB5u2689163;
        Sun, 14 Apr 2019 13:36:11 -0700
Date:   Sun, 14 Apr 2019 13:36:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-b01f6d368d296cac099383a3eb200e135420f885@git.kernel.org>
Cc:     jpoimboe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dalias@libc.org, rostedt@goodmis.org,
        luto@kernel.org, mingo@kernel.org, glider@google.com,
        ysato@users.sourceforge.jp, kuninori.morimoto.gx@renesas.com,
        horms+renesas@verge.net.au, hpa@zytor.com
Reply-To: mingo@kernel.org, dalias@libc.org, rostedt@goodmis.org,
          luto@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
          peterz@infradead.org, hpa@zytor.com,
          kuninori.morimoto.gx@renesas.com, horms+renesas@verge.net.au,
          glider@google.com, ysato@users.sourceforge.jp
In-Reply-To: <20190410103643.932464393@linutronix.de>
References: <20190410103643.932464393@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] sh/stacktrace: Remove the pointless ULONG_MAX
 marker
Git-Commit-ID: b01f6d368d296cac099383a3eb200e135420f885
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

Commit-ID:  b01f6d368d296cac099383a3eb200e135420f885
Gitweb:     https://git.kernel.org/tip/b01f6d368d296cac099383a3eb200e135420f885
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:27:58 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:28 +0200

sh/stacktrace: Remove the pointless ULONG_MAX marker

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
Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sh@vger.kernel.org
Cc: Simon Horman <horms+renesas@verge.net.au>
Link: https://lkml.kernel.org/r/20190410103643.932464393@linutronix.de

---
 arch/sh/kernel/stacktrace.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sh/kernel/stacktrace.c b/arch/sh/kernel/stacktrace.c
index f3cb2cccb262..2950b19ad077 100644
--- a/arch/sh/kernel/stacktrace.c
+++ b/arch/sh/kernel/stacktrace.c
@@ -49,8 +49,6 @@ void save_stack_trace(struct stack_trace *trace)
 	unsigned long *sp = (unsigned long *)current_stack_pointer;
 
 	unwind_stack(current, NULL, sp,  &save_stack_ops, trace);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace);
 
@@ -84,7 +82,5 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	unsigned long *sp = (unsigned long *)tsk->thread.sp;
 
 	unwind_stack(current, NULL, sp,  &save_stack_ops_nosched, trace);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
