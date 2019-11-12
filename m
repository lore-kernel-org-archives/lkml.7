Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A4D22469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfKLLWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:22:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33516 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfKLLSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBE-0000GB-MY; Tue, 12 Nov 2019 12:17:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 538F91C0084;
        Tue, 12 Nov 2019 12:17:52 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:17:51 -0000
From:   "tip-bot2 for Jiwei Sun" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf record: Add support for limit perf output file size
Cc:     Jiwei Sun <jiwei.sun@windriver.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Danter <richard.danter@windriver.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191022080901.3841-1-jiwei.sun@windriver.com>
References: <20191022080901.3841-1-jiwei.sun@windriver.com>
MIME-Version: 1.0
Message-ID: <157355747195.29376.11637889672517733386.tip-bot2@tip-bot2>
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

Commit-ID:     6d57581659f7229903d141455c7308e309056e89
Gitweb:        https://git.kernel.org/tip/6d57581659f7229903d141455c7308e309056e89
Author:        Jiwei Sun <jiwei.sun@windriver.com>
AuthorDate:    Tue, 22 Oct 2019 16:09:01 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 07 Nov 2019 08:30:19 -03:00

perf record: Add support for limit perf output file size

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
 tools/perf/Documentation/perf-record.txt |  4 ++-
 tools/perf/builtin-record.c              | 46 ++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 8a45061..ebcba1f 100644
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
index f6664bb..b95c000 100644
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
 
