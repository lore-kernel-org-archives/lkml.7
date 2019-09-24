Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BD3C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A56B2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569325994;
	bh=NGt6jMnoP7NnPCH22gx+cw8HTba0LuzHSXarHoqNTHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G8uXEgbiQ+dHgEA+KDA0DtQG44SHBUZ2WDfCi816GEnuw3tJRdRfWybxs0hG9BI7H
	 Gjh1wflUfCCu/uWLesBf3nOhLAkQm78fRJmaZFJO/qp4UY2BZ7+mDsabEMegdo82TR
	 LZKAv8ZFZqJC7Wgi5Eb1KGC8cWNvMgw9TCqB7zC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440881AbfIXLxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:53:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40098 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394463AbfIXLxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:53:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so1698109wmj.5;
        Tue, 24 Sep 2019 04:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WNfm1Zs8sa/yhnNl+F7HeaUQPH9XBnoe9OCsFmg1tQw=;
        b=Y2t3fapm2PZT2Uhvya0ZIbbp2/mwKc0CcQeCgdoDRiClaQxsL3PNxHtIqIqNt5AThl
         8oiLKFnEIWNK4DvLYbPi7dyrqwNQ9PUyL/rbKQiMN29HSwYI1n5xX4HCVG4lvLZeMR4K
         nxGq8EkZyWyVgx19XkJiigcz/F7/qvnNlPIDYRrxJuq0Lw7UJdjHTJjdU3FgS+38omCr
         mdXOKetZYAXg48JNvGOjjUBDrUyUyYA3OhPHlf96E8TcwEJUU8vJ+vecYSZ/I1B0ZXWw
         ZrZ+CSADls20iD1zoP4HI7v3M0nN2G3RfdIDymabwA1xGhA/f0jtCDbYrSvm5WaSqEO4
         6qBA==
X-Gm-Message-State: APjAAAUt6Crv6ern+pCR58Fl1Synh2G8MqMpRvSd2tNx+PHw9p4fON+c
        ymQta34/GTLOZKcvEm+qJvE=
X-Google-Smtp-Source: APXvYqxYnHcckWlHgDM9sqY+5/AP8HA4nq5+Sv98PoYYAkBHju2tePuUAxCFnt9r2RofX53c3Q3lkg==
X-Received: by 2002:a05:600c:2386:: with SMTP id m6mr2453390wma.164.1569325990427;
        Tue, 24 Sep 2019 04:53:10 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id b16sm2506984wrh.5.2019.09.24.04.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 04:53:09 -0700 (PDT)
Date:   Tue, 24 Sep 2019 13:53:07 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: Re: [PATCH] ASoC: samsung: i2s: Add clocks' macros descriptions
Message-ID: <20190924115307.GA9188@pi3>
References: <CGME20190924114843eucas1p2ea9c36289d3912e022ad7c9070fc00ee@eucas1p2.samsung.com>
 <20190924114838.25482-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924114838.25482-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 01:48:38PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> To increase macro readability added descriptions
> to clocks macros.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  include/dt-bindings/sound/samsung-i2s.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/dt-bindings/sound/samsung-i2s.h b/include/dt-bindings/sound/samsung-i2s.h
> index 77545f14c379..fd752475c762 100644
> --- a/include/dt-bindings/sound/samsung-i2s.h
> +++ b/include/dt-bindings/sound/samsung-i2s.h
> @@ -2,8 +2,13 @@
>  #ifndef _DT_BINDINGS_SAMSUNG_I2S_H
>  #define _DT_BINDINGS_SAMSUNG_I2S_H
>  
> -#define CLK_I2S_CDCLK		0
> -#define CLK_I2S_RCLK_SRC	1
> -#define CLK_I2S_RCLK_PSR	2
> +/* the CDCLK (CODECLKO) gate clock */
> +#define CLK_I2S_CDCLK 0

I do not find it more readable because of removal of indent after define name. Also the description is not accurate - you documented, not increased readability.

Best regards,
Krzysztof

> +
> +/* the RCLKSRC mux clock (corresponding to RCLKSRC bit in IISMOD register) */
> +#define CLK_I2S_RCLK_SRC 1
> +
> +/* the RCLK prescaler divider clock (corresponding to the IISPSR register) */
> +#define CLK_I2S_RCLK_PSR 2
>  
>  #endif /* _DT_BINDINGS_SAMSUNG_I2S_H */
> -- 
> 2.17.1
> 
> 
> 
