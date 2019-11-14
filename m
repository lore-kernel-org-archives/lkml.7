Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9B9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317F620727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfKNSSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:18:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727578AbfKNSS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 316472073B;
        Thu, 14 Nov 2019 18:18:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhL-0001BB-DV; Thu, 14 Nov 2019 13:18:27 -0500
Message-Id: <20191114181827.298204434@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:18:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [for-next][PATCH 27/33] tracing: Use generic type for comparator function
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Comparator function type, cmp_func_t, is defined in the types.h,
use it in the code.

Link: http://lkml.kernel.org/r/20191007135656.37734-3-andriy.shevchenko@linux.intel.com

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c       | 12 ++++++------
 kernel/trace/trace_branch.c |  8 ++++----
 kernel/trace/trace_stat.c   |  6 ++----
 kernel/trace/trace_stat.h   |  2 +-
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index d2d488c43a6a..82ef8d60a42b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -465,10 +465,10 @@ static void *function_stat_start(struct tracer_stat *trace)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 /* function graph compares on total time */
-static int function_stat_cmp(void *p1, void *p2)
+static int function_stat_cmp(const void *p1, const void *p2)
 {
-	struct ftrace_profile *a = p1;
-	struct ftrace_profile *b = p2;
+	const struct ftrace_profile *a = p1;
+	const struct ftrace_profile *b = p2;
 
 	if (a->time < b->time)
 		return -1;
@@ -479,10 +479,10 @@ static int function_stat_cmp(void *p1, void *p2)
 }
 #else
 /* not function graph compares against hits */
-static int function_stat_cmp(void *p1, void *p2)
+static int function_stat_cmp(const void *p1, const void *p2)
 {
-	struct ftrace_profile *a = p1;
-	struct ftrace_profile *b = p2;
+	const struct ftrace_profile *a = p1;
+	const struct ftrace_profile *b = p2;
 
 	if (a->counter < b->counter)
 		return -1;
diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index 3ea65cdff30d..88e158d27965 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -244,7 +244,7 @@ static int annotated_branch_stat_headers(struct seq_file *m)
 	return 0;
 }
 
-static inline long get_incorrect_percent(struct ftrace_branch_data *p)
+static inline long get_incorrect_percent(const struct ftrace_branch_data *p)
 {
 	long percent;
 
@@ -332,10 +332,10 @@ annotated_branch_stat_next(void *v, int idx)
 	return p;
 }
 
-static int annotated_branch_stat_cmp(void *p1, void *p2)
+static int annotated_branch_stat_cmp(const void *p1, const void *p2)
 {
-	struct ftrace_branch_data *a = p1;
-	struct ftrace_branch_data *b = p2;
+	const struct ftrace_branch_data *a = p1;
+	const struct ftrace_branch_data *b = p2;
 
 	long percent_a, percent_b;
 
diff --git a/kernel/trace/trace_stat.c b/kernel/trace/trace_stat.c
index 9ab0a1a7ad5e..874f1274cf99 100644
--- a/kernel/trace/trace_stat.c
+++ b/kernel/trace/trace_stat.c
@@ -72,9 +72,7 @@ static void destroy_session(struct stat_session *session)
 	kfree(session);
 }
 
-typedef int (*cmp_stat_t)(void *, void *);
-
-static int insert_stat(struct rb_root *root, void *stat, cmp_stat_t cmp)
+static int insert_stat(struct rb_root *root, void *stat, cmp_func_t cmp)
 {
 	struct rb_node **new = &(root->rb_node), *parent = NULL;
 	struct stat_node *data;
@@ -112,7 +110,7 @@ static int insert_stat(struct rb_root *root, void *stat, cmp_stat_t cmp)
  * This one will force an insertion as right-most node
  * in the rbtree.
  */
-static int dummy_cmp(void *p1, void *p2)
+static int dummy_cmp(const void *p1, const void *p2)
 {
 	return -1;
 }
diff --git a/kernel/trace/trace_stat.h b/kernel/trace/trace_stat.h
index 8786d17caf49..31d7dc5bf1db 100644
--- a/kernel/trace/trace_stat.h
+++ b/kernel/trace/trace_stat.h
@@ -16,7 +16,7 @@ struct tracer_stat {
 	void			*(*stat_start)(struct tracer_stat *trace);
 	void			*(*stat_next)(void *prev, int idx);
 	/* Compare two entries for stats sorting */
-	int			(*stat_cmp)(void *p1, void *p2);
+	cmp_func_t		stat_cmp;
 	/* Print a stat entry */
 	int			(*stat_show)(struct seq_file *s, void *p);
 	/* Release an entry */
-- 
2.23.0


