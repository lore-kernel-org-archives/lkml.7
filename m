Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A63C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68145207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI80Pwde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfIWPFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:05:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45225 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfIWPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:05:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id c21so17484695qtj.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xpNo85wDWcmRnoy4Jdo9DoQtPI+zrCStYwy+YauJZuM=;
        b=gI80PwdeLe7rPrGhcjNl8pVdUIa0yDkurG+qOronIkRPojxgeMSx8Oi8JS4nOq/4/O
         g5LrmAUR8USCAA8mnKPnfBjU82sq1xvzNQYF+XzrfAw1fn0WTrI53xCYbGs7wZTJgEFW
         h/6DZc35DooQJTGowStYlMyIMT2PnwhKRtY2sAXhJPDsz+ovdC3YK3beFPdZaKCWquvB
         VXVmvq+ntIEdu/YRizIZzILKPmA4iRhZ/GfVsHW7PFEB8vU9tMRLHruMY49ssqMGC8fw
         Z17m3ZJ7aTjweMN+p0XlDbepDLRvh/db7YqwYZXPVXojlccIiTFKQQnsfsGB8gdXjabr
         rqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xpNo85wDWcmRnoy4Jdo9DoQtPI+zrCStYwy+YauJZuM=;
        b=HRGGu8Z2snvnbXDVcHulQc745mw2hWMiDfI3xD1s32oRMBhEndQPGJtk7gmcvmbTym
         Ea1guVQcCqdyfM5JPleeeEDS0DVjLybEGCV+bhdY7Vq/QnADMu7fKGFbTyD78355cLAg
         PcY4OZntctvGCJCgL3rJn6/8tMC7hUx0RRibW/e6wRWAo0oMt9QOdCisqBhFNS1Md6IH
         wiv44axASBXmDZzqvMmNUApurveTzVRRUkZV3yVdCm9H13AUroUreRsMNrUSHiqoAk9d
         aL4Z/VEuqVqG65FPG5txX3JUaZpoTcCjRGYW8AxrDGcjMTg8zDMJ2MFHsjcmehGbdA3v
         UKaQ==
X-Gm-Message-State: APjAAAUFDirrh0SZcKLac1koGFxkOTWAc4cn/l1s3kOgdarnCDV0/1Zy
        +5erPMG9YpxwO5p2FSWFHnI=
X-Google-Smtp-Source: APXvYqxosHsmmQdnwiDJ/XiD6DU8TzF9a6ghQo1slEuXMxDChA0JneMkpvQi0Nh+vLK4xmOFmKjEfw==
X-Received: by 2002:ac8:2afb:: with SMTP id c56mr397218qta.222.1569251137880;
        Mon, 23 Sep 2019 08:05:37 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id o14sm6571336qtk.52.2019.09.23.08.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 08:05:36 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D1CDC41105; Mon, 23 Sep 2019 12:05:33 -0300 (-03)
Date:   Mon, 23 Sep 2019 12:05:33 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 10/73] libperf: Add perf_mmap struct
Message-ID: <20190923150533.GG16544@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
 <20190913132355.21634-11-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913132355.21634-11-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 13, 2019 at 03:22:52PM +0200, Jiri Olsa escreveu:
> Add the perf_mmap to libperf.
> 
> The definition is added into:
> 
>   include/internal/mmap.h
> 
> which is not to be included by users, but shared
> within perf and libperf.

> diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
> new file mode 100644
> index 000000000000..8d10559dee49
> --- /dev/null
> +++ b/tools/perf/lib/include/internal/mmap.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LIBPERF_INTERNAL_MMAP_H
> +#define __LIBPERF_INTERNAL_MMAP_H
> +
> +#include <linux/refcount.h>
> +#include <linux/compiler.h>
> +#include <stdlib.h>
> +#include <stdbool.h>

So you're doing this with high granularity, cool! But then you should
take care not to add unnecessary stuff here, i.e. these four headers are
not necessary at this point in the series, I'm removing them and adding
as they become necessary.

- Arnaldo


> +/**
> + * struct perf_mmap - perf's ring buffer mmap details
> + *
> + * @refcnt - e.g. code using PERF_EVENT_IOC_SET_OUTPUT to share this
> + */
> +struct perf_mmap {
> +	void		*base;
> +};
> +
> +#endif /* __LIBPERF_INTERNAL_MMAP_H */
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index f3b7c8b0fa90..76190b2edd78 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -31,7 +31,7 @@ size_t perf_mmap__mmap_len(struct mmap *map)
>  static union perf_event *perf_mmap__read(struct mmap *map,
>  					 u64 *startp, u64 end)
>  {
> -	unsigned char *data = map->base + page_size;
> +	unsigned char *data = map->core.base + page_size;
>  	union perf_event *event = NULL;
>  	int diff = end - *startp;
>  
> @@ -116,7 +116,7 @@ void perf_mmap__get(struct mmap *map)
>  
>  void perf_mmap__put(struct mmap *map)
>  {
> -	BUG_ON(map->base && refcount_read(&map->refcnt) == 0);
> +	BUG_ON(map->core.base && refcount_read(&map->refcnt) == 0);
>  
>  	if (refcount_dec_and_test(&map->refcnt))
>  		perf_mmap__munmap(map);
> @@ -317,9 +317,9 @@ void perf_mmap__munmap(struct mmap *map)
>  		munmap(map->data, perf_mmap__mmap_len(map));
>  		map->data = NULL;
>  	}
> -	if (map->base != NULL) {
> -		munmap(map->base, perf_mmap__mmap_len(map));
> -		map->base = NULL;
> +	if (map->core.base != NULL) {
> +		munmap(map->core.base, perf_mmap__mmap_len(map));
> +		map->core.base = NULL;
>  		map->fd = -1;
>  		refcount_set(&map->refcnt, 0);
>  	}
> @@ -370,12 +370,12 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
>  	refcount_set(&map->refcnt, 2);
>  	map->prev = 0;
>  	map->mask = mp->mask;
> -	map->base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
> +	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
>  			 MAP_SHARED, fd, 0);
> -	if (map->base == MAP_FAILED) {
> +	if (map->core.base == MAP_FAILED) {
>  		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
>  			  errno);
> -		map->base = NULL;
> +		map->core.base = NULL;
>  		return -1;
>  	}
>  	map->fd = fd;
> @@ -399,7 +399,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
>  	}
>  
>  	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
> -				&mp->auxtrace_mp, map->base, fd))
> +				&mp->auxtrace_mp, map->core.base, fd))
>  		return -1;
>  
>  	return perf_mmap__aio_mmap(map, mp);
> @@ -444,7 +444,7 @@ static int __perf_mmap__read_init(struct mmap *md)
>  {
>  	u64 head = perf_mmap__read_head(md);
>  	u64 old = md->prev;
> -	unsigned char *data = md->base + page_size;
> +	unsigned char *data = md->core.base + page_size;
>  	unsigned long size;
>  
>  	md->start = md->overwrite ? head : old;
> @@ -489,7 +489,7 @@ int perf_mmap__push(struct mmap *md, void *to,
>  		    int push(struct mmap *map, void *to, void *buf, size_t size))
>  {
>  	u64 head = perf_mmap__read_head(md);
> -	unsigned char *data = md->base + page_size;
> +	unsigned char *data = md->core.base + page_size;
>  	unsigned long size;
>  	void *buf;
>  	int rc = 0;
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index 01524608a984..9028b0e8a0ed 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -1,6 +1,7 @@
>  #ifndef __PERF_MMAP_H
>  #define __PERF_MMAP_H 1
>  
> +#include <internal/mmap.h>
>  #include <linux/compiler.h>
>  #include <linux/refcount.h>
>  #include <linux/types.h>
> @@ -20,7 +21,7 @@ struct aiocb;
>   * @refcnt - e.g. code using PERF_EVENT_IOC_SET_OUTPUT to share this
>   */
>  struct mmap {
> -	void		 *base;
> +	struct perf_mmap	core;
>  	int		 mask;
>  	int		 fd;
>  	int		 cpu;
> @@ -88,12 +89,12 @@ void perf_mmap__consume(struct mmap *map);
>  
>  static inline u64 perf_mmap__read_head(struct mmap *mm)
>  {
> -	return ring_buffer_read_head(mm->base);
> +	return ring_buffer_read_head(mm->core.base);
>  }
>  
>  static inline void perf_mmap__write_tail(struct mmap *md, u64 tail)
>  {
> -	ring_buffer_write_tail(md->base, tail);
> +	ring_buffer_write_tail(md->core.base, tail);
>  }
>  
>  union perf_event *perf_mmap__read_forward(struct mmap *map);
> -- 
> 2.21.0

-- 

- Arnaldo
