Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA1EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEF420823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553792253;
	bh=1+s1tfN1whTtmny1BbazMiPixkkQ250pXgXRihudVrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SuGU607MoVDSIfIxLXmo13FscRtPGAOtSmRyNDNl4fpRsWh5jtTsNGrByafC3tymD
	 ffjQng4szVT/YGZgHTS1FFK1TPEbsEl/aken7kdBEGxHsmGhJZQ+2tqnWR/MDYmdqN
	 Rz0IJunPVM07MOl/zAEMwfNlFrrW4FmSx54IWaQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfC1Q5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:57:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35192 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfC1Q5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:57:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id j132so16353652oib.2;
        Thu, 28 Mar 2019 09:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/QDI3NqvgJSGSPXIW7IvDe6RNu/CWYhoLpiKdFl7jMw=;
        b=IuWnpZ9dHLr8Xk1OCZa16JKEsYvMzjG7Yk1sQxTk0RtlCb3P/T+RzLCCWyCoEZOsuy
         wOgYrb7h/d+66TIp1SDg1ytSmo5h4TBEb5XK0rTmo2iLLLW3NRC7FQDBxe7DPJVfL6J4
         1fsFmzKZRgIs6FiLT4MOhEpRQ6+oV0GIMxLmUtWs+X8b/lCTd5pm0pV+QYe8Yqx2FcLU
         aTs19aGfpldHBTSj7PTY7VU8XtW8TaJQT2L9nzTw6gro3sVtzsfnshvXs1EDTicJC7T/
         yFIjdGXLi7iJBk+uApxo2gGYJfkfy2gN6UY7H1eWtRvjMEGze+cU4ztT/0TI5Q1x5DKZ
         d3TQ==
X-Gm-Message-State: APjAAAVp7VHcyfLJIPmnyU3lC+BikCNIIe3jBw6j0va57zSdxOFLZWF/
        CV26SDAGBY4hBSddsAWSXQ==
X-Google-Smtp-Source: APXvYqwRFPpqSnT92bXhr3oZKdWHBuBfApT/maRl1Jktm0Btxgl6j2Jl8rGqv74JCHjdzKzxi81vZw==
X-Received: by 2002:aca:f581:: with SMTP id t123mr760201oih.0.1553792250318;
        Thu, 28 Mar 2019 09:57:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e186sm10058475oia.44.2019.03.28.09.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 09:57:29 -0700 (PDT)
Date:   Thu, 28 Mar 2019 11:57:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH RESEND v7 2/3] dt-bindings: phy: Add documentation for
 mixel dphy
Message-ID: <20190328165729.GA32345@bogus>
References: <cover.1553674604.git.agx@sigxcpu.org>
 <3319783f60fedd7f0029dd60a51c76a75003fe05.1553674604.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3319783f60fedd7f0029dd60a51c76a75003fe05.1553674604.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 09:20:00AM +0100, Guido Günther wrote:
> Add support for the MIXEL DPHY IP as found in the NXP's i.MX8MQ.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../bindings/phy/mixel,mipi-dsi-phy.txt       | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> new file mode 100644
> index 000000000000..d3646580412a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> @@ -0,0 +1,29 @@
> +Mixel DSI PHY for i.MX8
> +
> +The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along the
> +MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
> +electrical signals for DSI.
> +
> +Required properties:
> +- compatible: Must be:
> +  - "mixel,imx8mq-mipi-dphy"

If you had a fallback for mixel, then it would make sense, but as this 
is imx8mq specifc 'fsl' should be the vendor prefix.

> +- clocks: Must contain an entry for each entry in clock-names.
> +- clock-names: Must contain the following entries:
> +  - "phy_ref": phandle and specifier referring to the DPHY ref clock
> +- reg: the register range of the PHY controller
> +- #phy-cells: number of cells in PHY, as defined in
> +  Documentation/devicetree/bindings/phy/phy-bindings.txt
> +  this must be <0>
> +
> +Optional properties:
> +- power-domains: phandle to power domain
> +
> +Example:
> +	mipi_dphy: mipi_dphy@30A0030 {

mipi-dphy@... or just dphy@...

> +		compatible = "mixel,imx8mq-mipi-dphy";
> +		clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> +		clock-names = "phy_ref";
> +		reg = <0x30A00300 0x100>;
> +		power-domains = <&pd_mipi0>;
> +		#phy-cells = <0>;
> +        };
> -- 
> 2.20.1
> 
