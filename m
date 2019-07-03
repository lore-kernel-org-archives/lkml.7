Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B760CC06510
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819432063F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRkXgnbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfGCBgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:36:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46194 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfGCBgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:36:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id z23so552560ote.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E2MNJNc0I8SY9kpTYL4zXVRKevXLFfOR8LtkzYCFYP8=;
        b=PRkXgnbejC/VB9+KXb4YewettRGuuiReipmTOyCGjNfN+UlPVFmB1qcV6KaskT+iPt
         Xdt7aspktUfzrU1W5HJ0qw7BOeqxXC3gDyB3yjaMb/leXWiKQ7J/NhOnstDi/DYadqUc
         Ab1sUvmz8dtcDu/NeHwTRZG+Y8HYq28MJWLl+Nuk4GaoKgCzqTuTyznilpie7ih+9kSe
         oaIFnji/asaBd/m66PPlG03NvkCpUJYwMUS/UfmVKlWPEX/3Ajs8/REuZcBVq/FOItqk
         HV9RXVR9I/ipnMmWgTy8jG06q4ISQ/nxIPUQOsH3XCrNPMG3nZ8bH40yE1y5yi5Nn0/x
         LXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E2MNJNc0I8SY9kpTYL4zXVRKevXLFfOR8LtkzYCFYP8=;
        b=kBXmqDumNIxZwRmg0pJB6Q+O2kSzVMFRKoX5b2GoNV+gAM6Lwj2QfgbE7MBHUbNWjw
         030i2WP1+L2i0ZKYyEcfqopVWZbAiKxkgyrXoNtngh/J48uxwrOPvVJpgYQuKElrb/gI
         pXeuHq1diJpWO4i/xDFoNg5Qd7l+67dOiiOC1beTh3h4lKP+OPnOX/K4olUfCS1jcWeS
         skmXITPEwYOVJzfZ9ToPK20GnxP4+jigjU7/tfy6hcyN9laY0iea66auIuOjnqq43XH+
         9IhVzcRuz0l0n85pIVx4tXENKdfXldoFcv5VCWq4NQrb1jp1RJcGQUoFcs9kYic+gdcS
         +3vA==
X-Gm-Message-State: APjAAAUADKFM/WhvbMCKT6CAW7vQm5FBFOfm1Ea9nny34rALkdmKykmu
        1iTNOzhkoTWsAEmMMbmJGWwG0g==
X-Google-Smtp-Source: APXvYqwGefhythDt/68wjxjOg0JL3+QasPI0nNvcZJItdd0qB/SHQCSt1CpNo+ij1fqyCtyrlOcIrw==
X-Received: by 2002:a9d:7f0e:: with SMTP id j14mr25247006otq.87.1562117764484;
        Tue, 02 Jul 2019 18:36:04 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id n26sm344887otq.10.2019.07.02.18.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 18:36:03 -0700 (PDT)
Date:   Wed, 3 Jul 2019 09:35:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 10/11] perf intel-pt: Smatch: Fix potential NULL
 pointer dereference
Message-ID: <20190703013553.GB6852@leoy-ThinkPad-X240s>
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702103420.27540-11-leo.yan@linaro.org>
 <cfef1777-141e-4223-e0c1-1a3f3aee1d3c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfef1777-141e-4223-e0c1-1a3f3aee1d3c@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Jul 02, 2019 at 02:07:40PM +0300, Adrian Hunter wrote:
> On 2/07/19 1:34 PM, Leo Yan wrote:
> > Based on the following report from Smatch, fix the potential
> > NULL pointer dereference check.
> 
> It never is NULL.  Remove the NULL test if you want:
> 
> -	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> +	if (session->itrace_synth_opts->set) {
> 
> But blindly making changes like below is questionable.

Thanks for suggestions.

I checked report and script commands, as you said, both command will
always set session->itrace_synth_opts.  For these two commands, we can
safely remove the NULL test.

Because perf tool contains many sub commands, so I don't have much
confidence it's very safe to remove the NULL test for all cases; e.g.
there have cases which will process aux trace buffer but without
itrace options; for this case, session->itrace_synth_opts might be NULL.

For either way (remove NULL test or keep NULL test), I don't want to
introduce regression and extra efforts by my patch.  So want to double
confirm with you for this :)

Thanks,
Leo Yan

> >   tools/perf/util/intel-pt.c:3200
> >   intel_pt_process_auxtrace_info() error: we previously assumed
> >   'session->itrace_synth_opts' could be null (see line 3196)
> > 
> >   tools/perf/util/intel-pt.c:3206
> >   intel_pt_process_auxtrace_info() warn: variable dereferenced before
> >   check 'session->itrace_synth_opts' (see line 3200)
> > 
> > tools/perf/util/intel-pt.c
> > 3196         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> > 3197                 pt->synth_opts = *session->itrace_synth_opts;
> > 3198         } else {
> > 3199                 itrace_synth_opts__set_default(&pt->synth_opts,
> > 3200                                 session->itrace_synth_opts->default_no_sample);
> >                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 3201                 if (!session->itrace_synth_opts->default_no_sample &&
> > 3202                     !session->itrace_synth_opts->inject) {
> > 3203                         pt->synth_opts.branches = false;
> > 3204                         pt->synth_opts.callchain = true;
> > 3205                 }
> > 3206                 if (session->itrace_synth_opts)
> >                          ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 3207                         pt->synth_opts.thread_stack =
> > 3208                                 session->itrace_synth_opts->thread_stack;
> > 3209         }
> > 
> > To dismiss the potential NULL pointer dereference, this patch validates
> > the pointer 'session->itrace_synth_opts' before access its elements.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/intel-pt.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> > index 550db6e77968..88b567bdf1f9 100644
> > --- a/tools/perf/util/intel-pt.c
> > +++ b/tools/perf/util/intel-pt.c
> > @@ -3195,7 +3195,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
> >  
> >  	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> >  		pt->synth_opts = *session->itrace_synth_opts;
> > -	} else {
> > +	} else if (session->itrace_synth_opts) {
> >  		itrace_synth_opts__set_default(&pt->synth_opts,
> >  				session->itrace_synth_opts->default_no_sample);
> >  		if (!session->itrace_synth_opts->default_no_sample &&
> > @@ -3203,8 +3203,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
> >  			pt->synth_opts.branches = false;
> >  			pt->synth_opts.callchain = true;
> >  		}
> > -		if (session->itrace_synth_opts)
> > -			pt->synth_opts.thread_stack =
> > +		pt->synth_opts.thread_stack =
> >  				session->itrace_synth_opts->thread_stack;
> >  	}
> >  
> > 
> 
