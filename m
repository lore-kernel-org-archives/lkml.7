Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8162CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CE12075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfCKITJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:19:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:27649 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfCKITJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:19:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 01:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,467,1544515200"; 
   d="scan'208";a="140922179"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2019 01:19:08 -0700
Received: from [10.125.252.60] (abudanko-mobl.ccr.corp.intel.com [10.125.252.60])
        by linux.intel.com (Postfix) with ESMTP id C0F0558046F;
        Mon, 11 Mar 2019 01:19:05 -0700 (PDT)
Subject: Re: [PATCH v5 03/10] perf session: define bytes_transferred and
 bytes_compressed metrics
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
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
 <bcee0574-80cc-79df-b36d-e6495c786d9f@linux.intel.com>
Organization: Intel Corp.
Message-ID: <92831c18-865b-50bf-1f03-b38b63099703@linux.intel.com>
Date:   Mon, 11 Mar 2019 11:19:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <bcee0574-80cc-79df-b36d-e6495c786d9f@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.2019 11:29, Alexey Budankov wrote:
> 
> On 05.03.2019 15:26, Jiri Olsa wrote:
>> On Fri, Mar 01, 2019 at 06:43:28PM +0300, Alexey Budankov wrote:
>>>
>>> Define bytes_transferred and bytes_compressed metrics to calculate
>>> comp_ratio=transferred/compressed in the end of the data collection.
>>>
>>> bytes_transferred accumulates the amount of bytes that was extracted from
>>> the mmaped kernel buffers for compression. bytes_compressed accumulates
>>> the amount of bytes that was received after applying compression to
>>> move to a storage.
>>>
>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>> ---
>>>  tools/perf/builtin-record.c | 8 ++++++++
>>>  tools/perf/util/env.h       | 1 +
>>>  tools/perf/util/session.h   | 2 ++
>>>  3 files changed, 11 insertions(+)
>>>
>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>> index 9b02a68e8c23..ab121bc27c6d 100644
>>> --- a/tools/perf/builtin-record.c
>>> +++ b/tools/perf/builtin-record.c
>>> @@ -1449,6 +1449,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>>  	record__mmap_read_all(rec, true);
>>>  	record__aio_mmap_read_sync(rec);
>>>  
>>> +	if (!quiet && rec->session->bytes_transferred && rec->session->bytes_compressed) {
>>> +		float ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
>>> +
>>> +		session->header.env.comp_ratio = ratio + 0.5;
>>
>> what's the + 0.5 for?
> 
> Arithmetic rounding before type cast.
> 
>>
>>> +		fprintf(stderr,	"[ perf record: Compressed %.3f MB to %.3f MB, ratio is %.3f ]\n",
>>> +			rec->session->bytes_transferred / 1024.0 / 1024.0, rec->session->bytes_compressed / 1024.0 / 1024.0, ratio);
>>> +	}
>>> +
>>
>> could this be below together with the current:
>>
>> 	fprintf(stderr, "[ perf record: Captured and wrote %.3f MB %s%s%s ]\n",
> 
> Please provide an example of what you exactly mean.

It could look like this:

[ perf record: Woken up 101 times to write data ]
[ perf record: Captured and wrote 5.173 MB perf.data (714077 samples), compressed 27.241 MB to 5.160 MB, ratio is 5.279 ]

Any comments?

~Alexey

> 
> ~Alexey
> 
>>
>> thanks,
>> jirka
>>
>>>  	if (forks) {
>>>  		int exit_status;
>>>  
>>> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
>>> index d01b8355f4ca..fb39e9af128f 100644
>>> --- a/tools/perf/util/env.h
>>> +++ b/tools/perf/util/env.h
>>> @@ -64,6 +64,7 @@ struct perf_env {
>>>  	struct memory_node	*memory_nodes;
>>>  	unsigned long long	 memory_bsize;
>>>  	u64                     clockid_res_ns;
>>> +	u32                     comp_ratio;
>>>  };
>>>  
>>>  extern struct perf_env perf_env;
>>> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
>>> index d96eccd7d27f..0e14884f28b2 100644
>>> --- a/tools/perf/util/session.h
>>> +++ b/tools/perf/util/session.h
>>> @@ -35,6 +35,8 @@ struct perf_session {
>>>  	struct ordered_events	ordered_events;
>>>  	struct perf_data	*data;
>>>  	struct perf_tool	*tool;
>>> +	u64			bytes_transferred;
>>> +	u64			bytes_compressed;
>>>  };
>>>  
>>>  struct perf_tool;
>>> -- 
>>> 2.20.1
>>>
>>
> 
