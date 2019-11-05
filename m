Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440C2C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C66621882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfKEVEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:04:25 -0500
Received: from foss.arm.com ([217.140.110.172]:53714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfKEVEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:04:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7DD5101E;
        Tue,  5 Nov 2019 13:04:23 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 461BC3F6C4;
        Tue,  5 Nov 2019 13:04:23 -0800 (PST)
Date:   Tue, 5 Nov 2019 21:04:21 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v4 0/6] Introduce Thermal Pressure
Message-ID: <20191105210301.GA23045@e108754-lin>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <20191031094420.GA19197@e108754-lin>
 <5DBB0EB0.9050106@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DBB0EB0.9050106@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On Thursday 31 Oct 2019 at 12:41:20 (-0400), Thara Gopinath wrote:
[...]
> >> Regarding testing, basic build, boot and sanity testing have been
> >> performed on db845c platform with debian file system.
> >> Further, dhrystone and hackbench tests have been
> >> run with the thermal pressure algorithm. During testing, due to
> >> constraints of step wise governor in dealing with big little systems,
> >> trip point 0 temperature was made assymetric between cpus in little
> >> cluster and big cluster; the idea being that
> >> big core will heat up and cpu cooling device will throttle the
> >> frequency of the big cores faster, there by limiting the maximum available
> >> capacity and the scheduler will spread out tasks to little cores as well.
> >>
> > 
> > Can you please share the changes you've made to sdm845.dtsi and a kernel
> > base on top of which to apply your patches? I would like to reproduce
> > your results and run more tests and it would be good if our setups were
> > as close as possible.
> Hi Ionela
> Thank you for the review.
> So I tested this on 5.4-rc1 kernel. The dtsi changes is to reduce the
> thermal trip points for the big CPUs to 60000 or 70000 from the default
> 90000. I did this for 2 reasons
> 1. I could never get the db845 to heat up sufficiently for my test cases
> with the default trip.
> 2. I was using the default step-wise governor for thermal. I did not
> want little and big to start throttling by the same % because then the
> task placement ratio will remain the same between little and big cores.
> 
> 

Some early testing on this showed that when setting the trip point to
60000 for the big CPUs and the big cluster, and running hackbench (1
group, 30000 loops) the cooling state of the big cluster results in
always being set to the maximum (the lowest OPP), which results in
capacity inversion (almost) continuously.

For 70000 the average cooling state of the bigs is around 20 so it
will leave a few more OPPs available on the bigs more of the time,
but probably the capacity of bigs is mostly lower than the capacity
of little CPUs, during this test as well.

I think that explains the difference in results that you obtained
below. This is good as it shows that thermal pressure is useful but
it shouldn't show much difference between the different decay
periods, as can also be observed in your results below.

This being said, I did not obtained such significant results on my
side by I'll try again with the kernel you've pointed me to offline.

Thanks,
Ionela.

> > 
> >> Test Results
> >>
> >> Hackbench: 1 group , 30000 loops, 10 runs       
> >>                                                Result         SD             
> >>                                                (Secs)     (% of mean)     
> >>  No Thermal Pressure                            14.03       2.69%           
> >>  Thermal Pressure PELT Algo. Decay : 32 ms      13.29       0.56%         
> >>  Thermal Pressure PELT Algo. Decay : 64 ms      12.57       1.56%           
> >>  Thermal Pressure PELT Algo. Decay : 128 ms     12.71       1.04%         
> >>  Thermal Pressure PELT Algo. Decay : 256 ms     12.29       1.42%           
> >>  Thermal Pressure PELT Algo. Decay : 512 ms     12.42       1.15%  
> >>
> >> Dhrystone Run Time  : 20 threads, 3000 MLOOPS
> >>                                                  Result      SD             
> >>                                                  (Secs)    (% of mean)     
> >>  No Thermal Pressure                              9.452      4.49%
> >>  Thermal Pressure PELT Algo. Decay : 32 ms        8.793      5.30%
> >>  Thermal Pressure PELT Algo. Decay : 64 ms        8.981      5.29%
> >>  Thermal Pressure PELT Algo. Decay : 128 ms       8.647      6.62%
> >>  Thermal Pressure PELT Algo. Decay : 256 ms       8.774      6.45%
> >>  Thermal Pressure PELT Algo. Decay : 512 ms       8.603      5.41%  
> >>
> > 
> > Do you happen to know by how much the CPUs were capped during these
> > experiments?
> 
> I don't have any captured results here. I know that big cores were
> capped and at times there was capacity inversion.
> 
> Also I will fix the nit comments above.
> 
> > 
> > Thanks,
> > Ionela.
> > 
> 
> 
> 
> -- 
> Warm Regards
> Thara
