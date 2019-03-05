Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD862082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfCEMZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:25:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfCEMZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:25:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDFEB309264C;
        Tue,  5 Mar 2019 12:25:48 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2A93F611A1;
        Tue,  5 Mar 2019 12:25:47 +0000 (UTC)
Date:   Tue, 5 Mar 2019 13:25:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 10/10] perf tests: implement Zstd comp/decomp
 integration test
Message-ID: <20190305122546.GD16615@krava>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <6f882af2-686b-7e94-cfb2-60f50e8d0136@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f882af2-686b-7e94-cfb2-60f50e8d0136@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 05 Mar 2019 12:25:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 07:09:26PM +0300, Alexey Budankov wrote:
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
> index 000000000000..5cb2ab8e2112
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
> +	$perf_tool record -h 2>&1 | grep '\-z, \-\-compression\-level <n>'
> +}
> +
> +collect_z_record() {
> +	echo "Collecting compressed record trace file:"
> +	$perf_tool record -o $trace_file -a -z 1 -F 25000 -e cycles -- \
> +		dd count=2000 if=/dev/random of=/dev/null > $output 2>&1
> +}
> +
> +check_compressed_stats() {
> +	echo "Checking compressed events stats:"
> +	$perf_tool report -i $trace_file --header --stats | \
> +		grep -E "(# compressed : Zstd,)|(COMPRESSED events:)" > $output 2>&1
> +}

so perf inject can decompress the perf.data and store
uncompressed one, right? would be great to 'uncompress'
the perf data and compare 'perf report --stdio > out.X'
outputs

thanks a lot for adding tests!

jirka
