Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026D1C742D2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 21:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9ADE20838
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 21:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFgb0hy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfGNVgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 17:36:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39464 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfGNVgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 17:36:55 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so31101496ioh.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqXaW1SBlO4ypk862puJP9ZlK8OkDZ0/srasv2LX6t0=;
        b=ZFgb0hy1hkaeTSQUqs9lXyHsiFuWqx6gh5YP3fEJehzrLCR6MjEL8iwhOlwxoLXaEW
         zxQbfSLsBgWNCahrjfC3wIHCFDCnl4R+uQ7MavD0QD7Oyc/9m/jm/me38n1Ax9ovZ3pj
         WylOFqR/h9JbOmyLnIRleSRzv1sPFYbM/2iewLMAKddcxJtBv3cMZ7nORkUe+gBCqWpF
         Kiq1w9gf07CjTuDJNycwdWQQzln/Hm+zy+cjiegwrUeyWIw8LbjCjGUdBSLaCAircNuP
         PTvx9aJ+1CouE+xdDBk44bGi3UJwojeHFlBPLcXVzJJZBp8iRZAhYSV5CNtSH7iaPPKu
         +X2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqXaW1SBlO4ypk862puJP9ZlK8OkDZ0/srasv2LX6t0=;
        b=AOBbDIYPONc3IYLM5QaLgMetbyoW9MevCH7LaUZCfYO5AxcV+U5fGJBhtH/DQnUAt+
         XmsbifU0G5/knvMwSSOeN5Vn4/iepJCHbsj7Ioa2SvqDCwBaHT9p30Jp8TRV9wjMqlFE
         2RrFQ/dNN0+rNF2pUtu6QO6SFwGq/l7eRlvlURRpN7YlSAbrN+qBShkQupqOiSvGvMdX
         9KoTStt46qkpCbg2P3hPxkVoIe3DHfocLcEiTvoIjYAFr4Sz8kugNu4Ja2ydvVUjVaYK
         51D7C5VICYG8ZQreZv4CjMYRBP07POsYgZS7wyzTA+qFkxMByzEj8BmcwnUYxMg1wqVB
         7SRg==
X-Gm-Message-State: APjAAAWGh8MiNIhssAl63tajfnXkNPiPNl35SMCMchFhkEey+17F/mlV
        7KKH3hMteSm+j+qOFgs631tixg+QoA/uXFuYUDX+3g==
X-Google-Smtp-Source: APXvYqweDmi/vA4Qumwgo7rXlvxPWGv67GIKW7GqKyLfWKUhYrE0W4xIUOUBsJ5DjH4hY6oiObgFBgBp/im9HrPTQco=
X-Received: by 2002:a02:c646:: with SMTP id k6mr15220352jan.134.1563140213957;
 Sun, 14 Jul 2019 14:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190710204540.176495-1-nums@google.com> <20190714204432.GA8120@krava>
 <20190714205505.GB8120@krava>
In-Reply-To: <20190714205505.GB8120@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Sun, 14 Jul 2019 14:36:42 -0700
Message-ID: <CABPqkBSq35HZVk2CNi8xy9j7eb3EWRXSdgPKd+fmv2XaKPjOqA@mail.gmail.com>
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

On Sun, Jul 14, 2019 at 1:55 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sun, Jul 14, 2019 at 10:44:36PM +0200, Jiri Olsa wrote:
> > On Wed, Jul 10, 2019 at 01:45:40PM -0700, Numfor Mbiziwo-Tiapo wrote:
> > > When perf stat is called with event groups and the repeat option,
> > > a segfault occurs because the cpu ids are stored on each iteration
> > > of the repeat, when they should only be stored on the first iteration,
> > > which causes a buffer overflow.
> > >
> > > This can be replicated by running (from the tip directory):
> > >
> > > make -C tools/perf
> > >
> > > then running:
> > >
> > > tools/perf/perf stat -e '{cycles,instructions}' -r 10 ls
> > >
> > > Since run_idx keeps track of the current iteration of the repeat,
> > > only storing the cpu ids on the first iteration (when run_idx < 1)
> > > fixes this issue.
> > >
> > > Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> > > ---
> > >  tools/perf/builtin-stat.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 63a3afc7f32b..92d6694367e4 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -378,9 +378,10 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
> > >     workload_exec_errno = info->si_value.sival_int;
> > >  }
> > >
> > > -static bool perf_evsel__should_store_id(struct perf_evsel *counter)
> > > +static bool perf_evsel__should_store_id(struct perf_evsel *counter, int run_idx)
> > >  {
> > > -   return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
> > > +   return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID
> > > +           && run_idx < 1;
> >
> > we create counters for every iteration, so this can't be
> > based on iteration
> >
> > I think that's just a workaround for memory corruption,
> > that's happening for repeating groupped events stats,
> > I'll check on this
>
> how about something like this? we did not cleanup
> ids on evlist close, so it kept on raising and
> causing corruption in next iterations
>
not sure, that would realloc on each iteration of the repeats.

>
> jirka
>
>
> ---
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ebb46da4dfe5..52459dd5ad0c 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1291,6 +1291,7 @@ static void perf_evsel__free_id(struct perf_evsel *evsel)
>         xyarray__delete(evsel->sample_id);
>         evsel->sample_id = NULL;
>         zfree(&evsel->id);
> +       evsel->ids = 0;
>  }
>
>  static void perf_evsel__free_config_terms(struct perf_evsel *evsel)
> @@ -2077,6 +2078,7 @@ void perf_evsel__close(struct perf_evsel *evsel)
>
>         perf_evsel__close_fd(evsel);
>         perf_evsel__free_fd(evsel);
> +       perf_evsel__free_id(evsel);
>  }
>
>  int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
