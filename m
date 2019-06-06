Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21834C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3701208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nXtM2+ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfFFUzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:55:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36774 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfFFUzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:55:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so2025785pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vXwmOi3AfKN5OHv9lMeQ1fdSh7ToHkHKZWUrn1bN3VI=;
        b=nXtM2+tatl2zhNi1LMjRbMtlKQKMh1F0YuStu6ETAeZzyXCV2AkrRTzWvmpv7yOzQ0
         1Xw+v1iBpU7gO+FnzKHujg8oKLG9A/jXnKgiDXXNJv/X2C4TGMC0QGQtpH90FJOBcf8D
         dqJ80bxgHz+MIc27AhTAtWwRPBtIB3eAIYk60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vXwmOi3AfKN5OHv9lMeQ1fdSh7ToHkHKZWUrn1bN3VI=;
        b=GFoPssThpSNiiT65k7UykZCDoGGxXB9XlUQHz1Ma++S4KOmPtg9nDDpUmyXeNyw0Uf
         6M2uyRlRq5/JtggFwMd8fxFYiTwCo1cExnDdcWK3Gl3P6Xn1SZ00C68IpnOmTZf++jNn
         E8h0M5t1ufy3Xh6N0AFGOCDUMJw/xKVD848hGm3DIMGOOysZBVV4YlCXRKuindAWxD99
         Z26mvjCIlLERVryTFOXkxQdnodGIsDmXR7Fx7rZ+fyiKNea9+QeE1Jcfg93fzdLmAX6u
         tMWp1LlyBilr5EsOJeBTRIx/Ry2R6989Fip0WoTVuXRT10w6N2VgM4ajvnzXH4mZJRnD
         5K4Q==
X-Gm-Message-State: APjAAAUmewT9dYgGHjb8nj541us2dev9CDJnl1me6zZyCZfV/EKJUNgW
        bIIahKge6lC+Ppmef7RKXvWU2dpwIMg=
X-Google-Smtp-Source: APXvYqwPuJ6+1LP1Sek3XDW/+rT9QbRxSaDnX4wC2uZ5aMZjfVcvCB7RUWdwtT8/NMvEyzpFKRoi7g==
X-Received: by 2002:a62:1456:: with SMTP id 83mr3664982pfu.228.1559854504040;
        Thu, 06 Jun 2019 13:55:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y4sm56879pgc.85.2019.06.06.13.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 13:55:03 -0700 (PDT)
Date:   Thu, 6 Jun 2019 13:55:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: tb10x: Use flexible-array member and
 struct_size() helper
Message-ID: <201906061354.CA1265C75E@keescook>
References: <20190606151232.GA20105@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606151232.GA20105@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:12:32AM -0500, Gustavo A. R. Silva wrote:
> Update the code to use a flexible array member instead of a pointer in
> structure i2c_mux_pinctrl and use the struct_size() helper:
> 
> struct tb10x_pinctrl {
>         ...
> 	struct tb10x_of_pinfunc pinfuncs[];
> };
> 
> Also, make use of the struct_size() helper instead of an open-coded
> version in order to avoid any potential type mistakes, in particular
> in the context in which this code is being used.
> 
> So, replace the following form:
> 
> sizeof(struct tb10x_pinctrl) + of_get_child_count(of_node) * sizeof(struct tb10x_of_pinfunc)
> 
> with:
> 
> struct_size(state, pinfuncs, of_get_child_count(of_node))
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/pinctrl/pinctrl-tb10x.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-tb10x.c b/drivers/pinctrl/pinctrl-tb10x.c
> index 2e90a6d8fb3b..a32badf3f118 100644
> --- a/drivers/pinctrl/pinctrl-tb10x.c
> +++ b/drivers/pinctrl/pinctrl-tb10x.c
> @@ -483,22 +483,22 @@ struct tb10x_port {
>   * @base: register set base address.
>   * @pingroups: pointer to an array of the pin groups this driver manages.
>   * @pinfuncgrpcnt: number of pingroups in @pingroups.
> - * @pinfuncs: pointer to an array of pin functions this driver manages.
>   * @pinfuncnt: number of pin functions in @pinfuncs.
>   * @mutex: mutex for exclusive access to a pin controller's state.
>   * @ports: current state of each port.
>   * @gpios: Indicates if a given pin is currently used as GPIO (1) or not (0).
> + * @pinfuncs: flexible array of pin functions this driver manages.
>   */
>  struct tb10x_pinctrl {
>  	struct pinctrl_dev *pctl;
>  	void *base;
>  	const struct tb10x_pinfuncgrp *pingroups;
>  	unsigned int pinfuncgrpcnt;
> -	struct tb10x_of_pinfunc *pinfuncs;
>  	unsigned int pinfuncnt;
>  	struct mutex mutex;
>  	struct tb10x_port ports[TB10X_PORTS];
>  	DECLARE_BITMAP(gpios, MAX_PIN + 1);
> +	struct tb10x_of_pinfunc pinfuncs[];
>  };
>  
>  static inline void tb10x_pinctrl_set_config(struct tb10x_pinctrl *state,
> @@ -771,15 +771,13 @@ static int tb10x_pinctrl_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	state = devm_kzalloc(dev, sizeof(struct tb10x_pinctrl) +
> -					of_get_child_count(of_node)
> -					* sizeof(struct tb10x_of_pinfunc),
> -				GFP_KERNEL);
> +	state = devm_kzalloc(dev, struct_size(state, pinfuncs,
> +					      of_get_child_count(of_node)),
> +			     GFP_KERNEL);
>  	if (!state)
>  		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, state);
> -	state->pinfuncs = (struct tb10x_of_pinfunc *)(state + 1);
>  	mutex_init(&state->mutex);
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -- 
> 2.21.0
> 

-- 
Kees Cook
