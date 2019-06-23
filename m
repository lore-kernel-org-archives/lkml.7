Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCA6C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 04:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E0020679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 04:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1eHZVqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfFWEbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 00:31:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37154 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfFWEbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 00:31:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so9441764ljf.4;
        Sat, 22 Jun 2019 21:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=hGiEqlRc5MJLXesODiy0ME7Yviwr/0syQWplXoAFPOw=;
        b=R1eHZVqjPIG79KkzlAK+XWzgqRQm6QGaPiBBa+VuPcJwD5/fXuEZZKUSQAcZBZDO5u
         /BNXmVzHrJfQg9hWSul7X6EfSGBqU1q357MNfloOkJwW0V+T6lfb8VHHmyMgwh7dnJcv
         6K5o7oSp62Yftv/YsN1tf6XgKT6AEIUhBmTyA+wSRhArkmazXIvH6FPgo3tPnQj5Tl+t
         aEj7FNvx9+i+sIgListx7TMmXsG7w50NwOizSJVQOT9Lv2CGNuPOv/XLi51x7RF8bIOl
         eUxr5NC/xGBMPSJb5JhxTpbWgrtDJsdTRQ4yYgdnYs5sd6RSLXmzrewvegVxJJnzwFZ0
         KTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=hGiEqlRc5MJLXesODiy0ME7Yviwr/0syQWplXoAFPOw=;
        b=j8rWxpjyyei64hUMt4Nwv8CpV+iF59JY1sqjGUlbGak3+8iQ8li2XVvFS5UNezX0oy
         soML4uo8f0sbQNTte9Q0LTBIGSRmDPlGe71ykYJhZr9Lv3Af5SgiG5h/JjgwIalx0ktl
         KbOsUcUFmrlipeMkxFQFYIt0nhB0SPpOHBXwuCGx+QsDiJvxLxhg8b/QQKyqM4pAYcR/
         57yEF4UrgRKn6zxjyHfa9+p+ZPT2jU1gGfQ9bBzCfeUtr8yr90qUYlf6xIwKpzzjkmrK
         NrwLRlzvoSkgTAdn7OLArMMHe3nbuwXI8aQZzc6jX5gErNpwNprJXAzn+dS1jhdkoc9C
         b7zQ==
X-Gm-Message-State: APjAAAVjcvxAjogsyjFbq7aGozgyb+To46CdRLxaR6oz/GJsq0jXc1cP
        wS2NkS2L5RiM/7FcDWgoFLg6b6GIzNd+b/NySAmrckCEqwk=
X-Google-Smtp-Source: APXvYqwMu5YzC6WJljI3IPIZfrsR5mXPbLbjlkf8bI8RZFs7OsvPB751t90niZpM5oV+SbbvBvdyhggWKqUyc6J3HCE=
X-Received: by 2002:a2e:3008:: with SMTP id w8mr41171796ljw.13.1561264259868;
 Sat, 22 Jun 2019 21:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190621180208.25361-7-krzk@kernel.org> <20190622191838.29850-1-krzk@kernel.org>
In-Reply-To: <20190622191838.29850-1-krzk@kernel.org>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 23 Jun 2019 13:30:23 +0900
Message-ID: <CAGTfZH2g6E2pCEtqjfCd+PjEzjwc2AB75LXJfCeO+PcYLiLTUw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable Panfrost and Lima drivers
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

2019=EB=85=84 6=EC=9B=94 23=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 4:20, K=
rzysztof Kozlowski <krzk@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Enable support for Mali GPU with Panfrost and Lima drivers for:
> 1. Samsung Exynos5433 and Exynos7 (having Mali T760),
> 2. Allwiner A64 and H5 (Mali 400/450).
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Enable Lima driver
> ---
>  arch/arm64/configs/defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index fbbc065415d4..3d31611368af 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -518,6 +518,8 @@ CONFIG_DRM_HISI_HIBMC=3Dm
>  CONFIG_DRM_HISI_KIRIN=3Dm
>  CONFIG_DRM_MESON=3Dm
>  CONFIG_DRM_PL111=3Dm
> +CONFIG_DRM_LIMA=3Dm
> +CONFIG_DRM_PANFROST=3Dm
>  CONFIG_FB=3Dy
>  CONFIG_FB_MODE_HELPERS=3Dy
>  CONFIG_BACKLIGHT_GENERIC=3Dm
> @@ -718,7 +720,6 @@ CONFIG_ARCH_TEGRA_194_SOC=3Dy
>  CONFIG_ARCH_K3_AM6_SOC=3Dy
>  CONFIG_SOC_TI=3Dy
>  CONFIG_TI_SCI_PM_DOMAINS=3Dy
> -CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=3Dy

Exynos5433-tm2 board support the exynos-bus device which
used the simple_ondmenad governor of devfreq.
Why do you remove this configuration from the defconfig?

>  CONFIG_EXTCON_USB_GPIO=3Dy
>  CONFIG_EXTCON_USBC_CROS_EC=3Dy
>  CONFIG_MEMORY=3Dy
> --
> 2.17.1
>


--=20
Best Regards,
Chanwoo Choi
