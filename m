Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ECDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E48520842
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KranUPvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbgAIQe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:34:28 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53049 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgAIQe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:34:28 -0500
Received: by mail-pj1-f68.google.com with SMTP id a6so1358004pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cKowTXElbIwNPHiVPa4u4GnF2xIwH7p+D7SwgI4xDds=;
        b=KranUPvIVSlrQAeovbcdugffemKy/nR+ighvkTl00RCdUFrRihDCRDxFEZRZN9JG+v
         UyNWVX9N764l0/gx4dzPGT7buMh2fg3v8z9XO03HhHGpmporxiy0g33ISVkf3n5Q1ccH
         lvGlJAU+N5/FoaOV0yWTPnIW5C964CXKHhFSESlOZyCKhwHJxUY0At3jJ1DIuUfJoceK
         lvvBBIPPjAsLca2UpRaroS6RID9NOl1V0zs8p5w0a+fi5KxWh1vKTXTa48eX/RF6nDzU
         mF7I+j3lThSGZvAjUALBKU1G/vYarh91VfoZLLTPlqyvK/7kn7UVSPyPBcoaLNtNUR/u
         Cb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cKowTXElbIwNPHiVPa4u4GnF2xIwH7p+D7SwgI4xDds=;
        b=USb+E6I/Norc1cC7zNzCI9eo5ruDu2t7O0GfWbxEELOocqDK4J5pP93CZCyxpyCk+L
         0IwRKUqfcXalQi9xUVAJ1Sv9dcjnZD370k91br2Yusu+yDZbbMg194QuyTXPRCDgb+yp
         dIkNe5+MnGpwHz3VgSTpqyz6puio1C9Wyz6PvRlcdq2kFUcSmEszOtO1L9Zpkxrl6KjS
         zSNo5lVokvdU1p5igcDigOIsTIXw1r38aBe8kpyckrovy0R/IA+8P7HWxst3lj29q5MH
         EO+4SnlYfZP8eBXrYnayeCkLS/z7TmyH6uZCBbDeVmo/ox2FJY9aJ4DL04cxGPNwPjE3
         BEOA==
X-Gm-Message-State: APjAAAUwHCsFoCnhic2ZnDZjH0psDl+XP7RzSBYGo4tbhPmLusqWphDr
        ryGsObJlXn/A2UgC81o2rM6hAw==
X-Google-Smtp-Source: APXvYqwS8CfoM7rN0/so2UXiS4NXNMNBpmHmy2fuhralDqnpSqUWh/Lv9MYVJQrARDZRLYxmVvnYcA==
X-Received: by 2002:a17:902:b68c:: with SMTP id c12mr12357128pls.160.1578587667268;
        Thu, 09 Jan 2020 08:34:27 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j9sm8446085pff.6.2020.01.09.08.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:34:26 -0800 (PST)
Date:   Thu, 9 Jan 2020 09:34:24 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v4 1/2] perf parse: Refactor struct perf_evsel_config_term
Message-ID: <20200109163424.GA5721@xps15>
References: <20200108142010.11269-1-leo.yan@linaro.org>
 <CANLsYkzv2Di-qeU1Q3M4Ro21hQ09eE26FBjeP1A9uSsA_W2Uww@mail.gmail.com>
 <20200109050753.GA24741@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109050753.GA24741@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 01:08:06PM +0800, Leo Yan wrote:
> Hi Mathieu,
> 
> On Wed, Jan 08, 2020 at 10:58:31AM -0700, Mathieu Poirier wrote:
> 
> [...]
> 
> > > diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
> > > index 1f8d2fe0b66e..4e5b3ebf09cf 100644
> > > --- a/tools/perf/util/evsel_config.h
> > > +++ b/tools/perf/util/evsel_config.h
> > > @@ -33,21 +33,8 @@ struct perf_evsel_config_term {
> > >         struct list_head      list;
> > >         enum evsel_term_type  type;
> > >         union {
> > > -               u64           period;
> > > -               u64           freq;
> > > -               bool          time;
> > > -               char          *callgraph;
> > > -               char          *drv_cfg;
> > > -               u64           stack_user;
> > > -               int           max_stack;
> > > -               bool          inherit;
> > > -               bool          overwrite;
> > > -               char          *branch;
> > > -               unsigned long max_events;
> > > -               bool          percore;
> > > -               bool          aux_output;
> > > -               u32           aux_sample_size;
> > > -               u64           cfg_chg;
> > > +               u64           num;
> > > +               char          *str;
> > 
> > That is a lot more than just dealing with the "char *" members.  Given
> > the pervasiveness of the changes I would have been happy to leave
> > other members alone for the time being.
> 
> I think actually you are suggesting like below which add general
> members and also keep the old members.  If so, I prefer to add two
> general members 'num' and 'str'.

If we are to deal with all flields of the union, I think it should be as below:

        union {
                bool            cfg_bool;
                int             cfg_int;
                unsigned long   cfg_ulong;
                u32             cfg_u32;
                char            *cfg_str;
        } val;

But just dealing with the "char *" as below would also be fine with me:

        union {
                u64           period;
                u64           freq;
                bool          time;
                u64           stack_user;
                int           max_stack;
                bool          inherit;
                bool          overwrite;
                unsigned long max_events;
                bool          percore;
                bool          aux_output;
                u32           aux_sample_size;
                u64           cfg_chg;
                u64           num;
                char          *str;
        } val;

> 
> struct perf_evsel_config_term {
>         struct list_head      list;
>         enum evsel_term_type  type;
>         union {
>                 u64           period;
>                 u64           freq;
>                 bool          time;
>                 char          *callgraph;
>                 char          *drv_cfg;
>                 u64           stack_user;
>                 int           max_stack;
>                 bool          inherit;
>                 bool          overwrite;
>                 char          *branch;
>                 unsigned long max_events;
>                 bool          percore;
>                 bool          aux_output;
>                 u32           aux_sample_size;
>                 u64           cfg_chg;
> +               u64           num;
> +               char          *str;
>         } val;
>         bool weak;
> };
> 
> > I will let Jiri make the
> > final call but if we are to proceed this way I think we should have a
> > member per type to avoid casting issues.
> 
> Yeah, let's see what's Jiri thinking.
> 
> Just note, with this change, I don't see any casting warning or errors
> when built perf on arm64/arm32.

At this time you may not, but they will happen and it will be very hard to
debug.

> 
> Thanks,
> Leo Yan
