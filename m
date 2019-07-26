Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA9AC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B12822BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j54lOfLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfGZXwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:52:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52756 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfGZXwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:52:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so49236989wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 16:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynP0RWGfXHb+Ugg6ER1XzuO5G0OYOiJ2jK1uvno/35E=;
        b=j54lOfLSrM52zu4Z1Omwfucejndrp+XFm/dAFcG2sWu4iuRIcyL+ZJL7nkx1FKzF6a
         EvYOAtkSsh2ojOCL3fs3jAEh9BSVwIFsilDab6dgr6sLUFaBshp0vhLLfSj8GUCWEkq5
         /yQb2YY9ZB3tZ13lHJzvd68aAHlY8BhQM5dg0En4cHGyvgWgPLVnpL/dsMc7kA0sk9pn
         9Xpni0yfoHPtb3di8nHFUrBDk1WisQcYOraB7Ez8ttFVYb1xworuzio38MIF8woinNp/
         a1hAE2r9QFh5m8wdlOddvsfRMxSJye40F4Cv+pbfVP2Prw5KR4NMZad/5C+9519Qh0PZ
         hksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynP0RWGfXHb+Ugg6ER1XzuO5G0OYOiJ2jK1uvno/35E=;
        b=iTW/JRJiHd8wMWxinM44jciErXMrLWpyo9jQ6ihEJ9O0Nxek7oKEJH5oJHQKix/Jao
         ra4yOYv2vkJzxgAxYqwW5tQZ2Di6G0iwAZwsXJIUGcPyOk5lIYcnD0ie9nENf80L5UzI
         MQdVmzdGM2M0AF+cGCnww/slhGXzBpGZ+dG7gFU92T0PUtcoR+INys9AvcIlbg7RoF2a
         gE4am1SVSN6xKSTV5wYOg5f+lSMAZaPlbYyW92o4B++Ngiia10zar7x68R2Fd7186W5i
         1A2AAF/9hnv2HZIhoHfA9RcepvK7oa55uQR359KRSxXb333QTEa4UNKfHcSG8atkwSUA
         ly1g==
X-Gm-Message-State: APjAAAWt1gV1cEZZAq+H2tKJ1EeoMPrszAGcBrXmecTDsGYjeEOiF28e
        GMs8yQnzgf9unzIJ0Ycj+iNcCZV1Irs5L1cRY9iiQA==
X-Google-Smtp-Source: APXvYqyagTff9ERbnr2ahjA+g53G/zQgaiKCoy/EuBCDcXm7bY0F0tc/29M9lpt+ezF4FTVcXZ/6AJrbRI05oJfzQGg=
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr14459424wmg.155.1564185158472;
 Fri, 26 Jul 2019 16:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190724234500.253358-1-nums@google.com> <20190724234500.253358-4-nums@google.com>
 <20190726193227.GH20482@kernel.org>
In-Reply-To: <20190726193227.GH20482@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Jul 2019 16:52:26 -0700
Message-ID: <CAP-5=fUfiG=HiBjcvOWwrBRarSTcc1fPWdWoxmWTdcwAF8e-mQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Fix sched-messaging.c use of uninitialized value errors
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, mbd@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 12:32 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Jul 24, 2019 at 04:45:00PM -0700, Numfor Mbiziwo-Tiapo escreveu:
> > Our local MSAN (Memory Sanitizer) build of perf throws use of
> > uninitialized value warnings in "tools/perf/bench/sched-messaging.c"
> > when running perf bench.
> >
> > The first warning comes from the "ready" function where the "dummy" char
> > is declared and then passed into "write" without being initialized.
> > Initializing "dummy" to any character silences the warning.
> >
> > The second warning comes from the "sender" function where a "write" call
> > is made to write the contents from the "data" char array when it has not
> > yet been initialized. Calling memset on "data" silences the warning.
>
> So, this is just to silence MSAN, as it doesn't matter what is sent,
> whatever values are in those variables is ok, as it will not be used,
> right?

That's right.

Thanks,
Ian Rogers

> - Arnaldo
>
> > To reproduce this warning, build perf by running:
> > make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-fsanitize=memory\
> >  -fsanitize-memory-track-origins"
> >
> > (Additionally, llvm might have to be installed and clang might have to
> > be specified as the compiler - export CC=/usr/bin/clang)
> >
> > then running: tools/perf/perf bench sched all
> >
> > Please see the cover letter for why false positive warnings may be
> > generated.
> >
> > Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> > ---
> >  tools/perf/bench/sched-messaging.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
> > index f9d7641ae833..d22d7b7b591d 100644
> > --- a/tools/perf/bench/sched-messaging.c
> > +++ b/tools/perf/bench/sched-messaging.c
> > @@ -69,7 +69,7 @@ static void fdpair(int fds[2])
> >  /* Block until we're ready to go */
> >  static void ready(int ready_out, int wakefd)
> >  {
> > -     char dummy;
> > +     char dummy = 'N';
> >       struct pollfd pollfd = { .fd = wakefd, .events = POLLIN };
> >
> >       /* Tell them we're ready. */
> > @@ -87,6 +87,7 @@ static void *sender(struct sender_context *ctx)
> >       char data[DATASIZE];
> >       unsigned int i, j;
> >
> > +     memset(data, 'N', DATASIZE);
> >       ready(ctx->ready_out, ctx->wakefd);
> >
> >       /* Now pump to every receiver. */
> > --
> > 2.22.0.657.g960e92d24f-goog
>
> --
>
> - Arnaldo
