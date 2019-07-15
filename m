Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5B7C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4E420C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2uJanJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfGOIPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:15:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33945 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfGOIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:15:12 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so32784805iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/4K6BJlwFivH7Ck0WyKZuYNHVyNBlGAg0jTOaxVGec=;
        b=t2uJanJrunb0Uuy0yhxSMKu6j/iphXKM8Z4f+DEMvY3/Rx3gc4O2PgEaVthRsFZTdQ
         BqM+lTQnkdXVDO28ZTVbzhQMXPRYdypFIo4uIYyYUNmENquYSh6hfRUke0PNFK92tZRO
         60YiVpGsgJueKZeLxI+039nXiHhsdjG3vv7PPWeGRFCKeHckYxahA1gUSOb4xnHmSmHT
         Q1PPuLAT1QActFlRSHPR13lbA+/6w5qFsfLS+5XZcqDC5ple3cAujbr0n6tXRPekLxre
         72Qa8JD6Bwscq9p+KiOLgYTs2KSKEUJLKF0wjctq9c9Bmh3zOR2H1bNTyAt5V/hZqwWL
         OLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/4K6BJlwFivH7Ck0WyKZuYNHVyNBlGAg0jTOaxVGec=;
        b=O34O/B8aCQWF9gG6ZH5b+Zux2YcqFmk4//IR289nKwfZe6FRBGY5PJMkAiEmHcuZqB
         pevUnui5h3LQgwgrZv7XqerD1sRvcQdBvH8gpWeZLS9mglTTjQCOkY+X+nHUCIExKhoi
         vb1P6t7acH5FJih4uyQXy1mtFQhwd5ylKrH3sB32BZJ/jdPtG9SF/19bc7Jf5mt4ettV
         emNYJ1vyau7wwrMzdT5RNi1584N7u0j0KmRhhJDV3/gGW2urpCPo2cqYnVqeLW7rEzpd
         jI6MgCBizoYpDJQPJcP22aKpEs8ixOp78zdoTaJkR+D+koQhJ4Z/tHGvUrtGxDs7kmQz
         T0Kw==
X-Gm-Message-State: APjAAAWirGfwtFm5OH0FDMMSpVF/wGwWRoMBDGrad9sKwWgr5jM+XhpQ
        ortO/yAh7lFusEKMIUL7f0axpsfA8b+uYkwsoGaGlA==
X-Google-Smtp-Source: APXvYqyuWdfTit/8FMurTyyFeufwY1doN8ppaCij/ekUqnJLnNRo5mHlUMXqsQkCRuCkuFC/sgGoq0ccoQ/YsIl9tjs=
X-Received: by 2002:a02:5a02:: with SMTP id v2mr25578264jaa.124.1563178511096;
 Mon, 15 Jul 2019 01:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190710204540.176495-1-nums@google.com> <20190714204432.GA8120@krava>
 <20190714205505.GB8120@krava> <CABPqkBSq35HZVk2CNi8xy9j7eb3EWRXSdgPKd+fmv2XaKPjOqA@mail.gmail.com>
 <20190715075912.GA2821@krava>
In-Reply-To: <20190715075912.GA2821@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 15 Jul 2019 01:14:59 -0700
Message-ID: <CABPqkBR=arE==2H2H0t1uAU2aTgPOr6Yucgh16J0rKughf_=CQ@mail.gmail.com>
Subject: Re: [PATCH] Fix perf stat repeat segfault
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, mbd@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 12:59 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sun, Jul 14, 2019 at 02:36:42PM -0700, Stephane Eranian wrote:
> > On Sun, Jul 14, 2019 at 1:55 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Sun, Jul 14, 2019 at 10:44:36PM +0200, Jiri Olsa wrote:
> > > > On Wed, Jul 10, 2019 at 01:45:40PM -0700, Numfor Mbiziwo-Tiapo wrote:
> > > > > When perf stat is called with event groups and the repeat option,
> > > > > a segfault occurs because the cpu ids are stored on each iteration
> > > > > of the repeat, when they should only be stored on the first iteration,
> > > > > which causes a buffer overflow.
> > > > >
> > > > > This can be replicated by running (from the tip directory):
> > > > >
> > > > > make -C tools/perf
> > > > >
> > > > > then running:
> > > > >
> > > > > tools/perf/perf stat -e '{cycles,instructions}' -r 10 ls
> > > > >
> > > > > Since run_idx keeps track of the current iteration of the repeat,
> > > > > only storing the cpu ids on the first iteration (when run_idx < 1)
> > > > > fixes this issue.
> > > > >
> > > > > Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> > > > > ---
> > > > >  tools/perf/builtin-stat.c | 7 ++++---
> > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > > > index 63a3afc7f32b..92d6694367e4 100644
> > > > > --- a/tools/perf/builtin-stat.c
> > > > > +++ b/tools/perf/builtin-stat.c
> > > > > @@ -378,9 +378,10 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
> > > > >     workload_exec_errno = info->si_value.sival_int;
> > > > >  }
> > > > >
> > > > > -static bool perf_evsel__should_store_id(struct perf_evsel *counter)
> > > > > +static bool perf_evsel__should_store_id(struct perf_evsel *counter, int run_idx)
> > > > >  {
> > > > > -   return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
> > > > > +   return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID
> > > > > +           && run_idx < 1;
> > > >
> > > > we create counters for every iteration, so this can't be
> > > > based on iteration
> > > >
> > > > I think that's just a workaround for memory corruption,
> > > > that's happening for repeating groupped events stats,
> > > > I'll check on this
> > >
> > > how about something like this? we did not cleanup
> > > ids on evlist close, so it kept on raising and
> > > causing corruption in next iterations
> > >
> > not sure, that would realloc on each iteration of the repeats.
>
> well, we need new ids, because we create new events every iteration
>
If you recreate them, then agreed.
It is not clear to me why you need ids when not running is STAT_RECORD mode.

> jirka
>
> >
> > >
> > > jirka
> > >
> > >
> > > ---
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index ebb46da4dfe5..52459dd5ad0c 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -1291,6 +1291,7 @@ static void perf_evsel__free_id(struct perf_evsel *evsel)
> > >         xyarray__delete(evsel->sample_id);
> > >         evsel->sample_id = NULL;
> > >         zfree(&evsel->id);
> > > +       evsel->ids = 0;
> > >  }
> > >
> > >  static void perf_evsel__free_config_terms(struct perf_evsel *evsel)
> > > @@ -2077,6 +2078,7 @@ void perf_evsel__close(struct perf_evsel *evsel)
> > >
> > >         perf_evsel__close_fd(evsel);
> > >         perf_evsel__free_fd(evsel);
> > > +       perf_evsel__free_id(evsel);
> > >  }
> > >
> > >  int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
