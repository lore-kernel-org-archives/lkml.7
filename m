Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D1BCA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395F621835
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ChEaHnzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfJaBFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:05:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57658 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfJaBFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:05:19 -0400
Received: by linux.microsoft.com (Postfix, from userid 1040)
        id 66DEB20B7192; Wed, 30 Oct 2019 18:05:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 66DEB20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572483918;
        bh=l+1Yn3gcH/T0rqz8/lhOt/F8mgcwtdsD0FATtgC5VQc=;
        h=From:To:Cc:Subject:Date:From;
        b=ChEaHnzzMA+/CkOQ1n0UThFyFbizzPu0yT/ys7YIBKTPUa5YZKaH0+4JwTLjDUPAB
         g/60C1wwgAiUPee7DgyKylplzUajhGMcxsF7UualkxMg8agP5+2jXn8nT5T9da6vVH
         y3/Cb4PM32qU6LJRabzYXvPqoPcFqA1HYNYA+uPY=
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
Subject: [PATCH v2] perf inject --jit: Remove //anon mmap events
Date:   Wed, 30 Oct 2019 18:05:12 -0700
Message-Id: <1572483912-111747-1-git-send-email-steve.maclean@linux.microsoft.com>
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

When attaching to an existing process, the synthetic anon map events are
given a time stamp of -1. These should not obscure the jitdump events which
have an actual time.

Summary:

Use thread->priv to store whether a jitdump file has been processed

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
 tools/perf/builtin-inject.c |  4 ++--
 tools/perf/util/jitdump.c   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

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
index e3ccb0c..c36d19b 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -26,6 +26,7 @@
 #include "jit.h"
 #include "jitdump.h"
 #include "genelf.h"
+#include "thread.h"
 
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
@@ -749,6 +750,34 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	return 0;
 }
 
+static void jit_add_pid(struct machine *machine, pid_t pid)
+{
+	struct thread *thread = machine__findnew_thread(machine, pid, pid);
+
+	if (!thread)
+	{
+		pr_err("jit_add_pid() thread not found\n");
+
+		return;
+	}
+
+	thread->priv = (void *) 1;
+}
+
+static bool jit_has_pid(struct machine *machine, pid_t pid)
+{
+	struct thread *thread = machine__findnew_thread(machine, pid, pid);
+
+	if (!thread)
+	{
+		pr_err("jit_has_pid() thread not found\n");
+
+		return 0;
+	}
+
+	return (bool) thread->priv;
+}
+
 int
 jit_process(struct perf_session *session,
 	    struct perf_data *output,
@@ -765,7 +794,15 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	 * first, detect marker mmap (i.e., the jitdump mmap)
 	 */
 	if (jit_detect(filename, pid))
+	{
+		/*
+		 * Strip //anon* mmaps if we processed a jitdump for this pid
+		 */
+		if (jit_has_pid(machine, pid) && (strncmp(filename, "//anon", 6) == 0))
+			return 1;
+
 		return 0;
+	}
 
 	memset(&jd, 0, sizeof(jd));
 
@@ -784,6 +821,7 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 
 	ret = jit_inject(&jd, filename);
 	if (!ret) {
+		jit_add_pid(machine, pid);
 		*nbytes = jd.bytes_written;
 		ret = 1;
 	}
-- 
1.8.3.1

