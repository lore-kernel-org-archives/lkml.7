Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8854EC28D1C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567F820872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="00LRxlmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfFFIaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:30:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37150 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFIai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:30:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so1448279wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lWkUIrodvhUR/Vu7PHVp17sBkIpYVtPnDIFzBj/hJa4=;
        b=00LRxlmYV1saOU1Wl+JG9Lh6z68v/R9ZBc0Qow4LifAGc8PTrHqiS4LvyImbrv9ier
         dVYhf0Wp47+lUZXOS0VpMS2smtIfussoTY2W/RCQ30TyrGNig2zg9o814oFFCfAuzz91
         O1oPdrnfJCazrGXtlXaHEF0Ll0nXNOm+XxJM/TSJoztf/6eEBu45Hh0W7EGovMu2pxYK
         Y8F6jMKkqPb8Ck2xpfo5VuJ68RKm/hHS4Z3Y2hOXd4dpV6FFRWuuOQO2I2wgJbaXX7Zk
         LQ/maBaafdeqBlGeaX7xrmeqbc7MYbf0kRIAIbZVsMzYbrNSk7AvnpbgJpT+p0d/pi4D
         IKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lWkUIrodvhUR/Vu7PHVp17sBkIpYVtPnDIFzBj/hJa4=;
        b=QpOzTZO7p2B9BwrOQJmzl/XP11YibbcxUgqKWFjnInAeJESaJJ89zxVA+eWd2Thfy3
         K4dck0Gui433YO8OvgM0dEqvFlogYmhEs/Sp8RTlCg+KgZt/SbX8vFZh0SJsMt0UvCFU
         Ndk4u8x41fjYcVp5TbFe0tUhXVRCukLK/uRnRdFK3wV5/v8lzDLIL1nSUm5pcLcQcKhd
         ZT46bE2SfHw3EJt6wGm2jbMnaW3NAx8fpOmDKuBpA8WdveFalEOncRRIBSmm5EhiW3b1
         v2Q0rSbILei5/dGJokEdQKmT3huFgOCnde3jI+5COzvps4l7262j0zhCFRh/Lrd65pWO
         baOQ==
X-Gm-Message-State: APjAAAVBl26t07E6P8tA4TIoa81GMX0LfvZu/hdaOCBPVD6KMq0vLSwJ
        qWOPjZ44ZkMbdxPhGOuKdbywfw==
X-Google-Smtp-Source: APXvYqwN6hJbyp1511FI8B8Q3PkkmydpA7jPINjcdqP5BhjvAFpiMsOkzpXyxyNWDfzl3wJzNQnGfA==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr8465443wmi.14.1559809836133;
        Thu, 06 Jun 2019 01:30:36 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f197sm1134357wme.39.2019.06.06.01.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 01:30:35 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: defconfig: add Panfrost driver
To:     arm@kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Olof Johansson <olof@lixom.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        "moderated list:ARM64 PORT AARCH64 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190604112003.31813-1-tomeu.vizoso@collabora.com>
 <20190604112003.31813-2-tomeu.vizoso@collabora.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <45509c02-2efc-3027-ff8f-1f47d224eaa2@baylibre.com>
Date:   Thu, 6 Jun 2019 10:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604112003.31813-2-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2019 13:20, Tomeu Vizoso wrote:
> With the goal of making it easier for CI services such as KernelCI to
> run tests for it.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 4d583514258c..d588ceb9aa3c 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -505,6 +505,7 @@ CONFIG_DRM_HISI_HIBMC=m
>  CONFIG_DRM_HISI_KIRIN=m
>  CONFIG_DRM_MESON=m
>  CONFIG_DRM_PL111=m
> +CONFIG_DRM_PANFROST=m
>  CONFIG_FB=y
>  CONFIG_FB_MODE_HELPERS=y
>  CONFIG_BACKLIGHT_GENERIC=m
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
