Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06D4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5312082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfCEMZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:25:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfCEMZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:25:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A7BE3DE08;
        Tue,  5 Mar 2019 12:25:37 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8491E1949C;
        Tue,  5 Mar 2019 12:25:35 +0000 (UTC)
Date:   Tue, 5 Mar 2019 13:25:34 +0100
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
Message-ID: <20190305122534.GB16615@krava>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <87fa1906-2d6a-a00a-7ba5-b570d0cbf9cc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fa1906-2d6a-a00a-7ba5-b570d0cbf9cc@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 05 Mar 2019 12:25:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 06:58:32PM +0300, Alexey Budankov wrote:

SNIP

>  
>  	/*
>  	 * Increment md->refcount to guard md->data[idx] buffer
> @@ -350,7 +357,7 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
>  	md->prev = head;
>  	perf_mmap__consume(md);
>  
> -	rc = push(to, &md->aio.cblocks[idx], md->aio.data[idx], size0 + size, *off);
> +	rc = push(to, md->aio.data[idx], size0 + size, *off, &md->aio.cblocks[idx]);
>  	if (!rc) {
>  		*off += size0 + size;
>  	} else {
> @@ -556,13 +563,15 @@ int perf_mmap__read_init(struct perf_mmap *map)
>  }
>  
>  int perf_mmap__push(struct perf_mmap *md, void *to,
> -		    int push(struct perf_mmap *map, void *to, void *buf, size_t size))
> +		    int push(struct perf_mmap *map, void *to, void *buf, size_t size),
> +		    perf_mmap__compress_fn_t compress, void *comp_data)
>  {
>  	u64 head = perf_mmap__read_head(md);
>  	unsigned char *data = md->base + page_size;
>  	unsigned long size;
>  	void *buf;
>  	int rc = 0;
> +	size_t mmap_len = perf_mmap__mmap_len(md);
>  
>  	rc = perf_mmap__read_init(md);
>  	if (rc < 0)
> @@ -574,7 +583,10 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
>  		buf = &data[md->start & md->mask];
>  		size = md->mask + 1 - (md->start & md->mask);
>  		md->start += size;
> -
> +		if (compress) {
> +			size = compress(comp_data, md->data, mmap_len, buf, size);
> +			buf = md->data;
> +		}
>  		if (push(md, to, buf, size) < 0) {
>  			rc = -1;
>  			goto out;

when we discussed the compress callback should be another layer
in perf_mmap__push I was thinking more of the layered/fifo design,
like:

normaly we call:

	perf_mmap__push(... push = record__pushfn ...)
		-> reads mmap data and calls push(data), which translates as:

		record__pushfn(data);
			- which stores the data


for compressed it'd be:

	perf_mmap__push(... push = compressed_push ...)

		-> reads mmap data and calls push(data), which translates as:

		compressed_push(data)
			-> reads data, compresses them and calls, next push callback in line:

			record__pushfn(data)
				- which stores the data


there'd need to be the logic for compressed_push to
remember the 'next push' function

but I think this was the original idea behind the
perf_mmap__push -> it gets the data and pushes them for
the next processing.. it should stay as simple as that

jirka
