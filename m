Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75825C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4832D2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfDURYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:24:22 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:60527 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDURYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:24:21 -0400
X-Originating-IP: 93.23.249.69
Received: from localhost (69.249.23.93.rev.sfr.net [93.23.249.69])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A7977240002;
        Sun, 21 Apr 2019 17:24:18 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] ARM: mvebu: fix a leaked reference by adding missing of_node_put
In-Reply-To: <1551785577-45896-2-git-send-email-wen.yang99@zte.com.cn>
References: <1551785577-45896-1-git-send-email-wen.yang99@zte.com.cn> <1551785577-45896-2-git-send-email-wen.yang99@zte.com.cn>
Date:   Sun, 21 Apr 2019 19:24:17 +0200
Message-ID: <877ebn8e66.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen Yang,

> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-mvebu/pm-board.c:135:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 88, but without a corresponding object release within this functio
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied on mvebu/arm

Thanks,

Gregory

> ---
>  arch/arm/mach-mvebu/pm-board.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
> index db17121..1e2c17c 100644
> --- a/arch/arm/mach-mvebu/pm-board.c
> +++ b/arch/arm/mach-mvebu/pm-board.c
> @@ -79,7 +79,7 @@ static void mvebu_armada_pm_enter(void __iomem *sdram_reg, u32 srcmd)
>  static int __init mvebu_armada_pm_init(void)
>  {
>  	struct device_node *np;
> -	struct device_node *gpio_ctrl_np;
> +	struct device_node *gpio_ctrl_np = NULL;
>  	int ret = 0, i;
>  
>  	if (!of_machine_is_compatible("marvell,axp-gp"))
> @@ -126,18 +126,23 @@ static int __init mvebu_armada_pm_init(void)
>  			goto out;
>  		}
>  
> +		if(gpio_ctrl_np)
> +			of_node_put(gpio_ctrl_np);
>  		gpio_ctrl_np = args.np;
>  		pic_raw_gpios[i] = args.args[0];
>  	}
>  
>  	gpio_ctrl = of_iomap(gpio_ctrl_np, 0);
> -	if (!gpio_ctrl)
> -		return -ENOMEM;
> +	if (!gpio_ctrl) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>  
>  	mvebu_pm_suspend_init(mvebu_armada_pm_enter);
>  
>  out:
>  	of_node_put(np);
> +	of_node_put(gpio_ctrl_np);
>  	return ret;
>  }
>  
> -- 
> 2.9.5
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
