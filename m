Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77FEC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA71020840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngzvhJZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfHMTsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:48:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35183 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHMTsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:48:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id u34so8329561qte.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DeGXme6+dwx5l6d8geNGR3pPKvRt8jf26dFTpmGE0LY=;
        b=ngzvhJZPGSpuXsvCyrZ/WIJGposKw9+tpqCt10RopxmuLd2Pz7ulmHU4XhYHQyKvgI
         kNKUU/nEO/MYESYLFIg0JZdcljHMOhFS+kDqMy57tl2/PA+RYIPXUUcd4YgFv1kQmKCl
         AMeoc5qlmi7t1V4+jX/G8Bt9NKyN0ZeQavlf0s3/IA6QNjQOHkRhTgODV3NwZ11B39E5
         SWB7IouQbfDIT3r1opkeM1DIjMwspCzdsNs97PlFNu/2JuoZIL+MjaRRxCIA3irCSH/b
         PLaM/Jxgo7Hb0IdVoKyHOtHHNOkld5mkyNlbVlQ5qsM4W9t5lNHOHJh9EAzODnydV3un
         dzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DeGXme6+dwx5l6d8geNGR3pPKvRt8jf26dFTpmGE0LY=;
        b=K+YsOFZiqulev9Yv0X4TJdWdz7YH8UuTad9rkGKc9uUBCMI/dkrgHYm2AhGKxl7zaF
         5DGVoGjJluMnn2yNtvMvbyWrZqcszMSG4jZLdnsspN7P+cVJRfHoD5h69+kOC68RDslT
         CQu+2YTS3mkd+eXrt+DNhgg7G6oIs0CaXxMk1OkHhpaBXFUm8n5MY+NxJwTkOzelb6ux
         xl69CECzWXnMNkNZqmtrKw+dRMmV9PyO7XDjN45LsqbalJNbVqMZpHqz5F1vBGuRbXNf
         CyTBhWlWI53LSfKe8y+SkSjVr+PyjADQ/iVVh4Cairliiq0nYi/HWbOqykxnMnTCPFek
         Nseg==
X-Gm-Message-State: APjAAAVSnrfmtB3n/yAi8MOPW2o4AXYZJr6YMpPXEg0eb17rV8TtTAAL
        CYtIRPNI1aA/bYjz+MP2K+XzfidePad6/vBBxnZTg9DFzwPHaw==
X-Google-Smtp-Source: APXvYqzEJl3HG1FRL7ajj/AJNzu2zpUea+aWnDGRaTX0rHteb+euaPWbhFg5Pay0bb/GPJUErSNfW95fjZLqXI4YCnY=
X-Received: by 2002:ac8:32a1:: with SMTP id z30mr35337650qta.117.1565725691929;
 Tue, 13 Aug 2019 12:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190809214642.12078-1-dxu@dxuuu.xyz> <20190809214642.12078-2-dxu@dxuuu.xyz>
 <CAEf4Bzb0jBmsdeKZ_vN4w-z1tM8M2Ygz_CoBoO_2iV55tgL1Bg@mail.gmail.com> <7232f649-78f8-4a2d-a3df-0ce9293f9de8@www.fastmail.com>
In-Reply-To: <7232f649-78f8-4a2d-a3df-0ce9293f9de8@www.fastmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Aug 2019 12:48:00 -0700
Message-ID: <CAEf4BzadWn+fWuxO9E0snn04BfFWXrWsakse2nHrTWSDG_rMmQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] tracing/probe: Add PERF_EVENT_IOC_QUERY_PROBE
 ioctl
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, peterz@infraded.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        alexander.shishkin@linux.intel.com, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 5:39 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Mon, Aug 12, 2019, at 8:57 AM, Andrii Nakryiko wrote:
> > On Fri, Aug 9, 2019 at 2:47 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > It's useful to know [uk]probe's nmissed and nhit stats. For example with
> > > tracing tools, it's important to know when events may have been lost.
> > > debugfs currently exposes a control file to get this information, but
> > > it is not compatible with probes registered with the perf API.
> > >
> > > While bpf programs may be able to manually count nhit, there is no way
> > > to gather nmissed. In other words, it is currently not possible to
> > > retrieve information about FD-based probes.
> > >
> > > This patch adds a new ioctl that lets users query nmissed (as well as
> > > nhit for completeness). We currently only add support for [uk]probes
> > > but leave the possibility open for other probes like tracepoint.
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  include/linux/trace_events.h    | 12 ++++++++++++
> > >  include/uapi/linux/perf_event.h | 19 +++++++++++++++++++
> > >  kernel/events/core.c            | 20 ++++++++++++++++++++
> > >  kernel/trace/trace_kprobe.c     | 23 +++++++++++++++++++++++
> > >  kernel/trace/trace_uprobe.c     | 23 +++++++++++++++++++++++
> > >  5 files changed, 97 insertions(+)
> > >
> [...]
> > > +       struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
> > > +       u64 nmissed, nhit;
> > > +
> > > +       if (!capable(CAP_SYS_ADMIN))
> > > +               return -EPERM;
> > > +       if (copy_from_user(&query, uquery, sizeof(query)))

Not sure why we are reading that struct in, if we never use that? With
size as a first argument (see below about compatiblity), I'd also read
just first 4 or 8 bytes only.

> >
> > what about forward/backward compatibility? Didn't you have a size
> > field for perf_event_query_probe?
>
> I initially did, yes. But after thinking about it more, I'm not convinced it
> is necessary. It seems the last change to the debugfs counterpart was in
> the initial comit cd7e7bd5e4, ~10 years ago. I cannot think of any other
> information that would be useful off the top of my head, so I figured it'd
> be best if we didn't make more complicated something that doesn't seem
> likely to change. If we really needed something else, I figured adding
> another ioctl is pretty cheap.
>
> If you (or anyone) feels strongly about adding it back, I can make it a
> u64 so there's no holes.

Debugfs is not stable API, so I guess that matters less. I think we
should support this forward/backward compatibility mechanism that
kernel implements for a lot of other stable APIs.

>
> >
> > > +               return -EFAULT;
> > > +
> > > +       nhit = trace_kprobe_nhit(tk);
> > > +       nmissed = tk->rp.kp.nmissed;
> > > +
> > > +       if (put_user(nmissed, &uquery->nmissed) ||
> > > +           put_user(nhit, &uquery->nhit))
> >
> > Wouldn't it be nicer to just do one user put for entire struct (or at
> > least relevant part of it with backward/forward compatibility?).
>
> Not sure how that didn't occur to me. Thanks.

Once you add back size field for compatibility, doing it with one call
will make it easier to write only first N requested bytes.
