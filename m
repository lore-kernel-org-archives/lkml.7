Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A77C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090A82082E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfDNUgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:36:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39873 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNUgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:36:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKZVWN2688920
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:35:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKZUDx2688917;
        Sun, 14 Apr 2019 13:35:30 -0700
Date:   Sun, 14 Apr 2019 13:35:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2a2bcfa0c94d8bc4770676a6799928036296c037@git.kernel.org>
Cc:     jpoimboe@redhat.com, hpa@zytor.com, glider@google.com,
        luto@kernel.org, linux@armlinux.org.uk, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Reply-To: jpoimboe@redhat.com, hpa@zytor.com, glider@google.com,
          luto@kernel.org, linux@armlinux.org.uk, tglx@linutronix.de,
          mingo@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190410103643.843075256@linutronix.de>
References: <20190410103643.843075256@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] arm/stacktrace: Remove the pointless
 ULONG_MAX marker
Git-Commit-ID: 2a2bcfa0c94d8bc4770676a6799928036296c037
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

Commit-ID:  2a2bcfa0c94d8bc4770676a6799928036296c037
Gitweb:     https://git.kernel.org/tip/2a2bcfa0c94d8bc4770676a6799928036296c037
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:27:57 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:27 +0200

arm/stacktrace: Remove the pointless ULONG_MAX marker

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
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lkml.kernel.org/r/20190410103643.843075256@linutronix.de

---
 arch/arm/kernel/stacktrace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index a56e7c856ab5..86870f40f9a0 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -115,8 +115,6 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 		 * running on another CPU?  For now, ignore it as we
 		 * can't guarantee we won't explode.
 		 */
-		if (trace->nr_entries < trace->max_entries)
-			trace->entries[trace->nr_entries++] = ULONG_MAX;
 		return;
 #else
 		frame.fp = thread_saved_fp(tsk);
@@ -134,8 +132,6 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 	}
 
 	walk_stackframe(&frame, save_trace, &data);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 
 void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
@@ -153,8 +149,6 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	frame.pc = regs->ARM_pc;
 
 	walk_stackframe(&frame, save_trace, &data);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
