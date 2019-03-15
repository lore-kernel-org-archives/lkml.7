Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9078BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451272075C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552693072;
	bh=dLXL7kGAqxhgekvtz3vpT5HCsL7HtHcWmfk1SG+XXUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gwEKTAyh14IPyUFmx9tOZfB5JWGJ1phVaF0VUVo+qnTrebthsS4iqViHftAT7oeAy
	 ZSri1WdinGxzoEu4fBE4L5952SA2Akmy696oZsG3Obz1Osmrg5F9o3p7QyQ8FweTMi
	 2ZyAbbGHyIBjToiZBOay1yyXE+/Zpge1b0YbhA0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfCOXhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:37:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37700 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfCOXhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:37:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id v84so2360343oif.4;
        Fri, 15 Mar 2019 16:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CLPs75sCST9BnuLqglaIrgbQ4U5qUjEloPjsVcjwgmM=;
        b=nXQWH5wRr0yTeu2IgKj23dlafX/ZzI4nLrE/Y/Y1p8f3ThGBqODKArptMm0837rDZb
         JsNJUvg4sRulEGdYgiWTwG20FzqscfrPA7b9fH14R9DQg9e8fQ+enlvslfg7NdXJESnr
         c4Hyb13LhNgTV2SyXzqhIIET6qTc3Ye7Jn4BAowS+N4WS93wFTMI0mvjXU5IP8LKPyR9
         NXLOoS8Vt++Cw6QiV4j5nRV3VGUX3uE0tYAK055L6dE1YUcpo6sO/UJ+7he87WBsijUh
         K+Jtc3DQlyJWgRoFLv7Lv09IGceu5OqkWRKzid/f7H4VhxDsZD/KHdNbvtWDufTSj6mw
         L97g==
X-Gm-Message-State: APjAAAW3LrYPX6xO+CuDqbATkN8yrM7zHNUFJ0ggAiMSsIZ7r+P+8x5V
        HwTz2TY+y2nH0bRi1GMSOQ==
X-Google-Smtp-Source: APXvYqwBvOkOZVRlZpFfZ548be4R7ryoTgcbGnG39fbpmX/jHfR83Wr54jMPfrzP7qr5qPqJw40eWA==
X-Received: by 2002:aca:3286:: with SMTP id y128mr3031261oiy.29.1552693069983;
        Fri, 15 Mar 2019 16:37:49 -0700 (PDT)
Received: from localhost (ip-108-119-106-197.ftwttx.spcsdns.net. [108.119.106.197])
        by smtp.gmail.com with ESMTPSA id y28sm698490oix.23.2019.03.15.16.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 16:37:49 -0700 (PDT)
Date:   Fri, 15 Mar 2019 18:37:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 06/10] dt-bindings: sdm845-pinctrl: add wakeup
 interrupt parent for GPIO
Message-ID: <20190315233748.GA7219@bogus>
References: <20190313211844.29416-1-ilina@codeaurora.org>
 <20190313211844.29416-7-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313211844.29416-7-ilina@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 03:18:40PM -0600, Lina Iyer wrote:
> SDM845 SoC has an always-on interrupt controller (PDC) with select GPIO
> routed to the PDC as interrupts that can be used to wake the system up
> from deep low power modes and suspend.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt    | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

I still don't love this being specific to wake-up, but don't have a 
better suggestion. One nit, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> index 665aadb5ea28..f0fedbc5d41a 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> @@ -29,6 +29,11 @@ SDM845 platform.
>  	Definition: must be 2. Specifying the pin number and flags, as defined
>  		    in <dt-bindings/interrupt-controller/irq.h>
>  
> +- wakeup-parent:
> +	Usage: optional
> +	Value type: <phandle>
> +	Definition: A phandle to the wakeup interrupt controller for the SoC.
> +
>  - gpio-controller:
>  	Usage: required
>  	Value type: <none>
> @@ -53,7 +58,6 @@ pin, a group, or a list of pins or groups. This configuration can include the
>  mux function to select on those pin(s)/group(s), and various pin configuration
>  parameters, such as pull-up, drive strength, etc.
>  
> -
>  PIN CONFIGURATION NODES:
>  
>  The name of each subnode is not important; all subnodes should be enumerated
> @@ -160,6 +164,7 @@ Example:
>  		#gpio-cells = <2>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
> +		wake-parent = <&pdc_intc>;

wakeup-parent

>  
>  		qup9_active: qup9-active {
>  			mux {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
