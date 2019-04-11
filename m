Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBE3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6739F217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554949824;
	bh=K1dDvojhPy/Vthioed5xtthZuN9kDbzoLUWlKZY0Pto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y6A7FP26VKkIALzZnmte1rh8IDByIKtC0VW5MeVcnBNeDRRzYYEW+99iSRpUKPzXs
	 L0xmpAKn94dFjiicZEq2ObG9FEVUD3r38AfZsaVAgq7qnhHSzKja4n+/XnAHjPt25P
	 Yrkh2HrKZDdXDFeZKYDwfDIW8UvBysjv3g7nHDN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDKCaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfDKCaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:30:22 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2C12217D4;
        Thu, 11 Apr 2019 02:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554949821;
        bh=K1dDvojhPy/Vthioed5xtthZuN9kDbzoLUWlKZY0Pto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzI9MzJd7WcqpyBOKeyD2BECO+I+hvmFPwwPQQLBjKYXJbgsQzEYtzYdY7y6hG5Ok
         0k0tX7D/ltNeZWvkgvWAOWijWhCECWRLuoPb0B7L14Yc4DPOoBSioONuVr0dNFej9H
         QO2yraCIHydz8I5f+Wr7EbYlND0Nh0rNbGy4L/6Q=
Date:   Thu, 11 Apr 2019 10:30:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as
 "ipg" clock to SDMA
Message-ID: <20190411023008.GK26817@dragon>
References: <20190329064924.8728-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329064924.8728-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 11:49:16PM -0700, Andrey Smirnov wrote:
> Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
> clock to determine if it needs to configure the IP block as operating
> at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
> clocks as IMX6QDL_CLK_SDMA results in driver incorrectly thinking that
> ratio is 1:1 which results in broken SDMA funtionality(this at least
> breaks RAVE SP serdev driver on RDU2). Fix the code to specify
> IMX6QDL_CLK_IPG as "ipg" clock for SDMA, to avoid detecting incorrect
> clock ratio.
> 
> Fixes: 25aaa75df1e6 ("dmaengine: imx-sdma: add clock ratio 1:1 check")

Since we have a fix in the dma driver, I dropped the Fixes tag here.

Applied all, thanks.

Shawn

> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 9f9aa6e7ed0e..354feba077b2 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -949,7 +949,7 @@
>  				compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
>  				reg = <0x020ec000 0x4000>;
>  				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clks IMX6QDL_CLK_SDMA>,
> +				clocks = <&clks IMX6QDL_CLK_IPG>,
>  					 <&clks IMX6QDL_CLK_SDMA>;
>  				clock-names = "ipg", "ahb";
>  				#dma-cells = <3>;
> -- 
> 2.20.1
> 
