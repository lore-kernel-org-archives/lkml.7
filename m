Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545AEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7252087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="sW0wQegx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfCRISt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:18:49 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:35166 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfCRISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:18:49 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id E16C65C013A;
        Mon, 18 Mar 2019 09:18:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1552897126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ie7gEvCZHt2dPtaEXOSM/yOAG6BLizHKnECPLrS9Wh4=;
        b=sW0wQegxmWjmnhEyKdxVz0jAoBw+x8NsF00BgKchTuPHwm9DfUFtlbG22eVFYTbacFw7Pp
        fPZuekzVctsDCbIPhh+DMepDILrDCIc4EIZ6KfUfrve7HOmIDThdq/SckLzqVrmiPS96LE
        9ynp2qUwSc6ZXU63wUHWOhvaPdz91mo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Mar 2019 09:18:46 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux@armlinux.org.uk, otavio@ossystems.com.br,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, jan.tuerk@emtrion.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
In-Reply-To: <1552894581-3391-2-git-send-email-Anson.Huang@nxp.com>
References: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
 <1552894581-3391-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <d1f8b006ad56e8ed4e9fb9137148d98b@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.2019 08:41, Anson Huang wrote:
> Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>  Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> new file mode 100644
> index 0000000..d47b8fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> @@ -0,0 +1,19 @@
> +Freescale i.MX TPM PWM controller
> +
> +Required properties:
> +- compatible : Should be "fsl,imx-tpm-pwm".
> +- reg: Physical base address and length of the controller's registers.
> +- #pwm-cells: Should be 2. See pwm.txt in this directory for a
> description of the cells format.

It seems that the driver supports polarity. Can we use 3 cells so we can
specify the polarity in the device tree?

Also use 3 cells in the base device tree to enable other boards making
use of the polarity (arch/arm/boot/dts/imx7ulp.dtsi).

--
Stefan

> +- clocks : The clock provided by the SoC to drive the PWM.
> +- interrupts: The interrupt for the pwm controller.
> +
> +Example:
> +
> +pwm0: tpm@40250000 {
> +	compatible = "fsl,imx-tpm-pwm";
> +	reg = <0x40250000 0x1000>;
> +	assigned-clocks = <&clks IMX7ULP_CLK_LPTPM4>;
> +	assigned-clock-parents = <&clks IMX7ULP_CLK_SOSC_BUS_CLK>;
> +	clocks = <&clks IMX7ULP_CLK_LPTPM4>;
> +	#pwm-cells = <2>;
> +};
