Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28E1C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B172E20989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfEMMFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:05:02 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:57374 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbfEMMFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:05:00 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id BC31A25AD69;
        Mon, 13 May 2019 22:04:58 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id A11E6E22B88; Mon, 13 May 2019 14:04:56 +0200 (CEST)
Date:   Mon, 13 May 2019 14:04:56 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] irqchip/renesas-irqc: Remove
 devm_kzalloc()/ioremap_nocache() error printing
Message-ID: <20190513120456.f63s7p37wwtmneyq@verge.net.au>
References: <20190429152006.22593-1-geert+renesas@glider.be>
 <20190429152006.22593-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429152006.22593-3-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 05:20:03PM +0200, Geert Uytterhoeven wrote:
> There is no need to print a message if devm_kzalloc() or
> ioremap_nocache() fails, as the memory allocation core already takes
> care of that.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/irqchip/irq-renesas-irqc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
> index 438a063c76156d98..0955ffe12b32eb36 100644
> --- a/drivers/irqchip/irq-renesas-irqc.c
> +++ b/drivers/irqchip/irq-renesas-irqc.c
> @@ -133,7 +133,6 @@ static int irqc_probe(struct platform_device *pdev)
>  
>  	p = kzalloc(sizeof(*p), GFP_KERNEL);
>  	if (!p) {
> -		dev_err(&pdev->dev, "failed to allocate driver data\n");
>  		ret = -ENOMEM;
>  		goto err0;
>  	}
> @@ -173,7 +172,6 @@ static int irqc_probe(struct platform_device *pdev)
>  	/* ioremap IOMEM and setup read/write callbacks */
>  	p->iomem = ioremap_nocache(io->start, resource_size(io));
>  	if (!p->iomem) {
> -		dev_err(&pdev->dev, "failed to remap IOMEM\n");
>  		ret = -ENXIO;
>  		goto err2;
>  	}
> -- 
> 2.17.1
> 
