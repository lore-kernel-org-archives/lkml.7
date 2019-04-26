Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D62C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A67B212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="MDSDbml2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfDZSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:40:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34720 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfDZSkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:40:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id j6so5273818qtq.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=oiWrrRsaoIdmOHtXZ3vrwqmAe9ZJbU+oxj1zFhSUEi0=;
        b=MDSDbml2h+OwU7bB2+JiMxmydA+lqekSeYoElqkaSEecUWBA3t9/ncfwuZi32xCYka
         TAmFWpUyTfugU4oCNtUspjneOmb4xHjnCWxak6wyD4T6ATY1dP05d/LXgk1Hb9xSpJq0
         YXhZutuVnooxt1G4GZnxaEa6JDDbHuUVALzKn2cc9hMRghvbrXpgr7L2x/lLjNUFj/E5
         A70TNaTZgp7IFILx8V9EbGUcRKHb/f/ZBxE8CDeEkYVbyN7xsclvvolIS4Gu/0+d504f
         pinRA/rJMjq4PkEucoRHMGipsw6fz78ZWN17oUCUW5uezyaZ9Q7th5LybNvt1Q2R4JEV
         ZD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=oiWrrRsaoIdmOHtXZ3vrwqmAe9ZJbU+oxj1zFhSUEi0=;
        b=MYwjU+0cfjZGQ8s2FDNeOOgFurR395SooQdxcjVHjp/ef1sCHcoJcUDzcG+2hpH6gv
         L34Ewbq6onrNa0Zhd8evzv/qGhKdVN2z1fiQi3si/hqfk1bbxyp9JPvVSRytnJCtzTPJ
         tPzNa7ljVkvpTDUbbCGQFZn/twMnSrOznHyW5pdLxylzwfrRKNrjZYhs2+Nfi6BTEFkg
         izbbVJVhASNrFr2+s+TpoUBhfaj9CelDj/Av2+ltIKTQwgWAD6BWCOaztLIxYhvioS3H
         YXp7bhIPu/GJnZUGV0gpiFE54l21qzRhhj2xs2oSH/pXqRe83zvAzXtHpujZ46jMRCgi
         0YFQ==
X-Gm-Message-State: APjAAAWLz8mm8n5P9T1J9kc12BSCtaLvZO5A8e0stkrl4FQbhDR/adSc
        iUSVSjNpQd8NEK13Vat0QNkv0g==
X-Google-Smtp-Source: APXvYqxI1s7dTEUb53dI0Zdnysi2H4UWsSw7nEJEJQ2yVyo2K+g+KqYBcFmnHBppp1ZIBcsFG7H5Lg==
X-Received: by 2002:ac8:396e:: with SMTP id t43mr17769510qtb.1.1556304018243;
        Fri, 26 Apr 2019 11:40:18 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id p19sm6001829qtp.19.2019.04.26.11.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 11:40:18 -0700 (PDT)
Date:   Fri, 26 Apr 2019 11:40:13 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Esben Haabendal <esben@geanix.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Yang Wei <yang.wei9@zte.com.cn>,
        YueHaibing <yuehaibing@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] net: ll_temac: Fix support for 64-bit platforms
Message-ID: <20190426114013.333e62c8@cakuba.netronome.com>
In-Reply-To: <20190426073231.4008-4-esben@geanix.com>
References: <20190426073231.4008-1-esben@geanix.com>
        <20190426073231.4008-4-esben@geanix.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 09:32:22 +0200, Esben Haabendal wrote:
> The use of buffer descriptor APP4 field (32-bit) for storing skb pointer
> obviously does not work on 64-bit platforms.
> As APP3 is also unused, we can use that to store the other half of 64-bit
> pointer values.
> 
> Contrary to what is hinted at in commit message of commit 15bfe05c8d63
> ("net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit")
> there are no other pointers stored in cdmac_bd.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>

This is a bit strange, the driver stores the host's virtual address into
the HW descriptor?

> diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
> index da4ec57..6d68c8a 100644
> --- a/drivers/net/ethernet/xilinx/Kconfig
> +++ b/drivers/net/ethernet/xilinx/Kconfig
> @@ -34,7 +34,6 @@ config XILINX_AXI_EMAC
>  config XILINX_LL_TEMAC
>  	tristate "Xilinx LL TEMAC (LocalLink Tri-mode Ethernet MAC) driver"
>  	depends on (PPC || MICROBLAZE)
> -	depends on !64BIT || BROKEN
>  	select PHYLIB
>  	---help---
>  	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC
> diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
> index 4594fe3..a365bfd 100644
> --- a/drivers/net/ethernet/xilinx/ll_temac_main.c
> +++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
> @@ -619,11 +619,39 @@ static void temac_adjust_link(struct net_device *ndev)
>  	mutex_unlock(&lp->indirect_mutex);
>  }
>  
> +#ifdef CONFIG_64BIT
> +
> +void ptr_to_txbd(void *p, struct cdmac_bd *bd)
> +{
> +	bd->app3 = (u32)(((u64)p) >> 32);
> +	bd->app4 = (u32)((u64)p & 0xFFFFFFFF);
> +}
> +
> +void *ptr_from_txbd(struct cdmac_bd *bd)
> +{
> +	return (void *)(((u64)(bd->app3) << 32) | bd->app4);
> +}
> +
> +#else
> +
> +void ptr_to_txbd(void *p, struct cmdac_bd *bd)
> +{
> +	bd->app4 = (u32)p;
> +}
> +
> +void *ptr_from_txbd(struct cdmac_bd *bd)
> +{
> +	return (void *)(bd->app4);
> +}
> +
> +#endif
> +
>  static void temac_start_xmit_done(struct net_device *ndev)
>  {
>  	struct temac_local *lp = netdev_priv(ndev);
>  	struct cdmac_bd *cur_p;
>  	unsigned int stat = 0;
> +	struct sk_buff *skb;
>  
>  	cur_p = &lp->tx_bd_v[lp->tx_bd_ci];
>  	stat = cur_p->app0;
> @@ -631,8 +659,9 @@ static void temac_start_xmit_done(struct net_device *ndev)
>  	while (stat & STS_CTRL_APP0_CMPLT) {
>  		dma_unmap_single(ndev->dev.parent, cur_p->phys, cur_p->len,
>  				 DMA_TO_DEVICE);
> -		if (cur_p->app4)
> -			dev_consume_skb_irq((struct sk_buff *)cur_p->app4);
> +		skb = (struct sk_buff *)ptr_from_txbd(cur_p);
> +		if (skb)
> +			dev_consume_skb_irq(skb);
>  		cur_p->app0 = 0;
>  		cur_p->app1 = 0;
>  		cur_p->app2 = 0;
> @@ -711,7 +740,7 @@ temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	cur_p->len = skb_headlen(skb);
>  	cur_p->phys = dma_map_single(ndev->dev.parent, skb->data,
>  				     skb_headlen(skb), DMA_TO_DEVICE);
> -	cur_p->app4 = (unsigned long)skb;
> +	ptr_to_txbd((void *)skb, cur_p);
>  
>  	for (ii = 0; ii < num_frag; ii++) {
>  		lp->tx_bd_tail++;

