Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13872C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDE420678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RnvZmwwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgAIFIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 00:08:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43626 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgAIFIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 00:08:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id p27so2042377pli.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 21:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lcAJ8a5JjzOWUFJCh86RBNGI7a8kNUnL/Mhr975Tw90=;
        b=RnvZmwwI6pZ9+qidRZsu0vns4iAn1DAJL5MlsGLIdlqfq4TZAVoPlJz/U1+JLRYEZT
         EYjPlCBSXAM3IAQ+BOQ3xalMH2B4N/y/Di06WGGOQD6/wip/IMUBYL1aOpYDdBS57I9G
         nQceWEUwEtys99Wtrms/hTUUDG8s1K8OxwItTaAe64xEffhKYBg773HmWD1qL8DqkEmC
         w8u7Sr6g1cUNPdfxuEUdWwoDxxOsvzO7EOyZVgj71XnE69iWWm+jiScOdoMvJhfJjAVy
         JzqTj57Dhawu7blgdHEYan07YQDuQVhtZj4WQ3yj3nKP7G7ARiqx4zR81gkGlytyJkDu
         IHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lcAJ8a5JjzOWUFJCh86RBNGI7a8kNUnL/Mhr975Tw90=;
        b=VyVlCLsijKbYjyCOsxBXjQREP4o+xaCF2sqvlDiDhRiXckSYydT+zpksVJUSEc4HP3
         Wd/CV5F6EWk13T0pT5hqPOnvACSUP+OW2h7MRoQeCf+qY9+SJdFEPWxWIDu85b7SwQVd
         vB6qpvZfPDwXlYyvfcKWsCF25Tid3nvwqSil7s5byHYr/qCT8YgT5LhzctZ88lFQlt4j
         0tf+aJmekVG+2RV0V+i/l0XWjiKDEo5Bry7e4Uab5azDOs5qYKeVxAHjpPYQtzm2dQ9s
         8k+VcHGjK8RMJ/tieKq/YrUsVPwL82QAmXV0oE7hCr4Pc05/mC7YJXzqkaoEiDPuQV0J
         9cvQ==
X-Gm-Message-State: APjAAAXZS5j++qQtQSVKLKLgJjxxdkMh2T50kR+6tW1CIQWFa6EO4CDZ
        N0NPAeUP1US40NRXiVX3VD7kvg==
X-Google-Smtp-Source: APXvYqyMdP63NJdH9SfWzk07UUKeaz4wI65kF4lFtyIiSizBhZXFfGZ5NaL5lEw5MHT5xrwe0s6MnA==
X-Received: by 2002:a17:90a:5806:: with SMTP id h6mr2977688pji.120.1578546493628;
        Wed, 08 Jan 2020 21:08:13 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id r37sm1049482pjb.7.2020.01.08.21.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 21:08:13 -0800 (PST)
Date:   Thu, 9 Jan 2020 13:08:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
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
Message-ID: <20200109050753.GA24741@leoy-ThinkPad-X240s>
References: <20200108142010.11269-1-leo.yan@linaro.org>
 <CANLsYkzv2Di-qeU1Q3M4Ro21hQ09eE26FBjeP1A9uSsA_W2Uww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkzv2Di-qeU1Q3M4Ro21hQ09eE26FBjeP1A9uSsA_W2Uww@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Wed, Jan 08, 2020 at 10:58:31AM -0700, Mathieu Poirier wrote:

[...]

> > diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
> > index 1f8d2fe0b66e..4e5b3ebf09cf 100644
> > --- a/tools/perf/util/evsel_config.h
> > +++ b/tools/perf/util/evsel_config.h
> > @@ -33,21 +33,8 @@ struct perf_evsel_config_term {
> >         struct list_head      list;
> >         enum evsel_term_type  type;
> >         union {
> > -               u64           period;
> > -               u64           freq;
> > -               bool          time;
> > -               char          *callgraph;
> > -               char          *drv_cfg;
> > -               u64           stack_user;
> > -               int           max_stack;
> > -               bool          inherit;
> > -               bool          overwrite;
> > -               char          *branch;
> > -               unsigned long max_events;
> > -               bool          percore;
> > -               bool          aux_output;
> > -               u32           aux_sample_size;
> > -               u64           cfg_chg;
> > +               u64           num;
> > +               char          *str;
> 
> That is a lot more than just dealing with the "char *" members.  Given
> the pervasiveness of the changes I would have been happy to leave
> other members alone for the time being.

I think actually you are suggesting like below which add general
members and also keep the old members.  If so, I prefer to add two
general members 'num' and 'str'.

struct perf_evsel_config_term {
        struct list_head      list;
        enum evsel_term_type  type;
        union {
                u64           period;
                u64           freq;
                bool          time;
                char          *callgraph;
                char          *drv_cfg;
                u64           stack_user;
                int           max_stack;
                bool          inherit;
                bool          overwrite;
                char          *branch;
                unsigned long max_events;
                bool          percore;
                bool          aux_output;
                u32           aux_sample_size;
                u64           cfg_chg;
+               u64           num;
+               char          *str;
        } val;
        bool weak;
};

> I will let Jiri make the
> final call but if we are to proceed this way I think we should have a
> member per type to avoid casting issues.

Yeah, let's see what's Jiri thinking.

Just note, with this change, I don't see any casting warning or errors
when built perf on arm64/arm32.

Thanks,
Leo Yan
