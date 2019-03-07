Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B60DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4143920840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfCGI3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:29:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:34762 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfCGI3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:29:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 00:29:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="152828213"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2019 00:29:41 -0800
Received: from [10.125.252.109] (abudanko-mobl.ccr.corp.intel.com [10.125.252.109])
        by linux.intel.com (Postfix) with ESMTP id 568C0580489;
        Thu,  7 Mar 2019 00:29:39 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v5 10/10] perf tests: implement Zstd comp/decomp
 integration test
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <6f882af2-686b-7e94-cfb2-60f50e8d0136@linux.intel.com>
 <20190305122546.GD16615@krava>
Organization: Intel Corp.
Message-ID: <6ea5cf06-ca9f-dee7-2d4d-3b83b6ca88d4@linux.intel.com>
Date:   Thu, 7 Mar 2019 11:29:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305122546.GD16615@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.03.2019 15:25, Jiri Olsa wrote:
> On Fri, Mar 01, 2019 at 07:09:26PM +0300, Alexey Budankov wrote:
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
>> index 000000000000..5cb2ab8e2112
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
>> +	$perf_tool record -h 2>&1 | grep '\-z, \-\-compression\-level <n>'
>> +}
>> +
>> +collect_z_record() {
>> +	echo "Collecting compressed record trace file:"
>> +	$perf_tool record -o $trace_file -a -z 1 -F 25000 -e cycles -- \
>> +		dd count=2000 if=/dev/random of=/dev/null > $output 2>&1
>> +}
>> +
>> +check_compressed_stats() {
>> +	echo "Checking compressed events stats:"
>> +	$perf_tool report -i $trace_file --header --stats | \
>> +		grep -E "(# compressed : Zstd,)|(COMPRESSED events:)" > $output 2>&1
>> +}
> 
> so perf inject can decompress the perf.data and store
> uncompressed one, right? would be great to 'uncompress'

Right.

> the perf data and compare 'perf report --stdio > out.X'
> outputs
> 
> thanks a lot for adding tests!

You are welcome.
Implemented test performs some level of sanity testing for the feature 
and it is all that I can provide in this patch set.

~Alexey

> 
> jirka
> 
