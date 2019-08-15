Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAE0C3A59B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 15:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AE9208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565882601;
	bh=3KBqf0uqTC0ABTjfZbdiuByQVZZGp/ONMP3E9R4V9jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ks8bRpS/l/6Adv0TewoBzPMJ1OHj9+aEzOJrOeFkuH/UEjNjl/ZQuGxjGq0C/OeNC
	 sldVc4tbQFEJDos72Kr7kil0Wevz+zA+s0Y21Rty+v/5EGh9xdSSFU2K509H+psSDX
	 U5pKQcve+DUd7RGvayk7gRMM0Plirj16nDt+NLrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfHOPXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 11:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728846AbfHOPXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 11:23:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85BCE20644;
        Thu, 15 Aug 2019 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565882599;
        bh=3KBqf0uqTC0ABTjfZbdiuByQVZZGp/ONMP3E9R4V9jQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qrYDyUNz5qqZaU1zX67lb+YeBx/VbjPGwOOxiCzCBPo22QkgFau7YFUkM6EaPfuDE
         K0JZYQeaVspP7x1io+ebzsGGGULqyIcq4xFjvpe5N/CFu6xNZSsz1K4NMLZ3WIsXB2
         5zkL7N/gFTlAPoPFQK1yfcpZRq2R+SJKkOFNys1k=
Date:   Thu, 15 Aug 2019 16:23:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: add nr_ats_masters for quickly
 check
Message-ID: <20190815152313.apa2d5rzhqa34l7l@willie-the-truck>
References: <20190815054439.30652-1-thunder.leizhen@huawei.com>
 <20190815054439.30652-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815054439.30652-3-thunder.leizhen@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 01:44:39PM +0800, Zhen Lei wrote:
> When (smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS) is true, even if a
> smmu domain does not contain any ats master, the operations of
> arm_smmu_atc_inv_to_cmd() and lock protection in arm_smmu_atc_inv_domain()
> are always executed. This will impact performance, especially in
> multi-core and stress scenarios. For my FIO test scenario, about 8%
> performance reduced.
> 
> In fact, we can use a struct member to record how many ats masters that
> the smmu contains. And check that without traverse the list and check all
> masters one by one in the lock protection.
> 
> Fixes: 9ce27afc0830 ("iommu/arm-smmu-v3: Add support for PCI ATS")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 29056d9bb12aa01..154334d3310c9b8 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -631,6 +631,7 @@ struct arm_smmu_domain {
>  
>  	struct io_pgtable_ops		*pgtbl_ops;
>  	bool				non_strict;
> +	int				nr_ats_masters;
>  
>  	enum arm_smmu_domain_stage	stage;
>  	union {
> @@ -1531,7 +1532,16 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>  	struct arm_smmu_cmdq_ent cmd;
>  	struct arm_smmu_master *master;
>  
> -	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
> +	/*
> +	 * The protectiom of spinlock(&iommu_domain->devices_lock) is omitted.
> +	 * Because for a given master, its map/unmap operations should only be
> +	 * happened after it has been attached and before it has been detached.
> +	 * So that, if at least one master need to be atc invalidated, the
> +	 * value of smmu_domain->nr_ats_masters can not be zero.
> +	 *
> +	 * This can alleviate performance loss in multi-core scenarios.
> +	 */

I find this reasoning pretty dubious, since I think you're assuming that
an endpoint cannot issue speculative ATS translation requests once its
ATS capability is enabled. That said, I think it also means we should enable
ATS in the STE *before* enabling it in the endpoint -- the current logic
looks like it's the wrong way round to me (including in detach()).

Anyway, these speculative translations could race with a concurrent unmap()
call and end up with the ATC containing translations for unmapped pages,
which I think we should try to avoid.

Did the RCU approach not work out? You could use an rwlock instead as a
temporary bodge if the performance doesn't hurt too much.

Alternatively... maybe we could change the attach flow to do something
like:

	enable_ats_in_ste(master);
	enable_ats_at_pcie_endpoint(master);
	spin_lock(devices_lock)
	add_to_device_list(master);
	nr_ats_masters++;
	spin_unlock(devices_lock);
	invalidate_atc(master);

in which case, the concurrent unmapper will be doing something like:

	issue_tlbi();
	smp_mb();
	if (READ_ONCE(nr_ats_masters)) {
		...
	}

and I *think* that means that either the unmapper will see the
nr_ats_masters update and perform the invalidation, or they'll miss
the update but the attach will invalidate the ATC /after/ the TLBI
in the command queue.

Also, John's idea of converting this stuff over to my command batching
mechanism should help a lot if we can defer this to sync time using the
gather structure. Maybe an rwlock would be alright for that. Dunno.

Will
