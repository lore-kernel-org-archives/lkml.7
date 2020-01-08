Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CE3C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0889820673
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCC1imwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgAHKWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:22:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60764 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726319AbgAHKWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578478952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4IZguadyHZ/WkeMc8C8Bu6CeTaifSwdzjNVYgKam9oQ=;
        b=cCC1imwp6VyEUS73yeLbw497lrnxOH6VfHnNdhwfFKFKdAXrtr2QrvB2NSVKEw/Uv31PF9
        mI5849aCQWWlf8aKC/MDNo50FcvyPKEdXdwxPcQhQlISzIMZ3MAVQ6ZMtirMBTKloQV9O3
        WNi+M5JhOOoZFirTJpx3HaGiV4WyYE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-eRM59uhzMSq5XhFjcMCo7Q-1; Wed, 08 Jan 2020 05:22:28 -0500
X-MC-Unique: eRM59uhzMSq5XhFjcMCo7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A72A310054E3;
        Wed,  8 Jan 2020 10:22:26 +0000 (UTC)
Received: from krava (ovpn-205-199.brq.redhat.com [10.40.205.199])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 335DB86C56;
        Wed,  8 Jan 2020 10:22:18 +0000 (UTC)
Date:   Wed, 8 Jan 2020 11:22:12 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v3] perf parse: Copy string to perf_evsel_config_term
Message-ID: <20200108102212.GA360164@krava>
References: <20200107120310.9632-1-leo.yan@linaro.org>
 <CANLsYkzs67NXpszueKTM5y05KrOUf-yaphs3Y7yC8P2sNz3YwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkzs67NXpszueKTM5y05KrOUf-yaphs3Y7yC8P2sNz3YwQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 02:45:27PM -0700, Mathieu Poirier wrote:
> Hi Leo,
> 
> On Tue, 7 Jan 2020 at 05:03, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > perf with CoreSight fails to record trace data with command:
> >
> >   perf record -e cs_etm/@tmc_etr0/u --per-thread ls
> >   failed to set sink "" on event cs_etm/@tmc_etr0/u with 21 (Is a
> >   directory)/perf/
> >
> > This failure is root caused with the commit 1dc925568f01 ("perf
> > parse: Add a deep delete for parse event terms").
> >
> > The log shows, cs_etm fails to parse the sink attribution; cs_etm event
> > relies on the event configuration to pass sink name, but the event
> > specific configuration data cannot be passed properly with flow:
> >
> >   get_config_terms()
> >     ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
> >       __t->val.drv_cfg = term->val.str;
> >         `> __t->val.drv_cfg is assigned to term->val.str;
> >
> >   parse_events_terms__purge()
> >     parse_events_term__delete()
> >       zfree(&term->val.str);
> >         `> term->val.str is freed and assigned to NULL pointer;
> >
> >   cs_etm_set_sink_attr()
> >     sink = __t->val.drv_cfg;
> >       `> sink string has been freed.
> >
> > To fix this issue, in the function get_config_terms(), this patch
> > changes from directly assignment pointer value for the strings to
> > use strdup() for allocation a new duplicate string for the cases:
> >
> >   perf_evsel_config_term::val.callgraph
> >   perf_evsel_config_term::val.branch
> >   perf_evsel_config_term::val.drv_cfg.
> >
> > In the data structure perf_evsel_config_term, this patch adds
> > 'char *str' pointer in the val union and new field 'free_str'.  When the
> > union is used as a string pointer, 'free_str' will be set to true;
> > finally it's flag to tell perf_evsel__free_config_terms() to free the
> > string with perf_evsel_config_term::val.str.
> 
> Many thanks for digging into this and stepping forward to provide a
> solution - it is much appreciated.
> 
> >
> > Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
> > Suggested-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/evsel.c        |  2 ++
> >  tools/perf/util/evsel_config.h |  2 ++
> >  tools/perf/util/parse-events.c | 56 +++++++++++++++++++++-------------
> >  3 files changed, 39 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index a69e64236120..ab9925cc1aa7 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1265,6 +1265,8 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
> >
> >         list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
> >                 list_del_init(&term->list);
> > +               if (term->free_str)
> > +                       free(term->val.str);
> 
> This will do the trick but we can definitely do better.
> 
> Part of his comments on V2, Jiri hinted that we should move to a
> common perf_evsel_config_term::str to replace {callgraph, drv_cfg,
> branch}, something that will work because we have
> perf_evsel_config_term::type.  That means  functions
> apply_config_terms() and cs_etm_set_sink_attr() need to be modified
> but the changes are quite small and well worth for the benefit they'll
> carry.
> 
> With that the above becomes neat and clean.

I wonder if there was some reason for keeping the variables
like that for every type and not just one per type as we did
'struct parse_events_term'

if the change is possible, the code would be cleaner, let's see ;-)

thanks,
jirka

