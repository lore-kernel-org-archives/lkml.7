Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91127C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B07F20850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfDNUkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:40:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNUkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:40:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKdYTO2689592
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:39:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKdYMU2689587;
        Sun, 14 Apr 2019 13:39:34 -0700
Date:   Sun, 14 Apr 2019 13:39:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-6a28b4c2d93b812512d8d2e5179e61a14f578560@git.kernel.org>
Cc:     schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org, luto@kernel.org,
        jpoimboe@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        glider@google.com
Reply-To: luto@kernel.org, peterz@infradead.org, glider@google.com,
          hpa@zytor.com, jpoimboe@redhat.com, tglx@linutronix.de,
          mingo@kernel.org, rostedt@goodmis.org,
          linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
          heiko.carstens@de.ibm.com
In-Reply-To: <20190410103644.396788431@linutronix.de>
References: <20190410103644.396788431@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] s390/stacktrace: Remove the pointless
 ULONG_MAX marker
Git-Commit-ID: 6a28b4c2d93b812512d8d2e5179e61a14f578560
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

Commit-ID:  6a28b4c2d93b812512d8d2e5179e61a14f578560
Gitweb:     https://git.kernel.org/tip/6a28b4c2d93b812512d8d2e5179e61a14f578560
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:28:03 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:29 +0200

s390/stacktrace: Remove the pointless ULONG_MAX marker

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
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Link: https://lkml.kernel.org/r/20190410103644.396788431@linutronix.de

---
 arch/s390/kernel/stacktrace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index 460dcfba7d4e..cc9ed9787068 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -45,8 +45,6 @@ void save_stack_trace(struct stack_trace *trace)
 
 	sp = current_stack_pointer();
 	dump_trace(save_address, trace, NULL, sp);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace);
 
@@ -58,8 +56,6 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	if (tsk == current)
 		sp = current_stack_pointer();
 	dump_trace(save_address_nosched, trace, tsk, sp);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
@@ -69,7 +65,5 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 
 	sp = kernel_stack_pointer(regs);
 	dump_trace(save_address, trace, NULL, sp);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_regs);
