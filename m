Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B503C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AFB218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPiaNAql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfGCKAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 06:00:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40579 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfGCKAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 06:00:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so1663437wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 03:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hSoC8nCs+Ob8KpfWiAi2Egv+8x1VlTi1X6Jdz/e0TiE=;
        b=GPiaNAqlidJ00jvmbOg+47CWfJuM45shHFlTIhUeIz4jD7SzAN4JOxAmjsR3J77NYE
         6fn5HBiY4d9so3sU7iDfDk60j9T1KO75VJ5iQW02N+ZbShqn3EXR+mzEHYzj2XvNKiMS
         vIA7Fc4ru6OJxZahc5yN8EK5MGWuVPeTOXwSbaxZSlmYolZOmJgrgYDb6U8aLLbdvQOT
         xd9/MebBpd5j0BEgUNdQUUi8MGKL5mLowQmHQx9cqWmHZ78xFGEDFT1OXKCw4g0aAEKg
         XCEVPmbltka1ruj/nkEsjkjbj/JbrfKuavcSe1AVcXKXb/rMBfk+QHGqodZkolThbFo6
         cjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSoC8nCs+Ob8KpfWiAi2Egv+8x1VlTi1X6Jdz/e0TiE=;
        b=W+unFNZMoJflhP6fmofeL+orzhL4sRe6exmjJVIErMEAnsNAX8zsYNtqYwxjed+THM
         3/7fub0QFXAc0d6CsP5bS3VRvIDRNjE/BaAVd51wnWUzhJtWQPSv/Cwp7qIoCTPtqeF5
         2mu39Iz8NrOgTFrDiWWUuCqI6VCdyq42pgO2US+tKN6mUlo4DM2dseAcksC/KWEZoAZ2
         T+3e5C+OOQc+nEA6mY1Lpc6xv3U4GpPhTSqlvSkFfSQPXifbMfjBQ7592HobjhOnQLFb
         XalAp+JWmMVy+MDLlNB1to2U3xMj4wCpL0CYHH3e6ZQYCx/CsFY24GF/vfAF4rOXx+iG
         iBtg==
X-Gm-Message-State: APjAAAVgRQlB1DfA80pg3qWceAHIMo1IISaROAawWz3Ng/mnqOK4LJzv
        d5q48lHR1fHRTtmXhlrv1ecXCQ==
X-Google-Smtp-Source: APXvYqyjnisJdnYjmgXQwAxd0u+GRWZQWek8Q0MirKmW/6kbwY/YptViRFJf/sYkiTHIsQAMpqnmvg==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr7504214wmg.48.1562148035749;
        Wed, 03 Jul 2019 03:00:35 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id e7sm1387470wmd.0.2019.07.03.03.00.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 03:00:35 -0700 (PDT)
Date:   Wed, 3 Jul 2019 11:00:32 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20190703100032.yx5genhqcrit4z5p@holly.lan>
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702103420.27540-11-leo.yan@linaro.org>
 <cfef1777-141e-4223-e0c1-1a3f3aee1d3c@intel.com>
 <20190703013553.GB6852@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703013553.GB6852@leoy-ThinkPad-X240s>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 09:35:54AM +0800, Leo Yan wrote:
> Hi Adrian,
> 
> On Tue, Jul 02, 2019 at 02:07:40PM +0300, Adrian Hunter wrote:
> > On 2/07/19 1:34 PM, Leo Yan wrote:
> > > Based on the following report from Smatch, fix the potential
> > > NULL pointer dereference check.
> > 
> > It never is NULL.  Remove the NULL test if you want:
> > 
> > -	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> > +	if (session->itrace_synth_opts->set) {
> > 
> > But blindly making changes like below is questionable.
> 
> Thanks for suggestions.
> 
> I checked report and script commands, as you said, both command will
> always set session->itrace_synth_opts.  For these two commands, we can
> safely remove the NULL test.
> 
> Because perf tool contains many sub commands, so I don't have much
> confidence it's very safe to remove the NULL test for all cases; e.g.
> there have cases which will process aux trace buffer but without
> itrace options; for this case, session->itrace_synth_opts might be NULL.
> 
> For either way (remove NULL test or keep NULL test), I don't want to
> introduce regression and extra efforts by my patch.  So want to double
> confirm with you for this :)

Review is useful to ensure the chosen solution is correct but
unless I missed something the non-regression reasoning here is easy
easy. In its original form and despite the check, the code will
always dereference session->itrace_synth_opts, therefore removing
the check cannot makes things worse.


Daniel.


PS Of course we do also have to check that
   itrace_synth_opts__set_default() isn't a macro... but it isn't.


> > >   tools/perf/util/intel-pt.c:3200
> > >   intel_pt_process_auxtrace_info() error: we previously assumed
> > >   'session->itrace_synth_opts' could be null (see line 3196)
> > > 
> > >   tools/perf/util/intel-pt.c:3206
> > >   intel_pt_process_auxtrace_info() warn: variable dereferenced before
> > >   check 'session->itrace_synth_opts' (see line 3200)
> > > 
> > > tools/perf/util/intel-pt.c
> > > 3196         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> > > 3197                 pt->synth_opts = *session->itrace_synth_opts;
> > > 3198         } else {
> > > 3199                 itrace_synth_opts__set_default(&pt->synth_opts,
> > > 3200                                 session->itrace_synth_opts->default_no_sample);
> > >                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > 3201                 if (!session->itrace_synth_opts->default_no_sample &&
> > > 3202                     !session->itrace_synth_opts->inject) {
> > > 3203                         pt->synth_opts.branches = false;
> > > 3204                         pt->synth_opts.callchain = true;
> > > 3205                 }
> > > 3206                 if (session->itrace_synth_opts)
> > >                          ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > 3207                         pt->synth_opts.thread_stack =
> > > 3208                                 session->itrace_synth_opts->thread_stack;
> > > 3209         }
> > > 
> > > To dismiss the potential NULL pointer dereference, this patch validates
> > > the pointer 'session->itrace_synth_opts' before access its elements.
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/util/intel-pt.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> > > index 550db6e77968..88b567bdf1f9 100644
> > > --- a/tools/perf/util/intel-pt.c
> > > +++ b/tools/perf/util/intel-pt.c
> > > @@ -3195,7 +3195,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
> > >  
> > >  	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> > >  		pt->synth_opts = *session->itrace_synth_opts;
> > > -	} else {
> > > +	} else if (session->itrace_synth_opts) {
> > >  		itrace_synth_opts__set_default(&pt->synth_opts,
> > >  				session->itrace_synth_opts->default_no_sample);
> > >  		if (!session->itrace_synth_opts->default_no_sample &&
> > > @@ -3203,8 +3203,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
> > >  			pt->synth_opts.branches = false;
> > >  			pt->synth_opts.callchain = true;
> > >  		}
> > > -		if (session->itrace_synth_opts)
> > > -			pt->synth_opts.thread_stack =
> > > +		pt->synth_opts.thread_stack =
> > >  				session->itrace_synth_opts->thread_stack;
> > >  	}
> > >  
> > > 
> > 
