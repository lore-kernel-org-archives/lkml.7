Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB364C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9A920842
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKJKYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 05:24:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54397 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfKJKYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 05:24:02 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iTkO0-0004XU-2e; Sun, 10 Nov 2019 11:24:00 +0100
Date:   Sun, 10 Nov 2019 10:21:53 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/urgent for v5.4-rc7
Message-ID: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

up to:  b0c51f158455: stacktrace: Don't skip first entry on noncurrent tasks

A small fix for a stacktrace regression. Saving a stacktrace for a foreign
task skipped an extra entry which makes e.g. the output of /proc/$PID/stack
incomplete.

Thanks,

	tglx

------------------>
Jiri Slaby (1):
      stacktrace: Don't skip first entry on noncurrent tasks


 kernel/stacktrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 6d1f68b7e528..c9ea7eb2cb1a 100644
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


