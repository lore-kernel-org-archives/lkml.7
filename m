Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD8720856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfJ3HZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 03:25:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:47742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbfJ3HZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:25:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 090E5AC2E;
        Wed, 30 Oct 2019 07:25:46 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Michal Suchanek <msuchanek@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v3] stacktrace: don't skip first entry on noncurrent tasks
Date:   Wed, 30 Oct 2019 08:25:45 +0100
Message-Id: <20191030072545.19462-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029071944.17123-1-jslaby@suse.cz>
References: <20191029071944.17123-1-jslaby@suse.cz>
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
Tested-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---

Notes:
    [v2] add the same for the !ARCH_STACKWALK case
    
    [v3] fix build on !ARCH_STACKWALK

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
-- 
2.23.0

