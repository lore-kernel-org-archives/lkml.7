Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E6CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5D22070B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbfHTLVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:21:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728409AbfHTLVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:21:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KBLfYe058766
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:21:41 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uge7a533n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:21:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Tue, 20 Aug 2019 12:21:31 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Aug 2019 12:21:27 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7KBLQbE32833786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 11:21:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7371042052;
        Tue, 20 Aug 2019 11:21:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7876842042;
        Tue, 20 Aug 2019 11:21:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.120.237.31])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 11:21:22 +0000 (GMT)
Subject: [PATCH V1]Perf: Return error code for perf_session__new function on
 failure
From:   Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mamatha4@linux.vnet.ibm.com, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        jeremie.galarneau@efficios.com, shawn@git.icu,
        tstoyanov@vmware.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, adrian.hunter@intel.com,
        songliubraving@fb.com, ravi.bangoria@linux.ibm.com
Date:   Tue, 20 Aug 2019 16:51:21 +0530
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19082011-0028-0000-0000-00000391AA31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082011-0029-0000-0000-00002453CDBF
Message-Id: <20190820105645.4920.55590.stgit@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch is to return error code of perf_new_session function
on failure instead of NULL
----------------------------------------------
Test Results:

Before Fix:

$ perf c2c report -input
failed to open nput: No such file or directory

$ echo $?
0
------------------------------------------
After Fix:

$ ./perf c2c report -input
failed to open nput: No such file or directory

$ echo $?
254

Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Tested-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
---
 tools/perf/builtin-annotate.c      |    5 +++--
 tools/perf/builtin-buildid-cache.c |    5 +++--
 tools/perf/builtin-buildid-list.c  |    5 +++--
 tools/perf/builtin-c2c.c           |    6 ++++--
 tools/perf/builtin-diff.c          |    9 +++++----
 tools/perf/builtin-evlist.c        |    5 +++--
 tools/perf/builtin-inject.c        |    5 +++--
 tools/perf/builtin-kmem.c          |    5 +++--
 tools/perf/builtin-kvm.c           |    9 +++++----
 tools/perf/builtin-lock.c          |    5 +++--
 tools/perf/builtin-mem.c           |    5 +++--
 tools/perf/builtin-record.c        |    5 +++--
 tools/perf/builtin-report.c        |    4 ++--
 tools/perf/builtin-sched.c         |   11 ++++++-----
 tools/perf/builtin-script.c        |    9 +++++----
 tools/perf/builtin-stat.c          |   11 ++++++-----
 tools/perf/builtin-timechart.c     |    5 +++--
 tools/perf/builtin-top.c           |    5 +++--
 tools/perf/builtin-trace.c         |    4 ++--
 tools/perf/util/data-convert-bt.c  |    5 ++++-
 tools/perf/util/session.c          |   13 +++++++++----
 21 files changed, 81 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 9bb6371..b3b9631 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -33,6 +33,7 @@
 #include "util/data.h"
 #include "arch/common.h"
 #include "util/block-range.h"
+#include <linux/err.h>
 
 #include <dlfcn.h>
 #include <errno.h>
@@ -581,8 +582,8 @@ int cmd_annotate(int argc, const char **argv)
 	data.path = input_name;
 
 	annotate.session = perf_session__new(&data, false, &annotate.tool);
-	if (annotate.session == NULL)
-		return -1;
+	if (IS_ERR(annotate.session))
+		return PTR_ERR(annotate.session);
 
 	annotate.has_br_stack = perf_header__has_feat(&annotate.session->header,
 						      HEADER_BRANCH_STACK);
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 10457b1..7bab695 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -26,6 +26,7 @@
 #include "util/symbol.h"
 #include "util/time-utils.h"
 #include "util/probe-file.h"
+#include <linux/err.h>
 
 static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
 {
@@ -420,8 +421,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 		data.force = force;
 
 		session = perf_session__new(&data, false, NULL);
-		if (session == NULL)
-			return -1;
+		if (IS_ERR(session))
+			return PTR_ERR(session);
 	}
 
 	if (symbol__init(session ? &session->header.env : NULL) < 0)
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index f403e19..95036ee 100644
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
index f0aae6e..a26a33c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -34,6 +34,7 @@
 #include "thread.h"
 #include "mem2node.h"
 #include "symbol.h"
+#include <linux/err.h>
 
 struct c2c_hists {
 	struct hists		hists;
@@ -2774,8 +2775,9 @@ static int perf_c2c__report(int argc, const char **argv)
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
index e91c0d7..3fb4938 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -22,6 +22,7 @@
 #include "util/annotate.h"
 #include "util/map.h"
 #include <linux/zalloc.h>
+#include <linux/err.h>
 
 #include <errno.h>
 #include <inttypes.h>
@@ -1149,9 +1150,9 @@ static int check_file_brstack(void)
 
 	data__for_each_file(i, d) {
 		d->session = perf_session__new(&d->data, false, &pdiff.tool);
-		if (!d->session) {
+		if (IS_ERR(d->session)) {
 			pr_err("Failed to open %s\n", d->data.path);
-			return -1;
+			return PTR_ERR(d->session);
 		}
 
 		has_br_stack = perf_header__has_feat(&d->session->header,
@@ -1181,9 +1182,9 @@ static int __cmd_diff(void)
 
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
index 238fa38..c54c186 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -17,6 +17,7 @@
 #include "util/session.h"
 #include "util/data.h"
 #include "util/debug.h"
+#include <linux/err.h>
 
 static int __cmd_evlist(const char *file_name, struct perf_attr_details *details)
 {
@@ -30,8 +31,8 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 	bool has_tracepoint = false;
 
 	session = perf_session__new(&data, 0, NULL);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	evlist__for_each_entry(session->evlist, pos) {
 		perf_evsel__fprintf(pos, details, stdout);
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 0401425..b11ace5 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -22,6 +22,7 @@
 #include "util/jit.h"
 #include "util/symbol.h"
 #include "util/thread.h"
+#include <linux/err.h>
 
 #include <subcmd/parse-options.h>
 
@@ -834,8 +835,8 @@ int cmd_inject(int argc, const char **argv)
 
 	data.path = inject.input_name;
 	inject.session = perf_session__new(&data, true, &inject.tool);
-	if (inject.session == NULL)
-		return -1;
+	if (IS_ERR(inject.session))
+		return PTR_ERR(inject.session);
 
 	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed.\n");
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 46f8289..3c723f4 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -13,6 +13,7 @@
 #include "util/tool.h"
 #include "util/callchain.h"
 #include "util/time-utils.h"
+#include <linux/err.h>
 
 #include <subcmd/parse-options.h>
 #include "util/trace-event.h"
@@ -1953,8 +1954,8 @@ int cmd_kmem(int argc, const char **argv)
 	data.path = input_name;
 
 	kmem_session = session = perf_session__new(&data, false, &perf_kmem);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	ret = -1;
 
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 69d16ac..7468df3 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -19,6 +19,7 @@
 #include "util/top.h"
 #include "util/data.h"
 #include "util/ordered-events.h"
+#include <linux/err.h>
 
 #include <sys/prctl.h>
 #ifdef HAVE_TIMERFD_SUPPORT
@@ -1087,9 +1088,9 @@ static int read_events(struct perf_kvm_stat *kvm)
 
 	kvm->tool = eops;
 	kvm->session = perf_session__new(&file, false, &kvm->tool);
-	if (!kvm->session) {
+	if (IS_ERR(kvm->session)) {
 		pr_err("Initializing perf session failed\n");
-		return -1;
+		return PTR_ERR(kvm->session);
 	}
 
 	symbol__init(&kvm->session->header.env);
@@ -1442,8 +1443,8 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
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
index 38500bf..9b48d4b 100644
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
index 9e60eda..c8406a4 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -15,6 +15,7 @@
 #include "util/debug.h"
 #include "util/map.h"
 #include "util/symbol.h"
+#include <linux/err.h>
 
 #define MEM_OPERATION_LOAD	0x1
 #define MEM_OPERATION_STORE	0x2
@@ -247,8 +248,8 @@ static int report_raw_events(struct perf_mem *mem)
 	struct perf_session *session = perf_session__new(&data, false,
 							 &mem->tool);
 
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	if (mem->cpu_list) {
 		ret = perf_session__cpu_bitmap(session, mem->cpu_list,
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f71631f..993dec9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -42,6 +42,7 @@
 #include "util/units.h"
 #include "util/bpf-event.h"
 #include "asm/bug.h"
+#include <linux/err.h>
 
 #include <errno.h>
 #include <inttypes.h>
@@ -1360,9 +1361,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
index 79dfb11..4640127 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1260,8 +1260,8 @@ int cmd_report(int argc, const char **argv)
 
 repeat:
 	session = perf_session__new(&data, false, &report.tool);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	ret = evswitch__init(&report.evswitch, session->evlist, stderr);
 	if (ret)
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0d6b4c3..3fa84cc 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -36,6 +36,7 @@
 #include <math.h>
 #include <api/fs/fs.h>
 #include <linux/time64.h>
+#include <linux/err.h>
 
 #include <linux/ctype.h>
 
@@ -1793,9 +1794,9 @@ static int perf_sched__read_events(struct perf_sched *sched)
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
@@ -2985,8 +2986,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	symbol_conf.use_callchain = sched->show_callchain;
 
 	session = perf_session__new(&data, false, &sched->tool);
-	if (session == NULL)
-		return -ENOMEM;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	evlist = session->evlist;
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1764efd1..26b0c99 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -50,6 +50,7 @@
 #include <unistd.h>
 #include <subcmd/pager.h>
 #include <perf/evlist.h>
+#include <linux/err.h>
 
 #include <linux/ctype.h>
 
@@ -3078,8 +3079,8 @@ int find_scripts(char **scripts_array, char **scripts_path_array, int num,
 	int i = 0;
 
 	session = perf_session__new(&data, false, NULL);
-	if (!session)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	snprintf(scripts_path, MAXPATHLEN, "%s/scripts", get_argv_exec_path());
 
@@ -3749,8 +3750,8 @@ int cmd_script(int argc, const char **argv)
 	}
 
 	session = perf_session__new(&data, false, &script.tool);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	if (header || header_only) {
 		script.tool.show_feat_hdr = SHOW_FEAT_HEADER;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b19df67..ed80a24 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -81,6 +81,7 @@
 #include <unistd.h>
 #include <sys/time.h>
 #include <sys/resource.h>
+#include <linux/err.h>
 
 #include <linux/ctype.h>
 #include <perf/evlist.h>
@@ -1446,9 +1447,9 @@ static int __cmd_record(int argc, const char **argv)
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
@@ -1645,8 +1646,8 @@ static int __cmd_report(int argc, const char **argv)
 	perf_stat.data.mode = PERF_DATA_MODE_READ;
 
 	session = perf_session__new(&perf_stat.data, false, &perf_stat.tool);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	perf_stat.session  = session;
 	stat_config.output = stderr;
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 7d6a6ec..628d008 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -36,6 +36,7 @@
 #include "util/tool.h"
 #include "util/data.h"
 #include "util/debug.h"
+#include <linux/err.h>
 
 #ifdef LACKS_OPEN_MEMSTREAM_PROTOTYPE
 FILE *open_memstream(char **ptr, size_t *sizeloc);
@@ -1605,8 +1606,8 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 							 &tchart->tool);
 	int ret = -EINVAL;
 
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	symbol__init(&session->header.env);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5970723..9f19f32 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -74,6 +74,7 @@
 #include <linux/stringify.h>
 #include <linux/time64.h>
 #include <linux/types.h>
+#include <linux/err.h>
 
 #include <linux/ctype.h>
 
@@ -1675,8 +1676,8 @@ int cmd_top(int argc, const char **argv)
 	}
 
 	top.session = perf_session__new(NULL, false, NULL);
-	if (top.session == NULL) {
-		status = -1;
+	if (IS_ERR(top.session)) {
+		status = PTR_ERR(top.session);
 		goto out_delete_evlist;
 	}
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bc44ed2..162f03c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3578,8 +3578,8 @@ static int trace__replay(struct trace *trace)
 	trace->multiple_threads = true;
 
 	session = perf_session__new(&data, false, &trace->tool);
-	if (session == NULL)
-		return -1;
+	if (IS_ERR(session))
+		return PTR_ERR(session);
 
 	if (trace->opts.target.pid)
 		symbol_conf.pid_list_str = strdup(trace->opts.target.pid);
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
index 82e0438..bd5d579 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -30,6 +30,7 @@
 #include "sample-raw.h"
 #include "stat.h"
 #include "arch/common.h"
+#include <linux/err.h>
 
 #ifdef HAVE_ZSTD_SUPPORT
 static int perf_session__process_compressed_event(struct perf_session *session,
@@ -183,6 +184,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 struct perf_session *perf_session__new(struct perf_data *data,
 				       bool repipe, struct perf_tool *tool)
 {
+	int ret = -ENOMEM;
 	struct perf_session *session = zalloc(sizeof(*session));
 
 	if (!session)
@@ -197,13 +199,15 @@ struct perf_session *perf_session__new(struct perf_data *data,
 
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
@@ -218,7 +222,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
 			perf_evlist__init_trace_event_sample_raw(session->evlist);
 
 			/* Open the directory data. */
-			if (data->is_dir && perf_data__open_dir(data))
+			ret = data->is_dir && perf_data__open_dir(data);
+			if (ret)
 				goto out_delete;
 		}
 	} else  {
@@ -252,7 +257,7 @@ struct perf_session *perf_session__new(struct perf_data *data,
  out_delete:
 	perf_session__delete(session);
  out:
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 static void perf_session__delete_threads(struct perf_session *session)

