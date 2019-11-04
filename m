Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE0ACA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8607921D71
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572853455;
	bh=rqP4SSpNvx234d+AvWoRHCFkLgHT+IVU/z6pCg63G3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S2qG4fBDOHjSr5hzRYXNASUsOUrBtlSjOCqt3/W7nHk99pTGgNulAS2v6q5Jnp2hM
	 JnbvnnM70BVH/NV/UJI9m5bX3LAXCmRAO2AJPH4Z4IDivzf4OzDES2c/x9lDkk5Dz3
	 kFRpnmeSzVDo00UgOQr7NEumXAKpRjd0jwf1chm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfKDHoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 02:44:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfKDHoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:44:14 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF09B2190F;
        Mon,  4 Nov 2019 07:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572853453;
        bh=rqP4SSpNvx234d+AvWoRHCFkLgHT+IVU/z6pCg63G3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zGPC6D60oP3iEGoEXdXdIB+wDXS1YRB7VcZuICeBUVX6uvWfBcT/JUarHJPTXoqTv
         HKUtalEQ/hfW/KuJVqlgkgCwHWWi1Rdk8KAiuRgGYmctRDU2x51kvQUEqYZocdHqb+
         mTcNAAhkUsObuVD5Bn0YX3fHDw1jx8WntyHmfStI=
Date:   Mon, 4 Nov 2019 15:43:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/11] ARM: dts: imx6ul-kontron-n6x1x-s: Disable the
 snvs-poweroff driver
Message-ID: <20191104074346.GT24620@dragon>
References: <20191031142112.12431-1-frieder.schrempf@kontron.de>
 <20191031142112.12431-10-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031142112.12431-10-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 02:24:27PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The snvs-poweroff driver can power off the system by pulling the
> PMIC_ON_REQ signal low, to let the PMIC disable the power.
> The Kontron SoMs do not have this signal connected, so let's remove
> the node.
> 
> This seems to fix a real issue when the signal is asserted at
> poweroff, but not actually causing the power to turn off. It was
> observed, that in this case the system would not shut down properly.

I do not quite follow on this.  How does disabling snvs_poweroff fix the
issue?  The root cause of system not shut down properly seems to be that
PMIC doesn't shut down power.  This looks like a clean-up rather than
bug fix.

> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Fixes: 1ea4b76cdfde ("ARM: dts: imx6ul-kontron-n6310: Add Kontron i.MX6UL N6310 SoM and boards")

If you think this is really a bug fix, it should be applied to the file
before renaming rather than the one after renaming.

Shawn

> ---
>  arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> index e18a8bd239be..4682a79f5b23 100644
> --- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> @@ -158,10 +158,6 @@
>  	status = "okay";
>  };
>  
> -&snvs_poweroff {
> -	status = "okay";
> -};
> -
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> -- 
> 2.17.1
