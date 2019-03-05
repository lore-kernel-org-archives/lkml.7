Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F6AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375B220684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfCEJbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:31:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:32110 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfCEJbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:31:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 01:31:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,443,1544515200"; 
   d="scan'208";a="279855853"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 05 Mar 2019 01:31:42 -0800
Received: from [10.125.252.140] (abudanko-mobl.ccr.corp.intel.com [10.125.252.140])
        by linux.intel.com (Postfix) with ESMTP id 45CCD5805FC;
        Tue,  5 Mar 2019 01:31:40 -0800 (PST)
Subject: [PATCH v6 10/10] perf tests: implement Zstd comp/decomp integration
 test
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <8b8a4f51-9606-1940-7cc9-40c2c67bfc92@linux.intel.com>
Organization: Intel Corp.
Message-ID: <53ae1b62-d959-64b1-97ce-2f4dc10a3ec8@linux.intel.com>
Date:   Tue, 5 Mar 2019 12:31:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <8b8a4f51-9606-1940-7cc9-40c2c67bfc92@linux.intel.com>
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
 .../tests/shell/record+zstd_comp_decomp.sh    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp.sh

diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
new file mode 100755
index 000000000000..5cb2ab8e2112
--- /dev/null
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+# record trace Zstd compression/decompression
+
+trace_file=$(mktemp /tmp/perf.data.XXX)
+perf_tool=perf
+output=/dev/null
+
+skip_if_no_z_record() {
+	$perf_tool record -h 2>&1 | grep '\-z, \-\-compression\-level <n>'
+}
+
+collect_z_record() {
+	echo "Collecting compressed record trace file:"
+	$perf_tool record -o $trace_file -a -z 1 -F 25000 -e cycles -- \
+		dd count=2000 if=/dev/random of=/dev/null > $output 2>&1
+}
+
+check_compressed_stats() {
+	echo "Checking compressed events stats:"
+	$perf_tool report -i $trace_file --header --stats | \
+		grep -E "(# compressed : Zstd,)|(COMPRESSED events:)" > $output 2>&1
+}
+
+skip_if_no_z_record || exit 2
+collect_z_record && check_compressed_stats
+err=$?
+rm -f $trace_file
+exit $err
-- 
2.20.1

