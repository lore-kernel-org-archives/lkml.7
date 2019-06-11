Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2A8C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1466021721
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="caXhb4Jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407270AbfFKXYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:24:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45568 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405384AbfFKXYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:24:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so8372117pfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pzZQijjYh2lq3MqwPAxsWI0diaePNWtLIjQJaO7lucU=;
        b=caXhb4JrKoL25WULlmBoyErRhTzl+Qlefw5zmfGbW45Q82gCsvakwZwKbdppzTmYHq
         wRtcEW9aBQjqtEnLBq7mdWutGGxaFThaxGaUrr6hxvw5WNwWKm/gOkg4F0fSjhpYU+jo
         UhKHDTsgIbt5HjMWbJmawF8TeUU/Hy1WjGBhjBAXjssbkfrEeKUaiqm8lJEgEsRrAAIn
         n4a6MQE9jdlTIiTsWxACww5EdRlH4vZyS8zy8itKUIjOB4AdOLbgdvxTVa0pYQqcCu6c
         PPn5HgnY7WyNT70n8RmIMIC3HhTaR4x6iNx15v4683bc2S0IIr/nfO8ayq1TU8Ok6nse
         kqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pzZQijjYh2lq3MqwPAxsWI0diaePNWtLIjQJaO7lucU=;
        b=J/RX8eBU6zWD7W22OZe313nVLMJcLMfx3z9X+Y7vUSUMA1udyLAAs0rgMM9RcL/2gL
         ZlOle7Vjq/yu8/e9L28RJfgZta4p+x5n+DnEdQaCxVMw2geHN7g0kuZvF+fPnP1jge+T
         QQ6iWGZ6Ai8QftXkdkHwb0YStfXiVyIJhWp3k+RyrS2O+ZULXniI7hoXdlnPJkv1EB4Y
         HUUxPAuXP/NLEsa8iOAHYeW63v9yhaSXhQaWWS2koDuGeu8dmx6SrU7mm9BuNo5RDM3q
         n98w206c1C9H3HoPad/RbgdG1064RPxIQRtIacIhyMZzch95FLIQ1GXLJ5ZO5qqm5uOj
         +YpA==
X-Gm-Message-State: APjAAAVW1PH1y8j15PftPBeylE2S7tlWNMDSLLskRPbptOYIJ2I2v6+t
        79PRVVptyR7Yiq31tBo7qg9BNYb582g=
X-Google-Smtp-Source: APXvYqynJgfnRKT9jxHr/rkFxt5cW774++TFNZRQTm5JTkX+8RQKfGhmIHYDuLE+xibLa/Xh3lHYeQ==
X-Received: by 2002:a65:514a:: with SMTP id g10mr22250270pgq.328.1560295489184;
        Tue, 11 Jun 2019 16:24:49 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id y7sm8141090pja.26.2019.06.11.16.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 16:24:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Yannick =?utf-8?Q?Fertr=C3=A9?= <yannick.fertre@st.com>,
        arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list\:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: add Panfrost driver
In-Reply-To: <71c929a0-d42e-7519-df43-100a474a63d4@baylibre.com>
References: <20190604112003.31813-1-tomeu.vizoso@collabora.com> <71c929a0-d42e-7519-df43-100a474a63d4@baylibre.com>
Date:   Tue, 11 Jun 2019 16:24:47 -0700
Message-ID: <7h4l4v4se8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 04/06/2019 13:20, Tomeu Vizoso wrote:
>> With the goal of making it easier for CI services such as KernelCI to
>> run tests for it.
>> 
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>  arch/arm/configs/multi_v7_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 6b748f214eae..952dff9d39f2 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -656,6 +656,7 @@ CONFIG_DRM_VC4=m
>>  CONFIG_DRM_ETNAVIV=m
>>  CONFIG_DRM_MXSFB=m
>>  CONFIG_DRM_PL111=m
>> +CONFIG_DRM_PANFROST=m
>>  CONFIG_FB_EFI=y
>>  CONFIG_FB_WM8505=y
>>  CONFIG_FB_SH_MOBILE_LCDC=y
>> 
>
> Hi Kevin,
>
> Could you apply this changeset on the linux-amlogic tree ?

No, this needs to go via arm-soc (already cc'd)

Kevin
