Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25493C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E937320821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUve0Zip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfEVFsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 01:48:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50847 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfEVFsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:48:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id f204so795764wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 22:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/tTf0o0S8X8KnChjJDfa2qYc6+8coCPQJrmnG5nMMms=;
        b=uUve0ZipnHu6cyNoI44TVwaoHbwO5Byw+UNySCQATErAkisI+mHPIbXN4XMMGxFRbd
         YU40swFzP8fPVrDfpyRwt0K1sNhjTFKRFTZ0jvSzNnDU0aayBXnXPkYQat15PEkbB7B2
         vdZImcsk6mklId16PzEv6fSWDOnOUW7nUpfiCksXPkZXigHjnI5aKhbvqJXFMXLtR1k2
         r1UkXhC+sh+5Qx+M+vywvf0UdtefyAn9GD2w+2709N6CFU7uSw9jsRL/28jYYhx4QoH4
         JLdQdZRONICn8J4EdMWYVD3d35LNAwi7oVsGBzBZiP2B7vylayIdp89IvWCQxbdPoC41
         LGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/tTf0o0S8X8KnChjJDfa2qYc6+8coCPQJrmnG5nMMms=;
        b=VCVqRv8tUF8xosFO5ClLK60XZvhSleavEmFXptlHdOohQ491b1REsIXLfyncsbmXBl
         Un5/TWve8zfHs0PE5bMpNAk1fbKqhCmjYsIIiRIgTv99qcWFndUyHoN5006WKRr0/Raa
         TshZbq2Ur5KxKd0OUCs99Tkf7SZUYoZb5vX2K5W+xtDEg/7Vq0/XobrVyhjdWA2HzYdk
         KR/ASx4HA0B10fY3S0kcf3ULofuvpyZHj8typeIKW9zQzYHpwZTg5dqhcjxVdlPIjhdG
         W59BzD4a6v8BMhRxkQRTxBeUiorigAiGwZQx5mqAw1hXb6k2Hd5ll/7coJd18542UbX0
         Ruuw==
X-Gm-Message-State: APjAAAU768rVS+dm2AvDiSRSPRKvJszurWKyLUUe1PV02nVFjuPHWYVX
        vKMcjo6cK1ti3sTMaYZ7IUQ4Tw==
X-Google-Smtp-Source: APXvYqw7YHeamUnm0AYxBgRDczx++fDFxFoKXuD29B3Z8t2mMkfJ9/TcKb9Bf8lpkjRJKl0djf95Gw==
X-Received: by 2002:a1c:f10f:: with SMTP id p15mr6051518wmh.150.1558504115720;
        Tue, 21 May 2019 22:48:35 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id p8sm15177511wro.0.2019.05.21.22.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 22:48:34 -0700 (PDT)
Date:   Wed, 22 May 2019 06:48:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, kbuild-all@01.org
Subject: Re: [PATCH] pinctrl: stmfx: Fix compile issue when CONFIG_OF_GPIO is
 not defined
Message-ID: <20190522054833.GB4574@dell>
References: <1558338735-8444-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1558338735-8444-1-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019, Amelie Delaunay wrote:

> When CONFIG_GPIO_OF is not defined, struct gpio_chip 'of_node' member does
> not exist:
> drivers/pinctrl/pinctrl-stmfx.c: In function 'stmfx_pinctrl_probe':
> drivers/pinctrl/pinctrl-stmfx.c:652:17: error: 'struct gpio_chip' has no member named 'of_node'
>      pctl->gpio_chip.of_node = np;
> 
> Fixes: 1490d9f841b1 ("pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  drivers/pinctrl/pinctrl-stmfx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
> index eba872c..bb64aa0 100644
> --- a/drivers/pinctrl/pinctrl-stmfx.c
> +++ b/drivers/pinctrl/pinctrl-stmfx.c
> @@ -648,7 +648,9 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
>  	pctl->gpio_chip.base = -1;
>  	pctl->gpio_chip.ngpio = pctl->pctl_desc.npins;
>  	pctl->gpio_chip.can_sleep = true;
> +#ifdef CONFIG_OF_GPIO
>  	pctl->gpio_chip.of_node = np;
> +#endif

This is pretty ugly.  Will STMFX ever be used without OF support?  If
not, it might be better to place this restriction on the driver as a
whole.

Incidentally, why is this blanked out in the structure definition?
Even 'struct device' doesn't do this.

>  	pctl->gpio_chip.need_valid_mask = true;
>  
>  	ret = devm_gpiochip_add_data(pctl->dev, &pctl->gpio_chip, pctl);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
