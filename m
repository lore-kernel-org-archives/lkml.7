Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAA8C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EED220867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfJGN5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:57:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:51025 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbfJGN5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:57:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 06:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="394337369"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 07 Oct 2019 06:57:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3F54622C; Mon,  7 Oct 2019 16:57:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        George Spelvin <lkml@sdf.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] tracing: Use generic type for comparator function
Date:   Mon,  7 Oct 2019 16:56:56 +0300
Message-Id: <20191007135656.37734-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007135656.37734-1-andriy.shevchenko@linux.intel.com>
References: <20191007135656.37734-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comparator function type, cmp_func_t, is defined in the types.h,
use it in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/trace/ftrace.c       | 12 ++++++------
 kernel/trace/trace_branch.c |  8 ++++----
 kernel/trace/trace_stat.c   |  6 ++----
 kernel/trace/trace_stat.h   |  2 +-
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 62a50bf399d6..3bf9e805c46c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -462,10 +462,10 @@ static void *function_stat_start(struct tracer_stat *trace)
 
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
@@ -476,10 +476,10 @@ static int function_stat_cmp(void *p1, void *p2)
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
index 75bf1bcb4a8a..dd9960a2dd0c 100644
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

