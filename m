Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D1CECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB21F2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC9EYEBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbfJNQXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:23:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33376 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbfJNQXo (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:23:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id r5so26284469qtd.0
        for <Linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hAYFqk/fFu/i8UZEoHch6mkzHQPlY6wNG+sE5V14CB4=;
        b=fC9EYEBeSqDv7q3Nxyj6jTbHqRWpPSelwcEsVAfXL+clChq6e2SWzGqlCCqdy5MFkg
         BW/yoTkNgVWIKLgNUlblpfbgBjiH/3AqhT1WSJQRTwWZTFyTHjkELeBthQPhxPHYBXRl
         GL31EfDKTaNNrzOkUTtbjMM5b0Ykck3tQRadMWmt+FsteUofywj54LYjlB29TAO7/TDX
         696AYnOmsvjq7TG6pLlKjbSK99eGvCW/YWmdhM8M4/YhhFg84RS407sG+tBbNOVwJ8TP
         2iVMWvzsqGAf41BZJmaDOIJhDCwS6kvifaVlfYxvqvx+5FeIl17jtpq4d1R1hVGExfQj
         Rwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hAYFqk/fFu/i8UZEoHch6mkzHQPlY6wNG+sE5V14CB4=;
        b=AP2yBgU0F7O4jtI/0pxgO+VqWUS6JzFghnDwqIlmH32kcsiDSHARXmbe8cgMsfn4Hz
         kX3oDUHcqdFdG358WQ31qbybuP+6HJC09EiDyF1ynx/IEmDOttahk9R1VpKRiLQtMYtk
         G1fT7E1uwthk5Lcaw3FtImbQE92Hm3Wu7A9AI95kbaiMpvHyqOlgwVBlOvtdYQJS4N0Y
         WCW92w6+ZKqbq6y/l61/Qu6O6ALakdJIDISjRsU4AjM9PKwsZS1zsdQIA18rFdhR1Bwn
         WShxN8l96xL/VrfJMwEnp3pV/hYhEw96c0/BUglM7cCfP9ZCm6LFCkzXb47yFB7y0MHI
         e72w==
X-Gm-Message-State: APjAAAUysjc13xeMuGkl7UcmMYi2hYvSMW6uFtZ+lqNtLa6Y5AM+Ex0w
        V23wO3nV7gDTShDKctuF2kE=
X-Google-Smtp-Source: APXvYqwT3YJQ7qV2937oAnFSONUKkZlXvnFyv7dbUJcdu7ZOJ0TpUzI513RcNbx/cjNgyHgcqrXLhQ==
X-Received: by 2002:ac8:334e:: with SMTP id u14mr34074138qta.120.1571070222860;
        Mon, 14 Oct 2019 09:23:42 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id r19sm9629934qte.63.2019.10.14.09.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 09:23:41 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5FD064DD66; Mon, 14 Oct 2019 13:23:39 -0300 (-03)
Date:   Mon, 14 Oct 2019 13:23:39 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Support --all-kernel/--all-user
Message-ID: <20191014162339.GN19627@kernel.org>
References: <20191011050545.3899-1-yao.jin@linux.intel.com>
 <20191014144208.GC9700@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014144208.GC9700@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 14, 2019 at 04:42:08PM +0200, Jiri Olsa escreveu:
> On Fri, Oct 11, 2019 at 01:05:45PM +0800, Jin Yao wrote:
> > perf record has supported --all-kernel / --all-user to configure all
> > used events to run in kernel space or run in user space. But perf
> > stat doesn't support these options.
> > 
> > It would be useful to support these options in perf-stat too to keep
> > the same semantics.
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

What happens if one asks for both? From the patch only the --all-kernel
will stick, right? Is that the behaviour for 'perf record'? Lemme see,
as I recall having this discussion at that time...

Yeah, same thing, and looking at that I wonder why we dong use
perf_evsel__config() in 'perf stat'...

Ok, I'm going to apply it.
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/Documentation/perf-stat.txt |  6 ++++++
> >  tools/perf/builtin-stat.c              |  6 ++++++
> >  tools/perf/util/stat.c                 | 10 ++++++++++
> >  tools/perf/util/stat.h                 |  2 ++
> >  4 files changed, 24 insertions(+)
> > 
> > diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> > index 930c51c01201..a9af4e440e80 100644
> > --- a/tools/perf/Documentation/perf-stat.txt
> > +++ b/tools/perf/Documentation/perf-stat.txt
> > @@ -323,6 +323,12 @@ The output is SMI cycles%, equals to (aperf - unhalted core cycles) / aperf
> >  
> >  Users who wants to get the actual value can apply --no-metric-only.
> >  
> > +--all-kernel::
> > +Configure all used events to run in kernel space.
> > +
> > +--all-user::
> > +Configure all used events to run in user space.
> > +
> >  EXAMPLES
> >  --------
> >  
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 468fc49420ce..c88d4e118409 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -803,6 +803,12 @@ static struct option stat_options[] = {
> >  	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
> >  		     "monitor specified metrics or metric groups (separated by ,)",
> >  		     parse_metric_groups),
> > +	OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
> > +			 "Configure all used events to run in kernel space.",
> > +			 PARSE_OPT_EXCLUSIVE),
> > +	OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
> > +			 "Configure all used events to run in user space.",
> > +			 PARSE_OPT_EXCLUSIVE),
> >  	OPT_END()
> >  };
> >  
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index ebdd130557fb..6822e4ffe224 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -490,6 +490,16 @@ int create_perf_stat_counter(struct evsel *evsel,
> >  	if (config->identifier)
> >  		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
> >  
> > +	if (config->all_user) {
> > +		attr->exclude_kernel = 1;
> > +		attr->exclude_user   = 0;
> > +	}
> > +
> > +	if (config->all_kernel) {
> > +		attr->exclude_kernel = 0;
> > +		attr->exclude_user   = 1;
> > +	}
> > +
> >  	/*
> >  	 * Disabling all counters initially, they will be enabled
> >  	 * either manually by us or by kernel via enable_on_exec
> > diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> > index edbeb2f63e8d..081c4a5113c6 100644
> > --- a/tools/perf/util/stat.h
> > +++ b/tools/perf/util/stat.h
> > @@ -106,6 +106,8 @@ struct perf_stat_config {
> >  	bool			 big_num;
> >  	bool			 no_merge;
> >  	bool			 walltime_run_table;
> > +	bool			 all_kernel;
> > +	bool			 all_user;
> >  	FILE			*output;
> >  	unsigned int		 interval;
> >  	unsigned int		 timeout;
> > -- 
> > 2.17.1
> > 

-- 

- Arnaldo
