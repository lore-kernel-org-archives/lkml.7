Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F69CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CEC217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfKAMzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:55:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfKAMzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:55:42 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 796CB10D7238D12C25CA;
        Fri,  1 Nov 2019 20:55:38 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 20:55:29 +0800
Subject: Re: [PATCH v2 22/36] irqchip/gic-v4.1: Advertise support v4.1 to KVM
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
 <20191027144234.8395-23-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <14462a79-fc0b-b8e5-115a-dfb505351acb@huawei.com>
Date:   Fri, 1 Nov 2019 20:55:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191027144234.8395-23-maz@kernel.org>
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
> Tell KVM that we support v4.1. Nothing uses this information so far.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/irqchip/irq-gic-v3-its.c       | 9 ++++++++-
>   drivers/irqchip/irq-gic-v3.c           | 1 +
>   include/linux/irqchip/arm-gic-common.h | 2 ++
>   3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index df259e202482..6483f8051b3e 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4580,6 +4580,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>   	struct device_node *of_node;
>   	struct its_node *its;
>   	bool has_v4 = false;
> +	bool has_v4_1 = false;
>   	int err;
>   
>   	gic_rdists = rdists;
> @@ -4600,8 +4601,14 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>   	if (err)
>   		return err;
>   
> -	list_for_each_entry(its, &its_nodes, entry)
> +	list_for_each_entry(its, &its_nodes, entry) {
>   		has_v4 |= is_v4(its);
> +		has_v4_1 |= is_v4_1(its);
> +	}
> +
> +	/* Don't bother with inconsistent systems */
> +	if (WARN_ON(!has_v4_1 && rdists->has_rvpeid))
> +		rdists->has_rvpeid = false;
>   
>   	if (has_v4 & rdists->has_vlpis) {
>   		if (its_init_vpe_domain() ||
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index f0d33ac64a99..94dddfb21076 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1758,6 +1758,7 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
>   		gic_v3_kvm_info.vcpu = r;
>   
>   	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
> +	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;

Also set gic_v3_kvm_info.has_v4_1 in gic_acpi_setup_kvm_info().


Thanks,
Zenghui

>   	gic_set_kvm_info(&gic_v3_kvm_info);
>   }
>   
> diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
> index b9850f5f1906..fa8c0455c352 100644
> --- a/include/linux/irqchip/arm-gic-common.h
> +++ b/include/linux/irqchip/arm-gic-common.h
> @@ -32,6 +32,8 @@ struct gic_kvm_info {
>   	struct resource vctrl;
>   	/* vlpi support */
>   	bool		has_v4;
> +	/* rvpeid support */
> +	bool		has_v4_1;
>   };
>   
>   const struct gic_kvm_info *gic_get_kvm_info(void);
> 

