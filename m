Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F360C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF7A20872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PLEhvTrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfERJYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:24:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47793 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:24:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9OV7Y1741121
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:24:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9OV7Y1741121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171471;
        bh=ZuR5mryf/9XZpkdbYGq7ot7oDGB5hixWx7cfapN/bz8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=PLEhvTrYCCAEjF1IdMvs+Mqi4jECUBJvU8gs0pbJw0CNGXl8FqxkgWdXz8ESGTEKm
         JroE8yv6mKgRKEF8UED+oxUp4dbQsxPQ5zkhUCrCqM4LG6KdIBexpnGeTeN/02g//z
         2i918+/YxutfYRH5418BcsRIyLh1mJrOuZRslfgJq4OXvxpCa6jERSI64JA7ly1dnJ
         hi8zLXLiigkTqso1pFLOYS2jzf6yxlMwE6tx48BvRD910/K6K5WSS5Ilc7r41kBVZv
         cJiM2xia2Mh/SHkT2pP491eLAui2rrDEQ6YdWjem4i8S0lp2pn/DHdH18MYc85H3Fw
         kZyZwgeULcOKQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9OUKs1741117;
        Sat, 18 May 2019 02:24:30 -0700
Date:   Sat, 18 May 2019 02:24:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-504c1ad11691d1a16e92285bb961728a80c06014@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, jolsa@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org, hpa@zytor.com,
        ak@linux.intel.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com
Reply-To: alexey.budankov@linux.intel.com, peterz@infradead.org,
          tglx@linutronix.de, namhyung@kernel.org, ak@linux.intel.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
          hpa@zytor.com, acme@redhat.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <9ff06518-ae63-a908-e44d-5d9e56dd66d9@linux.intel.com>
References: <9ff06518-ae63-a908-e44d-5d9e56dd66d9@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Implement -z,--compression_level[=<n>]
 option
Git-Commit-ID: 504c1ad11691d1a16e92285bb961728a80c06014
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  504c1ad11691d1a16e92285bb961728a80c06014
Gitweb:     https://git.kernel.org/tip/504c1ad11691d1a16e92285bb961728a80c06014
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Mon, 18 Mar 2019 20:44:42 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf record: Implement -z,--compression_level[=<n>] option

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
 tools/perf/Documentation/perf-record.txt |  5 +++++
 tools/perf/builtin-record.c              | 30 ++++++++++++++++++++++++++++++
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
