Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E9AC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AF921019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zyz0HHaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfEMHoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:44:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40344 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfEMHoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:44:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so14006924wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 00:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OT71EAwxl4wA6+YtX4rN0OJahyazfPvJiN7l6rKFsek=;
        b=Zyz0HHajuuueQ14dGBCAfnblxjKE63v6ovBq+xccC0TKAh0JGEjTZdmOOAyXfRourg
         Hkm3tNCyg6tFgqLZVzY7Cq/q84ISaM+vYaAjjbRWOvqHXWzvyV9AmjqMOA7dH2tuPk98
         b4vbcDt0GfpM9yfTGsQM5+ZlX9K2Vzj0irJIZoXo3WlwgGJcGaWEDv5zHknRy1fv2jLY
         qz2bxVbyfYssedNu5+e8xERXXgXfNfHaTrojeAfBfY5ziL70MWZwXQnFJ1fyPgszLCwq
         Q9QdMrBk0bb/0WlljPRgNAwCjGRVjSYDZ3lQinsYUf9o2PDsOCf7jhaB/7seBrb+GMsj
         NWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OT71EAwxl4wA6+YtX4rN0OJahyazfPvJiN7l6rKFsek=;
        b=Cm54I8dbbEMPNSTvvcwxgtKQmnTzPcsF5BJ+o7tZBBE2++gbRjG3lVxuTGw/Kka4gH
         J7Bau11ZQpQJRWwb/EPaY6ETJyY6wxiIPg6rFfdDOBAV14vqFez6oU8Lm+1CYN3+gRiX
         eDsCpFxZ9XTLmbe4bQdOZv7k2tzPcXNVxhFnwoOPvp4E87fuG+6BNsxq9HGxzCUni/Bf
         YUpQ57nNcQiSBvFburbT9y0uATV9Q3oexfIZpdHK26CQiQhBwqbwNPR7lUcynP4zVHFo
         of4Mto8S0GjOzXsEF31/LbDioL22f9QO9poOPb8c6JRwqKZ1A2DWMkd7WHbNjxNt8E5p
         lStw==
X-Gm-Message-State: APjAAAXb/3g4SvMfnqtL28ZWrHilf/wTRxJjhmaU90V6enFch8hndahA
        +y28PuSjqQhiIJVHUbNH13ub5Q==
X-Google-Smtp-Source: APXvYqxAXI43awYbJUlo3tZn1JOtkzPnPJ5Kpu6uf5DsvNl0ikrAa2gpF4ov4OG9hj0nfcDVurgUjA==
X-Received: by 2002:a5d:6cae:: with SMTP id a14mr1830626wra.214.1557733482420;
        Mon, 13 May 2019 00:44:42 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id h12sm9258467wrq.95.2019.05.13.00.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 00:44:41 -0700 (PDT)
Date:   Mon, 13 May 2019 08:44:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, kbuild-all@01.org,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] pinctrl: stmfx: Fix comparison of unsigned expression
 warnings
Message-ID: <20190513074440.GK4319@dell>
References: <1557732606-14662-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1557732606-14662-1-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019, Amelie Delaunay wrote:

> This patch fixes the following warnings:
> 
> drivers/pinctrl/pinctrl-stmfx.c:225:5-8: WARNING: Unsigned expression
> compared with zero: dir < 0
> drivers/pinctrl/pinctrl-stmfx.c:231:5-9: WARNING: Unsigned expression
> compared with zero: pupd < 0
> drivers/pinctrl/pinctrl-stmfx.c:228:5-9: WARNING: Unsigned expression
> compared with zero: type < 0
> 
> Fixes: 1490d9f841b1 ("pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  drivers/pinctrl/pinctrl-stmfx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Already fixed up and pushed.

> diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
> index bcd8126..3bd5d6f 100644
> --- a/drivers/pinctrl/pinctrl-stmfx.c
> +++ b/drivers/pinctrl/pinctrl-stmfx.c
> @@ -213,7 +213,7 @@ static int stmfx_pinconf_get(struct pinctrl_dev *pctldev,
>  	struct stmfx_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
>  	u32 param = pinconf_to_config_param(*config);
>  	struct pinctrl_gpio_range *range;
> -	u32 dir, type, pupd;
> +	int dir, type, pupd;
>  	u32 arg = 0;
>  	int ret;
>  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
