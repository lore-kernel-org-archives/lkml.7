Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD4BC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605692173C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122044;
	bh=CeLPBb6WFBe5IYkf/ly1dCEdkGPJsyqItmCaKusFbis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tMk+qg9qxKWpDIKfImO5iY7r69Hp3OQZxQ5ExlupYgAsWnn31SdSkIpt+1br+LhpN
	 HfCYvuMEEwxTvfN0UkVPZRtGHYYx8w55jyIg05+IXbNSkYLxlYiI/eSsVvtQMBgu0t
	 0jm90rpZmKH2JrWUKC6mOozkDM/pU1jdA6tJMssg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfEQTkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbfEQTkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:40:39 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA71B2087B;
        Fri, 17 May 2019 19:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122038;
        bh=CeLPBb6WFBe5IYkf/ly1dCEdkGPJsyqItmCaKusFbis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyXyXszTV3tHM1ay0yYxBLpe0fyhYU5rxfm2G7gV2KA2/MkTPCEvrv3gibNa45xvC
         Tlgtp1wDWFWh8+ftc5Y6WV4nCb5sfhzCDampzNw+uKI5ao1MOV/6YIZ/gmFRwE/91X
         6RSU3r376cBFyv5MnR98DgLQmVkr3P7DmvudUYds=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 59/73] perf test zstd: Fixup verbose mode output
Date:   Fri, 17 May 2019 16:35:57 -0300
Message-Id: <20190517193611.4974-60-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

