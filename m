Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB59C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B61620657
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553728046;
	bh=ckv5NTGJOJ5c1x2rFxgzpty7xf1eL9IDffHD4cThi3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1+HDZ2eNVrHcj/i2kJYKmOl/1ftlkTKy1qrXuyhXKxt0az1+bIUpqh7m/YbFVBxs1
	 pOBUVZ5uxNJbrj6ZkhDijI1ZeXeFAGL1kQN9pwV6kTMzELQZazeFIYJWKmcI+FaYgl
	 r1gHFVH39zf8BmXjIhdCnvwyAb1lFGl7KyESg8+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfC0XHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:07:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46561 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfC0XHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:07:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id s24so7076196otk.13;
        Wed, 27 Mar 2019 16:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WOIvTZkyBewSM9hPCcfz1BOCmh+9VTusdQO/GI6NhU4=;
        b=jcgKJXMYo2EocpuliClm7cm1KuHyzpeaYNGH/l2Ba8Cl47J1/A9M2IHFySxkEbMZO+
         sqTDQdE96wEE4YQetldPDzi2gII2J1khEXIJmK1GbCzk8A47pRmyacZb+6SxlgQle8e1
         VGA6OvcmMasSSD9ER3dfY7V7TU/1DEVDLdAQ6vHJUbjHcRxIio2gion8LLonvpnU70LV
         Ox/4qh/4yVlWmR3MP7g3lupUoR7wDIbyn87C5/o67N1Nmhy4y6tL1UP+a7PANmgS4R4+
         MU0uVpvp6iSI9+bfddLIb4u2M1x1T2lXOnlvAwa7AZKNuPgi4L6MIh7R3F8ekqySAhQT
         B4BQ==
X-Gm-Message-State: APjAAAU4LYv2zVMlPVLGMLoyFk5ZmjNY9e/YATBdEwz01hePzPbycBcR
        J4QXj26ozX8cfxuif4PoQJgpt6g=
X-Google-Smtp-Source: APXvYqyQncEU/wCGpKSUtn9FWrZTYXA9xm9Vpcs5bKyD8I4AFqjbedpUNACUeoqraP1sXUlECcUJBg==
X-Received: by 2002:a9d:6408:: with SMTP id h8mr26065756otl.68.1553728043646;
        Wed, 27 Mar 2019 16:07:23 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y1sm4430728ota.38.2019.03.27.16.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 16:07:22 -0700 (PDT)
Date:   Wed, 27 Mar 2019 18:07:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 1/8] dt-bindings: stm32: add bindings for ML-AHB
 interconnect
Message-ID: <20190327230722.GA13708@bogus>
References: <1551795849-13672-1-git-send-email-fabien.dessenne@st.com>
 <1551795849-13672-2-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551795849-13672-2-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 03:24:02PM +0100, Fabien Dessenne wrote:
> Document the ML-AHB interconnect for stm32 SoCs.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  .../devicetree/bindings/arm/stm32/mlahb.txt        | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/mlahb.txt b/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> new file mode 100644
> index 0000000..880cb38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> @@ -0,0 +1,30 @@
> +ML-AHB interconnect bindings
> +
> +These bindings describe the STM32 SoCs ML-AHB interconnect bus which connects
> +a Cortex-M subsystem with dedicated memories.
> +
> +Required properties:
> +- compatible: should be "simple-bus"

A binding for simple-bus was the first thing that looked odd.

> +- ranges: describes memory addresses translation between the local CPU and the
> +	   remote Cortex-M processor. Each memory region, is declared with 3
> +	   parameters:
> +		 - param 1: device base address (Cortex-M processor address)
> +		 - param 2: physical base address (local CPU address)
> +		 - param 3: size of the memory region.

Given that the driver is parsing ranges itself, this looks like abuse of 
ranges.

What exactly is address 0 supposed to be here? If it is the M4's view of 
memory, then dma-ranges is what you want to use here.


> +
> +The Cortex-M remote processor accessed via the mlahb interconnect is described
> +by a child node.
> +
> +Example:
> +mlahb: mlahb@0 {

Note that the unit-address is wrong here as it should be 38000000.

> +	compatible = "simple-bus";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges = <0x00000000 0x38000000 0x10000>,
> +		 <0x10000000 0x10000000 0x60000>,
> +		 <0x30000000 0x30000000 0x60000>;
> +
> +	m4_rproc: m4@0 {
> +		...
> +	};
> +};
> -- 
> 2.7.4
> 
