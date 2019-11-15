Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D03C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4493D20859
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfKOHkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:40:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42570 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOHkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:40:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVWDF-0002VY-ID; Fri, 15 Nov 2019 08:40:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2D7881C18B4;
        Fri, 15 Nov 2019 08:40:13 +0100 (CET)
Date:   Fri, 15 Nov 2019 07:40:12 -0000
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tool: Provide an option to print
 perf_event_open args and return value
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191108094128.28769-1-ravi.bangoria@linux.ibm.com>
References: <20191108094128.28769-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <157380361279.29467.6054303321507255621.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ccd26741f5e6bdf2c18ea38b32e6a347c5648a97
Gitweb:        https://git.kernel.org/tip/ccd26741f5e6bdf2c18ea38b32e6a347c5648a97
Author:        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate:    Fri, 08 Nov 2019 15:11:28 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 12 Nov 2019 08:32:27 -03:00

perf tool: Provide an option to print perf_event_open args and return value

Perf record with verbose=2 already prints this information along with
whole lot of other traces which requires lot of scrolling. Introduce
an option to print only perf_event_open() arguments and return value.

Sample o/p:

  $ perf --debug perf-event-open=1 record -- ls > /dev/null
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|PERIOD
    read_format                      ID
    disabled                         1
    inherit                          1
    exclude_kernel                   1
    mmap                             1
    comm                             1
    freq                             1
    enable_on_exec                   1
    task                             1
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  sys_perf_event_open: pid 4308  cpu 0  group_fd -1  flags 0x8 = 4
  sys_perf_event_open: pid 4308  cpu 1  group_fd -1  flags 0x8 = 5
  sys_perf_event_open: pid 4308  cpu 2  group_fd -1  flags 0x8 = 6
  sys_perf_event_open: pid 4308  cpu 3  group_fd -1  flags 0x8 = 8
  sys_perf_event_open: pid 4308  cpu 4  group_fd -1  flags 0x8 = 9
  sys_perf_event_open: pid 4308  cpu 5  group_fd -1  flags 0x8 = 10
  sys_perf_event_open: pid 4308  cpu 6  group_fd -1  flags 0x8 = 11
  sys_perf_event_open: pid 4308  cpu 7  group_fd -1  flags 0x8 = 12
  ------------------------------------------------------------
  perf_event_attr:
    type                             1
    size                             112
    config                           0x9
    watermark                        1
    sample_id_all                    1
    bpf_event                        1
    { wakeup_events, wakeup_watermark } 1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
  sys_perf_event_open failed, error -13
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.002 MB perf.data (9 samples) ]

Committer notes:

Just like the 'verbose' variable this new 'debug_peo_args' needs to be
added to util/python.c, since we don't link the debug.o file in the
python binding, which ended up making 'perf test python' fail with:

  # perf test -v python
  18: 'import perf' in python                               :
  --- start ---
  test child forked, pid 19237
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  ImportError: /tmp/build/perf/python/perf.so: undefined symbol: debug_peo_args
  test child finished with -1
  ---- end ----
  'import perf' in python: FAILED!
  #

After adding that new variable to util/python.c:

  # perf test -v python
  18: 'import perf' in python                               :
  --- start ---
  test child forked, pid 22364
  test child finished with 0
  ---- end ----
  'import perf' in python: Ok
  #

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191108094128.28769-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.txt |  2 ++-
 tools/perf/util/debug.c           |  2 ++-
 tools/perf/util/debug.h           |  9 ++++++++-
 tools/perf/util/evsel.c           | 36 +++++++++++++++---------------
 tools/perf/util/python.c          |  1 +-
 5 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 401f0ed..3f37ded 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -24,6 +24,8 @@ OPTIONS
 	  data-convert     - data convert command debug messages
 	  stderr           - write debug output (option -v) to stderr
 	                     in browser mode
+	  perf-event-open  - Print perf_event_open() arguments and
+			     return value
 
 --buildid-dir::
 	Setup buildid cache directory. It has higher priority than
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index e55114f..adb6567 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -24,6 +24,7 @@
 #include <linux/ctype.h>
 
 int verbose;
+int debug_peo_args;
 bool dump_trace = false, quiet = false;
 int debug_ordered_events;
 static int redirect_to_stderr;
@@ -180,6 +181,7 @@ static struct debug_variable {
 	{ .name = "ordered-events",	.ptr = &debug_ordered_events},
 	{ .name = "stderr",		.ptr = &redirect_to_stderr},
 	{ .name = "data-convert",	.ptr = &debug_data_convert },
+	{ .name = "perf-event-open",	.ptr = &debug_peo_args },
 	{ .name = NULL, }
 };
 
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index d25ae1c..f1734ab 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -8,6 +8,7 @@
 #include <linux/compiler.h>
 
 extern int verbose;
+extern int debug_peo_args;
 extern bool quiet, dump_trace;
 extern int debug_ordered_events;
 extern int debug_data_convert;
@@ -30,6 +31,14 @@ extern int debug_data_convert;
 #define pr_debug3(fmt, ...) pr_debugN(3, pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
 
+/* Special macro to print perf_event_open arguments/return value. */
+#define pr_debug2_peo(fmt, ...) {				\
+	if (debug_peo_args)						\
+		pr_debugN(0, pr_fmt(fmt), ##__VA_ARGS__);	\
+	else							\
+		pr_debugN(2, pr_fmt(fmt), ##__VA_ARGS__);	\
+}
+
 #define pr_time_N(n, var, t, fmt, ...) \
 	eprintf_time(n, var, t, fmt, ##__VA_ARGS__)
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d445184..1bf60f3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1524,7 +1524,7 @@ static int __open_attr__fprintf(FILE *fp, const char *name, const char *val,
 
 static void display_attr(struct perf_event_attr *attr)
 {
-	if (verbose >= 2) {
+	if (verbose >= 2 || debug_peo_args) {
 		fprintf(stderr, "%.60s\n", graph_dotted_line);
 		fprintf(stderr, "perf_event_attr:\n");
 		perf_event_attr__fprintf(stderr, attr, __open_attr__fprintf, NULL);
@@ -1540,7 +1540,7 @@ static int perf_event_open(struct evsel *evsel,
 	int fd;
 
 	while (1) {
-		pr_debug2("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
+		pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
 			  pid, cpu, group_fd, flags);
 
 		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, group_fd, flags);
@@ -1560,9 +1560,9 @@ static int perf_event_open(struct evsel *evsel,
 			break;
 		}
 
-		pr_debug2("\nsys_perf_event_open failed, error %d\n", -ENOTSUP);
+		pr_debug2_peo("\nsys_perf_event_open failed, error %d\n", -ENOTSUP);
 		evsel->core.attr.precise_ip--;
-		pr_debug2("decreasing precise_ip by one (%d)\n", evsel->core.attr.precise_ip);
+		pr_debug2_peo("decreasing precise_ip by one (%d)\n", evsel->core.attr.precise_ip);
 		display_attr(&evsel->core.attr);
 	}
 
@@ -1681,12 +1681,12 @@ retry_open:
 					continue;
 				}
 
-				pr_debug2("\nsys_perf_event_open failed, error %d\n",
+				pr_debug2_peo("\nsys_perf_event_open failed, error %d\n",
 					  err);
 				goto try_fallback;
 			}
 
-			pr_debug2(" = %d\n", fd);
+			pr_debug2_peo(" = %d\n", fd);
 
 			if (evsel->bpf_fd >= 0) {
 				int evt_fd = fd;
@@ -1754,58 +1754,58 @@ try_fallback:
 	 */
 	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
 		perf_missing_features.aux_output = true;
-		pr_debug2("Kernel has no attr.aux_output support, bailing out\n");
+		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
 		goto out_close;
 	} else if (!perf_missing_features.bpf && evsel->core.attr.bpf_event) {
 		perf_missing_features.bpf = true;
-		pr_debug2("switching off bpf_event\n");
+		pr_debug2_peo("switching off bpf_event\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.ksymbol && evsel->core.attr.ksymbol) {
 		perf_missing_features.ksymbol = true;
-		pr_debug2("switching off ksymbol\n");
+		pr_debug2_peo("switching off ksymbol\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.write_backward && evsel->core.attr.write_backward) {
 		perf_missing_features.write_backward = true;
-		pr_debug2("switching off write_backward\n");
+		pr_debug2_peo("switching off write_backward\n");
 		goto out_close;
 	} else if (!perf_missing_features.clockid_wrong && evsel->core.attr.use_clockid) {
 		perf_missing_features.clockid_wrong = true;
-		pr_debug2("switching off clockid\n");
+		pr_debug2_peo("switching off clockid\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.clockid && evsel->core.attr.use_clockid) {
 		perf_missing_features.clockid = true;
-		pr_debug2("switching off use_clockid\n");
+		pr_debug2_peo("switching off use_clockid\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.cloexec && (flags & PERF_FLAG_FD_CLOEXEC)) {
 		perf_missing_features.cloexec = true;
-		pr_debug2("switching off cloexec flag\n");
+		pr_debug2_peo("switching off cloexec flag\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.mmap2 && evsel->core.attr.mmap2) {
 		perf_missing_features.mmap2 = true;
-		pr_debug2("switching off mmap2\n");
+		pr_debug2_peo("switching off mmap2\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.exclude_guest &&
 		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
 		perf_missing_features.exclude_guest = true;
-		pr_debug2("switching off exclude_guest, exclude_host\n");
+		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.sample_id_all) {
 		perf_missing_features.sample_id_all = true;
-		pr_debug2("switching off sample_id_all\n");
+		pr_debug2_peo("switching off sample_id_all\n");
 		goto retry_sample_id;
 	} else if (!perf_missing_features.lbr_flags &&
 			(evsel->core.attr.branch_sample_type &
 			 (PERF_SAMPLE_BRANCH_NO_CYCLES |
 			  PERF_SAMPLE_BRANCH_NO_FLAGS))) {
 		perf_missing_features.lbr_flags = true;
-		pr_debug2("switching off branch sample type no (cycles/flags)\n");
+		pr_debug2_peo("switching off branch sample type no (cycles/flags)\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.group_read &&
 		    evsel->core.attr.inherit &&
 		   (evsel->core.attr.read_format & PERF_FORMAT_GROUP) &&
 		   perf_evsel__is_group_leader(evsel)) {
 		perf_missing_features.group_read = true;
-		pr_debug2("switching off group read\n");
+		pr_debug2_peo("switching off group read\n");
 		goto fallback_missing_features;
 	}
 out_close:
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2511860..83212c6 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -65,6 +65,7 @@ struct perf_env perf_env;
  * implementing 'verbose' and 'eprintf'.
  */
 int verbose;
+int debug_peo_args;
 
 int eprintf(int level, int var, const char *fmt, ...);
 
