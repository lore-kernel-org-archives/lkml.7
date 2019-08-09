Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F2DC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4CC2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+jVToaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437007AbfHIQE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:04:26 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:36261 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfHIQE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:04:26 -0400
Received: by mail-qk1-f177.google.com with SMTP id g18so754963qkl.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2PJLO8mzX7P8JmLFdEoCg9GN+XpWzpxzeTDvlNuxKhk=;
        b=g+jVToaKi0qrneBdCfE4DOIb9yCwOEXaZAGKhucWtFOqg8JL8Tj+wVMGFXi9F51cNL
         2ikazQ/A/2QpFYXn35Pk4UKPpFmTjTZbqbSxv+pFF4Q7NnbXGVxg+DdDtJffbi+w1RYr
         qowRR2eHRkKWZ3J+1WjdLkHggbeeGqsEQMKQH8kVlFJ2zSnFQUYWzPvnXbxV1eOU/XYM
         HgomxI3h2UB4eD6VlNE3+faw5m9SFv2OHlzckoTopgv0WIe8/0DwrvPQuvwZSv+bV5Tw
         SMPyF2u8usIXtG86mn8pd2fK9Y4dIXpIJDo9ghz2ScNaR/FQ4v0my4BCyfjCj3htv3Cv
         HZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2PJLO8mzX7P8JmLFdEoCg9GN+XpWzpxzeTDvlNuxKhk=;
        b=JzLlgCvOxAJwT2GEElX4MtXC0DFO3EVPf4ZatSHFwK/RHl0n4GoBEQxNW1Itk1V+nq
         aTLC2+iJSzqs/laWXCdSm13exZ9zX5tFS6neyIkGmblrt6BB0bgE0PF5ENflS7Vn706B
         Dzwj45+V9M5S81bm40mXxexFMbj9UlG5sdEDElIXq4wFiVggmLe0tIt1lx7VhTHM2aQr
         7f8hwKkmbVLEHX9oc/O6fIeoa8Yg8FbFlPF/TpNXJroGOBpWyux7/CyFvp+lbs08nSe7
         41ph25Vx+tBcCSpGqkXmdW+EM8Dmo3ikKf7vujGckj5Wa1tAGAx4E8vxbY6dXEyVMTyL
         vTOw==
X-Gm-Message-State: APjAAAV0Z2BBSg/Vezmym9xMVJLnpHvxsDLZd6bs9lkoYnPtzN45vwQ1
        ri3W6KmDQtVgROfQCPZGmcY=
X-Google-Smtp-Source: APXvYqwjQI+9OITGBLKxSuTq8iauyvURpDO3C7gjrRT58S6vzBVIDgko1oRvRpBs+vOQ3BMN6FkhcA==
X-Received: by 2002:ae9:ed94:: with SMTP id c142mr6800596qkg.70.1565366664590;
        Fri, 09 Aug 2019 09:04:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id f26sm53337367qtf.44.2019.08.09.09.04.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 09:04:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B120940340; Fri,  9 Aug 2019 13:04:21 -0300 (-03)
Date:   Fri, 9 Aug 2019 13:04:21 -0300
To:     "Hunter, Adrian" <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] perf_sample_id::idx
Message-ID: <20190809160421.GB9280@kernel.org>
References: <20190809092736.GA9377@krava>
 <363DA0ED52042842948283D2FC38E4649C5B1DB0@IRSMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363DA0ED52042842948283D2FC38E4649C5B1DB0@IRSMSX106.ger.corp.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 09, 2019 at 03:20:14PM +0000, Hunter, Adrian escreveu:

> It will be used for AUX area sampling.  A sample will have AUX area
> data that will be queued for decoding, where there are separate queues
> for each CPU (per-cpu tracing) or task (per-thread tracing).  The
> sample ID can be used to lookup 'idx' which is effectively the queue
> number.

Would be good to have this as a comment in the perf_sample_id struct
definition :-)

- Arnaldo
 
> > -----Original Message-----
> > From: Jiri Olsa [mailto:jolsa@redhat.com]
> > Sent: Friday, August 9, 2019 12:28 PM
> > To: Hunter, Adrian <adrian.hunter@intel.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>; Ingo Molnar
> > <mingo@kernel.org>; Namhyung Kim <namhyung@kernel.org>; Alexander
> > Shishkin <alexander.shishkin@linux.intel.com>; Peter Zijlstra
> > <a.p.zijlstra@chello.nl>; Michael Petlan <mpetlan@redhat.com>; linux-
> > kernel@vger.kernel.org
> > Subject: [RFC] perf_sample_id::idx
> > 
> > hi,
> > what's the perf_sample_id::idx for? It was added in here:
> >   3c659eedada2 perf tools: Add id index
> > 
> > but I dont see any practical usage of it in the sources, when I remove it like
> > below, I get clean build
> > 
> > any idea?
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h index
> > 70841d115349..24b90f68d616 100644
> > --- a/tools/perf/util/event.h
> > +++ b/tools/perf/util/event.h
> > @@ -498,7 +498,7 @@ struct tracing_data_event {
> > 
> >  struct id_index_entry {
> >  	u64 id;
> > -	u64 idx;
> > +	u64 idx; /* deprecated */
> >  	u64 cpu;
> >  	u64 tid;
> >  };
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c index
> > c4489a1ad6bc..e55133cacb64 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -519,11 +519,11 @@ int perf_evlist__id_add_fd(struct evlist *evlist,  }
> > 
> >  static void perf_evlist__set_sid_idx(struct evlist *evlist,
> > -				     struct evsel *evsel, int idx, int cpu,
> > +				     struct evsel *evsel, int cpu,
> >  				     int thread)
> >  {
> >  	struct perf_sample_id *sid = SID(evsel, cpu, thread);
> > -	sid->idx = idx;
> > +
> >  	if (evlist->core.cpus && cpu >= 0)
> >  		sid->cpu = evlist->core.cpus->map[cpu];
> >  	else
> > @@ -795,8 +795,7 @@ static int perf_evlist__mmap_per_evsel(struct evlist
> > *evlist, int idx,
> >  			if (perf_evlist__id_add_fd(evlist, evsel, cpu, thread,
> >  						   fd) < 0)
> >  				return -1;
> > -			perf_evlist__set_sid_idx(evlist, evsel, idx, cpu,
> > -						 thread);
> > +			perf_evlist__set_sid_idx(evlist, evsel, cpu, thread);
> >  		}
> >  	}
> > 
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h index
> > 3cf35aa782b9..b9d864933d75 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -23,7 +23,6 @@ struct perf_sample_id {
> >  	struct hlist_node 	node;
> >  	u64		 	id;
> >  	struct evsel		*evsel;
> > -	int			idx;
> >  	int			cpu;
> >  	pid_t			tid;
> > 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c index
> > b9fe71d11bf6..2642d60aa875 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -2394,7 +2394,6 @@ int perf_event__process_id_index(struct
> > perf_session *session,
> >  		sid = perf_evlist__id2sid(evlist, e->id);
> >  		if (!sid)
> >  			return -ENOENT;
> > -		sid->idx = e->idx;
> >  		sid->cpu = e->cpu;
> >  		sid->tid = e->tid;
> >  	}
> > @@ -2454,7 +2453,7 @@ int perf_event__synthesize_id_index(struct
> > perf_tool *tool,
> >  				return -ENOENT;
> >  			}
> > 
> > -			e->idx = sid->idx;
> > +			e->idx = -1;
> >  			e->cpu = sid->cpu;
> >  			e->tid = sid->tid;
> >  		}

-- 

- Arnaldo
