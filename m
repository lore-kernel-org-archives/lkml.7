Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D21C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A514207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575987036;
	bh=pDfWgToeCwKXy4rZwMgvZbyi7USiItVyJhcdghsgXJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2t9QMOQDrnAN3fIftUyDissi826fcXbPlWghA6Y9uS4MTo1HHWGwX/lXa8E3ZFbM2
	 ptJtMvT9Ztgrg6p9hjuKn+ag/t5vbARrweZVSySBBjdtMsFUbZr8ijejZs5N/G0tey
	 +r2jG9xOawwMjXtBDrYiM45QyEnh9yi8V/pUIBDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfLJOKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfLJOKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:10:34 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3ED22073B;
        Tue, 10 Dec 2019 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575987034;
        bh=pDfWgToeCwKXy4rZwMgvZbyi7USiItVyJhcdghsgXJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QspxdB2WHMDogjPzjFOUV7usPNe/GEhwj72SX925rqO4kbaUoWnkvvQeG0J9Xb0rB
         mgOGnEH4+GRYP7pWOHcsDPqBOMFSQHJXSSl+DqVcYjBfl6qjunFGtqytrrdJpnpR+V
         STSy/Bu7HiFuSk3/lUMrZbYEVIuzX6BPRpXTkfBY=
Date:   Tue, 10 Dec 2019 14:10:29 +0000
From:   Will Deacon <will@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/smmuv3: Remove the leftover put_cpu() in error path
Message-ID: <20191210141029.GB19183@willie-the-truck>
References: <1575974784-55046-1-git-send-email-guohanjun@huawei.com>
 <20191210132458.GA19183@willie-the-truck>
 <d251a136-2722-93ba-1bea-0000bf257db2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d251a136-2722-93ba-1bea-0000bf257db2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:55:28PM +0800, Hanjun Guo wrote:
> On 2019/12/10 21:24, Will Deacon wrote:
> > On Tue, Dec 10, 2019 at 06:46:24PM +0800, Hanjun Guo wrote:
> >> In smmu_pmu_probe(), there is put_cpu() in the error path,
> >> which is wrong because we use raw_smp_processor_id() to
> >> get the cpu ID, not get_cpu(), remove it.
> >>
> >> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> >> ---
> >>  drivers/perf/arm_smmuv3_pmu.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> >> index 773128f..fd1d46a 100644
> >> --- a/drivers/perf/arm_smmuv3_pmu.c
> >> +++ b/drivers/perf/arm_smmuv3_pmu.c
> >> @@ -834,7 +834,6 @@ static int smmu_pmu_probe(struct platform_device *pdev)
> >>  out_unregister:
> >>  	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
> >>  out_cpuhp_err:
> >> -	put_cpu();
> >>  	return err;
> > 
> > Can we kill 'out_cpuhp_err' altogether then and just return err if we fail
> > to add the hotplug instance?
> 
> Makes sense, but I think we can go further to kill both 'out_cpuhp_err' and
> 'out_register' as below [1], what do you think?

Although that's functionally correct, I'd prefer to keep out_unregister(),
since it acts as good reminder to anybody extending this function in future
that they need to unregister the hotplug instance on failure.

Will
