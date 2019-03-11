Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE11EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B544F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfCKK4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:56:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfCKK4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:56:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47E1B30832CF;
        Mon, 11 Mar 2019 10:56:03 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4E1D4600CD;
        Mon, 11 Mar 2019 10:56:01 +0000 (UTC)
Date:   Mon, 11 Mar 2019 11:56:00 +0100
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
Message-ID: <20190311105600.GC12810@krava>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <87fa1906-2d6a-a00a-7ba5-b570d0cbf9cc@linux.intel.com>
 <20190305122534.GB16615@krava>
 <ee765c0e-6e5c-e879-aaa6-40f314f85a5e@linux.intel.com>
 <20190307121429.GB29474@krava>
 <002e7e10-b0ef-df2a-261c-88fd9c00364d@linux.intel.com>
 <20190308104657.GA21500@krava>
 <8a44eb08-9ad2-4e8e-26f4-9e35496cc50e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a44eb08-9ad2-4e8e-26f4-9e35496cc50e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 11 Mar 2019 10:56:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 07:17:08PM +0300, Alexey Budankov wrote:

SNIP

> > so to be on the same page.. normal processing without compression is:
> > 
> >   perf_mmap__push does:
> > 	push(mmap buf)
> > 	  record__pushfn
> > 	    record__write
> > 	      write(buf)
> > 
> >   perf_mmap__aio_push does:
> > 	memcpy(aio buf, mmap buf)
> > 	  push(aio buf)
> > 	    record__aio_pushfn
> > 	      record__aio_write
> > 	        aio_write(aio buf)
> > 
> > 
> > and for compression it would be:
> > 
> >   perf_mmap__push does:
> > 	push(mmap buf)
> > 	  compress_push
> > 	    memcpy(compress buffer, mmapbuf)  EXTRA copy
> > 	      record__pushfn
> > 	        record__write
> > 		  write(buf)
> > 
> >   perf_mmap__aio_push does:
> > 	memcpy(aio buf, mmap buf)
> > 	  memcpy(compress buffer, mmapbuf)    EXTRA copy
> > 	    push(aio buf)
> > 	      record__aio_pushfn
> > 	        record__aio_write
> > 	          aio_write(aio buf)
> > 
> > 
> > side note: that actualy makes me think why do we even have perf_mmap__aio_push,
> > it looks like we could copy the buf in the callback push function with no harm?
> 
> Well, yes, perf_mmap__aio_push() can be avoided and perf_mmap__push() can be used
> as for serial as for AIO, moving all the specifics to record code from mmap.c,
> like this:
> 
> Serial
> 	perf_mmap__push(, record__pushfn)
>  	   push(), possibly two times
> 	      record__pushfn()
>                  if (-z) zstd_compress(map->base => map->data) <-- compressing memcpy()
>                  record__write(-z ? map->data, map->base)
> AIO
> 	record__aio_push()
> 	   perf_mmap__push(, record__aio_pushfn())
>               push(), possibly two times
>                  record__aio_pushfn()
>                     if (-z) zstd_compress(map->base => map->aio.data[i]) <--- compressing memcpy()
>                     else memcpy(map->base => map->aio.data[i]) <--- plain memcpy()
>            record__aio_write(map->aio.data[i]) 
> 
> So now it looks optimal as from performance and data loss reduction 
> perspective as from design perspective. What do you think?

yes, that looks much better.. so we'd have record__pushfn
for standard (serial) and record__aio_pushfn for AIO

thanks,
jirka
