Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9ADC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE012087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552344794;
	bh=XtGeIfym4niYKDt7XgfkhvMCaD6u6zK/tIfZ18RgWMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HBgQTNd0TgXV0+VcHlglD0NQWckuJl7IMsyvZjyJHK2MM/9XohsmObg3kyZqwgJbV
	 1SRdCVFlBjPMtIA42jkG1gsqQPtBqQVewvHguWU6UjatetwK7+5NU6GYV8Hs6iwtcJ
	 46MvF4KscQBsC/tgdWEnFsh2MSVksWObfiInLMBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfCKWxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:53:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41172 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfCKWxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:53:12 -0400
Received: by mail-oi1-f196.google.com with SMTP id e7so490082oia.8;
        Mon, 11 Mar 2019 15:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oyCUb+SQ2Aep3OtTCbjChbncCXfaiPNytP/E1A7nn+Q=;
        b=QnP7QmuZTpt3+4zUS4OcEHaprMHh7N7ZevpQ1FSZe9H4NrdjxNFJLBIGaJ3QtH4EJo
         v59X8JbSEWxIfBjTrWo2/80W82aeLlDQ1qOBDgI6o0/c+R114SSTVkxXJo2LgOJPFsa5
         7zC6K99kg3+RFg1wmLxJX/6vCo87W9fNO4DA5XolfDVWV1V7dipOqskuNA5wNqNc+K0k
         H9qKksN95mPtBlAZelki8HRDW8KGk5X4C7RoGFyzxTIt8BgMzAZgXfUL7yBT2LBTMK9O
         Q8I0KzgUqlrKUZfrGlrn04oRb+2ENmtdAE+ctaupL/NSambfXd/9rtSG28vebNNWRFb1
         DW5A==
X-Gm-Message-State: APjAAAV5AIFxcNCYoHf24fPltehPBsIQLI8vY1hnfvZJynaPLZ7F50qz
        P2Juc0jBO6yVcYeYe1qUQA==
X-Google-Smtp-Source: APXvYqwGJHQApQT4DaTv28AjMTsimBNRqTzQeBRd6JJXU/xzQxKNjw5h/1IrkxlYN8CuCRG0d8IYfg==
X-Received: by 2002:aca:6043:: with SMTP id u64mr19587oib.32.1552344791097;
        Mon, 11 Mar 2019 15:53:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n5sm2876541oih.19.2019.03.11.15.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:53:10 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:53:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: memory-controllers: freescale: add
 MMDC binding doc
Message-ID: <20190311225309.GA32334@bogus>
References: <1551403185-16314-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551403185-16314-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 01:24:18AM +0000, Anson Huang wrote:
> Freescale MMDC (Multi Mode DDR Controller) driver is supported
> since i.MX6Q, but not yet documented, this patch adds binding
> doc for MMDC module driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V3:
> 	- add i.MX6QP compatible name.
> ---
>  .../bindings/memory-controllers/fsl/mmdc.txt       | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt b/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
> new file mode 100644
> index 0000000..e4e0b50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
> @@ -0,0 +1,33 @@
> +Freescale Multi Mode DDR controller (MMDC)
> +
> +Required properties :
> +- compatible : should be one of following:
> +	for i.MX6Q/i.MX6DL:
> +	- "fsl,imx6q-mmdc";
> +	for i.MX6QP:
> +	- "fsl,imx6qp-mmdc", "fsl,imx6q-mmdc";
> +	for i.MX6SL:
> +	- "fsl,imx6sl-mmdc", "fsl,imx6q-mmdc";
> +	for i.MX6SLL:
> +	- "fsl,imx6sll-mmdc", "fsl,imx6q-mmdc";
> +	for i.MX6SX:
> +	- "fsl,imx6sx-mmdc", "fsl,imx6q-mmdc";
> +	for i.MX6UL/i.MX6ULL/i.MX6ULZ:
> +	- "fsl,imx6ul-mmdc", "fsl,imx6q-mmdc";
> +	for i.MX7ULP:
> +	- "fsl,imx7ulp-mmdc", "fsl,imx6q-mmdc";
> +- reg : address and size of MMDC DDR controller registers
> +
> +Optional properties :
> +- clocks : the clock provided by the SoC to access the MMDC registers
> +
> +Example :
> +	mmdc0: memory-controller@21b0000 { /* MMDC0 */
> +		compatible = "fsl,imx6q-mmdc";
> +		reg = <0x021b0000 0x4000>;
> +		clocks = <&clks IMX6QDL_CLK_MMDC_P0_IPG>;
> +	}
> +
> +	mmdc1: memory-controller@21b4000 { /* MMDC1 */
> +		reg = <0x021b4000 0x4000>;

What is this node? No compatible here should be considered invalid.

Seems like maybe the 1st node should have 2 register ranges if you want 
a single device.

Rob
