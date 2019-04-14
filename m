Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6A2C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135282082E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDNUfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:35:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49491 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNUfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:35:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKYmbI2688798
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:34:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKYlu82688795;
        Sun, 14 Apr 2019 13:34:47 -0700
Date:   Sun, 14 Apr 2019 13:34:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c5c27a0a583844c69a433039e4fd6396ba23551b@git.kernel.org>
Cc:     tglx@linutronix.de, luto@kernel.org, hpa@zytor.com,
        mingo@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        glider@google.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, luto@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
          glider@google.com, peterz@infradead.org, mingo@kernel.org,
          rostedt@goodmis.org
In-Reply-To: <20190410103643.750954603@linutronix.de>
References: <20190410103643.750954603@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] x86/stacktrace: Remove the pointless
 ULONG_MAX marker
Git-Commit-ID: c5c27a0a583844c69a433039e4fd6396ba23551b
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

Commit-ID:  c5c27a0a583844c69a433039e4fd6396ba23551b
Gitweb:     https://git.kernel.org/tip/c5c27a0a583844c69a433039e4fd6396ba23551b
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:27:56 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:27 +0200

x86/stacktrace: Remove the pointless ULONG_MAX marker

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
Link: https://lkml.kernel.org/r/20190410103643.750954603@linutronix.de

---
 arch/x86/kernel/stacktrace.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 5c2d71a1dc06..b2f706f1e0b7 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -46,9 +46,6 @@ static void noinline __save_stack_trace(struct stack_trace *trace,
 		if (!addr || save_stack_address(trace, addr, nosched))
 			break;
 	}
-
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 
 /*
@@ -97,7 +94,7 @@ __save_stack_trace_reliable(struct stack_trace *trace,
 		if (regs) {
 			/* Success path for user tasks */
 			if (user_mode(regs))
-				goto success;
+				return 0;
 
 			/*
 			 * Kernel mode registers on the stack indicate an
@@ -132,10 +129,6 @@ __save_stack_trace_reliable(struct stack_trace *trace,
 	if (!(task->flags & (PF_KTHREAD | PF_IDLE)))
 		return -EINVAL;
 
-success:
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
-
 	return 0;
 }
 
@@ -221,9 +214,6 @@ void save_stack_trace_user(struct stack_trace *trace)
 	/*
 	 * Trace user stack if we are not a kernel thread
 	 */
-	if (current->mm) {
+	if (current->mm)
 		__save_stack_trace_user(trace);
-	}
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
