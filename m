Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27219CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECCB218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7omyIFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfJ3QgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:36:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34572 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfJ3QgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:36:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id f5so2083072lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fglx1P/Lr2zU5Bv2rqxkj3RwVFl25hRHEVVaBlkj2AM=;
        b=i7omyIFWFXzx+qrHikNEEnejVxeMI+/RkkoSc9Uh7jn1Uu4NJ65e1gQXFAR6nerCCA
         k3s4BnXN/BLtrxMZ91NiqXOVQ+z6MmOPGK/HU3PwvL3nZU/odNQcqvj8Yyg2AP6beOm5
         kBZtrlO2zdXyQkrYbG0Nbnb8UcCOCKOiFhCt5PsLoAVGEU6ph/+cKBZjUf+9xYC2ZDay
         tu2FUNhEWyk3pK4M8HKIYLN+zHa9iXd+WZ9E43UDVVUbSxN9G9xPqaqKHtm2OC8hUvnt
         2TzmqLNiIlqHKQAlHLcKbXBUNTGGCEiqAALYpjcUaiaJiu2BL5ZXqhMDujNZGhPDNrCv
         oRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fglx1P/Lr2zU5Bv2rqxkj3RwVFl25hRHEVVaBlkj2AM=;
        b=V7lw3SNvJ/ivpTC1Ef4mgwtVxTGEcvXKE6Wl/2FUvQr6W3t8ueVGzfJKZfQS8uMsbk
         UqkZEGe1TjCMwXuaqs7uxgNai/vJoYxm7DK9VzkmK3Ai080KHICYPmkeGZp5SuSM7Ml3
         L80GZsBTFJhdoX8aSdz6gn7Zw4Aqe5/xiGA22CiIuhCkh9S7O3Zo/QxWq/h+g4/4RvLK
         vmr47lm3f6hIlZi2uc3XB6ihgPQhFwggJZV8DBeL8lmJXtUtwfL7izB2IXjVhsPtAEtd
         Nl4rOvMDDzRKsOdks4BtfvpwqWp2D54D/K1lFlOwhJWzGnxMbKAahTP4uTgCqEgEztam
         Lhjw==
X-Gm-Message-State: APjAAAUF2smzrzPVQnCYqb/Z2cu/dnLN+mbncbRMlUjuaeGYJWDvVqoD
        aAzFy0GZo2Ot3Cxf4g8Tmzt42f+fDjYcbUMRQZmS5Q==
X-Google-Smtp-Source: APXvYqyp9Wa/AjUY3SZTFNdxu9Cmd7YfligZ1R/JfPihPZrFZlrwopXaUWdcnzdnmSwfycSpsy2j5jqCbk36NnTVBUU=
X-Received: by 2002:a19:ca13:: with SMTP id a19mr6645684lfg.133.1572453366556;
 Wed, 30 Oct 2019 09:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <20191021075038.GA27361@gmail.com> <20191030162440.GO3016@techsingularity.net>
In-Reply-To: <20191030162440.GO3016@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Oct 2019 17:35:53 +0100
Message-ID: <CAKfTPtBVWenCt5qLvow6ubB6a8c1gdPfW8-fWaKAa0k8b47m9Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 at 17:24, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Oct 21, 2019 at 09:50:38AM +0200, Ingo Molnar wrote:
> > > <SNIP>
> >
> > Thanks, that's an excellent series!
> >
>
> Agreed despite the level of whining and complaining I made during the
> review.

Thanks for the review.
I haven't gone through all your comments yet but will do in the coming days

>
> > I've queued it up in sched/core with a handful of readability edits to
> > comments and changelogs.
> >
> > There are some upstreaming caveats though, I expect this series to be a
> > performance regression magnet:
> >
> >  - load_balance() and wake-up changes invariably are such: some workloads
> >    only work/scale well by accident, and if we touch the logic it might
> >    flip over into a less advantageous scheduling pattern.
> >
> >  - In particular the changes from balancing and waking on runnable load
> >    to full load that includes blocking *will* shift IO-intensive
> >    workloads that you tests don't fully capture I believe. You also made
> >    idle balancing more aggressive in essence - which might reduce cache
> >    locality for some workloads.
> >
> > A full run on Mel Gorman's magic scalability test-suite would be super
> > useful ...
> >
>
> I queued this back on the 21st and it took this long for me to get back
> to it.
>
> What I tested did not include the fix for the last patch so I cannot say
> the data is that useful. I also failed to include something that exercised
> the IO paths in a way that idles rapidly as that can catch interesting
> details (usually cpufreq related but sometimes load-balancing related).
> There was no real thinking behind this decision, I just used an old
> collection of tests to get a general feel for the series.
>
> Most of the results were performance-neutral and some notable gains
> (kernel compiles were 1-6% faster depending on the -j count). Hackbench
> saw a disproportionate gain in terms of performance but I tend to be wary
> of hackbench as improving it is rarely a universal win.
> There tends to be some jitter around the point where a NUMA nodes worth
> of CPUs gets overloaded. tbench (mmtests configuation network-tbench) on
> a NUMA machine showed gains for low thread counts and high thread counts
> but a loss near the boundary where a single node would get overloaded.
>
> Some NAS-related workloads saw a drop in performance on NUMA machines
> but the size class might be too small to be certain, I'd have to rerun
> with the D class to be sure.  The biggest strange drop in performance
> was the elapsed time to run the git test suite (mmtests configuration
> workload-shellscripts modified to use a fresh XFS partition) took 17.61%
> longer to execute on a UMA Skylake machine. This *might* be due to the
> missing fix because it is mostly a single-task workload.
>
> I'm not going to go through the results in detail because I think another
> full round of testing would be required to take the fix into account. I'd
> also prefer to wait to see if the review results in any material change
> to the series.
>
> --
> Mel Gorman
> SUSE Labs
