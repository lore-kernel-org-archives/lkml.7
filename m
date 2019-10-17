Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37724ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FB120854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X1xfYQE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438756AbfJQSXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:23:33 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59874 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbfJQSXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:23:33 -0400
Received: by linux.microsoft.com (Postfix, from userid 1040)
        id 5336920F3BFB; Thu, 17 Oct 2019 11:23:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5336920F3BFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571336612;
        bh=O8EaMRVP3tzpJtq5NUV1yUVPnkTIjUP4bcf+u5ix7pI=;
        h=From:To:Cc:Subject:Date:From;
        b=X1xfYQE9vdh3sdMHvULtHd+oq3tnbART+urKwNi+WOMSYMgus3cFM12ARCW5+YpMG
         XC11zLomNedtAY+u3aTcRdgUoR2V6xAP8wrClQSy62GHhjHA/fn2sruR/dhuSgeVQQ
         RIT+LA0ABuL7OguWXwC8XaoS8SbqpWyJ73xUkqx4=
From:   Steve MacLean <steve.maclean@linux.microsoft.com>
Cc:     Steve MacLean <Steve.MacLean@Microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] perf inject --jit: Remove //anon mmap events
Date:   Thu, 17 Oct 2019 11:23:20 -0700
Message-Id: <1571336600-21843-1-git-send-email-steve.maclean@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve MacLean <Steve.MacLean@Microsoft.com>

While a JIT is jitting code it will eventually need to commit more pages and
change these pages to executable permissions.

Typically the JIT will want these colocated to minimize branch displacements.

The kernel will coalesce these anonymous mapping with identical permissions
before sending an MMAP event for the new pages. This means the mmap event for
the new pages will include the older pages.

These anonymous mmap events will obscure the jitdump injected pseudo events.
This means that the jitdump generated symbols, machine code, debugging info,
and unwind info will no longer be used.

Observations:

When a process emits a jit dump marker and a jitdump file, the perf-xxx.map
file represents inferior information which has been superceded by the
jitdump jit-xxx.dump file.

Further the '//anon*' mmap events are only required for the legacy
perf-xxx.map mapping.

Summary:

Add rbtree to track which pids have sucessfully injected a jitdump file.

During "perf inject --jit", discard "//anon*" mmap events for any pid which
has sucessfully processed a jitdump file.

Committer testing:

// jitdump case
perf record <app with jitdump>
perf inject --jit --input perf.data --output perfjit.data

// verify mmap "//anon" events present initially
perf script --input perf.data --show-mmap-events | grep '//anon'
// verify mmap "//anon" events removed
perf script --input perfjit.data --show-mmap-events | grep '//anon'

// no jitdump case
perf record <app without jitdump>
perf inject --jit --input perf.data --output perfjit.data

// verify mmap "//anon" events present initially
perf script --input perf.data --show-mmap-events | grep '//anon'
// verify mmap "//anon" events not removed
perf script --input perfjit.data --show-mmap-events | grep '//anon'

Repro:

This issue was discovered while testing the initial CoreCLR jitdump
implementation. https://github.com/dotnet/coreclr/pull/26897.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>
---
 tools/perf/builtin-inject.c |  4 +--
 tools/perf/util/jitdump.c   | 63 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 372ecb3..0f38862 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -263,7 +263,7 @@ static int perf_event__jit_repipe_mmap(struct perf_tool *tool,
 	 * if jit marker, then inject jit mmaps and generate ELF images
 	 */
 	ret = jit_process(inject->session, &inject->output, machine,
-			  event->mmap.filename, sample->pid, &n);
+			  event->mmap.filename, event->mmap.pid, &n);
 	if (ret < 0)
 		return ret;
 	if (ret) {
@@ -301,7 +301,7 @@ static int perf_event__jit_repipe_mmap2(struct perf_tool *tool,
 	 * if jit marker, then inject jit mmaps and generate ELF images
 	 */
 	ret = jit_process(inject->session, &inject->output, machine,
-			  event->mmap2.filename, sample->pid, &n);
+			  event->mmap2.filename, event->mmap2.pid, &n);
 	if (ret < 0)
 		return ret;
 	if (ret) {
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index e3ccb0c..6d891d1 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -749,6 +749,59 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	return 0;
 }
 
+struct pid_rbtree
+{
+	struct rb_node node;
+	pid_t pid;
+};
+
+static void jit_add_pid(struct rb_root *root, pid_t pid)
+{
+	struct rb_node **new = &(root->rb_node), *parent = NULL;
+	struct pid_rbtree* data = NULL;
+
+	/* Figure out where to put new node */
+	while (*new) {
+		struct pid_rbtree *this = container_of(*new, struct pid_rbtree, node);
+		pid_t nodePid = this->pid;
+
+		parent = *new;
+		if (pid < nodePid)
+			new = &((*new)->rb_left);
+		else if (pid > nodePid)
+			new = &((*new)->rb_right);
+		else
+			return;
+	}
+
+	data = malloc(sizeof(struct pid_rbtree));
+	data->pid = pid;
+
+	/* Add new node and rebalance tree. */
+	rb_link_node(&data->node, parent, new);
+	rb_insert_color(&data->node, root);
+
+	return;
+}
+
+static bool jit_has_pid(struct rb_root *root, pid_t pid)
+{
+	struct rb_node *node = root->rb_node;
+
+	while (node) {
+		struct pid_rbtree *this = container_of(node, struct pid_rbtree, node);
+		pid_t nodePid = this->pid;
+
+		if (pid < nodePid)
+			node = node->rb_left;
+		else if (pid > nodePid)
+			node = node->rb_right;
+		else
+			return 1;
+	}
+	return 0;
+}
+
 int
 jit_process(struct perf_session *session,
 	    struct perf_data *output,
@@ -760,12 +813,21 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	struct evsel *first;
 	struct jit_buf_desc jd;
 	int ret;
+	static struct rb_root jitdump_pids = RB_ROOT;
 
 	/*
 	 * first, detect marker mmap (i.e., the jitdump mmap)
 	 */
 	if (jit_detect(filename, pid))
+	{
+		/*
+		 * Strip //anon* mmaps if we processed a jitdump for this pid
+		 */
+		if (jit_has_pid(&jitdump_pids, pid) && (strncmp(filename, "//anon", 6) == 0))
+			return 1;
+
 		return 0;
+	}
 
 	memset(&jd, 0, sizeof(jd));
 
@@ -784,6 +846,7 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 
 	ret = jit_inject(&jd, filename);
 	if (!ret) {
+		jit_add_pid(&jitdump_pids, pid);
 		*nbytes = jd.bytes_written;
 		ret = 1;
 	}
-- 
1.8.3.1

