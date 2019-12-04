Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656D4C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3615320863
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575442874;
	bh=Uz+eGmxI1QvDSjH59/5hQQsWRPvnzIDSoxgFIiTw4zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wk86rg1VQW/uYOw0jgAFxfyZ6QQ9Lr3XW/ApgP7h/6lLczkeAMGj6dDo27V9pJFcO
	 N0GzLMp1S2EmoKIwTJ71vB+hNaZAcsqjopE3J/+xS+LCPx1KV1X/IxAdxb1bXIhChB
	 xm7FjF/qP0nBEyklr+f5zDr75rsrmCtzvaWB4fvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLDHBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:01:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfLDHBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:01:11 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDFF820863;
        Wed,  4 Dec 2019 07:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575442871;
        bh=Uz+eGmxI1QvDSjH59/5hQQsWRPvnzIDSoxgFIiTw4zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=neZfJDKuEc1u5SMT1pvNbpZIi3eCK5kKOH1f/e7E8GfpEd4ccJZcKLZq9UcDDojgK
         5iVByjNd3N0iwdKzd3g0c067ZHmGkzxsEir/bKD5+GkqJneP3f2fzRFe3rgxuJw8I8
         cQTDef2S+CqP7AhWBEyvUfKoPdFFKIlK6UzFVJ9k=
Date:   Wed, 4 Dec 2019 15:01:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: lx2160a: add RGMII phy nodes
Message-ID: <20191204070103.GC3365@dragon>
References: <1573055536-21786-1-git-send-email-ioana.ciornei@nxp.com>
 <1573055536-21786-3-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573055536-21786-3-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 05:52:16PM +0200, Ioana Ciornei wrote:
> Annotate the EMDIO1 node and describe the 2 AR8035 RGMII PHYs.
> Also, add phy-handles for dpmac17 and dpmac18 to its associated PHY.
> The MAC is not capable to add the needed RGMII delays, thus the
> "rgmii-id" phy-connection-type is used.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 27 +++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index c2817b784232..1e2a7c4031fd 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -35,6 +35,33 @@
>  	status = "okay";
>  };
>  
> +&dpmac17 {
> +	phy-handle = <&rgmii_phy1>;
> +	phy-connection-type = "rgmii-id";
> +};
> +
> +&dpmac18 {
> +	phy-handle = <&rgmii_phy2>;
> +	phy-connection-type = "rgmii-id";
> +};
> +
> +&emdio1 {
> +	status = "okay";
> +
> +	rgmii_phy1: ethernet-phy@1 {
> +		/* AR8035 PHY */
> +		compatible = "ethernet-phy-id004d.d072";
> +		reg = <0x1>;
> +		eee-broken-1000t;
> +	};

Please have a newline between nodes.

Shawn

> +	rgmii_phy2: ethernet-phy@2 {
> +		/* AR8035 PHY */
> +		compatible = "ethernet-phy-id004d.d072";
> +		reg = <0x2>;
> +		eee-broken-1000t;
> +	};
> +};
> +
>  &esdhc0 {
>  	sd-uhs-sdr104;
>  	sd-uhs-sdr50;
> -- 
> 1.9.1
> 
