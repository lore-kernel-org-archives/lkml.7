Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878C4FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E22222CE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfKHNAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:00:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727260AbfKHNAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:00:54 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 03E495EDAC00252799ED;
        Fri,  8 Nov 2019 21:00:51 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 8 Nov 2019
 21:00:42 +0800
Subject: Re: [PATCH 01/11] irqchip/gic-v3-its: Free collection mapping on
 device teardown
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <lorenzo.pieralisi@arm.com>, <Andrew.Murray@arm.com>,
        Heyi Guo <guoheyi@huawei.com>
References: <20191105162258.22214-1-maz@kernel.org>
 <20191105162258.22214-2-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <5c3034c6-7593-64c0-0cbe-43dc6a184bbb@huawei.com>
Date:   Fri, 8 Nov 2019 21:00:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20191105162258.22214-2-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/11/6 0:22, Marc Zyngier wrote:
> Somehow, we forgot to free the collection mapping when tearing down
> a device, hence slowly leaking mapping arrays as devices get removed
> from the system. That is, almost never.
> 
> Just to be safe, properly free the array on device teardown.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 787e8eec9a7f..07d0bde60e16 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2471,6 +2471,7 @@ static void its_free_device(struct its_device *its_dev)
>   	raw_spin_lock_irqsave(&its_dev->its->lock, flags);
>   	list_del(&its_dev->entry);
>   	raw_spin_unlock_irqrestore(&its_dev->its->lock, flags);
> +	kfree(its_dev->event_map.col_map);

I agreed that this is the appropriate place to free the collection
mapping (act as the counterpart of the allocation which happened in
its_create_device).  But as pointed out by Heyi [1], this will
introduce a double free issue.  We'd better also drop the kfree()
in its_irq_domain_free() in this patch?

(I find that it had been dropped in the last patch in your
irq/gic-5.5-wip branch, but maybe better here.)


[1] https://lkml.org/lkml/2019/7/15/329


Thanks,
Zenghui

>   	kfree(its_dev->itt);
>   	kfree(its_dev);
>   }
> 

