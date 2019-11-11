Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D854C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB3020818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfKKJ0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:26:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:58132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfKKJ0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:26:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D369B4E4;
        Mon, 11 Nov 2019 09:26:48 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] stacktrace: get rid of unneeded !!
Date:   Mon, 11 Nov 2019 10:26:47 +0100
Message-Id: <20191111092647.27419-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My commit b0c51f158455 ("stacktrace: Don't skip first entry on
noncurrent tasks") adds one or zero to skipnr by "!!(current == tsk)".
But the C99 standard says:
  The == (equal to) and != (not equal to) operators are
  ...
  Each of the operators yields 1 if the specified relation is true and 0
  if it is false.

So there is no need to prepend the above expression by "!!" -- remove
it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reported-by: Joe Perches <joe@perches.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
---
 kernel/stacktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index c9ea7eb2cb1a..2af66e449aa6 100644
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
-- 
2.24.0

