Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9053C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A3820857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfCRMIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:08:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:15115 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfCRMIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:08:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 05:08:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="329619930"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2019 05:08:00 -0700
Received: from [10.125.252.163] (abudanko-mobl.ccr.corp.intel.com [10.125.252.163])
        by linux.intel.com (Postfix) with ESMTP id 34902580238;
        Mon, 18 Mar 2019 05:07:57 -0700 (PDT)
Subject: Re: [PATCH v9 12/12] perf tests: implement Zstd comp/decomp
 integration test
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <c1423198-e474-1739-e800-4615cce501ce@linux.intel.com>
 <6a1230b6-db9a-472d-cd69-15f1cad53080@linux.intel.com>
 <20190318114629.GC7900@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <a4525d8b-b2f8-35a8-9acb-5278fe83055a@linux.intel.com>
Date:   Mon, 18 Mar 2019 15:07:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318114629.GC7900@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.2019 14:46, Jiri Olsa wrote:
> On Sat, Mar 16, 2019 at 05:18:24PM +0300, Alexey Budankov wrote:
>>
>> Implemented basic integration test for Zstd based trace
>> compression/decompression in record and report modes.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  .../tests/shell/record+zstd_comp_decomp.sh    | 28 +++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp.sh
>>
>> diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
>> new file mode 100755
>> index 000000000000..bc195874fc27
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
>> @@ -0,0 +1,28 @@
>> +#!/bin/sh
>> +# record trace Zstd compression/decompression
>> +
>> +trace_file=$(mktemp /tmp/perf.data.XXX)
>> +perf_tool=perf
>> +output=/dev/null
>> +
>> +skip_if_no_z_record() {
>> +	$perf_tool record -h 2>&1 | grep '\-z, \-\-compression\-level'
>> +}
>> +
>> +collect_z_record() {
>> +	echo "Collecting compressed record trace file:"
>> +	$perf_tool record -o $trace_file -a -z -F 25000 -e cycles -- \
>> +		dd count=2000 if=/dev/random of=/dev/null > $output 2>&1
>> +}
>> +
>> +check_compressed_stats() {
>> +	echo "Checking compressed events stats:"
>> +	$perf_tool report -i $trace_file --header --stats | \
>> +		grep -E "(# compressed : Zstd,)|(COMPRESSED events:)" > $output 2>&1
>> +}
>> +
>> +skip_if_no_z_record || exit 2
>> +collect_z_record && check_compressed_stats
>> +err=$?
>> +rm -f $trace_file
>> +exit $err
>> -- 
>> 2.20.1
>>
> 
> could we also check the actualy decompression like below
> 
> plus let's disable -a so non root user can run it,
> and also it takes too long.. changing dd to count=1000
> and adding -g to record

in v10.

~Alexey

> 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> index bc195874fc27..c0ff142bf66a 100755
> --- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> +++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> @@ -11,8 +11,8 @@ skip_if_no_z_record() {
>  
>  collect_z_record() {
>  	echo "Collecting compressed record trace file:"
> -	$perf_tool record -o $trace_file -a -z -F 25000 -e cycles -- \
> -		dd count=2000 if=/dev/random of=/dev/null > $output 2>&1
> +	$perf_tool record -o $trace_file -g -z -F 25000 -- \
> +		dd count=1000 if=/dev/random of=/dev/null > $output 2>&1
>  }
>  
>  check_compressed_stats() {
> @@ -21,8 +21,15 @@ check_compressed_stats() {
>  		grep -E "(# compressed : Zstd,)|(COMPRESSED events:)" > $output 2>&1
>  }
>  
> +check_compressed_output() {
> +	$perf_tool inject -i $trace_file -o $trace_file.decomp &&
> +	$perf_tool report -i $trace_file --stdio | head -n -3 > $trace_file.comp.output &&
> +	$perf_tool report -i $trace_file.decomp --stdio | head -n -3 > $trace_file.decomp.output &&
> +	diff $trace_file.comp.output $trace_file.decomp.output > $output 2>&1
> +}
> +
>  skip_if_no_z_record || exit 2
> -collect_z_record && check_compressed_stats
> +collect_z_record && check_compressed_stats && check_compressed_output
>  err=$?
> -rm -f $trace_file
> +rm -f $trace_file*
>  exit $err
> 
