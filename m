Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2EFC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A2221823
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575550063;
	bh=VEJnwIcby7NkSIHqk+WsjfPDD9MrludIZFXfKcseyTU=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=kCHjFQvo3ZKrBFDnnt9+pyLibuauLOX/pi1LMj8A+gNhg08hCH29qIubLRuety13e
	 FfZe9zCTv9VYQCrapkKGJ2VlPIwC26GtdQKwuAqkq9smEkNaC5RBmuQL1C4xbPKsc/
	 flINzwLDWk8JsVtKuc0ZZsOLr6lXZwRV59kKeXLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfLEMrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:47:42 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:42311 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729096AbfLEMrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:47:42 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1icqXi-00068a-Dx; Thu, 05 Dec 2019 13:47:38 +0100
To:     Gaurav Kohli <gkohli@codeaurora.org>
Subject: Re: [PATCH v0] irqchip/gic-v3: Avoid check of lpi configuration for  non existent cpu
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Dec 2019 12:47:38 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
In-Reply-To: <1575543357-31892-1-git-send-email-gkohli@codeaurora.org>
References: <1575543357-31892-1-git-send-email-gkohli@codeaurora.org>
Message-ID: <60f61282c1b1e512ca6ce638b6dfca09@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: gkohli@codeaurora.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gaurav,

On 2019-12-05 10:55, Gaurav Kohli wrote:
> As per GIC specification, we can configure gic for more no of cpus
> then the available cpus in the soc, But this can cause mem abort
> while iterating lpi region for non existent cpu as we don't map

Which LPI region? We're talking about RDs, right... Or does LPI mean
something other than GIC LPIs for you?

> redistrubutor region for non-existent cpu.
>
> To avoid this issue, put one more check of valid mpidr.

Sorry, but I'm not sure I grasp your problem. Let me try and rephrase 
it:

- Your GIC is configured for (let's say) 8 CPUs, and your SoC has only 
4.

- As part of the probing, the driver iterates on the RD regions and 
explodes
   because something isn't mapped?

That'd be a grave bug, but I believe the issue is somewhere else.

>
> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
>
> diff --git a/drivers/irqchip/irq-gic-v3.c 
> b/drivers/irqchip/irq-gic-v3.c
> index 1edc993..adc9186 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -766,6 +766,7 @@ static int gic_iterate_rdists(int (*fn)(struct
> redist_region *, void __iomem *))
>  {
>  	int ret = -ENODEV;
>  	int i;
> +	int cpu = 0;
>
>  	for (i = 0; i < gic_data.nr_redist_regions; i++) {
>  		void __iomem *ptr = gic_data.redist_regions[i].redist_base;
> @@ -780,6 +781,7 @@ static int gic_iterate_rdists(int (*fn)(struct
> redist_region *, void __iomem *))
>  		}
>
>  		do {
> +			cpu++;
>  			typer = gic_read_typer(ptr + GICR_TYPER);
>  			ret = fn(gic_data.redist_regions + i, ptr);
>  			if (!ret)
> @@ -795,7 +797,8 @@ static int gic_iterate_rdists(int (*fn)(struct
> redist_region *, void __iomem *))
>  				if (typer & GICR_TYPER_VLPIS)
>  					ptr += SZ_64K * 2; /* Skip VLPI_base + reserved page */
>  			}
> -		} while (!(typer & GICR_TYPER_LAST));
> +		} while (!(typer & GICR_TYPER_LAST) &&
> +					cpu_logical_map(cpu) != INVALID_HWID);
>  	}
>
>  	return ret ? -ENODEV : 0;

This makes little sense. A redistributor region contains a bunch of 
RDs,
each of which maps onto a given CPU. We iterate on the RDs, and not on 
the
CPUs, as it is the RD that tells us which CPU it is affine with, not 
the
other way around.

If a RD is for some reason unavailable, then it shouldn't be described 
in
the firmware the first place. If you end-up exposing RD regions that do
not have the last RD having GICR_TYPER.Last set, then your SoC is 
broken,
and this needs yet another quirk.

         M.
-- 
Jazz is not dead. It just smells funny...
