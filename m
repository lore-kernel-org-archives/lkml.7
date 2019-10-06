Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A858C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 08:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032C921835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 08:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570350783;
	bh=uI2z8kh80JJBsoGDCTpXgGoUlxoiXMzMMLH6/pjgph4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yqMQs6iOX5VbIOnzpqHfwi/azGN2E9W9TG0vCRRAQNnonOmSlsZDvdWEOsWQCHnoZ
	 pH4PbfAMeMUsu7ANCA4CdcPBe7tki9kyQ5m9oh78pDmNS2swi751JgaCMTs30yVRRb
	 dgM5pYJonElKPpKpze4GXRM4j4Myv4r88nRKWqBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfJFIdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 04:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfJFIdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 04:33:02 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48FC220867;
        Sun,  6 Oct 2019 08:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570350781;
        bh=uI2z8kh80JJBsoGDCTpXgGoUlxoiXMzMMLH6/pjgph4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQ1mRK8Nn2V3RByDwL40J4iVe6wtSvOfgGM+mpzX1n1u3vY8AmNcM0y566Y9iRK/D
         H8sPOn6CgAXUfq2lUctn04EUH546sfhdvBSUnmFYJm9DNhtOsh/+f3pQb902XNFzUp
         3DXxOW6MoTALJyZoCrP8sMX1DVLJE7px0Xm666v0=
Date:   Sun, 6 Oct 2019 16:32:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx7s: Correct GPT's ipg clock source
Message-ID: <20191006083233.GB7150@dragon>
References: <1568622549-15819-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568622549-15819-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 04:29:09PM +0800, Anson Huang wrote:
> i.MX7S/D's GPT ipg clock should be from GPT clock root and
> controlled by CCM's GPT CCGR, using correct clock source for
> GPT ipg clock instead of IMX7D_CLK_DUMMY.

So both 'ipg' and 'per' clock are coming from GPT root clock?

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

It looks like a fix, so do we need a Fixes tag here?

Shawn

> ---
>  arch/arm/boot/dts/imx7s.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 710f850..e2e604d 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -448,7 +448,7 @@
>  				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
>  				reg = <0x302d0000 0x10000>;
>  				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clks IMX7D_CLK_DUMMY>,
> +				clocks = <&clks IMX7D_GPT1_ROOT_CLK>,
>  					 <&clks IMX7D_GPT1_ROOT_CLK>;
>  				clock-names = "ipg", "per";
>  			};
> @@ -457,7 +457,7 @@
>  				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
>  				reg = <0x302e0000 0x10000>;
>  				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clks IMX7D_CLK_DUMMY>,
> +				clocks = <&clks IMX7D_GPT2_ROOT_CLK>,
>  					 <&clks IMX7D_GPT2_ROOT_CLK>;
>  				clock-names = "ipg", "per";
>  				status = "disabled";
> @@ -467,7 +467,7 @@
>  				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
>  				reg = <0x302f0000 0x10000>;
>  				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clks IMX7D_CLK_DUMMY>,
> +				clocks = <&clks IMX7D_GPT3_ROOT_CLK>,
>  					 <&clks IMX7D_GPT3_ROOT_CLK>;
>  				clock-names = "ipg", "per";
>  				status = "disabled";
> @@ -477,7 +477,7 @@
>  				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
>  				reg = <0x30300000 0x10000>;
>  				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clks IMX7D_CLK_DUMMY>,
> +				clocks = <&clks IMX7D_GPT4_ROOT_CLK>,
>  					 <&clks IMX7D_GPT4_ROOT_CLK>;
>  				clock-names = "ipg", "per";
>  				status = "disabled";
> -- 
> 2.7.4
> 
