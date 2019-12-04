Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E99BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA7B20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOABLru4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfLDNs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:48:29 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39242 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfLDNs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:48:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id e10so8183682ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 05:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUCgkZkQGlomAJOzbgMFScKepIlz1LFeHjuD70SyCDU=;
        b=DOABLru4O3YLSC1Udp2kl5pZ+lWsZIGKvq5CRAFXe2rMUOCADT30wVieq72PNjLVBo
         DebY7P0Ttqsf2TDtWHJlpAW78tod/eky8WZdj3Frxhiq+BPU5iZme2DGk3lSVk36o4Vs
         3jDHwJF0yLZZrx6XEayGFjFGLaaAENOhpVP3SqGBQEtpDYPAGMfKSSykXOt9hsBOUrvD
         pgYaUuuALfDemB2IUMmBVsK5XQNNlRxBc3R7Pul2f9Al+Ar1wDuzyDcOpubWc2kv1lkI
         TIqBxjAIjzfF4pSyyTOaSf265a9FZ49biREUrILtvmD/v4WeL3KSLEb5lFZMhSI3G3dx
         bEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUCgkZkQGlomAJOzbgMFScKepIlz1LFeHjuD70SyCDU=;
        b=dOQ1zGamZ2/9mQnyKCBWIi66FWS90lsCIesOapcYzF7xl5setwa5+i3SdpxHnGRkQV
         wrAQzhruPEbf6EfdsmjQaut5g84C6KsFsBlDPkB2n/5boqtkX82OE+Y3ZfUZ0Di5vHin
         nLEq1krFXf5CrzL3TRes6a2ZdNwgZVC24eJajHIwfnwt52XdUyLCBx+o1auBDFfgXv5o
         iu2R2vUEQR0oLkk0OENMUkpoRkl4ewufNN9o+ldqPtSdgLInJJ/90CK+3W3U/KIAXIPi
         gOQmYFn9Y7S7ziOl1YobP3ILO5P8Z4wmiWMGCDLolVQb9kVzewcFtFSb8N/cD20kGdCs
         CENg==
X-Gm-Message-State: APjAAAUZTpULeVIITXhvGUekERr6Wc6VZ4U0+D9CxQzMt8ZKZGyuAzzy
        SbQZ1nkNHvEP1SLklz14YuBPmLTRvQgpjnmgC9CG1g==
X-Google-Smtp-Source: APXvYqyrors0Lqeum2YuOO9Y8I+L0AwkZy7afmR5sEZYatmvTAx4oky7L2jHZKumkSC+T6KuYakYrUq5tskDHSP4HeQ=
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr2001305ljj.206.1575467306357;
 Wed, 04 Dec 2019 05:48:26 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <CAKfTPtAvnLY3brp9iy_aHNu0rMM8nLfgeLc3CXEkMk3bwU1weA@mail.gmail.com>
 <20191204094216.u7yld5r3zelp22lf@e107158-lin.cambridge.arm.com>
 <20191204100925.GA15727@linaro.org> <629cca09-dde7-5d77-42e1-c68f2c1820d2@arm.com>
 <CAKfTPtDZLFn7msw88pTE_wr-BJo2ErqxpOW+ah0Jjcg6vE3SLw@mail.gmail.com> <20191204133224.uiqbkbpseree7xou@e107158-lin.cambridge.arm.com>
In-Reply-To: <20191204133224.uiqbkbpseree7xou@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Dec 2019 14:48:13 +0100
Message-ID: <CAKfTPtBP1wm706ZjZhW+BV5XUcONfJcGteeyoJQUhQsYPsY4tg@mail.gmail.com>
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019 at 14:32, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 12/04/19 13:08, Vincent Guittot wrote:
> > On Wed, 4 Dec 2019 at 11:41, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> > >
> > > On 04/12/2019 10:09, Vincent Guittot wrote:
> > > > Now, we test that a group has at least one allowed CPU for the task so we
> > > > could skip the local group with the correct/wrong p->cpus_ptr
> > > >
> > > > The path is used for fork/exec ibut also for wakeup path for b.L when the task doesn't fit in the CPUs
> > > >
> > > > So we can probably imagine a scenario where we change task affinity while
> > > > sleeping. If the wakeup happens on a CPU that belongs to the group that is not
> > > > allowed, we can imagine that we skip the local_group
> > > >
> > >
> > > Shoot, I think you're right. If it is the local group that is NULL, then
> > > we most likely splat on:
> > >
> > >                 if (local->sgc->max_capacity >= idlest->sgc->max_capacity)
> > >                         return NULL;
> > >
> > > We don't splat before because we just use local_sgs, which is uninitialized
> > > but on the stack.
> > >
> > > Also; does it really have to involve an affinity "race"? AFAIU affinity
> > > could have been changed a while back, but the waking CPU isn't allowed
> > > so we skip the local_group (in simpler cases where each CPU is a group).
> >
> > In fact, this will depend of the uninitialized values of local_sgs. I
> > have been able to reproduce the situation where we skip local group
> > but not to trigger the crash because the values already in the stack
> > don't trigger the misfit comparison.
>
> Will it be expensive to initialize local_sgs = {0}?

if we want to initialize local_sgs, it should be something like
local_sgs =  {
.avg_load = UINT_MAX,
.group_type = group_overloaded,
};

to make sure that we will not select local. This doesn't reflect any
kind of reality whereas local=NULL is more meaningful and more robust
IMO


>
> --
> Qais Yousef
