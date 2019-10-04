Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41D6C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AE721848
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzoZ9zTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfJDI2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:28:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36158 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfJDI2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:28:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so5611001ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hKi+636RBXTvH3wOb1b3R3904GH69OuunMKRoatD/XQ=;
        b=QzoZ9zTkLjo+KsCkEhCr3D7alDW8VWXwVEgBV4Y4UCDiqodIT5Gp8UeA6760Q1NEwf
         7idkT0f81NtuqzpIpd52yzd2K51tq07uMcncxip160mi2SVjoIpSf5TK7ojXctOPwZAt
         ZXebpGTwAEfDAw2Vaje3J9UWl0q/TtlSRD7rHRjJRFXVawYTb+mmZpNg63IIFstWs/wi
         Zuzed63czEjO0+R6BDpGYr2wVA+x7ksmbu9HRacmNu3LqOTqNxubAIHmb+6JSHmTx1ZO
         9CeCcYhRyhnZDyS5spqTNwY06+eBrxzAAgYaAMQ6oFuhMo6EK+DIBFkoKdDC30cBBawQ
         JKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKi+636RBXTvH3wOb1b3R3904GH69OuunMKRoatD/XQ=;
        b=fA13G08eqdcjJtvF2Z6fiPeY5uTkC5fJm9H3m1QHKLCVkeqyMrbImtnzI2pfqoekrA
         9GEbNyMEKrrmsWL9OvVtfLdtoCqskHCpNJys/th1R5zRuNQ5FmzPOwJNoIGq/Qzdzfg7
         YqNoOWKzms+rQRca2/tnRwCsRw04UrLdgje9cTE1ackEVZuqZg2ObU0wCfoGYOco9K4x
         ZuxUs90xeMKUMauaDI5iZu3kPKTG4nQuiWZdqSjPMvssU70lgRGnmKcFmGbxREuO3kFr
         WA1GoSxo0LoxGKOZfCkHpnhbObxi55+9hUvagWocT8aX8hpN+pOddz+NxEKlLEpWOoN0
         Do2Q==
X-Gm-Message-State: APjAAAXU1BAd4ejT/gwkUVp7IXdPyVW6hbVNLpn/soDN9+BZTYWKDBun
        5qop0chIPQbnIV42IM9jXbby6oqUMIcjENJ9EZeQ1xMj
X-Google-Smtp-Source: APXvYqyZqMuJkLNoPHSHCNzIAkC4G67OuDPKf8bc8GpfEtVCobcRdjFtDp4pBJt/wR/zDo1DjlAa0HgOL52eiNUZbFE=
X-Received: by 2002:a2e:551:: with SMTP id 78mr8962482ljf.48.1570177692777;
 Fri, 04 Oct 2019 01:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191002122926.385-1-ggherdovich@suse.cz> <20191002122926.385-3-ggherdovich@suse.cz>
 <13106850.QMtCbivBLn@kreacher> <5d6d601d2647644238fc51621407061e1c29320d.camel@linux.intel.com>
 <1570177786.30086.1.camel@suse.cz>
In-Reply-To: <1570177786.30086.1.camel@suse.cz>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 4 Oct 2019 10:28:01 +0200
Message-ID: <CAKfTPtDo_wpGvc+rzJaTYOZc2wVbzMojaSSq0pC_M4ySSaicBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: intel_pstate: Conditional frequency
 invariant accounting
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        x86@kernel.org, "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2019 at 10:24, Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> On Thu, 2019-10-03 at 20:31 -0700, Srinivas Pandruvada wrote:
> > On Thu, 2019-10-03 at 20:05 +0200, Rafael J. Wysocki wrote:
> > > On Wednesday, October 2, 2019 2:29:26 PM CEST Giovanni Gherdovich
> > > wrote:
> > > > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > >
> > > > intel_pstate has two operating modes: active and passive. In "active"
> > > > mode, the in-built scaling governor is used and in "passive" mode, the
> > > > driver can be used with any governor like "schedutil". In "active" mode
> > > > the utilization values from schedutil is not used and there is a
> > > > requirement from high performance computing use cases, not to readas
> > > > well any APERF/MPERF MSRs.
> > >
> > > Well, this isn't quite convincing.
> > >
> > > In particular, I don't see why the "don't read APERF/MPERF MSRs" argument
> > > applies *only* to intel_pstate in the "active" mode.  What about
> > > intel_pstate in the "passive" mode combined with the "performance"
> > > governor?  Or any other governor different from "schedutil" for that
> > > matter?
> > >
> > > And what about acpi_cpufreq combined with any governor different from
> > > "schedutil"?
> > >
> > > Scale invariance is not really needed in all of those cases right now
> > > AFAICS, or is it?
> >
> > Correct. This is just part of the patch to disable in active mode
> > (particularly in HWP and performance mode).
> >
> > But this patch is 2 years old. The folks who wanted this, disable
> > intel-pstate and use userspace governor with acpi-cpufreq. So may be
> > better to address those cases too.
>
> I disagree with "scale invariance is needed only by the schedutil governor";
> the two other users are the CPU's estimated utilization in the wakeup path,
> via cpu_util_without(), as well as the load-balance path, via cpu_util() which
> is used by update_sg_lb_stats().
>
> Also remember that scale invariance is applied to both PELT signals util_avg
> and load_avg; schedutil uses the former but not the latter.

You have been quicker than me to reply. I was about to say the exact
same things.
scale invariance also helps the scheduler in task placement by
stabilizing the metrics whatever the running frequency so a task will
not be seen as a big task just because of a CPU running at lower
frequency

>
> I understand Srinivas patch to disable MSR accesses during the tick as a
> band-aid solution to address a specific use case he cares about, but I don't
> think that extending this approach to any non-schedutil governor is a good
> idea -- you'd be killing load balancing in the process.
>
>
> Giovanni
