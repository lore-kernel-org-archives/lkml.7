Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FF9C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94590205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUXDBnIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgAHNUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:20:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41008 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAHNUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:20:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id bd4so1124268plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 05:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v5QuWl/+PY9Q73jf1DmwSNtvySHIXxjomMZ599Y61vs=;
        b=QUXDBnIjggHMVJ1vjZpL/09PJRr5wQywtvlcmjwyKrqWWWGWiwU5NxbjeLnMyBAY9V
         g5SA+SUvHxX+SSscvqxP3XIX6+f/Aunh5tFRmsirpJNJiyg2gR79d2oHhzrbGVqTjtd4
         q1X6JSeYUKiYxYmh7BI9zzt7b2IaEWdYnBHfpjkh6o10WdHpuvCXMtmv/40VmC3N5d3x
         jwRP/woqdBple+tDNX4J2cdROe9K4g0pAdnR4KhXN/IabZbp9hPn70PW8fMbN3xMAnp5
         yV9J4pmZD3rGsAZfKMunsARQMl9gsX/VzJciQhfb5Y8bDtRAQd6dMvSRVDPOkKi1Xu8G
         WZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v5QuWl/+PY9Q73jf1DmwSNtvySHIXxjomMZ599Y61vs=;
        b=XcgC9HkYYzQ+XJ0rsMyhFE/Mr64X7KgY5bJidnoQIPCIN2uiTVc+bvJ65wQ5pip+Dz
         Bxk21E40VT7R6h0gENsHjVMkh+E/f2yKpOkhIzD8AxavxZDvHvRpFaix/zct7Lbsm2L/
         QxB7uZlgzLFgh7/rwwy07Ttr8ZB7q/O2fr2G/6+gl7x3vkcafmAkTEyifmaYbhssfr5e
         kM2iBEDTBkg2u1HE5a/REC3wil+D9qo3S7Kw7eMAN6p86WVDWHJ0t3CbW0OwviEgKkF8
         32ZRg0d626F0Fgygb/zNOc9JyNLqKLAWyRREaKPx6e8ZzZYr25HLcUN/OOjmUZvfqbbK
         O8DA==
X-Gm-Message-State: APjAAAWmUiqkzft4hqBTpOrzjx1d1JRiyKBeV5/qQlrWohclhKwdACsv
        il24FJsEjGDBS6mvDn5jfqh+Kw==
X-Google-Smtp-Source: APXvYqwFrVUBTFT4TH96PlM5QwpRRFO+v8oK7loC4BoRfqYnyP3sB0JkBhAwEEs5F1Iuf0FsWQk/lg==
X-Received: by 2002:a17:902:8bc6:: with SMTP id r6mr4105919plo.53.1578489641346;
        Wed, 08 Jan 2020 05:20:41 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id p185sm3669828pfg.61.2020.01.08.05.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 05:20:40 -0800 (PST)
Date:   Wed, 8 Jan 2020 21:20:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
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
Message-ID: <20200108132028.GC7797@leoy-ThinkPad-X240s>
References: <20200107120310.9632-1-leo.yan@linaro.org>
 <CANLsYkzs67NXpszueKTM5y05KrOUf-yaphs3Y7yC8P2sNz3YwQ@mail.gmail.com>
 <20200108102212.GA360164@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108102212.GA360164@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu, Jiri,

On Wed, Jan 08, 2020 at 11:22:12AM +0100, Jiri Olsa wrote:
> On Tue, Jan 07, 2020 at 02:45:27PM -0700, Mathieu Poirier wrote:

[...]

> > Many thanks for digging into this and stepping forward to provide a
> > solution - it is much appreciated.

My pleasure!

After think again, we do need to add CoreSight test into perf test
ASAP, thus we can pay attention for the failure at the early time.
This is another topic, let's fistly focus on resolve this issue.

> > > Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
> > > Suggested-by: Jiri Olsa <jolsa@kernel.org>
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/util/evsel.c        |  2 ++
> > >  tools/perf/util/evsel_config.h |  2 ++
> > >  tools/perf/util/parse-events.c | 56 +++++++++++++++++++++-------------
> > >  3 files changed, 39 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index a69e64236120..ab9925cc1aa7 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -1265,6 +1265,8 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
> > >
> > >         list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
> > >                 list_del_init(&term->list);
> > > +               if (term->free_str)
> > > +                       free(term->val.str);
> > 
> > This will do the trick but we can definitely do better.
> > 
> > Part of his comments on V2, Jiri hinted that we should move to a
> > common perf_evsel_config_term::str to replace {callgraph, drv_cfg,
> > branch}, something that will work because we have
> > perf_evsel_config_term::type.  That means  functions
> > apply_config_terms() and cs_etm_set_sink_attr() need to be modified
> > but the changes are quite small and well worth for the benefit they'll
> > carry.
> > 
> > With that the above becomes neat and clean.
> 
> I wonder if there was some reason for keeping the variables
> like that for every type and not just one per type as we did
> 'struct parse_events_term'
> 
> if the change is possible, the code would be cleaner, let's see ;-)

Thanks for the suggestion, I hope to do right thing in next spin :)

I tried to only use val.num and val.str in perf_evsel_config_term in
my local code, same with the struct parse_events_term, it does work and
the effort is not big.  Will send out patches soon (will use two
patches, one is for refactoring, another is for fixing regression).

Thanks,
Leo Yan
