Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C6DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE882064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCGI2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:28:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:10537 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCGI2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:28:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 00:28:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="121743832"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2019 00:28:00 -0800
Received: from [10.125.252.109] (abudanko-mobl.ccr.corp.intel.com [10.125.252.109])
        by linux.intel.com (Postfix) with ESMTP id 29F54580489;
        Thu,  7 Mar 2019 00:27:57 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v5 08/10] perf report: implement record trace
 decompression
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <16550dfe-d4bf-2445-08df-faf0af0ab1e1@linux.intel.com>
 <20190305122529.GA16615@krava>
Organization: Intel Corp.
Message-ID: <1a752efa-d7aa-cfc3-f0fe-9230f8926fa5@linux.intel.com>
Date:   Thu, 7 Mar 2019 11:27:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305122529.GA16615@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.03.2019 15:25, Jiri Olsa wrote:
> On Fri, Mar 01, 2019 at 07:06:23PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> +static int __perf_session__process_decomp_events(struct perf_session *session)
>> +{
>> +	s64 skip;
>> +	u64 size, file_pos = 0;
>> +	union perf_event *event;
>> +	struct decomp *decomp = session->decomp_last;
>> +
>> +	if (!decomp)
>> +		return 0;
>> +
>> +	while (decomp->head < decomp->size && !session_done()) {
>> +		event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
>> +		if (!event)
>> +			break;
>> +
>> +		size = event->header.size;
>> +		if (size < sizeof(struct perf_event_header) ||
>> +		    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
>> +			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
>> +				decomp->file_pos + decomp->head, event->header.size, event->header.type);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (skip)
>> +			size += skip;
>> +
>> +		decomp->head += size;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * On 64bit we can mmap the data file in one go. No need for tiny mmap
>>   * slices. On 32bit we use 32MB.
>> @@ -1933,6 +2051,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>>  	head += size;
>>  	file_pos += size;
>>  
>> +	err = __perf_session__process_decomp_events(session);
>> +	if (err)
>> +		goto out;
> 
> why don't we process decompressed events directly from the 
> perf_session__process_compressed_event callback?
> 
> there would be no need for 'struct decomp' list logic

It would, because events need to stay in memory after decompression.
It looks reasonable to keep new processing code at the same place 
where the processing is implemented currently.

~Alexey

> 
> jirka
> 
