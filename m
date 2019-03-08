Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451AFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E2320811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCHKrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:47:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfCHKrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:47:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 945B4301E11B;
        Fri,  8 Mar 2019 10:47:01 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id D27E25C1B4;
        Fri,  8 Mar 2019 10:46:59 +0000 (UTC)
Date:   Fri, 8 Mar 2019 11:46:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 07/10] perf record: implement -z,--compression_level=n
 option and compression
Message-ID: <20190308104657.GA21500@krava>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <87fa1906-2d6a-a00a-7ba5-b570d0cbf9cc@linux.intel.com>
 <20190305122534.GB16615@krava>
 <ee765c0e-6e5c-e879-aaa6-40f314f85a5e@linux.intel.com>
 <20190307121429.GB29474@krava>
 <002e7e10-b0ef-df2a-261c-88fd9c00364d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002e7e10-b0ef-df2a-261c-88fd9c00364d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 08 Mar 2019 10:47:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 06:26:47PM +0300, Alexey Budankov wrote:
> 
> On 07.03.2019 15:14, Jiri Olsa wrote:
> > On Thu, Mar 07, 2019 at 11:39:46AM +0300, Alexey Budankov wrote:
> >>
> >> On 05.03.2019 15:25, Jiri Olsa wrote:
> >>> On Fri, Mar 01, 2019 at 06:58:32PM +0300, Alexey Budankov wrote:
> >>>
> >>> SNIP
> >>>
> >>>>  
> >>>>  	/*
> >>>>  	 * Increment md->refcount to guard md->data[idx] buffer
> >>>> @@ -350,7 +357,7 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
> >>>>  	md->prev = head;
> >>>>  	perf_mmap__consume(md);
> >>>>  
> >>>> -	rc = push(to, &md->aio.cblocks[idx], md->aio.data[idx], size0 + size, *off);
> >>>> +	rc = push(to, md->aio.data[idx], size0 + size, *off, &md->aio.cblocks[idx]);
> >>>>  	if (!rc) {
> >>>>  		*off += size0 + size;
> >>>>  	} else {
> >>>> @@ -556,13 +563,15 @@ int perf_mmap__read_init(struct perf_mmap *map)
> >>>>  }
> >>>>  
> >>>>  int perf_mmap__push(struct perf_mmap *md, void *to,
> >>>> -		    int push(struct perf_mmap *map, void *to, void *buf, size_t size))
> >>>> +		    int push(struct perf_mmap *map, void *to, void *buf, size_t size),
> >>>> +		    perf_mmap__compress_fn_t compress, void *comp_data)
> >>>>  {
> >>>>  	u64 head = perf_mmap__read_head(md);
> >>>>  	unsigned char *data = md->base + page_size;
> >>>>  	unsigned long size;
> >>>>  	void *buf;
> >>>>  	int rc = 0;
> >>>> +	size_t mmap_len = perf_mmap__mmap_len(md);
> >>>>  
> >>>>  	rc = perf_mmap__read_init(md);
> >>>>  	if (rc < 0)
> >>>> @@ -574,7 +583,10 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
> >>>>  		buf = &data[md->start & md->mask];
> >>>>  		size = md->mask + 1 - (md->start & md->mask);
> >>>>  		md->start += size;
> >>>> -
> >>>> +		if (compress) {
> >>>> +			size = compress(comp_data, md->data, mmap_len, buf, size);
> >>>> +			buf = md->data;
> >>>> +		}
> >>>>  		if (push(md, to, buf, size) < 0) {
> >>>>  			rc = -1;
> >>>>  			goto out;
> >>>
> >>> when we discussed the compress callback should be another layer
> >>> in perf_mmap__push I was thinking more of the layered/fifo design,
> >>> like:
> >>>
> >>> normaly we call:
> >>>
> >>> 	perf_mmap__push(... push = record__pushfn ...)
> >>> 		-> reads mmap data and calls push(data), which translates as:
> >>>
> >>> 		record__pushfn(data);
> >>> 			- which stores the data
> >>>
> >>>
> >>> for compressed it'd be:
> >>>
> >>> 	perf_mmap__push(... push = compressed_push ...)
> >>>
> >>> 		-> reads mmap data and calls push(data), which translates as:
> >>>
> >>> 		compressed_push(data)
> >>> 			-> reads data, compresses them and calls, next push callback in line:
> >>>
> >>> 			record__pushfn(data)
> >>> 				- which stores the data
> >>>
> >>>
> >>> there'd need to be the logic for compressed_push to
> >>> remember the 'next push' function
> >>
> >> That is suboptimal for AIO. Also compression is an independent operation that 
> >> could be applied on any of push stages you mean.
> > 
> > not sure what you mean by suboptimal, but I think
> > that it can still happen in subsequent push callback
> > 
> >>
> >>>
> >>> but I think this was the original idea behind the
> >>> perf_mmap__push -> it gets the data and pushes them for
> >>> the next processing.. it should stay as simple as that
> >>
> >> Agree on keeping simplicity and, at the moment, there is no any push to the next 
> >> processing in the code so provided implementation fits as for serial as for AIO
> >> at the same time sticking to simplicity as much as possibly. If you see something 
> >> that would fit better please speak up and share.
> > 
> > I have to insist that perf_mmap__push stays untouched
> > and we do other processing in the push callbacks
> 
> What is about perf_mmap__aio_push()?
> 
> Without compression it does 
> 	memcpy(), memcpy(), aio_push()
> 
> With compression its does
> 	memcpy_with_compression(), memcpy_with_compression(), aio_push()

so to be on the same page.. normal processing without compression is:

  perf_mmap__push does:
	push(mmap buf)
	  record__pushfn
	    record__write
	      write(buf)

  perf_mmap__aio_push does:
	memcpy(aio buf, mmap buf)
	  push(aio buf)
	    record__aio_pushfn
	      record__aio_write
	        aio_write(aio buf)


and for compression it would be:

  perf_mmap__push does:
	push(mmap buf)
	  compress_push
	    memcpy(compress buffer, mmapbuf)  EXTRA copy
	      record__pushfn
	        record__write
		  write(buf)

  perf_mmap__aio_push does:
	memcpy(aio buf, mmap buf)
	  memcpy(compress buffer, mmapbuf)    EXTRA copy
	    push(aio buf)
	      record__aio_pushfn
	        record__aio_write
	          aio_write(aio buf)


side note: that actualy makes me think why do we even have perf_mmap__aio_push,
it looks like we could copy the buf in the callback push function with no harm?

so.. there's one extra memcpy for compression, is it right?
I might miss some part which makes this scheme unusable..

thanks,
jirka
