Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA3CC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7854520850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfDNUi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:38:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39385 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNUi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:38:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKcEgg2689304
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:38:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKcDob2689300;
        Sun, 14 Apr 2019 13:38:13 -0700
Date:   Sun, 14 Apr 2019 13:38:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7b2c7b6233497bfab8826ece574bc1c26e97478d@git.kernel.org>
Cc:     mingo@kernel.org, catalin.marinas@arm.com, rostedt@goodmis.org,
        peterz@infradead.org, hpa@zytor.com, will.deacon@arm.com,
        tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, glider@google.com
Reply-To: tglx@linutronix.de, jpoimboe@redhat.com,
          linux-kernel@vger.kernel.org, luto@kernel.org, glider@google.com,
          mingo@kernel.org, rostedt@goodmis.org, catalin.marinas@arm.com,
          peterz@infradead.org, hpa@zytor.com, will.deacon@arm.com
In-Reply-To: <20190410103644.220247845@linutronix.de>
References: <20190410103644.220247845@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] arm64/stacktrace: Remove the pointless
 ULONG_MAX marker
Git-Commit-ID: 7b2c7b6233497bfab8826ece574bc1c26e97478d
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

Commit-ID:  7b2c7b6233497bfab8826ece574bc1c26e97478d
Gitweb:     https://git.kernel.org/tip/7b2c7b6233497bfab8826ece574bc1c26e97478d
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:28:01 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:29 +0200

arm64/stacktrace: Remove the pointless ULONG_MAX marker

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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lkml.kernel.org/r/20190410103644.220247845@linutronix.de

---
 arch/arm64/kernel/stacktrace.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d908b5e9e949..b00ec7d483d1 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -140,8 +140,6 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 #endif
 
 	walk_stackframe(current, &frame, save_trace, &data);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_regs);
 
@@ -172,8 +170,6 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 #endif
 
 	walk_stackframe(tsk, &frame, save_trace, &data);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 
 	put_task_stack(tsk);
 }
