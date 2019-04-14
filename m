Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977CAC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741AA2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfDNUi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:38:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNUiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:38:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKbZbS2689273
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:37:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKbYvC2689270;
        Sun, 14 Apr 2019 13:37:34 -0700
Date:   Sun, 14 Apr 2019 13:37:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-fa9833992d5ff3c0d6e81d708bec363bce2fb54c@git.kernel.org>
Cc:     luto@kernel.org, palmer@sifive.com, aou@eecs.berkeley.edu,
        jpoimboe@redhat.com, hpa@zytor.com, glider@google.com,
        peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Reply-To: palmer@sifive.com, aou@eecs.berkeley.edu, jpoimboe@redhat.com,
          luto@kernel.org, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, rostedt@goodmis.org, hpa@zytor.com,
          glider@google.com, peterz@infradead.org
In-Reply-To: <20190410103644.131061192@linutronix.de>
References: <20190410103644.131061192@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] riscv/stacktrace: Remove the pointless
 ULONG_MAX marker
Git-Commit-ID: fa9833992d5ff3c0d6e81d708bec363bce2fb54c
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

Commit-ID:  fa9833992d5ff3c0d6e81d708bec363bce2fb54c
Gitweb:     https://git.kernel.org/tip/fa9833992d5ff3c0d6e81d708bec363bce2fb54c
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:28:00 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:28 +0200

riscv/stacktrace: Remove the pointless ULONG_MAX marker

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
Cc: linux-riscv@lists.infradead.org
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Link: https://lkml.kernel.org/r/20190410103644.131061192@linutronix.de

---
 arch/riscv/kernel/stacktrace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index a4b1d94371a0..4d403274c2e8 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -169,8 +169,6 @@ static bool save_trace(unsigned long pc, void *arg)
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
 	walk_stackframe(tsk, NULL, save_trace, trace);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
