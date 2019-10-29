Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651EDCA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3199120663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfJ2HTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 03:19:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:50264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfJ2HTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:19:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88556B1F1;
        Tue, 29 Oct 2019 07:19:45 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2] stacktrace: don't skip first entry on noncurrent tasks
Date:   Tue, 29 Oct 2019 08:19:44 +0100
Message-Id: <20191029071944.17123-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025142110.jgz5jy4nuryhawv5@treble>
References: <20191025142110.jgz5jy4nuryhawv5@treble>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing cat /proc/<PID>/stack, the output is missing the first entry.
When the current code walks the stack starting in stack_trace_save_tsk,
it skips all scheduler functions (that's OK) plus one more function. But
this one function should be skipped only for the 'current' task as it is
stack_trace_save_tsk proper.

The original code (before the common infrastructure) skipped one
function only for the 'current' task -- see save_stack_trace_tsk before
3599fe12a125. So do so also in the new infrastructure now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Fixes: 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---

Notes:
    [v2] add the same for the !CONFIG_ARCH_STACKWALK case

 kernel/stacktrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 6d1f68b7e528..48703b252434 100644
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
+		.skip	= skipnr + !!(current == tsk),
 	};
 
 	save_stack_trace_tsk(task, &trace);
-- 
2.23.0

