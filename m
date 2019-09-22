Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4878C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8482208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfIVKwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 06:52:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55574 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbfIVKwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 06:52:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBzTc-0000v0-Os; Sun, 22 Sep 2019 12:52:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 34A931C0DEE;
        Sun, 22 Sep 2019 12:52:24 +0200 (CEST)
Date:   Sun, 22 Sep 2019 10:52:24 -0000
From:   "tip-bot2 for Mamatha Inamdar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf session: Return error code for
 perf_session__new() function on failure
Cc:     Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jeremie Galarneau <jeremie.galarneau@efficios.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shawn Landden <shawn@git.icu>,
        Song Liu <songliubraving@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190822071223.17892.45782.stgit@localhost.localdomain>
References: <20190822071223.17892.45782.stgit@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <156914954415.24167.10687604446503316253.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     6ef81c55a2b6584cb642917f5fdf3632ef44b670
Gitweb:        https://git.kernel.org/tip/6ef81c55a2b6584cb642917f5fdf3632ef44b670
Author:        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
AuthorDate:    Thu, 22 Aug 2019 12:50:49 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 15:58:11 -03:00

perf session: Return error code for perf_session__new() function on failure

This patch is to return error code of perf_new_session function on
failure instead of NULL.

Test Results:

Before Fix:

  $ perf c2c report -input
  failed to open nput: No such file or directory

  $ echo $?
  0
  $

After Fix:

  $ perf c2c report -input
  failed to open nput: No such file or directory

  $ echo $?
  254
  $

Committer notes:

Fix 'perf tests topology' case, where we use that TEST_ASSERT_VAL(...,
session), i.e. we need to pass zero in case of failure, which was the
case before when NULL was returned by perf_session__new() for failure,
but now we need to negate the result of IS_ERR(session) to respect that
TEST_ASSERT_VAL) expectation of zero meaning failure.

Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeremie Galarneau <jeremie.galarneau@efficios.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shawn Landden <shawn@git.icu>
Cc: Song Liu <songliubraving@fb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lore.kernel.org/lkml/20190822071223.17892.45782.stgit@localhost.localdomain
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c      |  5 +++--
 tools/perf/builtin-buildid-cache.c |  5 +++--
 tools/perf/builtin-buildid-list.c  |  5 +++--
 tools/perf/builtin-c2c.c           |  6 ++++--
 tools/perf/builtin-diff.c          |  9 +++++----
 tools/perf/builtin-evlist.c        |  5 +++--
 tools/perf/builtin-inject.c        |  5 +++--
 tools/perf/builtin-kmem.c          |  5 +++--
 tools/perf/builtin-kvm.c           |  9 +++++----
 tools/perf/builtin-lock.c          |  5 +++--
 tools/perf/builtin-mem.c           |  5 +++--
 tools/perf/builtin-record.c        |  5 +++--
 tools/perf/builtin-report.c        |  4 ++--
 tools/perf/builtin-sched.c         | 11 ++++++-----
 tools/perf/builtin-script.c        |  9 +++++----
 tools/perf/builtin-stat.c          | 11 ++++++-----
 tools/perf/builtin-timechart.c     |  5 +++--
 tools/perf/builtin-top.c           |  5 +++--
 tools/perf/builtin-trace.c         |  4 ++--
 tools/perf/tests/topology.c        |  5 +++--
 tools/perf/util/data-convert-bt.c  |  5 ++++-
 tools/perf/util/session.c          | 15 +++++++++++----
 22 files changed, 86 insertions(+), 57 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 553c651..8db8fc9 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -40,6 +40,7 @@
 #include <dlfcn.h>
 #include <errno.h>
 #include <linux/bitmap.h>
+#include <linux/err.h>
 
 struct perf_annotate {
 	struct perf_tool tool;
@@ -584,8 +585,8 @@ int cmd_annotate(int argc, const char **argv)
 	data.path = input_name;
 
 	annotate.session = perf_session__new(&data, false, &annotate.tool);
-	if (annotate.session == NULL)
-		return -1;
+	if (IS_ERR(annotate.session))
+		return PTR_ERR(annotate.session);
 
 	annotate.has_br_stack = perf_header__has_feat(&annotate.session->header,
 						      HEADER_BRANCH_STACK);
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 1a69eb5..39efa51 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -28,6 +28,7 @@
 #include "util/util.h"
 #include "util/probe-file.h"
 #include <linux/string.h>
+#include <linux/err.h>
 
 static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
 {
@@ -422,8 +423,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 		data.force = force;
 
 		session = perf_session__new(&data, false, NULL);
-		if (session == NULL)
-			return -1;
+		if (IS_ERR(session))
+			return PTR_ERR(session);
 	}
 
 	if (symbol__init(session ? &session->header.env : NULL) < 0)
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 5a0d8b3..e3ef755 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -18,6 +18,7 @@
 #include "util/symbol.h"
 #include "util/data.h"
 #include <errno.h>
+#include <linux/err.h>
 
 static int sysfs__fprintf_build_id(FILE *fp)
 {
@@ -65,8 +66,8 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
 		goto out;
 
 	session = perf_session__new(&data, false, &build_id__mark_dso_hit_ops);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	/*
 	 * We take all buildids when the file contains AUX area tracing data
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 61aaacc..3542b6a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -13,6 +13,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/compiler.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/zalloc.h>
@@ -2781,8 +2782,9 @@ static int perf_c2c__report(int argc, const char **argv)
 	}
 
 	session = perf_session__new(&data, 0, &c2c.tool);
-	if (session == NULL) {
-		pr_debug("No memory for session\n");
+	if (IS_ERR(session)) {
+		err = PTR_ERR(session);
+		pr_debug("Error creating perf session\n");
 		goto out;
 	}
 
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 827e480..c37a786 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -23,6 +23,7 @@
 #include "util/time-utils.h"
 #include "util/annotate.h"
 #include "util/map.h"
+#include <linux/err.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
@@ -1153,9 +1154,9 @@ static int check_file_brstack(void)
 
 	data__for_each_file(i, d) {
 		d->session = perf_session__new(&d->data, false, &pdiff.tool);
-		if (!d->session) {
+		if (IS_ERR(d->session)) {
 			pr_err("Failed to open %s\n", d->data.path);
-			return -1;
+			return PTR_ERR(d->session);
 		}
 
 		has_br_stack = perf_header__has_feat(&d->session->header,
@@ -1185,9 +1186,9 @@ static int __cmd_diff(void)
 
 	data__for_each_file(i, d) {
 		d->session = perf_session__new(&d->data, false, &pdiff.tool);
-		if (!d->session) {
+		if (IS_ERR(d->session)) {
+			ret = PTR_ERR(d->session);
 			pr_err("Failed to open %s\n", d->data.path);
-			ret = -1;
 			goto out_delete;
 		}
 
diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 294494e..60509ce 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -15,6 +15,7 @@
 #include "util/session.h"
 #include "util/data.h"
 #include "util/debug.h"
+#include <linux/err.h>
 
 static int __cmd_evlist(const char *file_name, struct perf_attr_details *details)
 {
@@ -28,8 +29,8 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 	bool has_tracepoint = false;
 
 	session = perf_session__new(&data, 0, NULL);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	evlist__for_each_entry(session->evlist, pos) {
 		perf_evsel__fprintf(pos, details, stdout);
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 23a76cf..372ecb3 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -23,6 +23,7 @@
 #include "util/symbol.h"
 #include "util/synthetic-events.h"
 #include "util/thread.h"
+#include <linux/err.h>
 
 #include <subcmd/parse-options.h>
 
@@ -835,8 +836,8 @@ int cmd_inject(int argc, const char **argv)
 
 	data.path = inject.input_name;
 	inject.session = perf_session__new(&data, true, &inject.tool);
-	if (inject.session == NULL)
-		return -1;
+	if (IS_ERR(inject.session))
+		return PTR_ERR(inject.session);
 
 	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed.\n");
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index b5682be..1e61e35 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -14,6 +14,7 @@
 #include "util/tool.h"
 #include "util/callchain.h"
 #include "util/time-utils.h"
+#include <linux/err.h>
 
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
@@ -1956,8 +1957,8 @@ int cmd_kmem(int argc, const char **argv)
 	data.path = input_name;
 
 	kmem_session = session = perf_session__new(&data, false, &perf_kmem);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	ret = -1;
 
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 6e3e366..c4b22e1 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -33,6 +33,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/time64.h>
@@ -1091,9 +1092,9 @@ static int read_events(struct perf_kvm_stat *kvm)
 
 	kvm->tool = eops;
 	kvm->session = perf_session__new(&file, false, &kvm->tool);
-	if (!kvm->session) {
+	if (IS_ERR(kvm->session)) {
 		pr_err("Initializing perf session failed\n");
-		return -1;
+		return PTR_ERR(kvm->session);
 	}
 
 	symbol__init(&kvm->session->header.env);
@@ -1446,8 +1447,8 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	 * perf session
 	 */
 	kvm->session = perf_session__new(&data, false, &kvm->tool);
-	if (kvm->session == NULL) {
-		err = -1;
+	if (IS_ERR(kvm->session)) {
+		err = PTR_ERR(kvm->session);
 		goto out;
 	}
 	kvm->session->evlist = kvm->evlist;
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 4c2b7f4..474dfd5 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -30,6 +30,7 @@
 #include <linux/hash.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
+#include <linux/err.h>
 
 static struct perf_session *session;
 
@@ -872,9 +873,9 @@ static int __cmd_report(bool display_info)
 	};
 
 	session = perf_session__new(&data, false, &eops);
-	if (!session) {
+	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
-		return -1;
+		return PTR_ERR(session);
 	}
 
 	symbol__init(&session->header.env);
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 27d2bde..a13f581 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -17,6 +17,7 @@
 #include "util/dso.h"
 #include "util/map.h"
 #include "util/symbol.h"
+#include <linux/err.h>
 
 #define MEM_OPERATION_LOAD	0x1
 #define MEM_OPERATION_STORE	0x2
@@ -249,8 +250,8 @@ static int report_raw_events(struct perf_mem *mem)
 	struct perf_session *session = perf_session__new(&data, false,
 							 &mem->tool);
 
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	if (mem->cpu_list) {
 		ret = perf_session__cpu_bitmap(session, mem->cpu_list,
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4bd11c9..3f66a49 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -54,6 +54,7 @@
 #include <signal.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
+#include <linux/err.h>
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
@@ -1354,9 +1355,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 	session = perf_session__new(data, false, tool);
-	if (session == NULL) {
+	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed.\n");
-		return -1;
+		return PTR_ERR(session);
 	}
 
 	fd = perf_data__fd(data);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 3047e51..aae0e57 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1269,8 +1269,8 @@ int cmd_report(int argc, const char **argv)
 
 repeat:
 	session = perf_session__new(&data, false, &report.tool);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	ret = evswitch__init(&report.evswitch, session->evlist, stderr);
 	if (ret)
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index f0b828c..079e67a 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -40,6 +40,7 @@
 #include <api/fs/fs.h>
 #include <perf/cpumap.h>
 #include <linux/time64.h>
+#include <linux/err.h>
 
 #include <linux/ctype.h>
 
@@ -1797,9 +1798,9 @@ static int perf_sched__read_events(struct perf_sched *sched)
 	int rc = -1;
 
 	session = perf_session__new(&data, false, &sched->tool);
-	if (session == NULL) {
-		pr_debug("No Memory for session\n");
-		return -1;
+	if (IS_ERR(session)) {
+		pr_debug("Error creating perf session");
+		return PTR_ERR(session);
 	}
 
 	symbol__init(&session->header.env);
@@ -2989,8 +2990,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	symbol_conf.use_callchain = sched->show_callchain;
 
 	session = perf_session__new(&data, false, &sched->tool);
-	if (session == NULL)
-		return -ENOMEM;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	evlist = session->evlist;
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e079b34..a17a930 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -52,6 +52,7 @@
 #include <unistd.h>
 #include <subcmd/pager.h>
 #include <perf/evlist.h>
+#include <linux/err.h>
 #include "util/record.h"
 #include "util/util.h"
 #include "perf.h"
@@ -3083,8 +3084,8 @@ int find_scripts(char **scripts_array, char **scripts_path_array, int num,
 	int i = 0;
 
 	session = perf_session__new(&data, false, NULL);
-	if (!session)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	snprintf(scripts_path, MAXPATHLEN, "%s/scripts", get_argv_exec_path());
 
@@ -3754,8 +3755,8 @@ int cmd_script(int argc, const char **argv)
 	}
 
 	session = perf_session__new(&data, false, &script.tool);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	if (header || header_only) {
 		script.tool.show_feat_hdr = SHOW_FEAT_HEADER;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 60cdd38..f7d1332 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -83,6 +83,7 @@
 #include <unistd.h>
 #include <sys/time.h>
 #include <sys/resource.h>
+#include <linux/err.h>
 
 #include <linux/ctype.h>
 #include <perf/evlist.h>
@@ -1436,9 +1437,9 @@ static int __cmd_record(int argc, const char **argv)
 	}
 
 	session = perf_session__new(data, false, NULL);
-	if (session == NULL) {
-		pr_err("Perf session creation failed.\n");
-		return -1;
+	if (IS_ERR(session)) {
+		pr_err("Perf session creation failed\n");
+		return PTR_ERR(session);
 	}
 
 	init_features(session);
@@ -1635,8 +1636,8 @@ static int __cmd_report(int argc, const char **argv)
 	perf_stat.data.mode = PERF_DATA_MODE_READ;
 
 	session = perf_session__new(&perf_stat.data, false, &perf_stat.tool);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	perf_stat.session  = session;
 	stat_config.output = stderr;
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index e0e8226..9e84fae 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -35,6 +35,7 @@
 #include "util/tool.h"
 #include "util/data.h"
 #include "util/debug.h"
+#include <linux/err.h>
 
 #ifdef LACKS_OPEN_MEMSTREAM_PROTOTYPE
 FILE *open_memstream(char **ptr, size_t *sizeloc);
@@ -1601,8 +1602,8 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 							 &tchart->tool);
 	int ret = -EINVAL;
 
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	symbol__init(&session->header.env);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b052470..8da3c93 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -77,6 +77,7 @@
 #include <linux/stringify.h>
 #include <linux/time64.h>
 #include <linux/types.h>
+#include <linux/err.h>
 
 #include <linux/ctype.h>
 
@@ -1672,8 +1673,8 @@ int cmd_top(int argc, const char **argv)
 	}
 
 	top.session = perf_session__new(NULL, false, NULL);
-	if (top.session == NULL) {
-		status = -1;
+	if (IS_ERR(top.session)) {
+		status = PTR_ERR(top.session);
 		goto out_delete_evlist;
 	}
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f0f7350..a292658 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3585,8 +3585,8 @@ static int trace__replay(struct trace *trace)
 	trace->multiple_threads = true;
 
 	session = perf_session__new(&data, false, &trace->tool);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	if (trace->opts.target.pid)
 		symbol_conf.pid_list_str = strdup(trace->opts.target.pid);
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 7d845d9..4a80049 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -8,6 +8,7 @@
 #include "session.h"
 #include "evlist.h"
 #include "debug.h"
+#include <linux/err.h>
 
 #define TEMPL "/tmp/perf-test-XXXXXX"
 #define DATA_SIZE	10
@@ -39,7 +40,7 @@ static int session_write_header(char *path)
 	};
 
 	session = perf_session__new(&data, false, NULL);
-	TEST_ASSERT_VAL("can't get session", session);
+	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
 
 	session->evlist = perf_evlist__new_default();
 	TEST_ASSERT_VAL("can't get evlist", session->evlist);
@@ -70,7 +71,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	int i;
 
 	session = perf_session__new(&data, false, NULL);
-	TEST_ASSERT_VAL("can't get session", session);
+	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
 
 	/* On platforms with large numbers of CPUs process_cpu_topology()
 	 * might issue an error while reading the perf.data file section
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 0c26844..dbc772b 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -30,6 +30,7 @@
 #include "machine.h"
 #include "config.h"
 #include <linux/ctype.h>
+#include <linux/err.h>
 
 #define pr_N(n, fmt, ...) \
 	eprintf(n, debug_data_convert, fmt, ##__VA_ARGS__)
@@ -1619,8 +1620,10 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 	err = -1;
 	/* perf.data session */
 	session = perf_session__new(&data, 0, &c.tool);
-	if (!session)
+	if (IS_ERR(session)) {
+		err = PTR_ERR(session);
 		goto free_writer;
+	}
 
 	if (c.queue_size) {
 		ordered_events__set_alloc_size(&session->ordered_events,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 58b5bc3..a621c73 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -34,6 +34,7 @@
 #include "../perf.h"
 #include "arch/common.h"
 #include <internal/lib.h>
+#include <linux/err.h>
 
 #ifdef HAVE_ZSTD_SUPPORT
 static int perf_session__process_compressed_event(struct perf_session *session,
@@ -187,6 +188,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 struct perf_session *perf_session__new(struct perf_data *data,
 				       bool repipe, struct perf_tool *tool)
 {
+	int ret = -ENOMEM;
 	struct perf_session *session = zalloc(sizeof(*session));
 
 	if (!session)
@@ -201,13 +203,15 @@ struct perf_session *perf_session__new(struct perf_data *data,
 
 	perf_env__init(&session->header.env);
 	if (data) {
-		if (perf_data__open(data))
+		ret = perf_data__open(data);
+		if (ret < 0)
 			goto out_delete;
 
 		session->data = data;
 
 		if (perf_data__is_read(data)) {
-			if (perf_session__open(session) < 0)
+			ret = perf_session__open(session);
+			if (ret < 0)
 				goto out_delete;
 
 			/*
@@ -222,8 +226,11 @@ struct perf_session *perf_session__new(struct perf_data *data,
 			perf_evlist__init_trace_event_sample_raw(session->evlist);
 
 			/* Open the directory data. */
-			if (data->is_dir && perf_data__open_dir(data))
+			if (data->is_dir) {
+				ret = perf_data__open_dir(data);
+			if (ret)
 				goto out_delete;
+			}
 		}
 	} else  {
 		session->machines.host.env = &perf_env;
@@ -256,7 +263,7 @@ struct perf_session *perf_session__new(struct perf_data *data,
  out_delete:
 	perf_session__delete(session);
  out:
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 static void perf_session__delete_threads(struct perf_session *session)
