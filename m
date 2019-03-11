Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E691EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8E72147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfCKUZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:25:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:37486 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbfCKUYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:24:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 13:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="306300714"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2019 13:24:48 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D5AF0301E31; Mon, 11 Mar 2019 13:24:48 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 08/10] perf, tools, script: Support relative time
Date:   Mon, 11 Mar 2019 13:24:44 -0700
Message-Id: <20190311202446.10210-9-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When comparing time stamps in perf script traces it can be annoying
to work with the full perf time stamps. Add a --reltime option
that displays time stamps relative to the trace start to make
it easier to read the traces.

Note: not currently supported for --time. Report an error in this
case.

Before:

% perf script
         swapper     0 [000] 245402.891216:          1 cycles:ppp:  ffffffffa0068814 native_write_msr+0x4 ([kernel.kallsyms])
         swapper     0 [000] 245402.891223:          1 cycles:ppp:  ffffffffa0068814 native_write_msr+0x4 ([kernel.kallsyms])
         swapper     0 [000] 245402.891227:          5 cycles:ppp:  ffffffffa0068814 native_write_msr+0x4 ([kernel.kallsyms])
         swapper     0 [000] 245402.891231:         41 cycles:ppp:  ffffffffa0068816 native_write_msr+0x6 ([kernel.kallsyms])
         swapper     0 [000] 245402.891235:        355 cycles:ppp:  ffffffffa000dd51 intel_bts_enable_local+0x21 ([kernel.kallsyms])
         swapper     0 [000] 245402.891239:       3084 cycles:ppp:  ffffffffa0a0150a end_repeat_nmi+0x48 ([kernel.kallsyms])

After:

% perf script --reltime

         swapper     0 [000]     0.000000:          1 cycles:ppp:  ffffffffa0068814 native_write_msr+0x4 ([kernel.kallsyms])
         swapper     0 [000]     0.000006:          1 cycles:ppp:  ffffffffa0068814 native_write_msr+0x4 ([kernel.kallsyms])
         swapper     0 [000]     0.000010:          5 cycles:ppp:  ffffffffa0068814 native_write_msr+0x4 ([kernel.kallsyms])
         swapper     0 [000]     0.000014:         41 cycles:ppp:  ffffffffa0068816 native_write_msr+0x6 ([kernel.kallsyms])
         swapper     0 [000]     0.000018:        355 cycles:ppp:  ffffffffa000dd51 intel_bts_enable_local+0x21 ([kernel.kallsyms])
         swapper     0 [000]     0.000022:       3084 cycles:ppp:  ffffffffa0a0150a end_repeat_nmi+0x48 ([kernel.kallsyms])

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt |  3 +++
 tools/perf/builtin-script.c              | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 2e19fd7ffe35..9b0d04dd2a61 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -380,6 +380,9 @@ include::itrace.txt[]
 	Set the maximum number of program blocks to print with brstackasm for
 	each sample.
 
+--reltime::
+	Print time stamps relative to trace start.
+
 --per-event-dump::
 	Create per event files with a "perf.data.EVENT.dump" name instead of
         printing to stdout, useful, for instance, for generating flamegraphs.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 111787e83784..9664db79dc5a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -53,6 +53,8 @@
 
 static char const		*script_name;
 static char const		*generate_script_lang;
+static bool			reltime;
+static u64			initial_time;
 static bool			debug_mode;
 static u64			last_timestamp;
 static u64			nr_unordered;
@@ -686,7 +688,13 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 	}
 
 	if (PRINT_FIELD(TIME)) {
-		nsecs = sample->time;
+		u64 time = sample->time;
+		if (reltime) {
+			if (!initial_time)
+				initial_time = sample->time;
+			time = sample->time - initial_time;
+		}
+		nsecs = time;
 		secs = nsecs / NSEC_PER_SEC;
 		nsecs -= secs * NSEC_PER_SEC;
 
@@ -694,7 +702,7 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 			printed += fprintf(fp, "%5lu.%09llu: ", secs, nsecs);
 		else {
 			char sample_time[32];
-			timestamp__scnprintf_usec(sample->time, sample_time, sizeof(sample_time));
+			timestamp__scnprintf_usec(time, sample_time, sizeof(sample_time));
 			printed += fprintf(fp, "%12s: ", sample_time);
 		}
 	}
@@ -3386,6 +3394,7 @@ int cmd_script(int argc, const char **argv)
 		     "Set the maximum stack depth when parsing the callchain, "
 		     "anything beyond the specified depth will be ignored. "
 		     "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
+	OPT_BOOLEAN(0, "reltime", &reltime, "Show time stamps relative to start"),
 	OPT_BOOLEAN('I', "show-info", &show_full_info,
 		    "display extended information from perf.data file"),
 	OPT_BOOLEAN('\0', "show-kernel-path", &symbol_conf.show_kernel_path,
@@ -3460,6 +3469,11 @@ int cmd_script(int argc, const char **argv)
 		}
 	}
 
+	if (script.time_str && reltime) {
+		fprintf(stderr, "Don't combine --reltime with --time\n");
+		return -1;
+	}
+
 	if (itrace_synth_opts.callchain &&
 	    itrace_synth_opts.callchain_sz > scripting_max_stack)
 		scripting_max_stack = itrace_synth_opts.callchain_sz;
-- 
2.20.1

