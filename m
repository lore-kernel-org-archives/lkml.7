Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA13C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 18:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798A520833
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 18:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575223494;
	bh=pqAi1JkER9NfqM1LYzhsF4Je7X+u8Mh5AQt5yCTnw/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=N2InHGHRqXy5W+01g7o3Ob1ETBquQFkJFAKnh3zh890jWmRXkTA6RceJDnqpuiEfT
	 9AHDmxBNGXu7JUUUGm7jUCPcuOdm+X9GfLu2c8aCJzMQBGNlS1RoUt/ospFP02om8J
	 ZEabn6QVuo/Vg+fdJifOFTRFs2KkMxzjGTXfB75w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfLASEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 13:04:39 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:49445 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbfLASEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 13:04:38 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ibTaF-0003tt-MP; Sun, 01 Dec 2019 19:04:35 +0100
Date:   Sun, 1 Dec 2019 18:04:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Heyi Guo <guoheyi@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] irq/gic-its: gicv4: set VPENDING table as
 inner-shareable
Message-ID: <20191201180434.1dba3116@why>
In-Reply-To: <20191130073849.38378-1-guoheyi@huawei.com>
References: <20191130073849.38378-1-guoheyi@huawei.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: guoheyi@huawei.com, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Nov 2019 15:38:49 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> There is no special reason to set virtual LPI pending table as
> non-shareable. If we choose to hard code the shareability without
> probing, inner-shareable will be a better choice, for all the other
> ITS/GICR tables prefer to be inner-shareable.

One of the issues is that we have strictly no idea what the caches are
Inner Shareable with (I've been asking for such clarification for years
without getting anywhere). You can have as many disconnected inner
shareable domains as you want!

I suspect that in the grand scheme of things, the redistributors
ought to be in the same inner shareable domain, and that with a bit of
luck, the CPUs are there as well. Still, that's a massive guess.

> What's more, on Hisilicon hip08 it will trigger some kind of bus
> warning when mixing use of different shareabilities.

Do you have more information about what the bus is complaining about?
Is that because the CPUs have these pages mapped as inner shareable?

I'll give it a go on D05 (HIP07) to find out what changes there.

Thanks,

	M.

> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 2 +-
>  include/linux/irqchip/arm-gic-v3.h | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 787e8eec9a7f..d31e863bc9ef 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2831,7 +2831,7 @@ static void its_vpe_schedule(struct its_vpe *vpe)
>  	val  = virt_to_phys(page_address(vpe->vpt_page)) &
>  		GENMASK_ULL(51, 16);
>  	val |= GICR_VPENDBASER_RaWaWb;
> -	val |= GICR_VPENDBASER_NonShareable;
> +	val |= GICR_VPENDBASER_InnerShareable;
>  	/*
>  	 * There is no good way of finding out if the pending table is
>  	 * empty as we can race against the doorbell interrupt very
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 5cc10cf7cb3e..a184f875e451 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -289,6 +289,9 @@
>  #define GICR_VPENDBASER_NonShareable					\
>  	GIC_BASER_SHAREABILITY(GICR_VPENDBASER, NonShareable)
>  
> +#define GICR_VPENDBASER_InnerShareable					\
> +	GIC_BASER_SHAREABILITY(GICR_VPENDBASER, InnerShareable)
> +
>  #define GICR_VPENDBASER_nCnB	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, nCnB)
>  #define GICR_VPENDBASER_nC 	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, nC)
>  #define GICR_VPENDBASER_RaWt	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, RaWt)



-- 
Jazz is not dead. It just smells funny...
