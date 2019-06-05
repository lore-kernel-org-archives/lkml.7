Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046ACC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CC520866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559726401;
	bh=FZid3iZIC4Rv5X+erq0U81RMe3PNMwfiFD1mq2Y047A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dg9RAGSw9p8b4xF5Ed1BG+moRaYpfRxu+9CBXJZFa4xzIxJGZxuFBKbNYopZOQmJg
	 ElL8b9oAXRE7LmFJBnObke8HzzbtuNUZzv1WHv53E1nBrqYSpM7bnz+f5DMR+/Ugtr
	 17N/Z1AQezQ+xZ7+6gT8LOejF3s1n6yQxjER5+FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfFEJUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfFEJUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:20:00 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A5E2075B;
        Wed,  5 Jun 2019 09:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559726399;
        bh=FZid3iZIC4Rv5X+erq0U81RMe3PNMwfiFD1mq2Y047A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJBnlb9OnMtwF7KEkX4mRIJ3lu/ZzZitk7k4ZxZ6UqCOtaRX5psjR9ihBFO/iySqW
         xBwm1h9fTD4Sb2DmeQfavdYll0DKEsyD6RU5N7KkvAackLWQwWExUyhYEjbqC3voWx
         /34xIx6OjmaoIj/vBpFoMl0YSf8pqK40nLY6jk38=
Date:   Wed, 5 Jun 2019 17:19:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-usb@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: phy: mxs: Disable external charger detect in
 mxs_phy_hw_init()
Message-ID: <20190605091943.GN29853@dragon>
References: <20190529065948.5492-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529065948.5492-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 11:59:48PM -0700, Andrey Smirnov wrote:
> Since this driver already handles changer detction state, copy the
> workaround code currently residing in arch/arm/mach-imx/anatop.c into
> this drier to consolidate the places modifying it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Shawn Guo <shawnguo@kernel.org>

> ---
> 
> The intent of this patch is to consolidate all of the code maipulating
> charge detection state to a signle place and if this patch is agreed
> upon I plan to follow it up with this change:
> 
> https://github.com/ndreys/linux/commit/7248f2b85b4706760fd33d2ff970e2ea12d3bea7
> 
> Thanks,
> Andrey Smirnov
> 
>  drivers/usb/phy/phy-mxs-usb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index 1b1bb0ad40c3..6fa16ab31e2e 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -63,6 +63,7 @@
>  
>  #define ANADIG_USB1_CHRG_DETECT_SET		0x1b4
>  #define ANADIG_USB1_CHRG_DETECT_CLR		0x1b8
> +#define ANADIG_USB2_CHRG_DETECT_SET		0x214
>  #define ANADIG_USB1_CHRG_DETECT_EN_B		BIT(20)
>  #define ANADIG_USB1_CHRG_DETECT_CHK_CHRG_B	BIT(19)
>  #define ANADIG_USB1_CHRG_DETECT_CHK_CONTACT	BIT(18)
> @@ -250,6 +251,19 @@ static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
>  	if (mxs_phy->data->flags & MXS_PHY_NEED_IP_FIX)
>  		writel(BM_USBPHY_IP_FIX, base + HW_USBPHY_IP_SET);
>  
> +	if (mxs_phy->regmap_anatop) {
> +		unsigned int reg = mxs_phy->port_id ?
> +			ANADIG_USB1_CHRG_DETECT_SET :
> +			ANADIG_USB2_CHRG_DETECT_SET;
> +		/*
> +		 * The external charger detector needs to be disabled,
> +		 * or the signal at DP will be poor
> +		 */
> +		regmap_write(mxs_phy->regmap_anatop, reg,
> +			     ANADIG_USB1_CHRG_DETECT_EN_B |
> +			     ANADIG_USB1_CHRG_DETECT_CHK_CHRG_B);
> +	}
> +
>  	mxs_phy_tx_init(mxs_phy);
>  
>  	return 0;
> -- 
> 2.21.0
> 
