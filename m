Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0EFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7B9218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfDXI4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:56:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:40134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728580AbfDXI4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:56:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 713A5AED7;
        Wed, 24 Apr 2019 08:56:05 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 3/3] livepatch: Cleanup message handling in klp_try_switch_task()
Date:   Wed, 24 Apr 2019 10:55:50 +0200
Message-Id: <20190424085550.29612-4-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424085550.29612-1-pmladek@suse.com>
References: <20190424085550.29612-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON_ONCE() could not be called safely under rq lock because
of console deadlock issues. Fortunately, simple printk_deferred()
is enough because the warning is printed from a well defined
location and context.

Also klp_try_switch_task() is called under klp_mutex.
Therefore, the buffer for debug messages could be static.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/transition.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 9c89ae8b337a..e8183d18227f 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -254,6 +254,7 @@ static int klp_check_stack_func(struct klp_func *func,
 static int klp_check_stack(struct task_struct *task, char *err_buf)
 {
 	static unsigned long entries[MAX_STACK_ENTRIES];
+	static int enosys_warned;
 	struct stack_trace trace;
 	struct klp_object *obj;
 	struct klp_func *func;
@@ -263,8 +264,16 @@ static int klp_check_stack(struct task_struct *task, char *err_buf)
 	trace.nr_entries = 0;
 	trace.max_entries = MAX_STACK_ENTRIES;
 	trace.entries = entries;
+
 	ret = save_stack_trace_tsk_reliable(task, &trace);
-	WARN_ON_ONCE(ret == -ENOSYS);
+	if (ret == -ENOSYS) {
+		if (!enosys_warned) {
+			printk_deferred(KERN_WARNING "%s: save_stack_trace_tsk_reliable() not supported on this architecture.\n",
+					__func__);
+			enosys_warned = 1;
+		}
+		return ret;
+	}
 	if (ret) {
 		snprintf(err_buf, STACK_ERR_BUF_SIZE,
 			 "%s: %s:%d has an unreliable stack\n",
@@ -297,11 +306,11 @@ static int klp_check_stack(struct task_struct *task, char *err_buf)
  */
 static bool klp_try_switch_task(struct task_struct *task)
 {
+	static char err_buf[STACK_ERR_BUF_SIZE];
 	struct rq *rq;
 	struct rq_flags flags;
 	int ret;
 	bool success = false;
-	char err_buf[STACK_ERR_BUF_SIZE];
 
 	err_buf[0] = '\0';
 
@@ -336,15 +345,15 @@ static bool klp_try_switch_task(struct task_struct *task)
 	task_rq_unlock(rq, task, &flags);
 
 	/*
-	 * Due to console deadlock issues, pr_debug() can't be used while
-	 * holding the task rq lock.  Instead we have to use a temporary buffer
+	 * printk_deferred() need to be used under rq lock to avoid
+	 * console deadlock issues.  But it does not support the dynamic
+	 * debug feature.  Instead we have to use a temporary buffer
 	 * and print the debug message after releasing the lock.
 	 */
 	if (err_buf[0] != '\0')
 		pr_debug("%s", err_buf);
 
 	return success;
-
 }
 
 /*
-- 
2.16.4

