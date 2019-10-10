Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2180FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018872067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbfJJNbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:31:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49652 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfJJNbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:31:40 -0400
Received: from dhcp-172-31-174-146.wireless.concordia.ca (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B004B29098D;
        Thu, 10 Oct 2019 14:31:38 +0100 (BST)
Date:   Thu, 10 Oct 2019 15:31:35 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] mtd: maps: l440gx: Avoid printing address to dmesg
Message-ID: <20191010153135.2b363c27@dhcp-172-31-174-146.wireless.concordia.ca>
In-Reply-To: <20191010084019.5190-1-huangfq.daxian@gmail.com>
References: <20191010084019.5190-1-huangfq.daxian@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 16:40:19 +0800
Fuqian Huang <huangfq.daxian@gmail.com> wrote:

> Avoid printing the address of l440gx_map.virt every time l440gx init.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/mtd/maps/l440gx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/maps/l440gx.c b/drivers/mtd/maps/l440gx.c
> index 876f12f40018..ebe37edc8e88 100644
> --- a/drivers/mtd/maps/l440gx.c
> +++ b/drivers/mtd/maps/l440gx.c
> @@ -86,7 +86,7 @@ static int __init init_l440gx(void)
>  		return -ENOMEM;
>  	}
>  	simple_map_init(&l440gx_map);
> -	printk(KERN_NOTICE "window_addr = 0x%08lx\n", (unsigned long)l440gx_map.virt);
> +	printk(KERN_DEBUG "window_addr = 0x%08lx\n", (unsigned long)l440gx_map.virt);

pr_debug() please, and use %p instead of this %lx with a cast.

>  
>  	/* Setup the pm iobase resource
>  	 * This code should move into some kind of generic bridge

