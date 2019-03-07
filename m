Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4632C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF2D2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfCGI3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:29:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:27930 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfCGI3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:29:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 00:29:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="121744178"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2019 00:29:22 -0800
Received: from [10.125.252.109] (abudanko-mobl.ccr.corp.intel.com [10.125.252.109])
        by linux.intel.com (Postfix) with ESMTP id BC8F75805B4;
        Thu,  7 Mar 2019 00:29:20 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v5 03/10] perf session: define bytes_transferred and
 bytes_compressed metrics
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <cc16317a-87f0-7abe-69a6-31394d32dda7@linux.intel.com>
 <20190305122604.GG16615@krava>
Organization: Intel Corp.
Message-ID: <bcee0574-80cc-79df-b36d-e6495c786d9f@linux.intel.com>
Date:   Thu, 7 Mar 2019 11:29:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305122604.GG16615@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.03.2019 15:26, Jiri Olsa wrote:
> On Fri, Mar 01, 2019 at 06:43:28PM +0300, Alexey Budankov wrote:
>>
>> Define bytes_transferred and bytes_compressed metrics to calculate
>> comp_ratio=transferred/compressed in the end of the data collection.
>>
>> bytes_transferred accumulates the amount of bytes that was extracted from
>> the mmaped kernel buffers for compression. bytes_compressed accumulates
>> the amount of bytes that was received after applying compression to
>> move to a storage.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-record.c | 8 ++++++++
>>  tools/perf/util/env.h       | 1 +
>>  tools/perf/util/session.h   | 2 ++
>>  3 files changed, 11 insertions(+)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 9b02a68e8c23..ab121bc27c6d 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -1449,6 +1449,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  	record__mmap_read_all(rec, true);
>>  	record__aio_mmap_read_sync(rec);
>>  
>> +	if (!quiet && rec->session->bytes_transferred && rec->session->bytes_compressed) {
>> +		float ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
>> +
>> +		session->header.env.comp_ratio = ratio + 0.5;
> 
> what's the + 0.5 for?

Arithmetic rounding before type cast.

> 
>> +		fprintf(stderr,	"[ perf record: Compressed %.3f MB to %.3f MB, ratio is %.3f ]\n",
>> +			rec->session->bytes_transferred / 1024.0 / 1024.0, rec->session->bytes_compressed / 1024.0 / 1024.0, ratio);
>> +	}
>> +
> 
> could this be below together with the current:
> 
> 	fprintf(stderr, "[ perf record: Captured and wrote %.3f MB %s%s%s ]\n",

Please provide an example of what you exactly mean.

~Alexey

> 
> thanks,
> jirka
> 
>>  	if (forks) {
>>  		int exit_status;
>>  
>> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
>> index d01b8355f4ca..fb39e9af128f 100644
>> --- a/tools/perf/util/env.h
>> +++ b/tools/perf/util/env.h
>> @@ -64,6 +64,7 @@ struct perf_env {
>>  	struct memory_node	*memory_nodes;
>>  	unsigned long long	 memory_bsize;
>>  	u64                     clockid_res_ns;
>> +	u32                     comp_ratio;
>>  };
>>  
>>  extern struct perf_env perf_env;
>> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
>> index d96eccd7d27f..0e14884f28b2 100644
>> --- a/tools/perf/util/session.h
>> +++ b/tools/perf/util/session.h
>> @@ -35,6 +35,8 @@ struct perf_session {
>>  	struct ordered_events	ordered_events;
>>  	struct perf_data	*data;
>>  	struct perf_tool	*tool;
>> +	u64			bytes_transferred;
>> +	u64			bytes_compressed;
>>  };
>>  
>>  struct perf_tool;
>> -- 
>> 2.20.1
>>
> 
