Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18713C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BAB2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388421AbfDRJWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:22:21 -0400
Received: from foss.arm.com ([217.140.101.70]:58248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388052AbfDRJWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:22:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C577315AB;
        Thu, 18 Apr 2019 02:22:20 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 183033F68F;
        Thu, 18 Apr 2019 02:22:17 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:22:16 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
Message-ID: <20190418092213.52wjhwbq6lpwxqxm@queper01-lin>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <20190417053626.GA47282@gmail.com>
 <5CB75FD9.3070207@linaro.org>
 <20190417182932.GB5140@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417182932.GB5140@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 Apr 2019 at 20:29:32 (+0200), Ingo Molnar wrote:
> 
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> 
> > 
> > On 04/17/2019 01:36 AM, Ingo Molnar wrote:
> > > 
> > > * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> > > 
> > >> The test results below shows 3-5% improvement in performance when
> > >> using the third solution compared to the default system today where
> > >> scheduler is unware of cpu capacity limitations due to thermal events.
> > > 
> > > The numbers look very promising!
> > 
> > Hello Ingo,
> > Thank you for the review.
> > > 
> > > I've rearranged the results to make the performance properties of the 
> > > various approaches and parameters easier to see:
> > > 
> > >                                          (seconds, lower is better)
> > > 
> > > 			                 Hackbench   Aobench   Dhrystone
> > >                                          =========   =======   =========
> > > Vanilla kernel (No Thermal Pressure)         10.21    141.58        1.14
> > > Instantaneous thermal pressure               10.16    141.63        1.15
> > > Thermal Pressure Averaging:
> > >       - PELT fmwk                             9.88    134.48        1.19
> > >       - non-PELT Algo. Decay : 500 ms         9.94    133.62        1.09
> > >       - non-PELT Algo. Decay : 250 ms         7.52    137.22        1.012
> > >       - non-PELT Algo. Decay : 125 ms         9.87    137.55        1.12
> > > 
> > > 
> > > Firstly, a couple of questions about the numbers:
> > > 
> > >    1)
> > > 
> > >       Is the 1.012 result for "non-PELT 250 msecs Dhrystone" really 1.012?
> > >       You reported it as:
> > > 
> > >              non-PELT Algo. Decay : 250 ms   1.012                   7.02%
> > 
> > It is indeed 1.012. So, I ran the "non-PELT Algo 250 ms" benchmarks
> > multiple time because of the anomalies noticed.  1.012 is a formatting
> > error on my part when I copy pasted the results into a google sheet I am
> > maintaining to capture the test results. Sorry about the confusion.
> 
> That's actually pretty good, because it suggests a 35% and 15% 
> improvement over the vanilla kernel - which is very good for such 
> CPU-bound workloads.
> 
> Not that 5% is bad in itself - but 15% is better ;-)
> 
> > Regarding the decay period, I agree that more testing can be done. I 
> > like your suggestions below and I am going to try implementing them 
> > sometime next week. Once I have some solid results, I will send them 
> > out.
> 
> Thanks!
> 
> > My concern regarding getting hung up too much on decay period is that I 
> > think it could vary from SoC to SoC depending on the type and number of 
> > cores and thermal characteristics. So I was thinking eventually the 
> > decay period should be configurable via a config option or by any other 
> > means. Testing on different systems will definitely help and maybe I am 
> > wrong and there is no much variation between systems.
> 
> Absolutely, so I'd not be against keeping it a SCHED_DEBUG tunable or so, 
> until there's a better understanding of how the physical properties of 
> the SoC map to an ideal decay period.

+1, that'd be really useful to try this out on several platforms.

> Assuming PeterZ & Rafael & Quentin doesn't hate the whole thermal load 
> tracking approach.

I certainly don't hate it :-) In fact we already have something in the
Android kernel to reflect thermal pressure into the CPU capacity using
the 'instantaneous' approach. I'm all in favour of replacing our
out-of-tree stuff by a mainline solution, and even more if that performs
better.

So yes, we need to discuss the implementation details and all, but I'd
personally be really happy to see something upstream in this area.

> I suppose there's some connection of this to Energy 
> Aware Scheduling? Or not ...

Hmm, there isn't an immediate connection, I think. But that could
change.

FWIW I'm currently pushing a patch-set to make the thermal subsystem use
the same Energy Model as EAS ([1]) instead of its own. There are several
good reasons to do this, but one of them is to make sure the scheduler
and the thermal stuff (and the rest of the kernel) have a consistent
definition of what 'power' means. That might enable us do smart things
in the scheduler, but that's really for later.

Thanks,
Quentin

[1] https://lore.kernel.org/lkml/20190417094301.17622-1-quentin.perret@arm.com/
