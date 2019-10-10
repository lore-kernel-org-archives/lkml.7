Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789B8C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560CE2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbfJJI0K convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:26:10 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50111 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfJJI0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:26:10 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5F40D24000D;
        Thu, 10 Oct 2019 08:26:07 +0000 (UTC)
Date:   Thu, 10 Oct 2019 10:26:06 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: maps: l440gx: Avoid print address to dmesg
Message-ID: <20191010102606.253ff6b9@xps13>
In-Reply-To: <20191010080130.25402-1-huangfq.daxian@gmail.com>
References: <20191010080130.25402-1-huangfq.daxian@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fuqian,

Fuqian Huang <huangfq.daxian@gmail.com> wrote on Thu, 10 Oct 2019
16:01:30 +0800:

> Avoid print the address of l440gx_map.virt every time l440gx init.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/mtd/maps/l440gx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/maps/l440gx.c b/drivers/mtd/maps/l440gx.c
> index 876f12f40018..e7e40bca82d1 100644
> --- a/drivers/mtd/maps/l440gx.c
> +++ b/drivers/mtd/maps/l440gx.c
> @@ -86,7 +86,6 @@ static int __init init_l440gx(void)
>  		return -ENOMEM;
>  	}
>  	simple_map_init(&l440gx_map);
> -	printk(KERN_NOTICE "window_addr = 0x%08lx\n", (unsigned long)l440gx_map.virt);
>  
>  	/* Setup the pm iobase resource
>  	 * This code should move into some kind of generic bridge


It looks more like a debug message, maybe turn it into a KERN_DEBUG?
Usually people do not run their kernels with such a low trace limit.

Thanks,
Miquèl
