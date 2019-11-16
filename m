Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABFFC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 07:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49A920730
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 07:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7Fv0B6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfKPHyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 02:54:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34759 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfKPHyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 02:54:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id j18so11704261wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 23:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJsVlKcEzfC8Aw2CjTXUgWWkubQwRdrbmcMgP7QRzQ0=;
        b=o7Fv0B6xocgI9Fdo860gt4k/T6iZCHifV66TP77pMBNTEvFXEZWD+YExGKAEoDKXFw
         7zlcFUO3dwE/rGbWmkdRYd5LpjGSGmgPIP0hRtngL7h2TFPXH7eKKmrJwbWkT2kwNWHa
         JUNrSkWfloo18GXBVGJzQ+mia/B2PnosUFV06XsBSUSXrQukKd8XYQ56Yrno0gfXZ+BG
         zTmZX9xbj9EPWJsiRPlQcm977SBh6dBme2h3j/TrQknF8UAMPQu9MLkBLUi7w0Byc+H4
         ksksjOvEad+IFdAalHUqs3aTwTzhSdMSUakY+NIazlFwEp3GMVY1p2uWgtipu1ucF8Xh
         MgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJsVlKcEzfC8Aw2CjTXUgWWkubQwRdrbmcMgP7QRzQ0=;
        b=PXM2pIT45XnTzXsDwuFWGN6euRBfKcOVjowObYJLWZxVAWSnb53L8AtH04htNrcf3+
         QvxUo8rqZJk9Sj0EDf4lznRhgwPU/raN+HwrkZ1MbYX9W9qLNMhLrVmO/kU5IO6v+Yti
         mhztxa34RKloWKLOYzQa+U4Ontmas/RHNp/h+rYqPpFJtJbx7aZdUdpeaIqTA4Ul64Gp
         1ywjaYoTc1r1th3BZnxiwUDbSN84skCvEPXOBDj57ZjDpIyNXxC6y8PSJQx/jGaLGZgK
         wHs2AnbKBgimPYgW9ToEZgTnbpb4ZwD4eIByZkDZUChSvlRX2maa4846cIWZaKa3wOMS
         vNQg==
X-Gm-Message-State: APjAAAWNrN+OLpDRpBoBh6iFAbIDKOWEYx7JYAs3Qbe5FpvOADfHtyUj
        oMPLwR0xyFZHzLGlktoKQ0lEgnJTvCLzyvBTT3ySjQ==
X-Google-Smtp-Source: APXvYqxOcw2TkSSrVjRCqXAGuIIW+j4s4wm81eLkevvaQQeD8PIdJfcNrzYFXTiWHCAZx9H2L9VIG+eLNmZyF4oLGNk=
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr20662651wmd.80.1573890837611;
 Fri, 15 Nov 2019 23:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20191107222315.GA7261@kernel.org> <20191108181533.222053-1-irogers@google.com>
 <20191111120341.GE9791@krava>
In-Reply-To: <20191111120341.GE9791@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 15 Nov 2019 23:53:46 -0800
Message-ID: <CAP-5=fUCz7CuDn8L_8QdBrvAAtZocPtfhFiQWZqjLsts=6=nSg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: report initial event parsing error
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 4:03 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Nov 08, 2019 at 10:15:33AM -0800, Ian Rogers wrote:
> > Record the first event parsing error and report. Implementing feedback
> > from Jiri Olsa:
> > https://lkml.org/lkml/2019/10/28/680
> >
> > An example error is:
> >
> > $ tools/perf/perf stat -e c/c/
> > WARNING: multiple event parsing errors
> > event syntax error: 'c/c/'
> >                        \___ unknown term
> >
> > valid terms: event,filter_rem,filter_opc0,edge,filter_isoc,filter_tid,filter_loc,filter_nc,inv,umask,filter_opc1,tid_en,thresh,filter_all_op,filter_not_nm,filter_state,filter_nm,config,config1,config2,name,period,percore
> >
> > Initial error:
> > event syntax error: 'c/c/'
> >                     \___ Cannot find PMU `c'. Missing kernel support?
> > Run 'perf list' for a list of valid events
> >
> >  Usage: perf stat [<options>] [<command>]
> >
> >     -e, --event <event>   event selector. use 'perf list' to list available events
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/powerpc/util/kvm-stat.c |  9 ++-
> >  tools/perf/builtin-stat.c               |  2 +
> >  tools/perf/builtin-trace.c              | 16 ++++--
> >  tools/perf/tests/parse-events.c         |  3 +-
> >  tools/perf/util/metricgroup.c           |  2 +-
> >  tools/perf/util/parse-events.c          | 76 ++++++++++++++++++-------
> >  tools/perf/util/parse-events.h          |  4 ++
> >  7 files changed, 84 insertions(+), 28 deletions(-)
> >
> > diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
> > index 9cc1c4a9dec4..30f5310373ca 100644
> > --- a/tools/perf/arch/powerpc/util/kvm-stat.c
> > +++ b/tools/perf/arch/powerpc/util/kvm-stat.c
> > @@ -113,10 +113,15 @@ static int is_tracepoint_available(const char *str, struct evlist *evlist)
> >       struct parse_events_error err;
> >       int ret;
> >
> > -     err.str = NULL;
> > +     bzero(&err, sizeof(err));
> >       ret = parse_events(evlist, str, &err);
> > -     if (err.str)
> > +     if (err.str) {
> >               pr_err("%s : %s\n", str, err.str);
> > +             free(&err->str);
> > +             free(&err->help);
> > +             free(&err->first_str);
> > +             free(&err->first_help);
>
> it's used in other places, so it's better to put it in
> parse_events_error__exit or such..

Done, using parse_events_print_error like other callers. This may
affect the output on error.

Thanks,
Ian

> jirka
>
