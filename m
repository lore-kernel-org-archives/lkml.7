Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BD2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409112070B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211748;
	bh=h1vsvdQzls9IqqB+bWx/pKq906Zsdon5hFup9pU1p0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CkEObXlGViMjDnTJTAjGMaI1TXqZ3HEUoDIiBdEb9Eh03WvJDUBw4OJjyngQjOFaI
	 ZbWImzcFa5tRBapPDRl0zb32q5HYkQ7lIWfAyNcrs2GbtEOXVf2KP9+K6ObQML0OdD
	 DFqJQu1jI7qc/pprFJeWNpW+jXrOl1DArvHMvfrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfJ0V3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:29:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38446 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731916AbfJ0VVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:21:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id r14so700803otn.5;
        Sun, 27 Oct 2019 14:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/1qX8QqURu4yTR6/F+UUQyKvsmnZpVehqktiXte3R0=;
        b=JTXd6g61ZLRjxtdTGudS2WI0DarJtHw9EK6Oae8napIvQzyUk2iQ6w0z8EA7UDUOAv
         OCQVLBVikRUx5H1iAXTH2IvD9ulpaGu+7SqSiiXTIHISa9vT0vP31OyvpetUFl1OKdrM
         /VzRUvMc+7oMVpkd2fbDZs4UdH3m4Uhh7c3mTuxSDt44nS8qSvOq1h1aDr50pCu3t9I2
         Tyu1N4ZxQMJRz/e435bytmULRjelbPXpQb123Sbu+ortNapi/3dgZyEHkY6GqKucZjgB
         eOxtY8EGjaLbbKAvGLiFAzKCjq/9s5JjHk4sNAxlN6BtEdyvR7aSmgkrsjDEoel5rWyw
         hOrw==
X-Gm-Message-State: APjAAAVLgWEiu1gtO9VDpxjrmnzhDZ8YPQhs9b59gq9ntVPc8eK6zXid
        W02m5GxuGgyWiZqD6Ruktw==
X-Google-Smtp-Source: APXvYqxeon+14sBfRLWGf2262ii9N4LSrDCmUuiwS4ja+XW6LEnxA7FhNfNFumE68Q5l0ZieaUkX9Q==
X-Received: by 2002:a9d:6357:: with SMTP id y23mr11151500otk.86.1572211282486;
        Sun, 27 Oct 2019 14:21:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o23sm3054166ote.67.2019.10.27.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 14:21:21 -0700 (PDT)
Date:   Sun, 27 Oct 2019 16:21:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" 
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] dt-bindings: timer: imx: gpt: Add pin group bindings
 for input capture
Message-ID: <20191027212121.GA3049@bogus>
References: <20191016010544.14561-1-slongerbeam@gmail.com>
 <20191016010544.14561-3-slongerbeam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016010544.14561-3-slongerbeam@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 06:05:44PM -0700, Steve Longerbeam wrote:
> Add pin group bindings to support input capture function of the i.MX
> GPT.
> 
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
> ---
>  .../devicetree/bindings/timer/fsl,imxgpt.txt  | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> index 5d8fd5b52598..32797b7b0d02 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> @@ -33,6 +33,13 @@ Required properties:
>             an entry for each entry in clock-names.
>  - clock-names : must include "ipg" entry first, then "per" entry.
>  
> +Optional properties:
> +
> +- pinctrl-0: For the i.MX GPT to support the Input Capture function,
> +  	     the input capture channel pin groups must be listed here.
> +- pinctrl-names: must be "default".
> +
> +
>  Example:
>  
>  gpt1: timer@10003000 {
> @@ -43,3 +50,24 @@ gpt1: timer@10003000 {
>  		 <&clks IMX27_CLK_PER1_GATE>;
>  	clock-names = "ipg", "per";
>  };
> +
> +
> +Example with input capture channel 0 support:
> +
> +pinctrl_gpt_input_capture0: gptinputcapture0grp {
> +	fsl,pins = <
> +		MX6QDL_PAD_SD1_DAT0__GPT_CAPTURE1 0x1b0b0
> +	>;
> +};
> +
> +gpt: gpt@2098000 {

timer@...

I don't really think this merits another example though. 

> +	compatible = "fsl,imx6q-gpt", "fsl,imx31-gpt";
> +	reg = <0x02098000 0x4000>;
> +	interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&clks IMX6QDL_CLK_GPT_IPG>,
> +		<&clks IMX6QDL_CLK_GPT_IPG_PER>,
> +		<&clks IMX6QDL_CLK_GPT_3M>;
> +	clock-names = "ipg", "per", "osc_per";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpt_input_capture0>;
> +};
> -- 
> 2.17.1
> 
