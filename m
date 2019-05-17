Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AED5C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B55221743
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122039;
	bh=yxg5adXGk4o6dU3rQUX8CrQw5eFAP1L9j7V+vKc+eDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZVYHFhuo8KxZCcYeuDb3FslN2/Y5ccSIEP9rbgkQ1dP/1fL/8KnxaxCFpXcPBLyVr
	 XGULYR9zWBmC3LGKXK0s90aNuPEy2TkrwW3+uyozwnCmoACvauhbwzigkNPIrioDsR
	 q1DqQE8XoYlxMAKG8hMekXS8PkTBlVtR5raXlHFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfEQTki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbfEQTkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:40:35 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB75A2166E;
        Fri, 17 May 2019 19:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122034;
        bh=yxg5adXGk4o6dU3rQUX8CrQw5eFAP1L9j7V+vKc+eDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rn/qu9rR5+IhGbMVI7a1CICqeZFLECTBV0YMfYm4WRVS8n2fiYJIV+HzLg2VearYM
         HV6QcvlvFNsv+eTNkSHJRVbXjgOxa1z8ofWu88P5bwSX6ypT3qnFNdtMfhdKIMV6i8
         g1hmBlPdD8PMUZMPROB7jSXnJWNoKlaIJZrgEGT0=
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
Subject: [PATCH 58/73] perf tests: Implement Zstd comp/decomp integration test
Date:   Fri, 17 May 2019 16:35:56 -0300
Message-Id: <20190517193611.4974-59-acme@kernel.org>
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
 .../tests/shell/record+zstd_comp_decomp.sh    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp.sh

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
-- 
2.20.1

