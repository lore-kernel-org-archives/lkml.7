Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5B5C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBB82186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTmZl5ui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfHZWIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:08:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42052 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfHZWIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:08:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id t12so19506525qtp.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 15:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wJx62bVXuq5VeSwzaQl9szOMIkdAB5uFLpBEy41vLcA=;
        b=RTmZl5ui0G5GhUiY1M7jmb7dsniQ7af2/ichloDZyCqVp5zhmRYp4VtQsT+IWU1OfP
         nSol8HHyC2qIpCQyPUGx1mMJwR4Q0MCnfra6UPrDgSnwd2EcZN65rTCCl5zYIKjEmyjn
         3GiTCkdBz3UVfTHX6ImYjyHTT2TEf6KR2tuY8znx5ifqJFDxmwZBBMwgB5mWdYEOO7OO
         EEYUNaVpGtFfMFZ9rVyl2CUkAAEJXg5mg4FDUhNNexodJ+kbBFLjRZ2LBOK+yjJVmhZw
         z1rVcZILL7HB+YR/GsbtZrhiHgManoJE+leJrlCGPcwlAscY59432BtWpOVYTZ3v6Km6
         AKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wJx62bVXuq5VeSwzaQl9szOMIkdAB5uFLpBEy41vLcA=;
        b=X51Yk/jpyEhxaOFf4w0FKr7yv1thqlQ0LEBtHvOChvi6sB8SLHwijVuS8SItJzcPl6
         xlZ1a6SwUv3umuKzqD4aWBcKDj0UTXC+OOOvcauFnyXl73My59lvtHM1jUIKcDXSgRTJ
         lTZOkScJcFcj9Aufv1yvVerh7AQRv4ULYdgEzk+mRLsAdOCUg3MS6VHzgzEcAznsCYDy
         Z0neXhAqzzWdNxdBAHoWn8Ud4wGNHAN44rVpddsjgeBP0+jZJ6XWOa1hj8bkSLPxZHoU
         vqn2H8JdhV6F0CmmFGwF0cZpz11/1rqwKlDjiG5vPnB7soG7ZKdNSICX2QjjWW8Xd8N/
         RTlw==
X-Gm-Message-State: APjAAAVVXWPiQ881ZxfF+uNNi+MmjctMgcRGoZvKhbCW8XJMTjVMEJEP
        ecJrfjGNrH1djczmAlZR1JE=
X-Google-Smtp-Source: APXvYqyi+jD0IIItEvVUnXhTKW64spiKpowhEnyqNkj9JH+lpdZSbaRFj3U+cuBSgyHEG6Ibd6a0+w==
X-Received: by 2002:a0c:abca:: with SMTP id k10mr17685943qvb.177.1566857292976;
        Mon, 26 Aug 2019 15:08:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id e2sm6316651qkg.38.2019.08.26.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 15:08:12 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1344040916; Mon, 26 Aug 2019 19:08:10 -0300 (-03)
Date:   Mon, 26 Aug 2019 19:08:10 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 00/12] libperf: Add events to perf/event.h
Message-ID: <20190826220810.GA21761@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
 <20190826154138.GD24801@kernel.org>
 <20190826164734.GE17554@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826164734.GE17554@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 26, 2019 at 06:47:34PM +0200, Jiri Olsa escreveu:
> On Mon, Aug 26, 2019 at 12:41:38PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Aug 25, 2019 at 08:17:40PM +0200, Jiri Olsa escreveu:
> > > hi,
> > > as a preparation for sampling libperf interface, moving event
> > > definitions into the library header. Moving just the kernel 
> > > non-AUX events now.
> > > 
> > > In order to keep libperf simple, we switch 'u64/u32/u16/u8'
> > > types used events to their generic '__u*' versions.
> > > 
> > > Perf added 'u*' types mainly to ease up printing __u64 values
> > > as stated in the linux/types.h comment:
> > > 
> > >   /*
> > >    * We define u64 as uint64_t for every architecture
> > >    * so that we can print it with "%"PRIx64 without getting warnings.
> > >    *
> > >    * typedef __u64 u64;
> > >    * typedef __s64 s64;
> > >    */
> > > 
> > > Adding and using new PRI_lu64 and PRI_lx64 macros to be used for
> > > that.  Using extra '_' to ease up the reading and differentiate
> > > them from standard PRI*64 macros.
> > 
> > I think we should take advantage of this moment to rename those structs
> > to have the 'perf_record_' prefix on them, I guess we could even remove
> > the _event from them, i.e.:
> > 
> > 'struct mmap_event' becomes 'perf_record_mmap', as it is the description
> > for the PERF_RECORD_MMAP meta-data event, are you ok with that?
> 
> hum, not sure about loosing the '_event' here, but we are
> not public yet, so we can always change back ;-) I do like
> it'd follow the enum name

So I'm making the already exported to libperf to be renamed to have the
same name as the PERF_RECORD_ enum they map to, just all lowercase.

Looks nice and also makes something exported by libperf to have a perf_
namespace prefix.

BTW: you forgot to move PERF_RECORD_CONTEXT_SWITCH :-)

> > I can go ahead and do it myself, updating each patch on this series to
> > do that.
> 
> sure, I thought we'd do it later, but feel free to do it,
> maybe in separate changes?

I did it as a separate patch, one patch for all the PERF_RECORD_ already
moved to libperf.

Also some other minor stuff, like having that
perf_event.{bpf,ksymbol}_event renamed to play perf_event.{bpf,ksymbol},
like the other records. so to make this idiom more compact and less
redundant:

    event->bpf_event

becomes:

    event->bpf

ditto for ksymbol_event.

- Arnaldo
