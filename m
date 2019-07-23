Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5814BC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 00:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2517621955
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 00:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3qJWuJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfGWAaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 20:30:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38891 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfGWAaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 20:30:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id h28so27967298lfj.5;
        Mon, 22 Jul 2019 17:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ydn5aXtbjPIthQYkb8DxoEn6a0yqGKXsQnxBhhcpdZQ=;
        b=C3qJWuJWplSYB8ByJ1dwwDffH+KZUkfbYP8PHNyRm7cS/J1Lir7t1sFAkd07DEZqco
         08WCgeHqWzSwGYLlx/e60/hNdrUMI3hGElgtiiCFrs4PpjekwDHCfq6ylyJJ1FWzkP3Q
         GEsZC6UYDteoP9+Pvc5RQB2YVkHLHgpi1MbQs7RwDjENUD+pVX6QrWtfhlscMQaMNWqn
         clSawOJRK912XFD7BG6itU8Vfe5Nf/QqCdSDKv2ag3i7cjsGLXq6vue3FRNnYG1YnC45
         a8+8SQzOd9C/UbVtMUQ3rkSV8qXQGpCuJGzhk1OVXSfnLTwLAK9MN3kf2nrx4wRe+QQE
         yjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ydn5aXtbjPIthQYkb8DxoEn6a0yqGKXsQnxBhhcpdZQ=;
        b=HMa51Hwi+NwdEtkJihUrm52xTJsv98B/qWp/VmCw/tG4/MvkEoAXQnqK43Qqq+nRrZ
         6VCzr538OJ8D7qibZFR2RG93ps1liu7OATLXKeytbCHfeuFcdKKEZyR+9TtdjmcpI3/m
         sP4OVBFRWSyM8BT4MnlHc245C/OVUkCShrw0Ev8RGFlqDoViE3eVZ1dyVFrsGp+InVu7
         TI7EpJxT37XEFYqNCaLCTSyGQm/HsFsZSkTVeAOsjZEoRhHcOqUm4FT9gYLxBrW15+5p
         d0+hNaGfNEypWbQ0gNdik0C3/tn+knXR+5bUIl3Wd9XVuBMzmlbnJ2rH8NFku43ZE6kB
         UOxQ==
X-Gm-Message-State: APjAAAWYvHmVY+BHhoYacSeyWBgKkgG2gzQCN0uDGTorFkcmMMZxQ/wD
        ZxY2E57j+5KNQBR4RGnJQfzPBHoR
X-Google-Smtp-Source: APXvYqxmsDUOvMm9RFs8rcYOlKF/8VpQPPWJKSzE41Iv1hLPzW7DNrnvEdDNJfjW6mv1WwHX4ehs2g==
X-Received: by 2002:a19:7f17:: with SMTP id a23mr35997598lfd.49.1563841806644;
        Mon, 22 Jul 2019 17:30:06 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id e26sm7804856ljl.33.2019.07.22.17.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 17:30:05 -0700 (PDT)
Subject: Re: [PATCH v2] drm/tegra: sor: Enable HDA interrupts at plugin
To:     Viswanath L <viswanathl@nvidia.com>, thierry.reding@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, jonathanh@nvidia.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1563787632-19762-1-git-send-email-viswanathl@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <11288075-f34a-222c-66da-2bfd13db987c@gmail.com>
Date:   Tue, 23 Jul 2019 03:30:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563787632-19762-1-git-send-email-viswanathl@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.07.2019 12:27, Viswanath L пишет:
> HDMI plugout calls runtime suspend, which clears interrupt registers
> and causes audio functionality to break on subsequent plugin; setting
> interrupt registers in sor_audio_prepare() solves the issue

Hello Viswanath,

A dot should be in the end of sentence, please. And should be better to
s/plugin/plug-in/ in the commit's message/title because 'plugin' sounds
as a noun.

Please don't version patch as v2 if v1 wasn't ever sent out.

You should add a stable tag here to get patch backported into stable
kernel versions:

Cc: <stable@vger.kernel.org>

> Signed-off-by: Viswanath L <viswanathl@nvidia.com>

The kernel upstreaming rules require a full name. I'm pretty sure that L
isn't yours surname.

> ---
>  drivers/gpu/drm/tegra/sor.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
> index 5be5a08..0470cfe 100644
> --- a/drivers/gpu/drm/tegra/sor.c
> +++ b/drivers/gpu/drm/tegra/sor.c
> @@ -2164,6 +2164,15 @@ static void tegra_sor_audio_prepare(struct tegra_sor *sor)
>  
>  	value = SOR_AUDIO_HDA_PRESENSE_ELDV | SOR_AUDIO_HDA_PRESENSE_PD;
>  	tegra_sor_writel(sor, value, SOR_AUDIO_HDA_PRESENSE);
> +
> +	/*
> +	 * Enable and unmask the HDA codec SCRATCH0 register interrupt. This
> +	 * is used for interoperability between the HDA codec driver and the
> +	 * HDMI/DP driver.
> +	 */
> +	value = SOR_INT_CODEC_SCRATCH1 | SOR_INT_CODEC_SCRATCH0;
> +	tegra_sor_writel(sor, value, SOR_INT_ENABLE);
> +	tegra_sor_writel(sor, value, SOR_INT_MASK);
>  }
>  
>  static void tegra_sor_audio_unprepare(struct tegra_sor *sor)
> @@ -2913,15 +2922,6 @@ static int tegra_sor_init(struct host1x_client *client)
>  	if (err < 0)
>  		return err;
>  
> -	/*
> -	 * Enable and unmask the HDA codec SCRATCH0 register interrupt. This
> -	 * is used for interoperability between the HDA codec driver and the
> -	 * HDMI/DP driver.
> -	 */
> -	value = SOR_INT_CODEC_SCRATCH1 | SOR_INT_CODEC_SCRATCH0;
> -	tegra_sor_writel(sor, value, SOR_INT_ENABLE);
> -	tegra_sor_writel(sor, value, SOR_INT_MASK);
> -
>  	return 0;
>  }
>  
> 

