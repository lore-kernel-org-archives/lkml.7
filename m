Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1155C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF02217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oFbCjFWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390546AbfKERsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 12:48:07 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:50192 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389356AbfKERsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LWDvwTMeC17EAC7hUSEvvrTqmpd3m3QI+NU/56B7HaM=; b=oFbCjFWjuvPbgQT31DANCYyJUP
        IHmNfRw4eM71RdtEXzyInpEzTnOnuilNhCQ1m3ky+aOhCXSNd1NeEVQlQOWTDpJ8JEEbhctNxHEcg
        OgxpSFeOfRE6AHFKaZf5ddUrhrAgRyUFOh6ArK0v7gAR+banjze4BWV7VkjNzNhTE/HQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iS2vp-0003Ah-Q9; Tue, 05 Nov 2019 18:47:53 +0100
Date:   Tue, 5 Nov 2019 18:47:53 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christophe Roullier <christophe.roullier@st.com>
Cc:     robh@kernel.org, davem@davemloft.net, joabreu@synopsys.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, peppe.cavallaro@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH V2 net-next 1/4] net: ethernet: stmmac: Add support for
 syscfg clock
Message-ID: <20191105174753.GH17620@lunn.ch>
References: <20191105124505.4738-1-christophe.roullier@st.com>
 <20191105124505.4738-2-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105124505.4738-2-christophe.roullier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 01:45:02PM +0100, Christophe Roullier wrote:
> Add optional support for syscfg clock in dwmac-stm32.c
> Now Syscfg clock is activated automatically when syscfg
> registers are used
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 32 ++++++++++++-------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> index 4ef041bdf6a1..df7e9e913041 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> @@ -152,19 +152,24 @@ static int stm32mp1_clk_prepare(struct stm32_dwmac *dwmac, bool prepare)
>  	int ret = 0;
>  
>  	if (prepare) {
> -		ret = clk_prepare_enable(dwmac->syscfg_clk);
> -		if (ret)
> -			return ret;
> -
> +		if (dwmac->syscfg_clk) {
> +			ret = clk_prepare_enable(dwmac->syscfg_clk);
> +			if (ret)
> +				return ret;
> +		}

Hi Christophe

All the clk_ API functions are happy to take a NULL point and then do
nothing. So you don't need these changes. 

> -	/*  Clock for sysconfig */
> +	/*  Optional Clock for sysconfig */
>  	dwmac->syscfg_clk = devm_clk_get(dev, "syscfg-clk");
>  	if (IS_ERR(dwmac->syscfg_clk)) {
> -		dev_err(dev, "No syscfg clock provided...\n");
> -		return PTR_ERR(dwmac->syscfg_clk);
> +		err = PTR_ERR(dwmac->syscfg_clk);
> +		if (err != -ENOENT)
> +			return err;
> +		dwmac->syscfg_clk = NULL;
>  	}
>  
> +	err = 0;
> +

That should be all you need. Just set dwmac->syscfg_clk to NULL and
the rest should work.

    Andrew
