Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEBAC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 00:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C9920578
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 00:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDkTBI8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfIQAF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 20:05:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42595 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfIQAFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 20:05:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id q12so952154pff.9;
        Mon, 16 Sep 2019 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=baniowhMYStzAeCarx/sh1i/50jPhkdSEMhte1BfHf4=;
        b=QDkTBI8OkV9+U41zSTFDRaG+W3egIuzxRz5itZnmQdqrzqvVJ8Xtln9xvMRJtZZjAK
         Tf56eIYGeByJ/f9FMO1zhyFYtwHRPXBRkTWMbmQGlqq3G3yU9pHj+uSYli5/GZ2nleUy
         i/3w9QBIgH5LhrPkNazF09K1o3/kld6DobWO9umsAeSvaC87oMZySdj5KuagsyM648lf
         OubKTWGcOBcWG6V+aDyDnxDiiJxNQFzItsHH/ObXq/tFCEeB/ETPIn4kxoWfIPMMCsCL
         pctGdCVVklBnwf7LWRT18d0e/QIKy88Af+qvGjHVxB4EFtB+asGhCDW9cYjes0Ty4p9q
         SaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=baniowhMYStzAeCarx/sh1i/50jPhkdSEMhte1BfHf4=;
        b=YwFxF9HwVG4J4TNnQQSN/jgbEVglpJ3W6N1wZlStYyHCXVrxLKM6VuhQkpBL23AVCy
         evSzWluHzJ3Ivar7ftvrH4bJnThD5MsbiO+YJMYq7JulB9mFpmreIj+eLrdWf0f+pS1a
         NQMaVwOMY3i10oq0JHTfpV0nijZw0d9kOXThpWu3ej9OCF7KFdnvEErObf5INrCu/1c2
         CpP01cmDXvj1uPajAr97NmiR3nUAAXi3lGBTcIV6+vOGnBOb0sIJxbYp/PTj2kA2EKYT
         QG02eYR7UEc4aLFWd0sZcq5WxSCXFyPgEuYu3RA9byvPzaDU2ZXcjtw3wUInOh70yBlT
         haAg==
X-Gm-Message-State: APjAAAWm20vVSb8ctFL7r7OKqHuzo0ZzPqgTnK/uvRWBAaweCK1gYuIS
        nTZ5AkmOWDk6qy8f/0T4/I6cXgpXP90=
X-Google-Smtp-Source: APXvYqz0PeZSDBSC5l5eljSy7AY5XnFCmp2VRvGuofWHCSx/srcu18Ht5AdkvIVeGwgA6Y5TqKZvzQ==
X-Received: by 2002:aa7:9835:: with SMTP id q21mr570191pfl.122.1568678755003;
        Mon, 16 Sep 2019 17:05:55 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id h18sm266844pfn.53.2019.09.16.17.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 17:05:54 -0700 (PDT)
Date:   Mon, 16 Sep 2019 17:05:36 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 1/2] ASoC: fsl_mqs: add DT binding documentation
Message-ID: <20190917000535.GE12789@Asurada-Nvidia.nvidia.com>
References: <65e1f035aea2951aacda54aa3a751bc244f72f6a.1568367274.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e1f035aea2951aacda54aa3a751bc244f72f6a.1568367274.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 05:42:13PM +0800, Shengjiu Wang wrote:
> Add the DT binding documentation for NXP MQS driver
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
> Changes in v2
> -refine the comments for properties
> 
>  .../devicetree/bindings/sound/fsl,mqs.txt     | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,mqs.txt b/Documentation/devicetree/bindings/sound/fsl,mqs.txt
> new file mode 100644
> index 000000000000..40353fc30255
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,mqs.txt
> @@ -0,0 +1,36 @@
> +fsl,mqs audio CODEC
> +
> +Required properties:
> +  - compatible : Must contain one of "fsl,imx6sx-mqs", "fsl,codec-mqs"
> +		"fsl,imx8qm-mqs", "fsl,imx8qxp-mqs".
> +  - clocks : A list of phandles + clock-specifiers, one for each entry in
> +	     clock-names
> +  - clock-names : "mclk" - must required.
> +		  "core" - required if compatible is "fsl,imx8qm-mqs", it
> +		           is for register access.
> +  - gpr : A phandle of General Purpose Registers in IOMUX Controller.
> +	  Required if compatible is "fsl,imx6sx-mqs".
> +
> +Required if compatible is "fsl,imx8qm-mqs":
> +  - power-domains: A phandle of PM domain provider node.
> +  - reg: Offset and length of the register set for the device.
> +
> +Example:
> +
> +mqs: mqs {
> +	compatible = "fsl,imx6sx-mqs";
> +	gpr = <&gpr>;
> +	clocks = <&clks IMX6SX_CLK_SAI1>;
> +	clock-names = "mclk";
> +	status = "disabled";
> +};
> +
> +mqs: mqs@59850000 {
> +	compatible = "fsl,imx8qm-mqs";
> +	reg = <0x59850000 0x10000>;
> +	clocks = <&clk IMX8QM_AUD_MQS_IPG>,
> +		 <&clk IMX8QM_AUD_MQS_HMCLK>;
> +	clock-names = "core", "mclk";
> +	power-domains = <&pd_mqs0>;
> +	status = "disabled";
> +};
> -- 
> 2.21.0
> 
