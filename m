Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD2FC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 07:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02536206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 07:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfLXHLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 02:11:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60266 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbfLXHLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:11:08 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 87DA525A48C8506A8904;
        Tue, 24 Dec 2019 15:11:06 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 15:10:56 +0800
Subject: Re: [PATCH v2 11/36] irqchip/gic-v4.1: VPE table (aka
 GICR_VPROPBASER) allocation
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Andrew Murray" <Andrew.Murray@arm.com>,
        Jayachandran C <jnair@marvell.com>,
        "Robert Richter" <rrichter@marvell.com>, <tangnianyao@huawei.com>,
        <wangwudi@hisilicon.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-12-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <61526052-aa00-0769-d5bb-3524161c5650@huawei.com>
Date:   Tue, 24 Dec 2019 15:10:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191027144234.8395-12-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

[ +Wudi and Nianyao. As they spotted the following issue but
  I forgot to send it out. ]

On 2019/10/27 22:42, Marc Zyngier wrote:
> GICv4.1 defines a new VPE table that is potentially shared between
> both the ITSs and the redistributors, following complicated affinity
> rules.
> 
> To make things more confusing, the programming of this table at
> the redistributor level is reusing the GICv4.0 GICR_VPROPBASER register
> for something completely different.
> 
> The code flow is somewhat complexified by the need to respect the
> affinities required by the HW, meaning that tables can either be
> inherited from a previously discovered ITS or redistributor.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---[...]
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 40912b3fb0e1..478d3678850c 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
[...]
> @@ -2025,6 +2098,214 @@ static int its_alloc_tables(struct its_node *its)
>   	return 0;
>   }
>   
> +static u64 inherit_vpe_l1_table_from_its(void)
> +{
> +	struct its_node *its;
> +	u64 val;
> +	u32 aff;
> +
> +	val = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
> +	aff = compute_common_aff(val);
> +
> +	list_for_each_entry(its, &its_nodes, entry) {
> +		u64 baser;
> +
> +		if (!is_v4_1(its))
> +			continue;
> +
> +		if (!FIELD_GET(GITS_TYPER_SVPET, its->typer))
> +			continue;
> +
> +		if (aff != compute_its_aff(its))
> +			continue;
> +
> +		/* GICv4.1 guarantees that the vPE table is GITS_BASER2 */
> +		baser = its->tables[2].val;
> +		if (!(baser & GITS_BASER_VALID))
> +			continue;
> +
> +		/* We have a winner! */
> +		val  = GICR_VPROPBASER_4_1_VALID;
> +		if (baser & GITS_BASER_INDIRECT)
> +			val |= GICR_VPROPBASER_4_1_INDIRECT;
> +		val |= FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE,
> +				  FIELD_GET(GITS_BASER_PAGE_SIZE_MASK, baser));
> +		val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR,
> +				  GITS_BASER_ADDR_48_to_52(baser) >> 12);

We've used GITS_BASER_ADDR_48_to_52() only in the KVM code where the
pagesize of ITS table is fixed to 64K.
It may not work when the pagesize is 4K or 16K?


Thanks,
Zenghui

> +		val |= FIELD_PREP(GICR_VPROPBASER_SHAREABILITY_MASK,
> +				  FIELD_GET(GITS_BASER_SHAREABILITY_MASK, baser));
> +		val |= FIELD_PREP(GICR_VPROPBASER_INNER_CACHEABILITY_MASK,
> +				  FIELD_GET(GITS_BASER_INNER_CACHEABILITY_MASK, baser));
> +		val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, GITS_BASER_NR_PAGES(baser) - 1);
> +
> +		return val;
> +	}
> +
> +	return 0;
> +}

