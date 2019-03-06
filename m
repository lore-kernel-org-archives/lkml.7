Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B0DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CD320663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIPVwoF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfCFUOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:14:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33194 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbfCFUOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:14:39 -0500
Received: by mail-qt1-f193.google.com with SMTP id z39so14418866qtz.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 12:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uIo5WkTc+H9u98wBIgXVB767/LLo0QUYuXZzebRbbBE=;
        b=nIPVwoF4B55BzXSowXtdox6Su5lQxHmqd5i8I3V6ckI4omEKZV5Ti2wYoHSFBz1ldq
         ZT0/JhJt/X6ETYZt5lEc/oCRI/eCkwsDx2B2PD2XLvwEBHQMFpbbcfLf/AhynLnJ+3Np
         bBolmaCZpuLDh7gGIfmUE7MfmlQG/3IMhyyQR9Zs0eoUQlx//oQwpTYrxJDP+xMRx/TR
         9SGLSttt8O/yLf4+FoID5vd94j9tUKjFFDah7f9krnfxT1DnOBdygxzOQIYTrg8sOtCP
         9bLQfLA43ROwgcIIBD/uT82rn0KI/Ml1uTMwaHEV4CxX4kvfKMa6OLc/3AWMSkXN2UXG
         QGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uIo5WkTc+H9u98wBIgXVB767/LLo0QUYuXZzebRbbBE=;
        b=fCZhGun/Dri3s4c3IzPmAryZnAn2qvarhUEai18HIRfbRry5p4JSfwHc5jp78Scmlz
         7COMOKHBYDLFantEpU8e2H24hdzFmzSbeXbXW8+6PUgjSzoYaYb3zeNUkoOh/veFcNIY
         gh+B/5iijEU/Z39tYWPjke+Zz5S+MqmPX2bdZRvyBk6U16n3C/Xd//X4oOdVB32ts5NX
         F9KmF13yOl7wBJy1PIPZuESFmwKmdv19WqR97qbqb2Y0h8DDLWPT6Nrqity9V5Se/3Xq
         xqMpdBEmG2967YaIaranueXbCYG/UExiTe7BiWSuy2eCcwi8iOkBpfFWQEtf1jPIlfpG
         2pzw==
X-Gm-Message-State: APjAAAWjBMh3KlSgIq98E82da2T1Ikmqm0QTvh9wSo95P/rNGyFYJ02e
        txhnE4NgofhvkCMOKfEsHQA=
X-Google-Smtp-Source: APXvYqw1MIdMZDpUy4lD1/wBQgycp7jd2K4iJQ8AAjFiJrXbbuhTfLCTukACWQ14MaWE1jrA2jE7Tw==
X-Received: by 2002:a0c:87d0:: with SMTP id 16mr7856165qvk.166.1551903278024;
        Wed, 06 Mar 2019 12:14:38 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id i33sm1683788qti.74.2019.03.06.12.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 12:14:36 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 86A9D4039C; Wed,  6 Mar 2019 17:14:34 -0300 (-03)
Date:   Wed, 6 Mar 2019 17:14:34 -0300
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: Re: [RFC PATCH] perf: workaround unaligned NEON vector load
Message-ID: <20190306201434.GJ30734@kernel.org>
References: <20190306140116.23078-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306140116.23078-1-l.stach@pengutronix.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 06, 2019 at 03:01:16PM +0100, Lucas Stach escreveu:
> The mmap event buffer may end up in a location that violates the
> alignment requirements for a NEON vector load,

which are?

> which GCC generates to load consecutive values from the event
> structure. Fix this by copying the event structure into a properly
> aligned buffer.

At a minimum this would be done only for such arch (is that an arch?),
so that the rest of the world doesn't have to eat this extra cost?

What is it that perf_event_mmap_event() is doing to
mmap_event->event_id.header.size that this NEON vector load dislikes?

- Arnaldo
 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  tools/perf/util/machine.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 143f7057d581..ab5500e85173 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1565,37 +1565,40 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
>  }
>  
>  int machine__process_mmap2_event(struct machine *machine,
> -				 union perf_event *event,
> +				 union perf_event *event_in,
>  				 struct perf_sample *sample)
>  {
> +	union perf_event event;
>  	struct thread *thread;
>  	struct map *map;
>  	int ret = 0;
>  
> +	memcpy(&event, event_in, sizeof(union perf_event));
> +
>  	if (dump_trace)
> -		perf_event__fprintf_mmap2(event, stdout);
> +		perf_event__fprintf_mmap2(&event, stdout);
>  
>  	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
>  	    sample->cpumode == PERF_RECORD_MISC_KERNEL) {
> -		ret = machine__process_kernel_mmap_event(machine, event);
> +		ret = machine__process_kernel_mmap_event(machine, &event);
>  		if (ret < 0)
>  			goto out_problem;
>  		return 0;
>  	}
>  
> -	thread = machine__findnew_thread(machine, event->mmap2.pid,
> -					event->mmap2.tid);
> +	thread = machine__findnew_thread(machine, event.mmap2.pid,
> +					event.mmap2.tid);
>  	if (thread == NULL)
>  		goto out_problem;
>  
> -	map = map__new(machine, event->mmap2.start,
> -			event->mmap2.len, event->mmap2.pgoff,
> -			event->mmap2.maj,
> -			event->mmap2.min, event->mmap2.ino,
> -			event->mmap2.ino_generation,
> -			event->mmap2.prot,
> -			event->mmap2.flags,
> -			event->mmap2.filename, thread);
> +	map = map__new(machine, event.mmap2.start,
> +			event.mmap2.len, event.mmap2.pgoff,
> +			event.mmap2.maj,
> +			event.mmap2.min, event.mmap2.ino,
> +			event.mmap2.ino_generation,
> +			event.mmap2.prot,
> +			event.mmap2.flags,
> +			event.mmap2.filename, thread);
>  
>  	if (map == NULL)
>  		goto out_problem_map;
> -- 
> 2.20.1

-- 

- Arnaldo
