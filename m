Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AD6C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B91121743
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122028;
	bh=96Ykpsqb3FDQ7iMqiJcl477CcXgJCoBX+zB5foYhdVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VZh0bwFHKTm2Lwts/I/n5dv6iYoWWhEPzPnncRP00ot86WE8wA0qhvC3yJ/rvOaxk
	 C5xItfRsapUrEUtBU2Drtnjz2vaWHI5M0CXlnZ/LES5vA/BjHkAU1B9KKZqEL4wi2x
	 9koIOzS0WbRGFSOddXr+/e91NnIUvEBpSeIbmvOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfEQTk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729682AbfEQTkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:40:23 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DCBD217F4;
        Fri, 17 May 2019 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122021;
        bh=96Ykpsqb3FDQ7iMqiJcl477CcXgJCoBX+zB5foYhdVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JxpqI14C2qOSpxMs5FqPEQg2MjJrY3RjF3Hn17bc5rFAy2y9wLwXeNsqY0g+DpUuc
         FF/9tE8YMZZuIciN8QRsOSadx4NPYSivv1lnY0DcYCLKntxrJoLZtG/GJ4uu4lLxbj
         EWT1T+KB9agNbtb8dWA9aJQ9yNnDVsWH5B+E3/7M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 55/73] perf record: Implement -z,--compression_level[=<n>] option
Date:   Fri, 17 May 2019 16:35:53 -0300
Message-Id: <20190517193611.4974-56-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Implemented -z,--compression_level[=<n>] option that enables compression
of mmaped kernel data buffers content in runtime during perf record mode
collection. Default option value is 1 (fastest compression).

Compression overhead has been measured for serial and AIO streaming when
profiling matrix multiplication workload:

      -------------------------------------------------------------
      | SERIAL			  | AIO-1                       |
  ----------------------------------------------------------------|
  |-z | OVH(x) | ratio(x) size(MiB) | OVH(x) | ratio(x) size(MiB) |
  |---------------------------------------------------------------|
  | 0 | 1,00   | 1,000    179,424   | 1,00   | 1,000    187,527   |
  | 1 | 1,04   | 8,427    181,148   | 1,01   | 8,474    188,562   |
  | 2 | 1,07   | 8,055    186,953   | 1,03   | 7,912    191,773   |
  | 3 | 1,04   | 8,283    181,908   | 1,03   | 8,220    191,078   |
  | 5 | 1,09   | 8,101    187,705   | 1,05   | 7,780    190,065   |
  | 8 | 1,05   | 9,217    179,191   | 1,12   | 6,111    193,024   |
  -----------------------------------------------------------------

OVH = (Execution time with -z N) / (Execution time with -z 0)

ratio - compression ratio
size  - number of bytes that was compressed

	size ~= trace size x ratio

Committer notes:

Testing it I noticed that it failed to disable build id processing when
compression is enabled, and as we'd have to uncompress everything to
look for the PERF_RECORD_{MMAP,SAMPLE,etc} to figure out which build ids
to read from DSOs, we better disable build id processing when
compression is enabled, logging with pr_debug() when doing so:

Original patch:

  # perf record -z2
  ^C[ perf record: Woken up 1 times to write data ]
  0x1746e0 [0x76]: failed to process type: 81 [Invalid argument]
  [ perf record: Captured and wrote 1.568 MB perf.data, compressed (original 0.452 MB, ratio is 3.995) ]
  #

After auto-disabling build id processing when compression is enabled:

  $ perf record -z2 sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data, compressed (original 0.001 MB, ratio is 2.292) ]
  $ perf record -v -z2 sleep 1
  Compression enabled, disabling build id collection at the end of the session.
  <SNIP extra -v pr_debug() messages>
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data, compressed (original 0.001 MB, ratio is 2.305) ]
  $

Also, with parts of the patch originally after this one moved to just
before this one we get:

  $ perf record -z2 sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data, compressed (original 0.001 MB, ratio is 2.371) ]
  $ perf report -D | grep COMPRESS
  0 0x1b8 [0x155]: PERF_RECORD_COMPRESSED: unhandled!
  0 0x30d [0x80]: PERF_RECORD_COMPRESSED: unhandled!
        COMPRESSED events:          2
        COMPRESSED events:          0
  $

I.e. when faced with PERF_RECORD_COMPRESSED that we still have no code
to process, we just show it as not being handled, skip them and
continue, while before we had:

  $ perf report -D | grep COMPRESS
  0x1b8 [0x169]: failed to process type: 81 [Invalid argument]
  Error:
  failed to process sample
  0 0x1b8 [0x169]: PERF_RECORD_COMPRESSED
  $

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/9ff06518-ae63-a908-e44d-5d9e56dd66d9@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  5 ++++
 tools/perf/builtin-record.c              | 30 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 58986f4cc190..27b37624c376 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -478,6 +478,11 @@ Also at some cases executing less output write syscalls with bigger data size
 can take less time than executing more output write syscalls with smaller data
 size thus lowering runtime profiling overhead.
 
+-z::
+--compression-level[=n]::
+Produce compressed trace using specified level n (default: 1 - fastest compression,
+22 - smallest trace)
+
 --all-kernel::
 Configure all used events to run in kernel space.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a0bd9104fae6..861395753c25 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -443,6 +443,25 @@ static int record__mmap_flush_parse(const struct option *opt,
 	return 0;
 }
 
+#ifdef HAVE_ZSTD_SUPPORT
+static unsigned int comp_level_default = 1;
+
+static int record__parse_comp_level(const struct option *opt, const char *str, int unset)
+{
+	struct record_opts *opts = opt->value;
+
+	if (unset) {
+		opts->comp_level = 0;
+	} else {
+		if (str)
+			opts->comp_level = strtol(str, NULL, 0);
+		if (!opts->comp_level)
+			opts->comp_level = comp_level_default;
+	}
+
+	return 0;
+}
+#endif
 static unsigned int comp_level_max = 22;
 
 static int record__comp_enabled(struct record *rec)
@@ -2200,6 +2219,11 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
 		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
 		     record__parse_affinity),
+#ifdef HAVE_ZSTD_SUPPORT
+	OPT_CALLBACK_OPTARG('z', "compression-level", &record.opts, &comp_level_default,
+			    "n", "Compressed records using specified level (default: 1 - fastest compression, 22 - greatest compression)",
+			    record__parse_comp_level),
+#endif
 	OPT_END()
 };
 
@@ -2259,6 +2283,12 @@ int cmd_record(int argc, const char **argv)
 			"cgroup monitoring only available in system-wide mode");
 
 	}
+
+	if (rec->opts.comp_level != 0) {
+		pr_debug("Compression enabled, disabling build id collection at the end of the session.\n");
+		rec->no_buildid = true;
+	}
+
 	if (rec->opts.record_switch_events &&
 	    !perf_can_record_switch_events()) {
 		ui__error("kernel does not support recording context switch events\n");
-- 
2.20.1

