Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528F9C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F442206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfI0HT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:19:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbfI0HT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:19:57 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5CA93AB8D235F5ACECF8;
        Fri, 27 Sep 2019 15:04:02 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 27 Sep 2019
 15:03:53 +0800
Subject: Re: [PATCH 03/35] irqchip/gic-v3-its: Allow LPI invalidation via the
 DirectLPI interface
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-4-maz@kernel.org>
 <92ff82ca-ebcb-8f5f-5063-313f65bbc5e3@huawei.com>
 <22202880-9a99-f0d9-4737-6112d60b30a6@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <9399fbe3-5293-d34f-712e-3bf62680fda4@huawei.com>
Date:   Fri, 27 Sep 2019 14:59:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <22202880-9a99-f0d9-4737-6112d60b30a6@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/27 0:17, Marc Zyngier wrote:
> On 26/09/2019 15:57, Zenghui Yu wrote:
>> Hi Marc,
>>
>> I get one kernel panic with this patch on D05.
> 
> Can you please try this (completely untested for now) on top of the
> whole series? I'll otherwise give it a go next week.

Yes, it helps. At least I don't see panic any more. Without this change,
the host would get crashed as long as the VM is started.


Thanks,
zenghui

> 
> Thanks,
> 
> 	M.
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index bc55327406b7..9d24236d1257 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3461,15 +3461,16 @@ static void its_vpe_send_cmd(struct its_vpe *vpe,
>   
>   static void its_vpe_send_inv(struct irq_data *d)
>   {
> +	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> +
>   	if (gic_rdists->has_direct_lpi) {
> -		/*
> -		 * Don't mess about. Generating the invalidation is easily
> -		 * done by using the parent irq_data, just like below.
> -		 */
> -		direct_lpi_inv(d->parent_data);
> -	} else {
> -		struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> +		void __iomem *rdbase;
>   
> +		/* Target the redistributor this VPE is currently known on */
> +		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
> +		gic_write_lpir(d->parent_data->hwirq, rdbase + GICR_INVLPIR);
> +		wait_for_syncr(rdbase);
> +	} else {
>   		its_vpe_send_cmd(vpe, its_send_inv);
>   	}
>   }
> 

