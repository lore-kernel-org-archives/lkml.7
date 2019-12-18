Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C97CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187D32176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfLRQQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:16:01 -0500
Received: from foss.arm.com ([217.140.110.172]:51546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfLRQQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:16:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8E4530E;
        Wed, 18 Dec 2019 08:16:00 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E94723F719;
        Wed, 18 Dec 2019 08:15:59 -0800 (PST)
Date:   Wed, 18 Dec 2019 16:15:57 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/smmuv3: Remove the leftover put_cpu() in error
 path
Message-ID: <20191218161557.GE50582@arrakis.emea.arm.com>
References: <1576046586-59145-1-git-send-email-guohanjun@huawei.com>
 <20191216122057.GB12947@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216122057.GB12947@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 12:20:57PM +0000, Will Deacon wrote:
> On Wed, Dec 11, 2019 at 02:43:06PM +0800, Hanjun Guo wrote:
> > In smmu_pmu_probe(), there is put_cpu() in the error path,
> > which is wrong because we use raw_smp_processor_id() to
> > get the cpu ID, not get_cpu(), remove it.
> > 
> > While we are at it, kill 'out_cpuhp_err' altogether and
> > just return err if we fail to add the hotplug instance.
> > 
> > Acked-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> > ---
> >  drivers/perf/arm_smmuv3_pmu.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> > index 773128f..d704ecc 100644
> > --- a/drivers/perf/arm_smmuv3_pmu.c
> > +++ b/drivers/perf/arm_smmuv3_pmu.c
> > @@ -814,7 +814,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
> >  	if (err) {
> >  		dev_err(dev, "Error %d registering hotplug, PMU @%pa\n",
> >  			err, &res_0->start);
> > -		goto out_cpuhp_err;
> > +		return err;
> >  	}
> >  
> >  	err = perf_pmu_register(&smmu_pmu->pmu, name, -1);
> > @@ -833,8 +833,6 @@ static int smmu_pmu_probe(struct platform_device *pdev)
> >  
> >  out_unregister:
> >  	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
> > -out_cpuhp_err:
> > -	put_cpu();
> >  	return err;
> >  }
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Catalin -- please can you take this as a fix via the arm64 tree? I don't
> have any other perf patches pending at the moment.

Queued.

-- 
Catalin
