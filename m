Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE507C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FC520854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgXUXhOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbfJOPL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:11:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43243 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJOPL0 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:11:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id t20so25702897qtr.10
        for <Linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+GV7lls91NbEz69rkgCFKrFFp0YlWtB12S3sy3CsNSc=;
        b=NgXUXhOdQKUuLgTMppjJoXe+DIgNYmfq7CkO9w8XBx/HzuDLVt+aR8GyRkyiCj4bWP
         9eR+6c9gwaUH/iR53eBL9PZ8kQruxgcD8WbvgvXHsw5RuM8Bv1tulPcsXwTCyUKaWUGP
         aJP1O2hypFsiuAQ+sbBqStgro5VYaHeJ94pA5UXpjgfd2uyIltUEfb3KObB6bJHU0mJ2
         42qMPHoykxb/dYRvfHRkBnk3q5mh9ly8GEAbrMlwbaZ3Ot9IyJgVI1OLVrhrIgddjPse
         91m7Y4FQBkW4SlhTK98/nhaPGpGRyDovAlKXwT4EffAVzV2MYA9mnXnBmGDIpXF0WxqG
         kGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+GV7lls91NbEz69rkgCFKrFFp0YlWtB12S3sy3CsNSc=;
        b=heSqtqzu24kJaNxyyUeZyOOn3Iho0BBSmO2+J1lwutR/w+GDhArF6pURVHbFdjhuDy
         pU8w+HKGLwtOpoKTadKacZRsjlIniO5B54+12GbxI7H9sW8ju2LT8qdwiqrRVHsySxHG
         ykUaCVpeA6ucuwS43686hSiMVgS/H874T8aLtwpO8muiahSAa+2+4kigUgdr60Pf0b/3
         Y1MTxdpDHYewv1lC+u6uK+Z5z9p3KXfpofxi02JLA7rFp6S3/ntaUfyf2vV7gzlFgp8v
         DvyooQAtsk880mp6Y8VNsxx0yPgmE83CXtcKDah28EMrmxzsl5Ea2j2zlWlESaMk7hIG
         JhkA==
X-Gm-Message-State: APjAAAUXCeUFddsEjnKXoHamZQQkM2aYWjPHF3w3xyofOV7y6UHvLthT
        r5OvjnhRvl6MldhiEyreY3w=
X-Google-Smtp-Source: APXvYqxE1J64PreUzsPx4hlYCPNl3d94xuBJUPPm+b35UVPT4r7jm09Iq7pSLzr4lSiJ7OnchHvBNg==
X-Received: by 2002:ac8:363c:: with SMTP id m57mr39128185qtb.290.1571152284746;
        Tue, 15 Oct 2019 08:11:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id m63sm10256991qkc.72.2019.10.15.08.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:11:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D72F4DD66; Tue, 15 Oct 2019 12:11:21 -0300 (-03)
Date:   Tue, 15 Oct 2019 12:11:21 -0300
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Support --all-kernel/--all-user
Message-ID: <20191015151121.GD25820@kernel.org>
References: <20191011050545.3899-1-yao.jin@linux.intel.com>
 <20191014144208.GC9700@krava>
 <20191014162339.GN19627@kernel.org>
 <2672b8ea-06f2-d828-3da0-da0e59f2eb9d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2672b8ea-06f2-d828-3da0-da0e59f2eb9d@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 15, 2019 at 09:57:33AM +0800, Jin, Yao escreveu:
> 
> 
> On 10/15/2019 12:23 AM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Oct 14, 2019 at 04:42:08PM +0200, Jiri Olsa escreveu:
> > > On Fri, Oct 11, 2019 at 01:05:45PM +0800, Jin Yao wrote:
> > > > perf record has supported --all-kernel / --all-user to configure all
> > > > used events to run in kernel space or run in user space. But perf
> > > > stat doesn't support these options.
> > > > 
> > > > It would be useful to support these options in perf-stat too to keep
> > > > the same semantics.
> > > > 
> > > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > 
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > What happens if one asks for both? From the patch only the --all-kernel
> > will stick, right? Is that the behaviour for 'perf record'? Lemme see,
> > as I recall having this discussion at that time...
> > 
> > Yeah, same thing, and looking at that I wonder why we dong use
> > perf_evsel__config() in 'perf stat'...
> > 
> > Ok, I'm going to apply it.
> > 
> 
> Hi Arnaldo,
> 
> If we specify both, we will see the error.

Cool, I looked for this code and couldn't quickly spot it nor tried
running with both to see what happened, my bad, thanks for replying and
making sure that that is the behaviour.
 
> root@kbl:~# perf stat --all-kernel --all-user -a -- sleep 1
>  Error: option `all-user' cannot be used with all-kernel
> 
> root@kbl:~# perf record --all-kernel --all-user -a -- sleep 1
>  Error: option `all-user' cannot be used with all-kernel
> 
> For why I don't set them in perf_evsel__config, because perf_evsel__config
> is called in record but not called in stat.

Ok, at some point we should try and check if we could make 'perf stat'
use perf_evsel__config(), even if we have to separate what is shared
into some __perf_evsel__config() that then gets called by 'perf stat'
while the preexisting perf_evsel__config() calls it and does things
that don't make sense for 'perf stat'.
 
> Thanks for reviewing and applying this patch.

You're welcome!

- Arnaldo
 
> Thanks
> Jin Yao
> 
> > > thanks,
> > > jirka
> > > 
> > > > ---
> > > >   tools/perf/Documentation/perf-stat.txt |  6 ++++++
> > > >   tools/perf/builtin-stat.c              |  6 ++++++
> > > >   tools/perf/util/stat.c                 | 10 ++++++++++
> > > >   tools/perf/util/stat.h                 |  2 ++
> > > >   4 files changed, 24 insertions(+)
> > > > 
> > > > diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> > > > index 930c51c01201..a9af4e440e80 100644
> > > > --- a/tools/perf/Documentation/perf-stat.txt
> > > > +++ b/tools/perf/Documentation/perf-stat.txt
> > > > @@ -323,6 +323,12 @@ The output is SMI cycles%, equals to (aperf - unhalted core cycles) / aperf
> > > >   Users who wants to get the actual value can apply --no-metric-only.
> > > > +--all-kernel::
> > > > +Configure all used events to run in kernel space.
> > > > +
> > > > +--all-user::
> > > > +Configure all used events to run in user space.
> > > > +
> > > >   EXAMPLES
> > > >   --------
> > > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > > index 468fc49420ce..c88d4e118409 100644
> > > > --- a/tools/perf/builtin-stat.c
> > > > +++ b/tools/perf/builtin-stat.c
> > > > @@ -803,6 +803,12 @@ static struct option stat_options[] = {
> > > >   	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
> > > >   		     "monitor specified metrics or metric groups (separated by ,)",
> > > >   		     parse_metric_groups),
> > > > +	OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
> > > > +			 "Configure all used events to run in kernel space.",
> > > > +			 PARSE_OPT_EXCLUSIVE),
> > > > +	OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
> > > > +			 "Configure all used events to run in user space.",
> > > > +			 PARSE_OPT_EXCLUSIVE),
> > > >   	OPT_END()
> > > >   };
> > > > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > > > index ebdd130557fb..6822e4ffe224 100644
> > > > --- a/tools/perf/util/stat.c
> > > > +++ b/tools/perf/util/stat.c
> > > > @@ -490,6 +490,16 @@ int create_perf_stat_counter(struct evsel *evsel,
> > > >   	if (config->identifier)
> > > >   		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
> > > > +	if (config->all_user) {
> > > > +		attr->exclude_kernel = 1;
> > > > +		attr->exclude_user   = 0;
> > > > +	}
> > > > +
> > > > +	if (config->all_kernel) {
> > > > +		attr->exclude_kernel = 0;
> > > > +		attr->exclude_user   = 1;
> > > > +	}
> > > > +
> > > >   	/*
> > > >   	 * Disabling all counters initially, they will be enabled
> > > >   	 * either manually by us or by kernel via enable_on_exec
> > > > diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> > > > index edbeb2f63e8d..081c4a5113c6 100644
> > > > --- a/tools/perf/util/stat.h
> > > > +++ b/tools/perf/util/stat.h
> > > > @@ -106,6 +106,8 @@ struct perf_stat_config {
> > > >   	bool			 big_num;
> > > >   	bool			 no_merge;
> > > >   	bool			 walltime_run_table;
> > > > +	bool			 all_kernel;
> > > > +	bool			 all_user;
> > > >   	FILE			*output;
> > > >   	unsigned int		 interval;
> > > >   	unsigned int		 timeout;
> > > > -- 
> > > > 2.17.1
> > > > 
> > 

-- 

- Arnaldo
