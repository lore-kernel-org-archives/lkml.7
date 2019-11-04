Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383B5CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 20:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7C120848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 20:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfKDUYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 15:24:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38848 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbfKDUYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 15:24:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRitR-0004xa-4U; Mon, 04 Nov 2019 21:24:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 791611C0017;
        Mon,  4 Nov 2019 21:24:04 +0100 (CET)
Date:   Mon, 04 Nov 2019 20:24:04 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] stacktrace: Don't skip first entry on noncurrent tasks
Cc:     Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191030072545.19462-1-jslaby@suse.cz>
References: <20191030072545.19462-1-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157289904416.29376.6390821004707816453.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     b0c51f158455e31d5024100cf3580fcd88214b0e
Gitweb:        https://git.kernel.org/tip/b0c51f158455e31d5024100cf3580fcd88214b0e
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Wed, 30 Oct 2019 08:25:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 04 Nov 2019 21:19:25 +01:00

stacktrace: Don't skip first entry on noncurrent tasks

When doing cat /proc/<PID>/stack, the output is missing the first entry.
When the current code walks the stack starting in stack_trace_save_tsk,
it skips all scheduler functions (that's OK) plus one more function. But
this one function should be skipped only for the 'current' task as it is
stack_trace_save_tsk proper.

The original code (before the common infrastructure) skipped one
function only for the 'current' task -- see save_stack_trace_tsk before
3599fe12a125. So do so also in the new infrastructure now.

Fixes: 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20191030072545.19462-1-jslaby@suse.cz

---
 kernel/stacktrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 6d1f68b..c9ea7eb 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -141,7 +141,8 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
 	struct stacktrace_cookie c = {
 		.store	= store,
 		.size	= size,
-		.skip	= skipnr + 1,
+		/* skip this function if they are tracing us */
+		.skip	= skipnr + !!(current == tsk),
 	};
 
 	if (!try_get_task_stack(tsk))
@@ -298,7 +299,8 @@ unsigned int stack_trace_save_tsk(struct task_struct *task,
 	struct stack_trace trace = {
 		.entries	= store,
 		.max_entries	= size,
-		.skip		= skipnr + 1,
+		/* skip this function if they are tracing us */
+		.skip	= skipnr + !!(current == task),
 	};
 
 	save_stack_trace_tsk(task, &trace);
