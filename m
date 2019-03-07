Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B233920840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfCGIy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:54:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:60226 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfCGIyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:54:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 00:54:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="139888538"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 07 Mar 2019 00:54:54 -0800
Received: from [10.125.252.109] (abudanko-mobl.ccr.corp.intel.com [10.125.252.109])
        by linux.intel.com (Postfix) with ESMTP id CCD4A5805B4;
        Thu,  7 Mar 2019 00:54:52 -0800 (PST)
Subject: Re: [PATCH v5 02/10] perf record: implement
 -f,--mmap-flush=<threshold> option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <3600e56e-0431-080e-9df8-e376cdea1aad@linux.intel.com>
 <20190305122609.GH16615@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <50578e9f-5e3f-64de-fa68-5e2ec25be594@linux.intel.com>
Date:   Thu, 7 Mar 2019 11:54:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305122609.GH16615@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.03.2019 15:26, Jiri Olsa wrote:
> On Fri, Mar 01, 2019 at 06:41:44PM +0300, Alexey Budankov wrote:
>>
>> Implemented -f,--mmap-flush option that specifies minimal size of data
>> chunk that is extracted from mmaped kernel buffer to store into a trace.
>>
>>   $ tools/perf/perf record -f 1024 -e cycles -- matrix.gcc
>>   $ tools/perf/perf record --aio -f 1024 -e cycles -- matrix.gcc
>>
>> Option can serve two purposes the first one is to increase the compression
>> ratio of a trace data and the second one is to avoid live-lock-like self 
>> monitoring in system wide (-a) profiling mode.
>>
>> The default option value is 1 byte what means that every time trace
>> writing thread finds some new data in the mmaped buffer the data is
>> extracted, possibly compressed and written to a trace. Larger data chunks
>> are compressed more effectively in comparison to smaller chunks so
>> extraction of larger chunks from the kernel buffer is preferable from
>> perspective of trace size reduction. So the implemented option allows 
>> specifying minimal data chunk size that is more than 1 byte to influence 
>> data compression ratio. Also at some cases executing more write syscalls 
>> with smaller data size can take longer than executing less write syscalls 
>> with bigger data size due to syscall overhead so extracting bigger data 
>> chunks specified by the option value could additionally decrease runtime 
>> overhead.
>>
>> Profiling in system wide mode with compression (-a -z) can additionally 
>> induce data into the kernel buffers along with the data from monitored 
>> processes. If performance data rate and volume from the monitored processes 
>> is high then trace streaming and compression activity in the tool is also 
>> high and it can lead to subtle live-lock effect of endless activity when 
>> compression of single new byte from some of mmaped kernel buffer leads to 
>> eneration of the next single byte at some mmaped buffer so perf tool trace 
>> writing thread never stops on polling event file descriptors.
>>
>> Implemented sync param is the mean to force data move independently from
>> the threshold value. Despite the provided flush value from the command
>> line, the tool needs capability to drain memory buffers, at least in the
>> end of the collection.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/Documentation/perf-record.txt | 13 ++++++
>>  tools/perf/builtin-record.c              | 53 +++++++++++++++++++++---
>>  tools/perf/perf.h                        |  1 +
>>  tools/perf/util/evlist.c                 |  6 +--
>>  tools/perf/util/evlist.h                 |  3 +-
>>  tools/perf/util/mmap.c                   |  4 +-
>>  tools/perf/util/mmap.h                   |  3 +-
>>  7 files changed, 71 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index 8f0c2be34848..9fa33ce9bc00 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -459,6 +459,19 @@ Set affinity mask of trace reading thread according to the policy defined by 'mo
>>    node - thread affinity mask is set to NUMA node cpu mask of the processed mmap buffer
>>    cpu  - thread affinity mask is set to cpu of the processed mmap buffer
>>  
>> +-f::
>> +--mmap-flush=n::
>> +Specify minimal number of bytes that is extracted from mmap data pages and stored
>> +into a trace. Maximal allowed value is a quarter of the size of mmaped data pages.
>> +The default option value is 1 what means that every time trace writing thread finds
>> +some new data in the mmaped buffer the data is extracted, possibly compressed (-z)
>> +and written to a trace. Larger data chunks are compressed more effectively in
>> +comparison to smaller chunks so extraction of larger chunks from the mmap data pages
>> +is preferable from perspective of trace size reduction. Also at some cases
>> +executing less trace write syscalls with bigger data size can take shorter than
>> +executing more trace write syscalls with smaller data size thus lowering runtime
>> +profiling overhead.
> 
> I was wondering if that's the same we would achieve with ring buffer
> watermak config on kernel side.. but I guess it does not hurt to
> have something on user side.. I'm just not sure it makes sense to have
> a config option for that
> 
> I'd understand if we configure some sane value when compression is
> enabled.. if it makes sense to have this option, I'd allow it only
> when compression is enabled

This threshold already exists in the code with default value of 1 byte. New option 
provides configuration capability for the threshold keeping default the same.

The option is the mean to get around the live lock issue in the tool in case of 
intensive system wide profiling and the issue is not specific to the compression.

The option gives benefit jointly with compression. The bigger chink is compressed 
the higher compression ratio it has, limit exists, of course.

~Alexey

> 
> jirka
> 
