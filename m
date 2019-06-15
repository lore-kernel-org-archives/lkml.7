Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D443C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 09:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F552070B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 09:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWTGzFth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfFOJIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 05:08:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38481 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfFOJIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 05:08:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so4712242ljg.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 02:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vayDdK/vaesz7L05p0dkZXM5UoCyNlQN49Uoqkipvlw=;
        b=fWTGzFthId9hzVyOtgiaLMjIvqa6ZwEXSRdzOHrCr7pRT60A9Xw6me5yQuXvKPy3sH
         04iSCrBPln324GOkoEuntvOOuj1CjuSsnnjxMhKKkxAJvpr8sfvP5Zm4nEc/foZqa1hG
         WPU68e3+OWeh7rqmvIGT9YS6xT0SbBLqb6MemZsAj6cH2LuQWirffy0CMPTDjRL0s0t3
         iDgo3D/6jkqIGtfPnvmA5szG9SgxGczSRHnibNBEwSzGF947YLRKY5v92sqixTz/blf9
         ozamKszRE1ID1EnYxgHbp9RxFHJDwPCV4/tY95DXj/Bkr7NecURtcTyhKtmVstUQ67p3
         OVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vayDdK/vaesz7L05p0dkZXM5UoCyNlQN49Uoqkipvlw=;
        b=Di2GYx9rWoQlmjAFNG0rxQl/vhYfobeut7g0LLnToZAeUjQXDtwAbpJNfMsvu5Rcuw
         CzfGeyCgQLsQJPd3ak/GUcdBMcDipd6IB5MJ0EvTlhDg20b/oBow8qsN4TnWzoIUzvK7
         fYyRnm7MO4T78XIah2FEFOLYFBvk+XTXquoQNXzVdrc07ofKxNPRwKEsEGwbW0BFTgih
         KxQBHnPehyToEMQSpGr2XZJRP831nxYha5cW8Wk1MFb6LAs7+AwH09NgNDnrAWSEVfKi
         iNghZlzEGEcAiXxBEgox1jVjEOSaQBLt/bYLOJVs/o6F/zK82TGYIehcW+9SY/MI9AeH
         zESw==
X-Gm-Message-State: APjAAAVhPwdd3X3HI9ImuLZPk5itv37jjgaCVWaxKV0HcdiKYIJALzhY
        PNyIkVCxoCrMKEjR2vnJCxpfqSK1xRP10qiGgfYunlMt
X-Google-Smtp-Source: APXvYqxxpPX0MFg86Ybf9Btur1w6L41hbpJT1a9eqVSP6PVSeEyKabLCfrQuRI9zJM1kbI+LqUsQ9tji85rSyc7toy0=
X-Received: by 2002:a2e:8195:: with SMTP id e21mr31572361ljg.62.1560589686938;
 Sat, 15 Jun 2019 02:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190612193115.6751-1-martin.blumenstingl@googlemail.com> <20190612193115.6751-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190612193115.6751-2-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 15 Jun 2019 11:07:53 +0200
Message-ID: <CACRpkdajXRXRFz=XpbEzwUb-crhBxNQ4f-m9rfdY6+HcG0+_gA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/1] net: stmmac: use GPIO descriptors in stmmac_mdio_reset
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     netdev <netdev@vger.kernel.org>,
        Giuseppe CAVALLARO <peppe.cavallaro@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin!

Thanks for fixing this up!

A hint for a follow-up:

On Wed, Jun 12, 2019 at 9:31 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 4335bd771ce5..816edb545592 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -97,7 +97,7 @@ struct stmmac_mdio_bus_data {
>         int *irqs;
>         int probed_phy_irq;
>  #ifdef CONFIG_OF
> -       int reset_gpio, active_low;
> +       int reset_gpio;

Nothing in the kernel seems to be using this reset_gpio either.

I think it can be deleted with associated code, any new users
should use machine descriptors if they insist on board files.

Yours,
Linus Walleij
