Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBFDCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4500D2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfJaGdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 02:33:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5657 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbfJaGdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 02:33:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D5BE744129F9C179275F;
        Thu, 31 Oct 2019 14:33:33 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 14:33:24 +0800
Subject: Re: [PATCH v2 06/36] irqchip/gic-v3-its: Kill its->device_ids and use
 TYPER copy instead
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
        "Robert Richter" <rrichter@marvell.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-7-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <603e60d8-b2a5-74a4-6d32-8277aa0e39c1@huawei.com>
Date:   Thu, 31 Oct 2019 14:33:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191027144234.8395-7-maz@kernel.org>
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

On 2019/10/27 22:42, Marc Zyngier wrote:
> Now that we have a copy of TYPER in the ITS structure, rely on this
> to provide the same service as its->device_ids, which gets axed.
> Errata workarounds are now updating the cached fields instead of
> requiring a separate field in the ITS structure.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

> ---
>   drivers/irqchip/irq-gic-v3-its.c   | 24 +++++++++++++-----------
>   include/linux/irqchip/arm-gic-v3.h |  2 +-
>   2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 3b046181ddfc..6c91c7feadf3 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -109,7 +109,6 @@ struct its_node {
>   	struct list_head	its_device_list;
>   	u64			flags;
>   	unsigned long		list_nr;
> -	u32			device_ids;
>   	int			numa_node;
>   	unsigned int		msi_domain_flags;
>   	u32			pre_its_base; /* for Socionext Synquacer */
> @@ -117,6 +116,7 @@ struct its_node {
>   };
>   
>   #define is_v4(its)		(!!((its)->typer & GITS_TYPER_VLPIS))
> +#define device_ids(its)		(FIELD_GET(GITS_TYPER_DEVBITS, (its)->typer) + 1)
>   
>   #define ITS_ITT_ALIGN		SZ_256
>   
> @@ -1938,9 +1938,9 @@ static bool its_parse_indirect_baser(struct its_node *its,
>   	if (new_order >= MAX_ORDER) {
>   		new_order = MAX_ORDER - 1;
>   		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
> -		pr_warn("ITS@%pa: %s Table too large, reduce ids %u->%u\n",
> +		pr_warn("ITS@%pa: %s Table too large, reduce ids %llu->%u\n",
>   			&its->phys_base, its_base_type_string[type],
> -			its->device_ids, ids);
> +			device_ids(its), ids);

But this pr_warn() looks a bit odd. The table type is chosen from
its_base_type_string[], but ids is always Devbits (+1)?


Thanks,
Zenghui

