Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D87C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A754F20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfCJQRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:17:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:49085 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfCJQRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:17:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2019 09:17:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,464,1544515200"; 
   d="scan'208";a="193580974"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 10 Mar 2019 09:17:12 -0700
Received: from [10.251.89.100] (abudanko-mobl.ccr.corp.intel.com [10.251.89.100])
        by linux.intel.com (Postfix) with ESMTP id B691D58048A;
        Sun, 10 Mar 2019 09:17:09 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
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
 <ee765c0e-6e5c-e879-aaa6-40f314f85a5e@linux.intel.com>
 <20190307121429.GB29474@krava>
 <002e7e10-b0ef-df2a-261c-88fd9c00364d@linux.intel.com>
 <20190308104657.GA21500@krava>
Organization: Intel Corp.
Message-ID: <8a44eb08-9ad2-4e8e-26f4-9e35496cc50e@linux.intel.com>
Date:   Sun, 10 Mar 2019 19:17:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308104657.GA21500@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.2019 13:46, Jiri Olsa wrote:
> On Thu, Mar 07, 2019 at 06:26:47PM +0300, Alexey Budankov wrote:
>>
>> On 07.03.2019 15:14, Jiri Olsa wrote:
>>> On Thu, Mar 07, 2019 at 11:39:46AM +0300, Alexey Budankov wrote:
>>>>
>>>> On 05.03.2019 15:25, Jiri Olsa wrote:
>>>>> On Fri, Mar 01, 2019 at 06:58:32PM +0300, Alexey Budankov wrote:
>>>>>
>>>>> SNIP
>>>>>
>>>>>>  
>>>>>>  	/*
>>>>>>  	 * Increment md->refcount to guard md->data[idx] buffer
>>>>>> @@ -350,7 +357,7 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
>>>>>>  	md->prev = head;
>>>>>>  	perf_mmap__consume(md);
>>>>>>  
>>>>>> -	rc = push(to, &md->aio.cblocks[idx], md->aio.data[idx], size0 + size, *off);
>>>>>> +	rc = push(to, md->aio.data[idx], size0 + size, *off, &md->aio.cblocks[idx]);
>>>>>>  	if (!rc) {
>>>>>>  		*off += size0 + size;
>>>>>>  	} else {
>>>>>> @@ -556,13 +563,15 @@ int perf_mmap__read_init(struct perf_mmap *map)
>>>>>>  }
>>>>>>  
>>>>>>  int perf_mmap__push(struct perf_mmap *md, void *to,
>>>>>> -		    int push(struct perf_mmap *map, void *to, void *buf, size_t size))
>>>>>> +		    int push(struct perf_mmap *map, void *to, void *buf, size_t size),
>>>>>> +		    perf_mmap__compress_fn_t compress, void *comp_data)
>>>>>>  {
>>>>>>  	u64 head = perf_mmap__read_head(md);
>>>>>>  	unsigned char *data = md->base + page_size;
>>>>>>  	unsigned long size;
>>>>>>  	void *buf;
>>>>>>  	int rc = 0;
>>>>>> +	size_t mmap_len = perf_mmap__mmap_len(md);
>>>>>>  
>>>>>>  	rc = perf_mmap__read_init(md);
>>>>>>  	if (rc < 0)
>>>>>> @@ -574,7 +583,10 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
>>>>>>  		buf = &data[md->start & md->mask];
>>>>>>  		size = md->mask + 1 - (md->start & md->mask);
>>>>>>  		md->start += size;
>>>>>> -
>>>>>> +		if (compress) {
>>>>>> +			size = compress(comp_data, md->data, mmap_len, buf, size);
>>>>>> +			buf = md->data;
>>>>>> +		}
>>>>>>  		if (push(md, to, buf, size) < 0) {
>>>>>>  			rc = -1;
>>>>>>  			goto out;
>>>>>
>>>>> when we discussed the compress callback should be another layer
>>>>> in perf_mmap__push I was thinking more of the layered/fifo design,
>>>>> like:
>>>>>
>>>>> normaly we call:
>>>>>
>>>>> 	perf_mmap__push(... push = record__pushfn ...)
>>>>> 		-> reads mmap data and calls push(data), which translates as:
>>>>>
>>>>> 		record__pushfn(data);
>>>>> 			- which stores the data
>>>>>
>>>>>
>>>>> for compressed it'd be:
>>>>>
>>>>> 	perf_mmap__push(... push = compressed_push ...)
>>>>>
>>>>> 		-> reads mmap data and calls push(data), which translates as:
>>>>>
>>>>> 		compressed_push(data)
>>>>> 			-> reads data, compresses them and calls, next push callback in line:
>>>>>
>>>>> 			record__pushfn(data)
>>>>> 				- which stores the data
>>>>>
>>>>>
>>>>> there'd need to be the logic for compressed_push to
>>>>> remember the 'next push' function
>>>>
>>>> That is suboptimal for AIO. Also compression is an independent operation that 
>>>> could be applied on any of push stages you mean.
>>>
>>> not sure what you mean by suboptimal, but I think
>>> that it can still happen in subsequent push callback
>>>
>>>>
>>>>>
>>>>> but I think this was the original idea behind the
>>>>> perf_mmap__push -> it gets the data and pushes them for
>>>>> the next processing.. it should stay as simple as that
>>>>
>>>> Agree on keeping simplicity and, at the moment, there is no any push to the next 
>>>> processing in the code so provided implementation fits as for serial as for AIO
>>>> at the same time sticking to simplicity as much as possibly. If you see something 
>>>> that would fit better please speak up and share.
>>>
>>> I have to insist that perf_mmap__push stays untouched
>>> and we do other processing in the push callbacks
>>
>> What is about perf_mmap__aio_push()?
>>
>> Without compression it does 
>> 	memcpy(), memcpy(), aio_push()
>>
>> With compression its does
>> 	memcpy_with_compression(), memcpy_with_compression(), aio_push()
> 
> so to be on the same page.. normal processing without compression is:
> 
>   perf_mmap__push does:
> 	push(mmap buf)
> 	  record__pushfn
> 	    record__write
> 	      write(buf)
> 
>   perf_mmap__aio_push does:
> 	memcpy(aio buf, mmap buf)
> 	  push(aio buf)
> 	    record__aio_pushfn
> 	      record__aio_write
> 	        aio_write(aio buf)
> 
> 
> and for compression it would be:
> 
>   perf_mmap__push does:
> 	push(mmap buf)
> 	  compress_push
> 	    memcpy(compress buffer, mmapbuf)  EXTRA copy
> 	      record__pushfn
> 	        record__write
> 		  write(buf)
> 
>   perf_mmap__aio_push does:
> 	memcpy(aio buf, mmap buf)
> 	  memcpy(compress buffer, mmapbuf)    EXTRA copy
> 	    push(aio buf)
> 	      record__aio_pushfn
> 	        record__aio_write
> 	          aio_write(aio buf)
> 
> 
> side note: that actualy makes me think why do we even have perf_mmap__aio_push,
> it looks like we could copy the buf in the callback push function with no harm?

Well, yes, perf_mmap__aio_push() can be avoided and perf_mmap__push() can be used
as for serial as for AIO, moving all the specifics to record code from mmap.c,
like this:

Serial
	perf_mmap__push(, record__pushfn)
 	   push(), possibly two times
	      record__pushfn()
                 if (-z) zstd_compress(map->base => map->data) <-- compressing memcpy()
                 record__write(-z ? map->data, map->base)
AIO
	record__aio_push()
	   perf_mmap__push(, record__aio_pushfn())
              push(), possibly two times
                 record__aio_pushfn()
                    if (-z) zstd_compress(map->base => map->aio.data[i]) <--- compressing memcpy()
                    else memcpy(map->base => map->aio.data[i]) <--- plain memcpy()
           record__aio_write(map->aio.data[i]) 

So now it looks optimal as from performance and data loss reduction 
perspective as from design perspective. What do you think?

~Alexey

> 
> so.. there's one extra memcpy for compression, is it right?
> I might miss some part which makes this scheme unusable..
> 
> thanks,
> jirka
> 
