Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFEDC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E0120872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GDuwFyPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfERJ1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:27:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:27:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9RHip1741605
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:27:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9RHip1741605
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171637;
        bh=fivn3MS59Xw2J78N3OUj+2kU5God/6k+4KC0UlUW8/s=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=GDuwFyPKS6O5/9LOKeA3jATojakwxR9zCq2rPlC9mZofpmrIdFtJtM0uond7dIMLm
         sqs2S2kfyW0pxIYkVHuOQ1iNbM4WGB+wZT4jkyHQZLJrtwr8ObL7/eXMq+D+5i3AJQ
         9VMNhXM/NHXtRq6DgB29WTjrcieeLDNxN0PoEYOwJsmXJ4hDzzGpDclpZ27foa39NR
         0BtK75eScBBpSNoXWFCKjy9dLzTUAE7JaV5YnUfHYQBo3AkqYZ0ZUuVSfDlIkJFyEJ
         j/rdKeg2C/zcvCJpF7AbO6e0ZtL3uYkGBila1qXCsFXNHoyH1y1gAc0CzOXR0fTjh5
         XqN6zZkTZGjWQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9RGeb1741602;
        Sat, 18 May 2019 02:27:16 -0700
Date:   Sat, 18 May 2019 02:27:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-tp96618ds42zic94nlh0msz3@git.kernel.org>
Cc:     jolsa@kernel.org, ak@linux.intel.com,
        alexey.budankov@linux.intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        hpa@zytor.com, namhyung@kernel.org
Reply-To: namhyung@kernel.org, acme@redhat.com, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, ak@linux.intel.com,
          alexey.budankov@linux.intel.com, jolsa@kernel.org,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test zstd: Fixup verbose mode output
Git-Commit-ID: d94cfbab6da92a3fc5fb69c8dae75c5720e6ed26
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

Commit-ID:  d94cfbab6da92a3fc5fb69c8dae75c5720e6ed26
Gitweb:     https://git.kernel.org/tip/d94cfbab6da92a3fc5fb69c8dae75c5720e6ed26
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 15 May 2019 15:58:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf test zstd: Fixup verbose mode output

The shell tests should not redirect useful output to /dev/null, as that
is done automatically by 'perf test' in non verbose mode, so remove that
from the zstd comp/decomp test, fixing up verbose mode.

Before:

  $ perf test zstd
  68: Zstd perf.data compression/decompression              : Ok
  $ perf test -v zstd
  68: Zstd perf.data compression/decompression              :
  --- start ---
  test child forked, pid 11956
      -z, --compression-level[=<n>]
  Collecting compressed record file:
  Checking compressed events stats:
  test child finished with 0
  ---- end ----
  Zstd perf.data compression/decompression: Ok
  $

Now:

  $ perf test zstd
  68: Zstd perf.data compression/decompression              : Ok
  $ perf test -v zstd
  68: Zstd perf.data compression/decompression              :
  --- start ---
  test child forked, pid 12695
  Collecting compressed record file:
  0+500 records in
  72+1 records out
  37361 bytes (37 kB, 36 KiB) copied, 9.83796 s, 3.8 kB/s
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB /tmp/perf.data.rzq, compressed (original 0.004 MB, ratio is 3.679) ]
  Checking compressed events stats:
  # compressed : Zstd, level = 1, ratio = 4
        COMPRESSED events:          3
  test child finished with 0
  ---- end ----
  Zstd perf.data compression/decompression: Ok
  $

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-tp96618ds42zic94nlh0msz3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+zstd_comp_decomp.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
index 93a26a87b1f2..5dcba800109f 100755
--- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
@@ -3,29 +3,28 @@
 
 trace_file=$(mktemp /tmp/perf.data.XXX)
 perf_tool=perf
-output=/dev/null
 
 skip_if_no_z_record() {
-	$perf_tool record -h 2>&1 | grep '\-z, \-\-compression\-level'
+	$perf_tool record -h 2>&1 | grep -q '\-z, \-\-compression\-level'
 }
 
 collect_z_record() {
 	echo "Collecting compressed record file:"
 	$perf_tool record -o $trace_file -g -z -F 5000 -- \
-		dd count=500 if=/dev/random of=/dev/null > $output 2>&1
+		dd count=500 if=/dev/random of=/dev/null
 }
 
 check_compressed_stats() {
 	echo "Checking compressed events stats:"
 	$perf_tool report -i $trace_file --header --stats | \
-		grep -E "(# compressed : Zstd,)|(COMPRESSED events:)" > $output 2>&1
+		grep -E "(# compressed : Zstd,)|(COMPRESSED events:)"
 }
 
 check_compressed_output() {
 	$perf_tool inject -i $trace_file -o $trace_file.decomp &&
 	$perf_tool report -i $trace_file --stdio | head -n -3 > $trace_file.comp.output &&
 	$perf_tool report -i $trace_file.decomp --stdio | head -n -3 > $trace_file.decomp.output &&
-	diff $trace_file.comp.output $trace_file.decomp.output > $output 2>&1
+	diff $trace_file.comp.output $trace_file.decomp.output
 }
 
 skip_if_no_z_record || exit 2
