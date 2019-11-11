Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC545C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB8B206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKKKLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:11:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56043 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKKLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:11:49 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iU6fc-00046R-6A; Mon, 11 Nov 2019 11:11:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A7E4D1C0093;
        Mon, 11 Nov 2019 11:11:39 +0100 (CET)
Date:   Mon, 11 Nov 2019 10:11:39 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/stacktrace] stacktrace: Get rid of unneeded '!!' pattern
Cc:     Joe Perches <joe@perches.com>, Jiri Slaby <jslaby@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191111092647.27419-1-jslaby@suse.cz>
References: <20191111092647.27419-1-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157346709937.29376.10784180052617315961.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/stacktrace branch of tip:

Commit-ID:     4b48512c2e9c63b62d7da23563cdb224b4d61d72
Gitweb:        https://git.kernel.org/tip/4b48512c2e9c63b62d7da23563cdb224b4d61d72
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Mon, 11 Nov 2019 10:26:47 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Nov 2019 10:30:59 +01:00

stacktrace: Get rid of unneeded '!!' pattern

My commit b0c51f158455 ("stacktrace: Don't skip first entry on
noncurrent tasks") adds one or zero to skipnr by "!!(current == tsk)".

But the C99 standard says:

  The == (equal to) and != (not equal to) operators are
  ...
  Each of the operators yields 1 if the specified relation is true and 0
  if it is false.

So there is no need to prepend the above expression by "!!" -- remove it.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111092647.27419-1-jslaby@suse.cz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/stacktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index c9ea7eb..2af66e4 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -142,7 +142,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
 		.store	= store,
 		.size	= size,
 		/* skip this function if they are tracing us */
-		.skip	= skipnr + !!(current == tsk),
+		.skip	= skipnr + (current == tsk),
 	};
 
 	if (!try_get_task_stack(tsk))
@@ -300,7 +300,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *task,
 		.entries	= store,
 		.max_entries	= size,
 		/* skip this function if they are tracing us */
-		.skip	= skipnr + !!(current == task),
+		.skip	= skipnr + (current == task),
 	};
 
 	save_stack_trace_tsk(task, &trace);
