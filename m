Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF091C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AFF20679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqdeS5lE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKLRBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:01:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46801 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKLRBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:01:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id r18so12209483pgu.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GDojT++zYyimFKXjGTgtIMvoNwjyBW8FizODRtTHlkU=;
        b=gqdeS5lER8xfVdf3MPfzRhQWtIdYGVkfvSEfkEikV5sK+iUbNyoUDxfqd0+Gf8qRon
         qIHWABuQ6RrIuV9KP9et/nCefEYxwgv0VU6xWDH/6WigGjakxakLa/uAk/OZfK6aVs7K
         LvkNK+dcIIHQrnxcoqA/IqdlZjyzz32xgRlYjaX7VbauzkexzJ8FhEebDZqN5k6CV5bv
         1E2P4sJBj7B20dAtY+vRdNYhwg7+Crzg+hEcAIZsxPn2ZVIiajYUgAJYOPGKF8JwDcwE
         0IZzMwP9eCWaBLOLkKUPL66WfWRvEgGNsCoRadK6bSa6QAU6DElkyAo1XDy0qVlKPQZg
         tUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDojT++zYyimFKXjGTgtIMvoNwjyBW8FizODRtTHlkU=;
        b=rCiCg/FSdXU2HWALohdwtFcA+ED4aP+DSf8YSg6eIHaGxjXXpRMShbinSu7d2JufBM
         j2ic1Ru0ivrvrj8h2t6LubNJbNrLLE/fes62GPjyAAXXFdKh9sJZhqMmpj4wWqk4LCmI
         i7S4R79mjUUCVB/a0fSlx8JZ5Il3CJVNTNIIfvozx6ZSUKf+TB4ON0aDKPxuHFV50AlY
         0qHRNHHixgVqmLnmwF6SKCPrhKcFcTTLgmBBA7Z7bYPyzYiILg5Qo6XVi/Y1sq1DvxMP
         8u8/0ioJe+6XSLxABygIAqbzMU5A4TGNOBlIrsLOhFSsNEgTDC+1+kG7SKCHCmdU0Bt/
         OBTg==
X-Gm-Message-State: APjAAAX1WZQzg9KTJT8FGOfZ9CEEP3qEja6X+kZVHxbR85mXhvDw/3lU
        vKR0Nuk2lvpuAU9loqyJS3uvSQ==
X-Google-Smtp-Source: APXvYqw4G8Nv44pA6Fs7EzjALZ0qCpPOe1DYkXKQWUmcJweMaKJlE6IhOyuyuFHl+85B3ZJqZHBicw==
X-Received: by 2002:aa7:85d7:: with SMTP id z23mr38064618pfn.24.1573578109877;
        Tue, 12 Nov 2019 09:01:49 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y138sm20294845pfb.174.2019.11.12.09.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 09:01:48 -0800 (PST)
Date:   Tue, 12 Nov 2019 09:01:44 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-oxnas@groups.io,
        linux-rockchip@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] pinctrl: Use new GPIO_LINE_DIRECTION
Message-ID: <20191112170144.GF3797@yoga>
References: <20191112141819.GA22076@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112141819.GA22076@localhost.localdomain>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Nov 06:18 PST 2019, Matti Vaittinen wrote:
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 763da0be10d6..8844ca1261d5 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -485,8 +485,8 @@ static int msm_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
>  
>  	val = msm_readl_ctl(pctrl, g);
>  
> -	/* 0 = output, 1 = input */
> -	return val & BIT(g->oe_bit) ? 0 : 1;
> +	return val & BIT(g->oe_bit) ? GPIO_LINE_DIRECTION_OUT :
> +				      GPIO_LINE_DIRECTION_IN;
>  }
>  

For pinctrl-msm

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
