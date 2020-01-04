Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3B9C33C99
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441BD21734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578173618;
	bh=7+jGGHJV6qP+A3Z9vIGvn7koJ+D4zh6a+42XTDGlfAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x8gM5rjdB7B+gM5+s54v4T75j3ZCq1pPJRDYYb5Y96HU5d7XvVsfnVOBNWvz3LOs9
	 S9KXj29NMkyMNnR94qV5bPBys0PZCLvWURfVAxFBtKt+J1IPWLVKajbSpy44ao2tEZ
	 lGFZlYA0FsDCsmR2OAOtGR+LrzwiXwuzyXicAWvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgADVdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:33:37 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40953 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADVdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:33:37 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so44752224iop.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E086cLVBXwQ6vOtP7yO03NEZ/tAJB2ltt2lzCZgTgEA=;
        b=GfZXj9AiIuxMgZmcQQV8GFpQZUB4va9ofJml/lqeXrXYTV8WR+rnqeHgLOWccxxINU
         r+l5Ym2slKpY6It19Rn/LIdzWR1RZ/f+esDMq0Xo6H40L8HJrN+BIEPsmPxQO8fkeh4B
         24qflgmv/5yYVg1MsMI6mpfQNo7qKFJNIyxhJV/IbOL83oaFoSiOWiRNz9t7WDD/Dh3G
         q/ihaG0LrVlJnhGsn87TvaHK2T4IgxFqXh2xGZRZJUfnB+DV6YIPOynm9pcWouivWr1X
         5IlKS9107EURppDNdtsCGhB8gPCgl7+NXfVtKfiu4b+Qpd3UwQo7pNr+lVpWHRNHSImZ
         RX+w==
X-Gm-Message-State: APjAAAVF8xUPTtkdbCmwC3l1262Ci+tTi2eS/V1CFdr5lJ4tIJ+42XHj
        nahn1EiGHBFUEJplkQlhtYLxWzc=
X-Google-Smtp-Source: APXvYqytqvAQG/FUZchlEeHg9EqLdv1ZRBe9eryvXlKJcnBEMa3hmtYk41hNhw355m13JHuRfGnsjQ==
X-Received: by 2002:a5d:949a:: with SMTP id v26mr66183567ioj.13.1578173615353;
        Sat, 04 Jan 2020 13:33:35 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id m18sm20426297ila.54.2020.01.04.13.33.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:33:34 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:33:32 -0700
Date:   Sat, 4 Jan 2020 14:33:32 -0700
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, kernel@pengutronix.de, linus.walleij@linaro.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, olof@lixom.net, maxime@cerno.tech,
        leonard.crestez@nxp.com, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] dt-bindings: imx: Add pinctrl binding doc for
 i.MX8MP
Message-ID: <20200104213332.GA19211@bogus>
References: <1577342743-25885-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577342743-25885-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 02:45:41PM +0800, Anson Huang wrote:
> Add binding doc for i.MX8MP pinctrl driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>  .../bindings/pinctrl/fsl,imx8mp-pinctrl.txt        |  38 +

Please make this a DT schema.

>  arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h     | 931 +++++++++++++++++++++
>  2 files changed, 969 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.txt
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.txt
> new file mode 100644
> index 0000000..619104b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.txt
> @@ -0,0 +1,38 @@
> +* Freescale IMX8MP IOMUX Controller
> +
> +Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
> +for common binding part and usage.
> +
> +Required properties:
> +- compatible: "fsl,imx8mp-iomuxc"
> +- reg: should contain the base physical address and size of the iomuxc
> +  registers.
> +
> +Required properties in sub-nodes:
> +- fsl,pins: each entry consists of 6 integers and represents the mux and config
> +  setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
> +  input_val> are specified using a PIN_FUNC_ID macro, which can be found in
> +  <arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h>. The last integer CONFIG is
> +  the pad setting value like pull-up on this pin. Please refer to i.MX8M Plus
> +  Reference Manual for detailed CONFIG settings.
> +
> +Examples:
> +
> +&uart1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart1>;
> +};
> +
> +iomuxc: pinctrl@30330000 {
> +        compatible = "fsl,imx8mp-iomuxc";
> +        reg = <0x30330000 0x10000>;
> +
> +	pinctrl_uart1: uart1grp {

In particular, define some node naming pattern that you can match on. 
Perhaps "grp$" works.

> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX    0x140
> +			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX    0x140
> +			MX8MP_IOMUXC_UART3_RXD__UART1_DCE_CTS   0x140
> +			MX8MP_IOMUXC_UART3_TXD__UART1_DCE_RTS   0x140
> +		>;
> +	};
> +};
