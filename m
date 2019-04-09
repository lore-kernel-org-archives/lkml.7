Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00732C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD33E20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnLUsQGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfDISow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:44:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40077 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDISow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:44:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so15431391ljq.7;
        Tue, 09 Apr 2019 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WfCzyC8QBaiprEbkfnq16RnTqbITQWA6W2Znk7EGPpw=;
        b=PnLUsQGUS56d0pBtW/zA8U6dsJTDk3o2N7ufgXJCi6WcTNubG7Wq7w7p3UqcTG5ko5
         Kg33h2HbNi019uTouEp5bP6fbG3Xu/ePFHFJHqBorqlliidQQZwF+BVbTExNJsTD2kaB
         rhcILzhwAkpyBfb6jCUqtxzAm1a8hiA8oU4Xq4hAjO9VTXE5vBfYzVHPzjgMFgaKe3Dm
         aPVOMKvFk2raDeJjkVqG+oIFOcET3CwxDEgICbJD5JEGH2YtlMrqa2CLJgegHosm4kj9
         CH9iQpihjvFO3dXxq6CO15ViNUKLAengi8HJ66lQPm2uCGqBI++ieFkBSii6Grptiaww
         hWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WfCzyC8QBaiprEbkfnq16RnTqbITQWA6W2Znk7EGPpw=;
        b=WqTk02MWk46kHb5H0gpZzyOP/wWr3wgI6Fq8XzpOMaPzQnUwcoo/L9abJwkLsTjCor
         y3WQ9OoPW3wCWO+/eOQZTl/ctpYNlTudGMDcCUeDGLv4YpvIQsj19YbSabLQ0QKN8Elj
         4MrBRUHi3tQBg0jJiBJYdB8E+u82eNIMoMblJG0GWCRBG2OlP9c63yMh9Fq0pmOfpAF8
         qLsidR+5jYCMKOlgdUVRA76GuR4A42yLbhTgHjZYSYN+FA+SAY9rmNpolJ+x2Nvqm+1X
         LYD7xkskYfi5WPpNa2QBHl2HB41ebP0xLdBRYHmWerPDcP1LZpDHkX4iF8s2cw6nWLKP
         m2Lw==
X-Gm-Message-State: APjAAAWmgy0VI4AbZASIDXDNl/SI/SpqwXeHqOaCTVM/AdJvbsLukMXB
        yK6lQUv+HUVShw/sGrBbS7drxqYo
X-Google-Smtp-Source: APXvYqxrK9pqDCWW81Q2fAs17hk0536RwmtZCpqGpGpnS5NlpelJavDqLL28frjVr+LSbV0srWXl5g==
X-Received: by 2002:a2e:808e:: with SMTP id i14mr21539694ljg.103.1554835489771;
        Tue, 09 Apr 2019 11:44:49 -0700 (PDT)
Received: from [192.168.1.19] (civ8.neoplus.adsl.tpnet.pl. [83.31.45.8])
        by smtp.gmail.com with ESMTPSA id p25sm722981lfh.0.2019.04.09.11.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 11:44:49 -0700 (PDT)
Subject: Re: [PATCH 1/6] regulator: lm363x: Make the gpio register enable
 flexible
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        lee.jones@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190405145540.27703-1-dmurphy@ti.com>
 <20190405145540.27703-2-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <1dcaa34b-cce6-63fc-5866-242c1757a4cb@gmail.com>
Date:   Tue, 9 Apr 2019 20:44:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405145540.27703-2-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Regulator maintainers should be added too.

On 4/5/19 4:55 PM, Dan Murphy wrote:
> The use of and enablement of the GPIO can be used across devices.
> Use the enable_reg in the regulator descriptor for the register to
> write.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   drivers/regulator/lm363x-regulator.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
> index c876e161052a..382b1cecdd93 100644
> --- a/drivers/regulator/lm363x-regulator.c
> +++ b/drivers/regulator/lm363x-regulator.c
> @@ -263,8 +263,8 @@ static int lm363x_regulator_probe(struct platform_device *pdev)
>   
>   	if (gpiod) {
>   		cfg.ena_gpiod = gpiod;
> -
> -		ret = regmap_update_bits(regmap, LM3632_REG_BIAS_CONFIG,
> +		ret = regmap_update_bits(regmap,
> +					 lm363x_regulator_desc[id].enable_reg,
>   					 LM3632_EXT_EN_MASK,
>   					 LM3632_EXT_EN_MASK);
>   		if (ret) {
> 

-- 
Best regards,
Jacek Anaszewski
