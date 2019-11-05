Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405CAC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E717121929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfKEV3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:29:04 -0500
Received: from foss.arm.com ([217.140.110.172]:54224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbfKEV3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:29:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE9D930E;
        Tue,  5 Nov 2019 13:29:02 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7ED5C3F6C4;
        Tue,  5 Nov 2019 13:29:02 -0800 (PST)
Date:   Tue, 5 Nov 2019 21:29:01 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v4 6/6] sched: thermal: Enable tuning of decay period
Message-ID: <20191105212735.GA32353@e108754-lin>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-7-git-send-email-thara.gopinath@linaro.org>
 <20191104161035.GA6680@e108754-lin>
 <5DC1DADE.60603@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DC1DADE.60603@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 Nov 2019 at 15:26:06 (-0500), Thara Gopinath wrote:
> On 11/04/2019 11:12 AM, Ionela Voinescu wrote:
> > Hi Thara,
> > 
> > On Tuesday 22 Oct 2019 at 16:34:25 (-0400), Thara Gopinath wrote:
> >> Thermal pressure follows pelt signas which means the
> >> decay period for thermal pressure is the default pelt
> >> decay period. Depending on soc charecteristics and thermal
> >> activity, it might be beneficial to decay thermal pressure
> >> slower, but still in-tune with the pelt signals.
> > 
> > I wonder if it can be beneficial to decay thermal pressure faster as
> > well.
> > 
> > This implementation makes 32 (LOAD_AVG_PERIOD) the minimum half-life
> > of the thermal pressure samples. This results in more than 100ms for a
> > sample to decay significantly and therefore let's say it can take more
> > than 100ms for capacity to return to (close to) max when the CPU is no
> > longer capped. This value seems high to me considering that a minimum
> > value should result in close to 'instantaneous' behaviour, when there
> > are thermal capping mechanisms that can react in ~20ms (hikey960 has a
> > polling delay of 25ms, if I'm remembering correctly).
> > 
> > I agree 32ms seems like a good default but given that you've made this
> > configurable as to give users options, I'm wondering if it would be
> > better to cover a wider range.
> >

[...]

> 
> Hi Ionela,
>

[...]

> 
> Regarding a slower decay, we need a strong case for it.
> 
>

I think you mean faster decay, if you refer to my comment above.

To be blunt, I'm not sure there is a strong case for either kind of
dacay, if we look at the test results only. There is a theoretical case
for both, in my opinion and given that the purpose of this patch is to
give options to platform with different thermal characteristics, I do
believe it's worth providing a good range of options for the decay
period.

Thanks,
Ionela.

> 
> -- 
> Warm Regards
> Thara
