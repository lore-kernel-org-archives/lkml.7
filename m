Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3553BC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084932084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570176546;
	bh=B93kPkD47DmrcuChvGsiW7/PbJlftlvIBac7zEMoCk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UmJUGo2i3dpODIP6IrlJUuSHtVPYj2qNqCMcXrcSJAMFANtUY4JZPozjRUFTcHyc/
	 K6y+3QBM34uErMSKHPRnL1JyHbTc7QPWqSnolc2mUfJVaxRA5FDKFj3phxlMk7P/WO
	 BUBl6IVCqyv2j7SuVYLhUfXE8YgsouEzMhdUevvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbfJDIJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:09:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:47033 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfJDIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:09:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id k25so4988440oiw.13;
        Fri, 04 Oct 2019 01:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWpuMGc11BNkqrkoCeNAZ7dAgiYiZ18TIDa7gt4d9dk=;
        b=CXWr4zshrv+E4ywUXJqQyTrOhMlPZ63r/fIVezD5cAbFWRu4o+1DFRa7LEaIZ1krTy
         fDSy9f43pEKTA7jtO/gs6ktHnh4doJ/aPYtUpomGWa3bdTazmSwTrQOzscJ/a8msDAMp
         mF+6i7oD/tP/OHeG6boZpt+j4FAZY2Kp8GQPAgdFetjGGR+dbn8F6xx11K/ZivjzU4Q1
         EchB5F5uVGEDGwrdEvC8w4dYubUsIctISNREpVjXpx49Fot2BAZjsGdT0mpyS5zgwlWm
         nkj0a4R9rSUCv0ilT2adEt0RecHv3Yc71O2wVyDdvg40fOw1LAWyBAViOwpPL6CWv3V0
         t6SA==
X-Gm-Message-State: APjAAAWWWOguk6aoFYsz232z3mlnu5GK7tZ/9ofRQ6fR5Xn2mKiOvmTC
        D7cGMBcKx6fsUFLCZx/esj7ypxC/uwQ8HAKiMbQ=
X-Google-Smtp-Source: APXvYqzZFsIHzdMBE1DaDvaAf9llVOGhkAVfs5hmO4p5b31drxpKxcAa4bFnlJl1nssIljEVi5GDAReZMaBiZ0fDvQ8=
X-Received: by 2002:aca:484:: with SMTP id 126mr5953082oie.68.1570176543946;
 Fri, 04 Oct 2019 01:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191002122926.385-1-ggherdovich@suse.cz> <20191002122926.385-3-ggherdovich@suse.cz>
 <13106850.QMtCbivBLn@kreacher> <5d6d601d2647644238fc51621407061e1c29320d.camel@linux.intel.com>
In-Reply-To: <5d6d601d2647644238fc51621407061e1c29320d.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Oct 2019 10:08:52 +0200
Message-ID: <CAJZ5v0hzrGQ8Tt2HO5DAAJdsEbEZPAnnvYG6LkdeMJgonVv0yA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: intel_pstate: Conditional frequency
 invariant accounting
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 5:31 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Thu, 2019-10-03 at 20:05 +0200, Rafael J. Wysocki wrote:
> > On Wednesday, October 2, 2019 2:29:26 PM CEST Giovanni Gherdovich
> > wrote:
> > > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > >
> > > intel_pstate has two operating modes: active and passive. In
> > > "active"
> > > mode, the in-built scaling governor is used and in "passive" mode,
> > > the driver can be used with any governor like "schedutil". In
> > > "active"
> > > mode the utilization values from schedutil is not used and there is
> > > a requirement from high performance computing use cases, not to
> > > readas well
> > > any APERF/MPERF MSRs.
> >
> > Well, this isn't quite convincing.
> >
> > In particular, I don't see why the "don't read APERF/MPERF MSRs"
> > argument
> > applies *only* to intel_pstate in the "active" mode.  What about
> > intel_pstate
> > in the "passive" mode combined with the "performance" governor?  Or
> > any other
> > governor different from "schedutil" for that matter?
> >
> > And what about acpi_cpufreq combined with any governor different from
> > "schedutil"?
> >
> > Scale invariance is not really needed in all of those cases right now
> > AFAICS,
> > or is it?
>
> Correct. This is just part of the patch to disable in active mode
> (particularly in HWP and performance mode).
>
> But this patch is 2 years old. The folks who wanted this, disable
> intel-pstate and use userspace governor with acpi-cpufreq. So may be
> better to address those cases too.

Well, that's my point. :-)

It looks like the scale invariance is only needed when the schedutil
governor is used, regardless of the driver, and it may lead to
performance degradation in the other cases, at least in principle (I
wonder, though, if any hard data supporting that claim are available).
That can be addressed in two ways IMO, either by reducing the possible
negative impact of the scale invariance code (eg. by running it less
frequently), so that it can be always enabled (as long as it is
supported by the processor), or by avoiding to run it in all cases
when it is not needed (but that basically would require the governor
->init and ->exit to enable and disable the scale invariance,
respectively).

> >
> > So is the real concern that intel_pstate in the "active" mode reads
> > the MPERF
> > and APERF MSRs by itself and that kind of duplicates what the scale
> > invariance
> > code does and is redundant etc?
> It is redundant in non-HWP mode. In HWP and performance (active mode)
> we don't use atleast at this time.

Right.
