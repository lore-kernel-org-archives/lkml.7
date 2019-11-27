Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA29CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D02520862
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+ZK+0Hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfK0Sdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:33:43 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36662 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0Sdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:33:43 -0500
Received: by mail-yw1-f66.google.com with SMTP id y64so8740628ywe.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OjRi9UMypWzzX9/4nFcvQwOg0nYRy1dHKkHuUJ53+8=;
        b=K+ZK+0HravEAzoAlA2idzRZjAVNh2ZfjaaRKVFFueLUIi9QXZ3PLV+wkoSCWaPvsPe
         3I57x17cuFqVttoaY9dOb2kLJmecjpFEfxSf84fCMQGsw1IZ2vO2/8E040ICTSodPtyD
         +LnTtigkbMklWlFkgXTW7bUUHRhbxvTvr7HTCYG/+p6wXBbnNRXGHi1M+4Av5i6/D9Ay
         mWtb0py+8Ny9Iq6qsuoIItf0kJmcp7QgLPm3i31svTz0KzydaBXxD/KKO4i2ZWXy9MuP
         nvFYtALl0dM0bnIEzsR3uh3j6Kw0Z+k24Z4Ubfu+TSmzVKoU7RSOBtoTr5JRgBptbUyW
         obZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OjRi9UMypWzzX9/4nFcvQwOg0nYRy1dHKkHuUJ53+8=;
        b=rsu5ORXBLL4MI27/3kwV+Z4Az7IwX2KoNxAhxnUCih67bztW4+iBY1WJmpVCJhNAu+
         CG/pHH4mUiwuJNdK362zMNpAJ31s2Gkhf+mO5COL+BG7Cy350vjsZH8Nhl1kf24Csdvr
         eqsgXcT920akrsEaiCSRclIWyji8X0kl3NUaq7Gk7hRTH8RgpwO9vQJW9WpTjKGPbuXe
         PKbt2mW91XtbUhCZURR2sYDenlm9rbtHWkM9TXfOiqR2GEzAo39d60piOO3jNd7sa2Lx
         gb5eV+k1qvEplXCAiqwhu2UC0bYaw9hXVeioLM3vNwdGIi9DlcGfBq+zjBgCbSJVBRrJ
         pZ0g==
X-Gm-Message-State: APjAAAXQqJJ2nxBBloOUxgbpa1mVSOsL9FXZW3yZ/pD7A+y8HTLOu28y
        8zZCDtCpgTQW3/FXpt/vBapsiaUy3KqPJDivfcYbyg==
X-Google-Smtp-Source: APXvYqxZCZzobDLUfgfVI9CO0nFruf34M+w51JC3QCWjxOTiA2cFEKYZ6we2BkJTkb7z+aEcsSHfV58hXuWK60i/DRk=
X-Received: by 2002:a81:7053:: with SMTP id l80mr3532099ywc.377.1574879621810;
 Wed, 27 Nov 2019 10:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20191127073442.174202-1-irogers@google.com> <20191127081844.GH32367@krava>
In-Reply-To: <20191127081844.GH32367@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 27 Nov 2019 10:33:30 -0800
Message-ID: <CAP-5=fUpn0fecOyXH14Wjo7SCqV5wnkMcZwDvB8wJ5z5Jc2FHw@mail.gmail.com>
Subject: Re: [PATCH] perf c2c: fix '-e list'
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:18 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Nov 26, 2019 at 11:34:42PM -0800, Ian Rogers wrote:
> > When the event is passed as list, the default events should be listed as
> > per 'perf mem record -e list'. Previous behavior is:
> >
> > $ perf c2c record -e list
> > failed: event 'list' not found, use '-e list' to get list of available events
> >
> >  Usage: perf c2c record [<options>] [<command>]
> >     or: perf c2c record [<options>] -- <command> [<options>]
> >
> >     -e, --event <event>   event selector. Use 'perf mem record -e list' to list available events
>
> man c2c page do say you should use 'perf mem' not 'perf c2c'
> could you please change the man page as well?

Done.

> >
> > New behavior:
> >
> > $ perf c2c record -e list
> > ldlat-loads  : available
> > ldlat-stores : available
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-c2c.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index e69f44941aad..dd69cd218e4c 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -2872,10 +2872,26 @@ static int perf_c2c__report(int argc, const char **argv)
> >  static int parse_record_events(const struct option *opt,
> >                              const char *str, int unset __maybe_unused)
> >  {
> > +     int j;
> >       bool *event_set = (bool *) opt->value;
> >
> > -     *event_set = true;
> > -     return perf_mem_events__parse(str);
> > +     if (strcmp(str, "list")) {
> > +             *event_set = true;
> > +             if (!perf_mem_events__parse(str))
> > +                     return 0;
> > +
> > +             exit(-1);
> > +     }
> > +     for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> > +             struct perf_mem_event *e = &perf_mem_events[j];
> > +
> > +             fprintf(stderr, "%-13s%-*s%s\n",
> > +                     e->tag,
> > +                     verbose > 0 ? 25 : 0,
> > +                     verbose > 0 ? perf_mem_events__name(j) : "",
> > +                     e->supported ? ": available" : "");
> > +     }
>
> there's same loop in builtin-mem.c, could you please put it
> to function in mem-events.c?

Done.

Thanks for the review!
Ian

> thanks,
> jirka
>
