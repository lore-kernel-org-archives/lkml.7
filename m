Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48114C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D5A2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153732;
	bh=/uCqjg7wtCfRzgq/VLmF5TtDcuXNk8W84DoByWC4AVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ncrLE0IwxxoFFta+2eTx68+VpzqaTDzZn7TEuffJGxEOEQhqiDs2IAPU/jZ/oQbYL
	 Sk379++lD3ZOpiJO5G7+alk6Hdfiqmi+mBTbMx60jMi8gYsGom7RbcWT8Y1FuOVC38
	 nvsduG8olfggGL27pTi552CwJB5pUVOXV/PDgOCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfKGTIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:08:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731168AbfKGTIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:08:47 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B272085B;
        Thu,  7 Nov 2019 19:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153726;
        bh=/uCqjg7wtCfRzgq/VLmF5TtDcuXNk8W84DoByWC4AVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nX/gUa/dFx3jNkwomZIXjjIe9LkYt7XFxpKO/K2yLVwEcTOKNiULcttB4rm+ukk2T
         tz9duMGFcB5CvscEhvW0XtjlAOp8M11CpiXdrT/eQZc74Tr9GNHUYvc1pAJVIaksXw
         Yo618jouISUWFLe3uBiNX2OY3pTSbvXQIkHfz+3s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiwei Sun <jiwei.sun@windriver.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Danter <richard.danter@windriver.com>
Subject: [PATCH 55/63] perf record: Add support for limit perf output file size
Date:   Thu,  7 Nov 2019 16:00:03 -0300
Message-Id: <20191107190011.23924-56-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiwei Sun <jiwei.sun@windriver.com>

The patch adds a new option to limit the output file size, then based on
it, we can create a wrapper of the perf command that uses the option to
avoid exhausting the disk space by the unconscious user.

In order to make the perf.data parsable, we just limit the sample data
size, since the perf.data consists of many headers and sample data and
other data, the actual size of the recorded file will bigger than the
setting value.

Testing it:

  # ./perf record -a -g --max-size=10M
  Couldn't synthesize bpf events.
  [ perf record: perf size limit reached (10249 KB), stopping session ]
  [ perf record: Woken up 32 times to write data ]
  [ perf record: Captured and wrote 10.133 MB perf.data (71964 samples) ]

  # ls -lh perf.data
  -rw------- 1 root root 11M Oct 22 14:32 perf.data

  # ./perf record -a -g --max-size=10K
  [ perf record: perf size limit reached (10 KB), stopping session ]
  Couldn't synthesize bpf events.
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Captured and wrote 1.546 MB perf.data (69 samples) ]

  # ls -l perf.data
  -rw------- 1 root root 1626952 Oct 22 14:36 perf.data

Committer notes:

Fixed the build in multiple distros by using PRIu64 to print u64 struct
members, fixing this:

  builtin-record.c: In function 'record__write':
  builtin-record.c:150:5: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'u64' [-Werror=format=]
       rec->bytes_written >> 10);
       ^
    CC       /tmp/build/pe

Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Danter <richard.danter@windriver.com>
Link: http://lore.kernel.org/lkml/20191022080901.3841-1-jiwei.sun@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  4 +++
 tools/perf/builtin-record.c              | 46 +++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 8a4506113d9f..ebcba1f95513 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -574,6 +574,10 @@ Implies --tail-synthesize.
 --kcore::
 Make a copy of /proc/kcore and place it into a directory with the perf data file.
 
+--max-size=<size>::
+Limit the sample data max size, <size> is expected to be a number with
+appended unit character - B/K/M/G
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1]
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f6664bb08b26..b95c000c1ed9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -94,8 +94,11 @@ struct record {
 	struct switch_output	switch_output;
 	unsigned long long	samples;
 	cpu_set_t		affinity_mask;
+	unsigned long		output_max_size;	/* = 0: unlimited */
 };
 
+static volatile int done;
+
 static volatile int auxtrace_record__snapshot_started;
 static DEFINE_TRIGGER(auxtrace_snapshot_trigger);
 static DEFINE_TRIGGER(switch_output_trigger);
@@ -123,6 +126,12 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
+static bool record__output_max_size_exceeded(struct record *rec)
+{
+	return rec->output_max_size &&
+	       (rec->bytes_written >= rec->output_max_size);
+}
+
 static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 			 void *bf, size_t size)
 {
@@ -135,6 +144,13 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 
 	rec->bytes_written += size;
 
+	if (record__output_max_size_exceeded(rec) && !done) {
+		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
+				" stopping session ]\n",
+				rec->bytes_written >> 10);
+		done = 1;
+	}
+
 	if (switch_output_size(rec))
 		trigger_hit(&switch_output_trigger);
 
@@ -499,7 +515,6 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 	return record__write(rec, map, bf, size);
 }
 
-static volatile int done;
 static volatile int signr = -1;
 static volatile int child_finished;
 
@@ -1984,6 +1999,33 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
 	return 0;
 }
 
+static int parse_output_max_size(const struct option *opt,
+				 const char *str, int unset)
+{
+	unsigned long *s = (unsigned long *)opt->value;
+	static struct parse_tag tags_size[] = {
+		{ .tag  = 'B', .mult = 1       },
+		{ .tag  = 'K', .mult = 1 << 10 },
+		{ .tag  = 'M', .mult = 1 << 20 },
+		{ .tag  = 'G', .mult = 1 << 30 },
+		{ .tag  = 0 },
+	};
+	unsigned long val;
+
+	if (unset) {
+		*s = 0;
+		return 0;
+	}
+
+	val = parse_tag_value(str, tags_size);
+	if (val != (unsigned long) -1) {
+		*s = val;
+		return 0;
+	}
+
+	return -1;
+}
+
 static int record__parse_mmap_pages(const struct option *opt,
 				    const char *str,
 				    int unset __maybe_unused)
@@ -2311,6 +2353,8 @@ static struct option __record_options[] = {
 			    "n", "Compressed records using specified level (default: 1 - fastest compression, 22 - greatest compression)",
 			    record__parse_comp_level),
 #endif
+	OPT_CALLBACK(0, "max-size", &record.output_max_size,
+		     "size", "Limit the maximum size of the output file", parse_output_max_size),
 	OPT_END()
 };
 
-- 
2.21.0

