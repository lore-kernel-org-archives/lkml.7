Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43F2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AAE20652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfCGIjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:39:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:15923 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfCGIjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:39:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 00:39:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="132291683"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 07 Mar 2019 00:39:50 -0800
Received: from [10.125.252.109] (abudanko-mobl.ccr.corp.intel.com [10.125.252.109])
        by linux.intel.com (Postfix) with ESMTP id 2A31C5805B4;
        Thu,  7 Mar 2019 00:39:47 -0800 (PST)
Subject: Re: [PATCH v5 07/10] perf record: implement -z,--compression_level=n
 option and compression
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <87fa1906-2d6a-a00a-7ba5-b570d0cbf9cc@linux.intel.com>
 <20190305122534.GB16615@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <ee765c0e-6e5c-e879-aaa6-40f314f85a5e@linux.intel.com>
Date:   Thu, 7 Mar 2019 11:39:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305122534.GB16615@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.03.2019 15:25, Jiri Olsa wrote:
> On Fri, Mar 01, 2019 at 06:58:32PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  
>>  	/*
>>  	 * Increment md->refcount to guard md->data[idx] buffer
>> @@ -350,7 +357,7 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
>>  	md->prev = head;
>>  	perf_mmap__consume(md);
>>  
>> -	rc = push(to, &md->aio.cblocks[idx], md->aio.data[idx], size0 + size, *off);
>> +	rc = push(to, md->aio.data[idx], size0 + size, *off, &md->aio.cblocks[idx]);
>>  	if (!rc) {
>>  		*off += size0 + size;
>>  	} else {
>> @@ -556,13 +563,15 @@ int perf_mmap__read_init(struct perf_mmap *map)
>>  }
>>  
>>  int perf_mmap__push(struct perf_mmap *md, void *to,
>> -		    int push(struct perf_mmap *map, void *to, void *buf, size_t size))
>> +		    int push(struct perf_mmap *map, void *to, void *buf, size_t size),
>> +		    perf_mmap__compress_fn_t compress, void *comp_data)
>>  {
>>  	u64 head = perf_mmap__read_head(md);
>>  	unsigned char *data = md->base + page_size;
>>  	unsigned long size;
>>  	void *buf;
>>  	int rc = 0;
>> +	size_t mmap_len = perf_mmap__mmap_len(md);
>>  
>>  	rc = perf_mmap__read_init(md);
>>  	if (rc < 0)
>> @@ -574,7 +583,10 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
>>  		buf = &data[md->start & md->mask];
>>  		size = md->mask + 1 - (md->start & md->mask);
>>  		md->start += size;
>> -
>> +		if (compress) {
>> +			size = compress(comp_data, md->data, mmap_len, buf, size);
>> +			buf = md->data;
>> +		}
>>  		if (push(md, to, buf, size) < 0) {
>>  			rc = -1;
>>  			goto out;
> 
> when we discussed the compress callback should be another layer
> in perf_mmap__push I was thinking more of the layered/fifo design,
> like:
> 
> normaly we call:
> 
> 	perf_mmap__push(... push = record__pushfn ...)
> 		-> reads mmap data and calls push(data), which translates as:
> 
> 		record__pushfn(data);
> 			- which stores the data
> 
> 
> for compressed it'd be:
> 
> 	perf_mmap__push(... push = compressed_push ...)
> 
> 		-> reads mmap data and calls push(data), which translates as:
> 
> 		compressed_push(data)
> 			-> reads data, compresses them and calls, next push callback in line:
> 
> 			record__pushfn(data)
> 				- which stores the data
> 
> 
> there'd need to be the logic for compressed_push to
> remember the 'next push' function

That is suboptimal for AIO. Also compression is an independent operation that 
could be applied on any of push stages you mean.

> 
> but I think this was the original idea behind the
> perf_mmap__push -> it gets the data and pushes them for
> the next processing.. it should stay as simple as that

Agree on keeping simplicity and, at the moment, there is no any push to the next 
processing in the code so provided implementation fits as for serial as for AIO
at the same time sticking to simplicity as much as possibly. If you see something 
that would fit better please speak up and share.

~Alexey

> 
> jirka
> 
