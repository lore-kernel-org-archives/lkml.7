Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757BFC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3EA21655
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfGOH7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 03:59:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfGOH7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 03:59:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8893D3DD47;
        Mon, 15 Jul 2019 07:59:16 +0000 (UTC)
Received: from krava (unknown [10.40.205.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id D441E6090E;
        Mon, 15 Jul 2019 07:59:13 +0000 (UTC)
Date:   Mon, 15 Jul 2019 09:59:12 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, mbd@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] Fix perf stat repeat segfault
Message-ID: <20190715075912.GA2821@krava>
References: <20190710204540.176495-1-nums@google.com>
 <20190714204432.GA8120@krava>
 <20190714205505.GB8120@krava>
 <CABPqkBSq35HZVk2CNi8xy9j7eb3EWRXSdgPKd+fmv2XaKPjOqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSq35HZVk2CNi8xy9j7eb3EWRXSdgPKd+fmv2XaKPjOqA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 15 Jul 2019 07:59:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 02:36:42PM -0700, Stephane Eranian wrote:
> On Sun, Jul 14, 2019 at 1:55 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Sun, Jul 14, 2019 at 10:44:36PM +0200, Jiri Olsa wrote:
> > > On Wed, Jul 10, 2019 at 01:45:40PM -0700, Numfor Mbiziwo-Tiapo wrote:
> > > > When perf stat is called with event groups and the repeat option,
> > > > a segfault occurs because the cpu ids are stored on each iteration
> > > > of the repeat, when they should only be stored on the first iteration,
> > > > which causes a buffer overflow.
> > > >
> > > > This can be replicated by running (from the tip directory):
> > > >
> > > > make -C tools/perf
> > > >
> > > > then running:
> > > >
> > > > tools/perf/perf stat -e '{cycles,instructions}' -r 10 ls
> > > >
> > > > Since run_idx keeps track of the current iteration of the repeat,
> > > > only storing the cpu ids on the first iteration (when run_idx < 1)
> > > > fixes this issue.
> > > >
> > > > Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> > > > ---
> > > >  tools/perf/builtin-stat.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > > index 63a3afc7f32b..92d6694367e4 100644
> > > > --- a/tools/perf/builtin-stat.c
> > > > +++ b/tools/perf/builtin-stat.c
> > > > @@ -378,9 +378,10 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
> > > >     workload_exec_errno = info->si_value.sival_int;
> > > >  }
> > > >
> > > > -static bool perf_evsel__should_store_id(struct perf_evsel *counter)
> > > > +static bool perf_evsel__should_store_id(struct perf_evsel *counter, int run_idx)
> > > >  {
> > > > -   return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
> > > > +   return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID
> > > > +           && run_idx < 1;
> > >
> > > we create counters for every iteration, so this can't be
> > > based on iteration
> > >
> > > I think that's just a workaround for memory corruption,
> > > that's happening for repeating groupped events stats,
> > > I'll check on this
> >
> > how about something like this? we did not cleanup
> > ids on evlist close, so it kept on raising and
> > causing corruption in next iterations
> >
> not sure, that would realloc on each iteration of the repeats.

well, we need new ids, because we create new events every iteration

jirka

> 
> >
> > jirka
> >
> >
> > ---
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index ebb46da4dfe5..52459dd5ad0c 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1291,6 +1291,7 @@ static void perf_evsel__free_id(struct perf_evsel *evsel)
> >         xyarray__delete(evsel->sample_id);
> >         evsel->sample_id = NULL;
> >         zfree(&evsel->id);
> > +       evsel->ids = 0;
> >  }
> >
> >  static void perf_evsel__free_config_terms(struct perf_evsel *evsel)
> > @@ -2077,6 +2078,7 @@ void perf_evsel__close(struct perf_evsel *evsel)
> >
> >         perf_evsel__close_fd(evsel);
> >         perf_evsel__free_fd(evsel);
> > +       perf_evsel__free_id(evsel);
> >  }
> >
> >  int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
