Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36837C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2DB20872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mhBO7Ovi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfERJ0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:26:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37605 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:26:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9QbU61741326
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:26:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9QbU61741326
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171598;
        bh=/OB55E/goRKEh9q0ojzDFZWvrrdbXX8e/sHWfWqykTI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=mhBO7OviMJdIu9jiVsxgeA7dIfG4dfoi6xWnatSb5Gvj2CAhN7mCePWRkw0yc1XPv
         HCYSTtVhZgZ3RQ3opjhvFvXOAHaTxS2noaJLmdqHUZ1TUXuVjJ7F6wKVoVULtGmfDv
         D1iJRJGIzyC23uBVOzp5GRODM1s7iQ7NnoSke7aIr63em1TYBg7NilyGsndXGODYC0
         RpYBpMR9IyUyuuRQpDx/opO2JILEyn+Zc8PI7tUpx1Qjag0Xn4xuSR49dHtaf85DBq
         7knceuJhADSg6Y+4QW2snB54i4qVzy+Zc9OgCjFJe3OPs8XaAQqTbGe2aTvOHKst4Q
         Z4OHl1aXWYcgQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9QbOV1741323;
        Sat, 18 May 2019 02:26:37 -0700
Date:   Sat, 18 May 2019 02:26:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-bdc35cbc35c0b33428922503c7c85259510911a6@git.kernel.org>
Cc:     ak@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        acme@redhat.com
Reply-To: mingo@kernel.org, acme@redhat.com,
          alexey.budankov@linux.intel.com,
          alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, ak@linux.intel.com, peterz@infradead.org
In-Reply-To: <dc007ae4-104a-2b7c-316e-275929025f0d@linux.intel.com>
References: <dc007ae4-104a-2b7c-316e-275929025f0d@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Implement Zstd comp/decomp integration
 test
Git-Commit-ID: bdc35cbc35c0b33428922503c7c85259510911a6
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

Commit-ID:  bdc35cbc35c0b33428922503c7c85259510911a6
Gitweb:     https://git.kernel.org/tip/bdc35cbc35c0b33428922503c7c85259510911a6
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Mon, 18 Mar 2019 20:46:17 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf tests: Implement Zstd comp/decomp integration test

Introduce a basic integration test for Zstd based record
compression/decompression using 'perf record' and 'perf report'.

Committer notes:

Reduce a bit the freq (from 25 kHz to 5 kHz) and the number of /dev/null
records read (from 1000 to 500), reducing the time it takes to something
more in line with the time existing 'perf test' entries take to run.

With that in place:

  $ time perf test zstd
  68: Zstd perf.data compression/decompression              : Ok

  real	0m10.376s
  user	0m0.105s
  sys	0m0.440s
  $ grep "model name" /proc/cpuinfo  | head -1
  model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
  $

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/dc007ae4-104a-2b7c-316e-275929025f0d@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+zstd_comp_decomp.sh | 35 +++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
new file mode 100755
index 000000000000..93a26a87b1f2
--- /dev/null
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+# Zstd perf.data compression/decompression
+
+trace_file=$(mktemp /tmp/perf.data.XXX)
+perf_tool=perf
+output=/dev/null
+
+skip_if_no_z_record() {
+	$perf_tool record -h 2>&1 | grep '\-z, \-\-compression\-level'
+}
+
+collect_z_record() {
+	echo "Collecting compressed record file:"
+	$perf_tool record -o $trace_file -g -z -F 5000 -- \
+		dd count=500 if=/dev/random of=/dev/null > $output 2>&1
+}
+
+check_compressed_stats() {
+	echo "Checking compressed events stats:"
+	$perf_tool report -i $trace_file --header --stats | \
+		grep -E "(# compressed : Zstd,)|(COMPRESSED events:)" > $output 2>&1
+}
+
+check_compressed_output() {
+	$perf_tool inject -i $trace_file -o $trace_file.decomp &&
+	$perf_tool report -i $trace_file --stdio | head -n -3 > $trace_file.comp.output &&
+	$perf_tool report -i $trace_file.decomp --stdio | head -n -3 > $trace_file.decomp.output &&
+	diff $trace_file.comp.output $trace_file.decomp.output > $output 2>&1
+}
+
+skip_if_no_z_record || exit 2
+collect_z_record && check_compressed_stats && check_compressed_output
+err=$?
+rm -f $trace_file*
+exit $err
