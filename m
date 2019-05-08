Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B2BC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D862420989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfEHMFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:05:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38203 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbfEHMFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:05:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id f2so2937854wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 05:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=69qxMd9w/VPIB594fPnsC8YI+TS1muSCPwX6VOqGegI=;
        b=tavEtlEbrCFise/le8XKYlO1Gd/0UP7FRXcyYp+QHbAVNuTOTxiqR+G1aq1A/ROYxk
         ZAQvYpKPz0s7jZT0h8mymvsWLVhPSnIvENkC3BHWch9hnh3uHg7AknNCJgRUbXLN2Rsc
         K2HckGBeN1DM2S1rG4N9tXvdhkNvGP4W+7gUUlhIg7Qk+LKjniwVKzAc6DHAdPDiHjlx
         ICMsh43GhwsZh++o7CfIo+T9NpJhWUVUFbCZFU7auiXzEkfvwjxVLlD568L5+lO5YQgG
         3OFNRfQowBTKX+ZI/Dj7MOnbizehbHBl7P6ZoHYPL/sHSiAgB8bFfQNHd6fKEwEYIDSR
         ew3w==
X-Gm-Message-State: APjAAAWGlvDPfHnPKjyXXPDtM6PNWf+qx+kUoZUW2L60grE/VQ4Ak5KQ
        csAO/lsdlV1lmCowbHsS2qr0qQ==
X-Google-Smtp-Source: APXvYqyn6Ss7vNnGcKR380rTa/68guZqWHRBGYZ2w0ALvBH5B0Mcsp4ABxQvfzGSGqT6A04hTDBT2A==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr2707545wmf.125.1557317130212;
        Wed, 08 May 2019 05:05:30 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id e7sm2256151wme.37.2019.05.08.05.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 05:05:28 -0700 (PDT)
Date:   Wed, 8 May 2019 14:05:26 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 4/6] sched/dl: Improve capacity-aware wakeup
Message-ID: <20190508120526.GI6551@localhost.localdomain>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-5-luca.abeni@santannapisa.it>
 <20190508090855.GG6551@localhost.localdomain>
 <20190508112437.74661fa8@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508112437.74661fa8@nowhere>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/19 11:24, luca abeni wrote:
> On Wed, 8 May 2019 11:08:55 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > On 06/05/19 06:48, Luca Abeni wrote:
> > > From: luca abeni <luca.abeni@santannapisa.it>
> > > 
> > > Instead of considering the "static CPU bandwidth" allocated to
> > > a SCHED_DEADLINE task (ratio between its maximum runtime and
> > > reservation period), try to use the remaining runtime and time
> > > to scheduling deadline.
> > > 
> > > Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> > > ---
> > >  kernel/sched/cpudeadline.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> > > index d21f7905b9c1..111dd9ac837b 100644
> > > --- a/kernel/sched/cpudeadline.c
> > > +++ b/kernel/sched/cpudeadline.c
> > > @@ -114,8 +114,13 @@ static inline int dl_task_fit(const struct
> > > sched_dl_entity *dl_se, int cpu, u64 *c)
> > >  {
> > >  	u64 cap = (arch_scale_cpu_capacity(NULL, cpu) *
> > > arch_scale_freq_capacity(cpu)) >> SCHED_CAPACITY_SHIFT;
> > > -	s64 rel_deadline = dl_se->dl_deadline;
> > > -	u64 rem_runtime  = dl_se->dl_runtime;
> > > +	s64 rel_deadline = dl_se->deadline -
> > > sched_clock_cpu(smp_processor_id());
> > > +	u64 rem_runtime  = dl_se->runtime;
> > > +
> > > +	if ((rel_deadline < 0) || (rel_deadline *
> > > dl_se->dl_runtime < dl_se->dl_deadline * rem_runtime)) {
> > > +		rel_deadline = dl_se->dl_deadline;
> > > +		rem_runtime  = dl_se->dl_runtime;
> > > +	}  
> > 
> > So, are you basically checking if current remaining bw can be consumed
> > safely?
> 
> I check if the current runtime (rescaled based on the capacity) is
> smaller than the time to the current scheduling deadline (basically, if
> it can be consumed in time).
> 
> However, if
> 	q / (d - t) > Q / P 
> (where "q" is the current runtime, "d" is the scheduling deadline, "Q"
> is the maximum runtime, and "P" is the CBS period), then a new
> scheduling deadline will be generated (later), and the runtime will be
> reset to Q... So, I need to use the maximum budget and CBS period for
> checking if the task fits in the core.

OK. I'd add a comment about it.

> > I'm not actually sure if looking at dynamic values is what we need to
> > do at this stage. By considering static values we fix admission
> > control (and scheduling). Aren't dynamic values more to do with
> > energy tradeoffs (and so to be introduced when starting to look at
> > the energy model)?
> 
> Using the current runtime and scheduling deadline might allow to
> migrate a task to SMALL cores (if its remaining runtime is small
> enough), even if the rescaled Q is larger than P.
> So, in theory it might allow to reduce the load on big cores.
> 
> If we decide that this is overkilling, I can just drop the patch.

So, my first impression was that we shouldn't be too clever until we
start using info from the energy model (using which one should be able
to understand if, for example, reducing load on big cores is a winning
power/perf decision).

However, I was also wondering if we should actually compare dynamic
parameters with {running,this}_bw (per-rq) the moment we search for
potential migration candidates (so that we are not overloading rqs).
