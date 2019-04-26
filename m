Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6EDC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF504206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lBLB0Yol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfDZOVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:21:14 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45540 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfDZOVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6TOYRVLSYm3pTlQplTTOyVWUN3SL+or4WplAj6u3u6A=; b=lBLB0YolKVoDNMdFde2qgyArKA
        uDp6BvGQ/+RJI1QDbFvUjoI71zb9wwyEWHdpNbwXXMnyec5DdkFWVUEwxKo44LcnC63rW/uj1Aaok
        YTwMkwUV27KSMdZbhqP3lTuZdm/M8Iz4HhtduBhSL1P4oeWIOyNEjEoZl7MJjhMdEC5U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hK1ip-0001G8-6M; Fri, 26 Apr 2019 16:21:03 +0200
Date:   Fri, 26 Apr 2019 16:21:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Esben Haabendal <esben@geanix.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Yang Wei <yang.wei9@zte.com.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] net: ll_temac: Fix iommu/swiotlb leak
Message-ID: <20190426142103.GI14432@lunn.ch>
References: <20190426073231.4008-1-esben@geanix.com>
 <20190426073231.4008-9-esben@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426073231.4008-9-esben@geanix.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 09:32:27AM +0200, Esben Haabendal wrote:
> Unmap the actual buffer length, not the amount of data received.

Hi Esben

The patch Subject does not seem to match the content?

Also, there can be performance advantages of just unmapping the
received length. The unmap operation does a cache invalidate, which
can be expensive. Consider the effort of unmapping a 64 byte ACK vs 9K
jumbo frame?

      Andrew
 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
> index 309f149..56d8077 100644
> --- a/drivers/net/ethernet/xilinx/ll_temac_main.c
> +++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
> @@ -821,7 +821,7 @@ static void ll_temac_recv(struct net_device *ndev)
>  		length = be32_to_cpu(cur_p->app4) & 0x3FFF;
>  
>  		dma_unmap_single(ndev->dev.parent, be32_to_cpu(cur_p->phys),
> -				 length, DMA_FROM_DEVICE);
> +				 XTE_MAX_JUMBO_FRAME_SIZE, DMA_FROM_DEVICE);
>  
>  		skb_put(skb, length);
>  		skb->protocol = eth_type_trans(skb, ndev);
> -- 
> 2.4.11
> 
