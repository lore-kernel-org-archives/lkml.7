Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B2A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCRLqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:46:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfCRLqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:46:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C725C308FF1F;
        Mon, 18 Mar 2019 11:46:31 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2DBF05C207;
        Mon, 18 Mar 2019 11:46:30 +0000 (UTC)
Date:   Mon, 18 Mar 2019 12:46:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/12] perf tests: implement Zstd comp/decomp
 integration test
Message-ID: <20190318114629.GC7900@krava>
References: <c1423198-e474-1739-e800-4615cce501ce@linux.intel.com>
 <6a1230b6-db9a-472d-cd69-15f1cad53080@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a1230b6-db9a-472d-cd69-15f1cad53080@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 18 Mar 2019 11:46:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 05:18:24PM +0300, Alexey Budankov wrote:
> 
> Implemented basic integration test for Zstd based trace
> compression/decompression in record and report modes.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  .../tests/shell/record+zstd_comp_decomp.sh    | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp.sh
> 
> diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> new file mode 100755
> index 000000000000..bc195874fc27
> --- /dev/null
> +++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> @@ -0,0 +1,28 @@
> +#!/bin/sh
> +# record trace Zstd compression/decompression
> +
> +trace_file=$(mktemp /tmp/perf.data.XXX)
> +perf_tool=perf
> +output=/dev/null
> +
> +skip_if_no_z_record() {
> +	$perf_tool record -h 2>&1 | grep '\-z, \-\-compression\-level'
> +}
> +
> +collect_z_record() {
> +	echo "Collecting compressed record trace file:"
> +	$perf_tool record -o $trace_file -a -z -F 25000 -e cycles -- \
> +		dd count=2000 if=/dev/random of=/dev/null > $output 2>&1
> +}
> +
> +check_compressed_stats() {
> +	echo "Checking compressed events stats:"
> +	$perf_tool report -i $trace_file --header --stats | \
> +		grep -E "(# compressed : Zstd,)|(COMPRESSED events:)" > $output 2>&1
> +}
> +
> +skip_if_no_z_record || exit 2
> +collect_z_record && check_compressed_stats
> +err=$?
> +rm -f $trace_file
> +exit $err
> -- 
> 2.20.1
> 

could we also check the actualy decompression like below

plus let's disable -a so non root user can run it,
and also it takes too long.. changing dd to count=1000
and adding -g to record

jirka


---
diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
index bc195874fc27..c0ff142bf66a 100755
--- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
@@ -11,8 +11,8 @@ skip_if_no_z_record() {
 
 collect_z_record() {
 	echo "Collecting compressed record trace file:"
-	$perf_tool record -o $trace_file -a -z -F 25000 -e cycles -- \
-		dd count=2000 if=/dev/random of=/dev/null > $output 2>&1
+	$perf_tool record -o $trace_file -g -z -F 25000 -- \
+		dd count=1000 if=/dev/random of=/dev/null > $output 2>&1
 }
 
 check_compressed_stats() {
@@ -21,8 +21,15 @@ check_compressed_stats() {
 		grep -E "(# compressed : Zstd,)|(COMPRESSED events:)" > $output 2>&1
 }
 
+check_compressed_output() {
+	$perf_tool inject -i $trace_file -o $trace_file.decomp &&
+	$perf_tool report -i $trace_file --stdio | head -n -3 > $trace_file.comp.output &&
+	$perf_tool report -i $trace_file.decomp --stdio | head -n -3 > $trace_file.decomp.output &&
+	diff $trace_file.comp.output $trace_file.decomp.output > $output 2>&1
+}
+
 skip_if_no_z_record || exit 2
-collect_z_record && check_compressed_stats
+collect_z_record && check_compressed_stats && check_compressed_output
 err=$?
-rm -f $trace_file
+rm -f $trace_file*
 exit $err
