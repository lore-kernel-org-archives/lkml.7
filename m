Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEDDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF042075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfC0RPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:15:49 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:35770 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfC0RPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:15:49 -0400
Received: from localhost.localdomain (unknown [116.84.110.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 90C17CA7F5;
        Wed, 27 Mar 2019 18:15:43 +0100 (CET)
Subject: Re: [PATCH] net: ieee802154: fix missing checks for
 regmap_update_bits
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Xue Liu <liuxuenetmail@gmail.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190324231856.2664-1-kjlu@umn.edu>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <bc46d1b9-92eb-e1b7-aca6-28a743c59194@datenfreihafen.org>
Date:   Thu, 28 Mar 2019 02:15:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190324231856.2664-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 25.03.19 08:18, Kangjie Lu wrote:
> regmap_update_bits could fail and deserves a check.
> 
> The patch adds the checks and if it fails, returns its error
> code upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/ieee802154/mcr20a.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index c589f5ae75bb..8bb53ec8d9cf 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -533,6 +533,8 @@ mcr20a_start(struct ieee802154_hw *hw)
>  	dev_dbg(printdev(lp), "no slotted operation\n");
>  	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>  				 DAR_PHY_CTRL1_SLOTTED, 0x0);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* enable irq */
>  	enable_irq(lp->spi->irq);
> @@ -540,11 +542,15 @@ mcr20a_start(struct ieee802154_hw *hw)
>  	/* Unmask SEQ interrupt */
>  	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL2,
>  				 DAR_PHY_CTRL2_SEQMSK, 0x0);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* Start the RX sequence */
>  	dev_dbg(printdev(lp), "start the RX sequence\n");
>  	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>  				 DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);
> +	if (ret < 0)
> +		return ret;
>  
>  	return 0;
>  }
> 

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
