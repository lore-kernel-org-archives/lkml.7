Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4837C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA00520848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+KbsTrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgAGJnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:43:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41164 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgAGJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:43:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so54026443ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ipxg+mShUeBN3220glE2cu6hVf+70zFtXuBgxlpkxU=;
        b=C+KbsTrNKoT/dd4MTngZCacjJtZ/37dPc6fRSVH/Fb0VcuWAvJmkO6mo1grt1+V/DG
         rB1g37oOU1g17KWtTyRovUBIrdTdUL58SVsiyNmQunIdq/4Q5EKqZzgsCIIoO38INKmp
         Rpes93NH/LDrTsL6vEj9H39hKGZ/kqMo8R5C0Dohi65BubCH1rsmbizbsXKylGe6L735
         IVDH/SiEbaaqHPF8I+dfHQXhP9COEhPFzcvtibC/tsEI3wDiZo3mdqvz1GGgnzfaBQKe
         n9CqkvJ+e/CpNPtl1oQGWnB9sPVwaVIUWfONVpJW3TleavwESPWjVcgbg2ohQCcPki/f
         DfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ipxg+mShUeBN3220glE2cu6hVf+70zFtXuBgxlpkxU=;
        b=NOUnCDqRDzlYkmqu3jb45BGezWCfuUaQJszr1X9DhDRBo/rkHtST8Mt0Unymx0JXae
         zIUyElIxwea7nI1+3+LlyWrfaIXPB/J6y9w7obuW37OVGNCqVI57jAcq2MbTh/Yr110Z
         0cInZyeVjsP/zgpt9tNAp/XLTcGy3/eW8D0K6iCbe1qoxSgHBgPTAWhk6Gk9LKGfWtgV
         1GZRl+p2/HQId2VXd/uXdhdgUj+V6ZtoYYb7ugNUpxk3NQ6M1wVnb+OHSEcuglCJ6Lm1
         uFAriN8zHw+LJag9UyyINJmMOs80LRSfwS0d5AS08B2Z7ymLT08YMpnqVt4cYWJw49EK
         vUXw==
X-Gm-Message-State: APjAAAXmXY6Le8xvAoa6LFCQfWBaCsrbSLAngtJSNAFkkFTvzVZGNkYy
        fxHBYKRdg6nkQcYGUZwVN9yi+G/rWX3VDDO6vNwDmQ==
X-Google-Smtp-Source: APXvYqxbNgYy8IYVupvVRxi9Er3s6wCZFxItYWsgyj+gW6MwzK7vAb1UJ0jl8eXaWdcgUSfyPoNOo2XJPsWG9lbRzTw=
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr55549048ljj.225.1578390200247;
 Tue, 07 Jan 2020 01:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20200106144250.GA3466@techsingularity.net> <04033a63f11a9c59ebd2b099355915e4e889b772.camel@surriel.com>
 <20200106163303.GC3466@techsingularity.net> <20200107015111.4836-1-hdanton@sina.com>
 <20200107091256.GE3466@techsingularity.net>
In-Reply-To: <20200107091256.GE3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Jan 2020 10:43:08 +0100
Message-ID: <CAKfTPtAMeta=jtTkTewdFN1UyqT+iyRhm9pfNDjkydfJQjaorQ@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v3
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Hillf Danton <hdanton@sina.com>, Rik van Riel <riel@surriel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Parth Shah <parth@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 at 10:12, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Jan 07, 2020 at 09:51:11AM +0800, Hillf Danton wrote:
> >
> > Hi Folks
> >
> > On Mon, 06 Jan 2020 11:44:57 -0500 Rik van Riel wrote:
> > > On Mon, 2020-01-06 at 16:33 +0000, Mel Gorman wrote:
> > > > On Mon, Jan 06, 2020 at 10:47:18AM -0500, Rik van Riel wrote:
> > > > > > +                     imbalance_adj = (100 / (env->sd->imbalance_pct - 100)) - 1;
> > > > > > +
> > > > > > +                     /*
> > > > > > +                      * Allow small imbalances when the busiest group has
> > > > > > +                      * low utilisation.
> > > > > > +                      */
> > > > > > +                     imbalance_max = imbalance_adj << 1;
> > > > > > +                     if (busiest->sum_nr_running < imbalance_max)
> > > > > > +                             env->imbalance -= min(env->imbalance, imbalance_adj);
> > > > > > +             }
> > > > > > +
> > > > >
> > > > > Wait, so imbalance_max is a function only of
> > > > > env->sd->imbalance_pct, and it gets compared
> > > > > against busiest->sum_nr_running, which is related
> > > > > to the number of CPUs in the node?
> > > > >
> > > >
> > > > It's not directly related to the number of CPUs in the node. Are you
> > > > thinking of busiest->group_weight?
> > >
> > > I am, because as it is right now that if condition
> > > looks like it might never be true for imbalance_pct 115.
> > >
> > > Presumably you put that check there for a reason, and
> > > would like it to trigger when the amount by which a node
> > > is busy is less than 2 * (imbalance_pct - 100).
> >
> >
> > If three per cent can make any sense in helping determine utilisation
> > low then the busy load has to meet
> >
> >       busiest->sum_nr_running < max(3, cpus in the node / 32);
> >
>
> Why 3% and why would the low utilisation cut-off depend on the number of

But in the same way, why only 6 tasks ? which is the value with
default imbalance_pct ?
I expect a machine with 128 CPUs to have more bandwidth than a machine
with only 32 CPUs and as a result to allow more imbalance

Maybe the number of running tasks (or idle cpus) is not the right
metrics to choose if we can allow a small degree of imbalance because
this doesn't take into account it wether the tasks are long running or
short running ones

> CPUs in the node? That simply means that the cut-off scales to machine
> size and does not take into account any consideration between local memory
> latency and memory bandwidth.
>
> > And we can't skip pulling tasks from a numa node without comparing it
> > to the local load
> >
> >       local->sum_nr_running * env->sd->imbalance_pct <
> >       busiest->sum_nr_running * 100;
> >
> > with imbalance_pct taken into account.
> >
>
> Again, why? In this context, an imbalance has already been calculated
> and whether based on running tasks or idle CPUs, it's not a negative
> number. The imbalance_adj used as already accounted for imbalance_pct
> albeit not as a ratio as it's normally used.
>
> --
> Mel Gorman
> SUSE Labs
