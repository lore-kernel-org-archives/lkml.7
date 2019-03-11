Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB81C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DC4206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfCKNlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:41:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:40412 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfCKNlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:41:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 06:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,467,1544515200"; 
   d="scan'208";a="150601388"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2019 06:41:27 -0700
Received: from [10.251.89.100] (abudanko-mobl.ccr.corp.intel.com [10.251.89.100])
        by linux.intel.com (Postfix) with ESMTP id 27ECF58046F;
        Mon, 11 Mar 2019 06:41:24 -0700 (PDT)
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
 <bcee0574-80cc-79df-b36d-e6495c786d9f@linux.intel.com>
 <92831c18-865b-50bf-1f03-b38b63099703@linux.intel.com>
 <20190311123345.GD26829@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <a1064e73-c20a-5b21-9d15-77622fccb2cb@linux.intel.com>
Date:   Mon, 11 Mar 2019 16:41:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311123345.GD26829@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.2019 15:33, Jiri Olsa wrote:
> On Mon, Mar 11, 2019 at 11:19:03AM +0300, Alexey Budankov wrote:
>> On 07.03.2019 11:29, Alexey Budankov wrote:
>>>
>>> On 05.03.2019 15:26, Jiri Olsa wrote:
>>>> On Fri, Mar 01, 2019 at 06:43:28PM +0300, Alexey Budankov wrote:
>>>>>
>>>>> Define bytes_transferred and bytes_compressed metrics to calculate
>>>>> comp_ratio=transferred/compressed in the end of the data collection.
>>>>>
>>>>> bytes_transferred accumulates the amount of bytes that was extracted from
>>>>> the mmaped kernel buffers for compression. bytes_compressed accumulates
>>>>> the amount of bytes that was received after applying compression to
>>>>> move to a storage.
>>>>>
>>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>>> ---
>>>>>  tools/perf/builtin-record.c | 8 ++++++++
>>>>>  tools/perf/util/env.h       | 1 +
>>>>>  tools/perf/util/session.h   | 2 ++
>>>>>  3 files changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>>>> index 9b02a68e8c23..ab121bc27c6d 100644
>>>>> --- a/tools/perf/builtin-record.c
>>>>> +++ b/tools/perf/builtin-record.c
>>>>> @@ -1449,6 +1449,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>>>>  	record__mmap_read_all(rec, true);
>>>>>  	record__aio_mmap_read_sync(rec);
>>>>>  
>>>>> +	if (!quiet && rec->session->bytes_transferred && rec->session->bytes_compressed) {
>>>>> +		float ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
>>>>> +
>>>>> +		session->header.env.comp_ratio = ratio + 0.5;
>>>>
>>>> what's the + 0.5 for?
>>>
>>> Arithmetic rounding before type cast.
>>>
>>>>
>>>>> +		fprintf(stderr,	"[ perf record: Compressed %.3f MB to %.3f MB, ratio is %.3f ]\n",
>>>>> +			rec->session->bytes_transferred / 1024.0 / 1024.0, rec->session->bytes_compressed / 1024.0 / 1024.0, ratio);
>>>>> +	}
>>>>> +
>>>>
>>>> could this be below together with the current:
>>>>
>>>> 	fprintf(stderr, "[ perf record: Captured and wrote %.3f MB %s%s%s ]\n",
>>>
>>> Please provide an example of what you exactly mean.
>>
>> It could look like this:
>>
>> [ perf record: Woken up 101 times to write data ]
>> [ perf record: Captured and wrote 5.173 MB perf.data (714077 samples), compressed 27.241 MB to 5.160 MB, ratio is 5.279 ]
> 
> yes, maybe we don't need to repeat the original size twice:
> 
> [ perf record: Captured and wrote 5.173 MB perf.data (714077 samples), compressed (original 27.241 MB, ratio 5.279) ]

Ok, lets have it like this.

~Alexey

> 
> jirka
> 
