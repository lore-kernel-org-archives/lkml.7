Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBB6C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 20:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F0F20673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 20:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImlsjQ/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfFUUPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 16:15:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46243 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUUPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 16:15:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so7458337ote.13;
        Fri, 21 Jun 2019 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mzt2KqaKRns439nf1E0NkuZmvKiRIAINQSETZ97d2PM=;
        b=ImlsjQ/rYDPh01yLV/h4IoJNfeNXruc4vXFeH+bJvYhHCuw3SKYEgWl4abUTP2QvxN
         MfJrHQdgcmbD3KfXnQIjyt1wZ9sm8L9FaXP+wsXlc/YQuy8Utz4XVap35YA5b7d1c4K2
         OG+EiVNBoswmXAheOG9KDVkROd8tlscncA8Kri59jZpz/MoodvfLn7qn5e31GgjK+Jdi
         1ohMEzsUA+Snmy9b5lCtBkOLAp/a4HuD74VFksj6ASBEXwdeEz1B26tthpC7Dq8dLm4c
         upJD0HbKhjEu+zmZ0IxXeqlk1Zkz/n+kFxgq0jMitXgAIOkCkgHo1NNnOfAX+0BlJYWg
         8BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mzt2KqaKRns439nf1E0NkuZmvKiRIAINQSETZ97d2PM=;
        b=jOJNyTkLpwP/+E8CK1f0nUBCsBmHzMHdcp32nTNSB+Cc0zs2Lh9rVXwsYwTEYSm4cl
         wOL1F9NTwBB9cWB+CJ60TqhXhpoHZN5J9qjN6PqCLZiQrn4TPhlC92JVz/g69LkwNfK+
         k770Kg1YiYRGwKm0XNRQvxagSBOmozkQueRubTK/sl+K98faj6QevWquJdyKoEXyqL7Q
         ZVHXpvVXvT9aW0rLKpGyNEH5TGJUyrhhD5C+l0MRny28OMk3Pwd65oTD0rrZQpKToEDh
         64lZn/ZyZ79hADGkCKYwNYXEuUdBsl2W7PvnOcyoOF6BpcnQBkQ+xkFfDizZONXoBoAh
         GMWg==
X-Gm-Message-State: APjAAAXTRFYLV/EoPUDecXwk36f8Ak65QoELWEw/7AoK30TJhO89nsva
        HqYsfSMfW/pGljjoH1NhukYzysfZPR1CvmcN+v0=
X-Google-Smtp-Source: APXvYqzBDkZojNKB/k/9/UKU9XV3h8B9Iu/jGst1/MhqDi2Rm9U75jItEMKKU9mKHMTcTPQHa6+GWsisq10Bm12yFno=
X-Received: by 2002:a9d:d87:: with SMTP id 7mr76241164ots.263.1561148150749;
 Fri, 21 Jun 2019 13:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190621180208.25361-1-krzk@kernel.org> <20190621180208.25361-7-krzk@kernel.org>
In-Reply-To: <20190621180208.25361-7-krzk@kernel.org>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Fri, 21 Jun 2019 13:15:35 -0700
Message-ID: <CA+E=qVe45NVCfpSHRF6=0aYRpURZA4DVz8W-XkSaNDB=1mX2kA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: defconfig: Enable Panfrost driver
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joseph Kogut <joseph.kogut@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:04 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Enable support for Mali GPU with Panfrost driver, e.g. for Exynos5433
> and Exynos7 (having Mali T760).
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6b4f5cf23324..972b17239f13 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -517,6 +517,7 @@ CONFIG_DRM_HISI_HIBMC=m
>  CONFIG_DRM_HISI_KIRIN=m
>  CONFIG_DRM_MESON=m
>  CONFIG_DRM_PL111=m
> +CONFIG_DRM_PANFROST=m

It makes sense to enable lima for arm64 defconfig as well since it's
used on number of 64-bit Allwinner SoCs.

>  CONFIG_FB=y
>  CONFIG_FB_MODE_HELPERS=y
>  CONFIG_BACKLIGHT_GENERIC=m
> @@ -717,7 +718,6 @@ CONFIG_ARCH_TEGRA_194_SOC=y
>  CONFIG_ARCH_K3_AM6_SOC=y
>  CONFIG_SOC_TI=y
>  CONFIG_TI_SCI_PM_DOMAINS=y
> -CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
>  CONFIG_EXTCON_USB_GPIO=y
>  CONFIG_EXTCON_USBC_CROS_EC=y
>  CONFIG_MEMORY=y
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
