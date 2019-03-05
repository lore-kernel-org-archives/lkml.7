Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892CCC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5298C2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551786961;
	bh=gjewAjdzvrBYiZPuoG2Ym5XjZv4VAZ8ESMblXQ4D0hQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=evk4LJGA1zO3U8+R8SrLOqu0ZFfmSWu1nBtMTMWZPXb0LM866rM2PDT7DwZ/yHeYl
	 cey3vh+RN0WpP+G8GZk+VS7t18CZZwwy+gppo0qIcs1f3eO1kVPAdUOf0UZcgmNtv5
	 LhUsl2gAH9/e+I81J9YjGDB9Nr/AYnJaZxEst6xA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfCELz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:55:59 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43463 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfCELz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:55:59 -0500
Received: by mail-oi1-f195.google.com with SMTP id i8so6602125oib.10;
        Tue, 05 Mar 2019 03:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOKVvl9GuIvzIa+EYYCsqWPrqOa4fRsaDhRv9se+jpE=;
        b=Mz5toRsVkDkPfhr8TEf4aoVtjaVsXg32TRJmdGPS7UU5RJufOjYHduQw+NFQAPQYKY
         n4NeTvxUaFr7Aln6jedF4Oy5heYgpk/pGvOEx2reu29pTs04OU3L6bqwT4gDv3bfzjkD
         Pt53GwcMxYxxlAMF4CXrpfzyq0miv/xVlGrXO9k/m9L/gQLiXXIm0WvI88Ouu6U3fFNo
         A3aLLEaVzJYLl0XWsow3eB7Je5e/5WPqi9lCtX5Dv0Ap/jOGh8YPw6TpjSt2n7kehiJ5
         BXZFwHmtZkhNp0m6SAsDpoPcKZvm8l7cGMgR+itERignETeIIuu0SH6qGyXn7Av2ESh8
         LQ+Q==
X-Gm-Message-State: APjAAAUf5aElulqr8K4quk2+w9Y4zNxrMrFts05sSes4Hsu24DW9S5Dh
        LHULQBsApWLradTdc8Jofdw5Gb6Tmaay0agXy+Q=
X-Google-Smtp-Source: APXvYqwkzQs0hzna3yFx7mWxCyMlyi2aUzVJYKd05tr8YUIwrE+BZR8a95s1PYC1srgT2hk4okmo7lq5MrgZlkuCF2A=
X-Received: by 2002:aca:355:: with SMTP id 82mr1843522oid.30.1551786958181;
 Tue, 05 Mar 2019 03:55:58 -0800 (PST)
MIME-Version: 1.0
References: <1755407.S0oJirvq9V@aspire.rjw.lan> <258653930.nEdAsQ7rt7@aspire.rjw.lan>
 <20190305114252.wu55upnrzb5j2g7j@queper01-lin>
In-Reply-To: <20190305114252.wu55upnrzb5j2g7j@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Mar 2019 12:55:47 +0100
Message-ID: <CAJZ5v0g8aJf9tf5NJ8sui46=Vjmadibg391apjXSU+h5LYfixA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] cpufreq: intel_pstate: Update max frequency on
 global turbo changes
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 12:43 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Tuesday 05 Mar 2019 at 11:42:06 (+0100), Rafael J. Wysocki wrote:
> > +static void intel_pstate_update_max_freq(unsigned int cpu)
> > +{
> > +     struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
> > +     struct cpufreq_policy new_policy;
> > +     struct cpudata *cpudata;
> > +
> > +     if (!policy)
> > +             return;
> > +
> > +     cpudata = all_cpu_data[cpu];
> > +     policy->cpuinfo.max_freq = global.turbo_disabled_mf ?
> > +                     cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
>
> I'm not too familiar with how the Intel turbo stuff so bear with me but
> is this 'pstate.turbo_freq' constant ?

Yes, it is.

> Why not just write it unconditionally into cpuinfo.max_freq ? It's not
> guaranteed to always be reachable anyways no ? So maybe that's OK to always
> report that one regardless of the boost availability ?

So the concern is that on some systems turbo is disabled permanently
by the platform FW and it doesn't make sense to even take
pstate.turbo_freq into consideration then.
