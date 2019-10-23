Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2844DCA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35DE20640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571835060;
	bh=T2Glx9RTjlFT9FkGXOCt1ml4fZ8gy+uQGlUDPcU+y0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uv4t1y6qUfNVrzk3wMtq1gbu263ZLC736RmrWg2mGDHMrtn/8e5KZtL9E/G5wNdab
	 i2eN0/6Vs6omEQp/G5rawccyz6sWjCMiswLMA1/xObGZyFVHLZYkTNZB4j35EehVXy
	 dBN6OGNp3p26qAW6DBmu/j8FIWbkSXkRU522UO3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391787AbfJWMu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:50:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44020 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391683AbfJWMu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:50:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id q24so9673114edr.10;
        Wed, 23 Oct 2019 05:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oT2q812vkwR6lQz5u4dP7bLM7jh35Rq8yHei8+lOv9w=;
        b=kS1X1nMGBxMBPVs/M7fHz1EIhJYTK5VXNdrni33UKnpObnrwXXYVH6fn0KOf9bKwoU
         AW85dcb6wsRJFPc4zQUdMAUgkQNAPIXxpncjoqVxjQY9/XRrLViA44CdN4vOUKyTNKi/
         zXju32QZ75DXz9DG++kQZ78+DWkBUnMLgb7fWert/XXmLzmrgA6to/JCu76aHCrId3OQ
         Yh2GRAmKQm9pK9eO+dfwIVdm4fabBBtN4uNOgXN3xtzi/gnyjJdeCqCpFLqeMRYFXTr/
         bY4ZW29SZxgt7O6wWjX2pAy2+qCdPMSPwqrZAA3jqvQldFaUz8DrPGNnvSUTC1wzQ/sf
         bPGQ==
X-Gm-Message-State: APjAAAUda0nJG6OO3H4NVW185qbYkKj7/oTiA8Ru29YTw4UxEc0XmgbN
        P8gh8mbU2jCO3n89X2K33fM=
X-Google-Smtp-Source: APXvYqzLq1IwwtENOWtlyqBj9T2iqCV94L/4HoNoJFxSLjEVDtlX9NMAHQ1sSA9Bd3uXFYj6DR034w==
X-Received: by 2002:a05:6402:88c:: with SMTP id e12mr23305215edy.170.1571835056324;
        Wed, 23 Oct 2019 05:50:56 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id i63sm780337edi.65.2019.10.23.05.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:50:55 -0700 (PDT)
Date:   Wed, 23 Oct 2019 14:50:53 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 21/36] ARM: s3c: move iis pinctrl config into boards
Message-ID: <20191023125053.GF11048@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-21-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-21-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:30:05PM +0200, Arnd Bergmann wrote:
> The s3c_gpio_cfgall_range() function is an internal interface of
> the samsung gpio driver and should not be called directly by drivers,
> so move the iis pin initialization into the boards.
> 
> Note that the s3c2412-i2s driver has no boards using it in
> mainline linux, the driver gets selected for the jive machine
> but is never instantiated.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c24xx/mach-gta02.c    | 4 ++++
>  arch/arm/mach-s3c24xx/mach-h1940.c    | 3 +++
>  arch/arm/mach-s3c24xx/mach-mini2440.c | 5 +++++
>  arch/arm/mach-s3c24xx/mach-n30.c      | 5 +++++
>  arch/arm/mach-s3c24xx/mach-nexcoder.c | 5 +++++
>  arch/arm/mach-s3c24xx/mach-otom.c     | 6 ++++++
>  arch/arm/mach-s3c24xx/mach-qt2410.c   | 3 +++
>  arch/arm/mach-s3c24xx/mach-rx1950.c   | 3 +++
>  arch/arm/mach-s3c24xx/mach-rx3715.c   | 4 ++++
>  arch/arm/mach-s3c24xx/mach-smdk2410.c | 5 +++++
>  arch/arm/mach-s3c24xx/mach-smdk2413.c | 4 ++++
>  arch/arm/mach-s3c24xx/mach-smdk2440.c | 6 +++++-
>  arch/arm/mach-s3c24xx/mach-vstms.c    | 6 +++++-
>  arch/arm/mach-s3c24xx/simtec-audio.c  | 6 ++++++
>  sound/soc/samsung/s3c2412-i2s.c       | 7 -------
>  sound/soc/samsung/s3c24xx-i2s.c       | 7 -------
>  16 files changed, 63 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
> index 526fd0933289..1ca0460d82f4 100644
> --- a/arch/arm/mach-s3c24xx/mach-gta02.c
> +++ b/arch/arm/mach-s3c24xx/mach-gta02.c
> @@ -540,6 +540,10 @@ static void __init gta02_machine_init(void)
>  
>  	i2c_register_board_info(0, gta02_i2c_devs, ARRAY_SIZE(gta02_i2c_devs));
>  
> +	/* Configure the I2S pins (GPE0...GPE4) in correct mode */
> +	s3c_gpio_cfgall_range(S3C2410_GPE(0), 5, S3C_GPIO_SFN(2),
> +			      S3C_GPIO_PULL_NONE);

This is not entirely equivalent move as before this was probe (so being
executed also on rebinds) and now it is init. I guess it should not make
any difference so let it be.

Best regards,
Krzysztof

