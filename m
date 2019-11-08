Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEFDC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48E221882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfKHEAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 23:00:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726556AbfKHEAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 23:00:01 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA83vn8Q048143
        for <linux-kernel@vger.kernel.org>; Thu, 7 Nov 2019 23:00:00 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w504ch4nd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 22:59:59 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 8 Nov 2019 03:59:58 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Nov 2019 03:59:54 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA83xsYu51708068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 03:59:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAFE942041;
        Fri,  8 Nov 2019 03:59:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98AE54203F;
        Fri,  8 Nov 2019 03:59:52 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.59.212])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 03:59:52 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [RFC] perf record: Add option to print perf_event_open args and return value
Date:   Fri,  8 Nov 2019 09:29:49 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110803-4275-0000-0000-0000037BD615
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110803-4276-0000-0000-0000388F2937
Message-Id: <20191108035949.32644-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf record with verbose=2 already prints this information along with
whole lot of other traces which requires lot of scrolling. I thought
to show this information in verbose=1 but I fear that it will be too
much for level 1. So finally created a new option specifically for
printing this.

Sample o/p:
  $ ./perf record --peo-args -- ls > /dev/null
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

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/Documentation/perf-record.txt |  3 ++
 tools/perf/builtin-record.c              |  1 +
 tools/perf/util/debug.c                  |  1 +
 tools/perf/util/debug.h                  |  9 ++++++
 tools/perf/util/evsel.c                  | 36 ++++++++++++------------
 5 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index c6f9f31b6039..8257c9b28c13 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -268,6 +268,9 @@ OPTIONS
 --verbose::
 	Be more verbose (show counter open errors, etc).
 
+--peo-args::
+	Print perf_event_open() arguments and return value.
+
 -s::
 --stat::
 	Record per-thread event counts.  Use it with 'perf report -T' to see
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 23332861de6e..ebb09238fcb0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2159,6 +2159,7 @@ static struct option __record_options[] = {
 		     &record_parse_callchain_opt),
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show counter open errors, etc)"),
+	OPT_BOOLEAN(0, "peo-args", &peo_args, "Print perf_event_open() args and return value"),
 	OPT_BOOLEAN('q', "quiet", &quiet, "don't print any message"),
 	OPT_BOOLEAN('s', "stat", &record.opts.inherit_stat,
 		    "per thread counts"),
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index e55114f0336f..692cf6788a55 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -24,6 +24,7 @@
 #include <linux/ctype.h>
 
 int verbose;
+bool peo_args;
 bool dump_trace = false, quiet = false;
 int debug_ordered_events;
 static int redirect_to_stderr;
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index d25ae1c4cee9..3e54c5d86f3d 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -8,6 +8,7 @@
 #include <linux/compiler.h>
 
 extern int verbose;
+extern bool peo_args;
 extern bool quiet, dump_trace;
 extern int debug_ordered_events;
 extern int debug_data_convert;
@@ -30,6 +31,14 @@ extern int debug_data_convert;
 #define pr_debug3(fmt, ...) pr_debugN(3, pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
 
+/* Special macro to print perf_event_open arguments/return value. */
+#define pr_debug2_peo(fmt, ...) {				\
+	if (peo_args)						\
+		pr_debugN(0, pr_fmt(fmt), ##__VA_ARGS__);	\
+	else							\
+		pr_debugN(2, pr_fmt(fmt), ##__VA_ARGS__);	\
+}
+
 #define pr_time_N(n, var, t, fmt, ...) \
 	eprintf_time(n, var, t, fmt, ##__VA_ARGS__)
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index abc7fda4a0fe..f87ab5c4a29b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1524,7 +1524,7 @@ static int __open_attr__fprintf(FILE *fp, const char *name, const char *val,
 
 static void display_attr(struct perf_event_attr *attr)
 {
-	if (verbose >= 2) {
+	if (verbose >= 2 || peo_args) {
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
 
@@ -1681,12 +1681,12 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
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
@@ -1754,58 +1754,58 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
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
-- 
2.21.0

