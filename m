Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF774C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 14:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49E42086A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 14:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfHJOS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 10:18:28 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:44079 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbfHJOS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 10:18:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TZ5UoG6_1565446689;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TZ5UoG6_1565446689)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 10 Aug 2019 22:18:10 +0800
Date:   Sat, 10 Aug 2019 22:18:09 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190810141808.GB73644@aaronlu>
References: <20190619183302.GA6775@sinkpad>
 <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
 <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com>
 <20190808125516.GA67687@aaronlu>
 <9e6f3170-2607-6ff7-3367-8f36d1d8f862@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e6f3170-2607-6ff7-3367-8f36d1d8f862@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 09:39:45AM -0700, Tim Chen wrote:
> On 8/8/19 5:55 AM, Aaron Lu wrote:
> > On Mon, Aug 05, 2019 at 08:55:28AM -0700, Tim Chen wrote:
> >> On 8/2/19 8:37 AM, Julien Desfossez wrote:
> >>> We tested both Aaron's and Tim's patches and here are our results.
> 
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 26fea68f7f54..542974a8da18 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3888,7 +3888,7 @@ next_class:;
> >  		WARN_ON_ONCE(!rq_i->core_pick);
> >  
> >  		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
> > -			rq->core_forceidle = true;
> > +			rq_i->core_forceidle = true;
> 
> Good catch!
> 
> >  
> >  		rq_i->core_pick->core_occupation = occ;
> > 
> > With this fixed and together with the patch to let schedule always
> > happen, your latest 2 patches work well for the 10s cpuhog test I
> > described previously:
> > https://lore.kernel.org/lkml/20190725143003.GA992@aaronlu/
> 
> That's encouraging.  You are talking about my patches
> that try to keep the force idle time between sibling threads
> balanced, right?

Yes.

> > 
> > overloaded workload without any cpu binding doesn't work well though, I
> > haven't taken a closer look yet.
> > 
> 
> I think we need a load balancing scheme among the cores that will try
> to minimize force idle.

Agree.

> 
> One possible metric to measure load compatibility imbalance that leads to
> force idle is 
> 
> Say i, j are sibling threads of a cpu core
> imbalanace = \sum_tagged_cgroup  abs(Load_cgroup_cpui - Load_cgroup_cpuj)
> 
> This gives us a metric to decide if migrating a task will improve
> load compatability imbalance.  As we already track cgroup load on a CPU,
> it should be doable without adding too much overhead.
