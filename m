Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238062064A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfCRRqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:46:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:27340 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfCRRqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:46:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 10:46:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="153454112"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 18 Mar 2019 10:46:20 -0700
Received: from [10.251.91.19] (abudanko-mobl.ccr.corp.intel.com [10.251.91.19])
        by linux.intel.com (Postfix) with ESMTP id 553D2580238;
        Mon, 18 Mar 2019 10:46:18 -0700 (PDT)
Subject: [PATCH v10 12/12] perf tests: implement Zstd comp/decomp integration
 test
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <12cce142-6238-475b-b9aa-236531c12c2b@linux.intel.com>
Organization: Intel Corp.
Message-ID: <dc007ae4-104a-2b7c-316e-275929025f0d@linux.intel.com>
Date:   Mon, 18 Mar 2019 20:46:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <12cce142-6238-475b-b9aa-236531c12c2b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implemented basic integration test for Zstd based trace
compression/decompression in record and report modes.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 .../tests/shell/record+zstd_comp_decomp.sh    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp.sh

diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
new file mode 100755
index 000000000000..c0ff142bf66a
--- /dev/null
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+# record trace Zstd compression/decompression
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
+	echo "Collecting compressed record trace file:"
+	$perf_tool record -o $trace_file -g -z -F 25000 -- \
+		dd count=1000 if=/dev/random of=/dev/null > $output 2>&1
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

