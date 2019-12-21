Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25035C2D0D3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 20:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7B5206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 20:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCDIKDoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfLUU55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 15:57:57 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46569 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfLUU54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 15:57:56 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so10945561ilm.13;
        Sat, 21 Dec 2019 12:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdRMbfvT7ToYO4IXf9aTfMV8O7SDeU1yIb+GInd1nZw=;
        b=WCDIKDoM1/9OxguUwRo5xL3Y56bhxtsYB/A117Dvol4FrLN7xgp17JqsiuBYp7TKTY
         ydbTmGBYUK4fvvoVgXHXjdLgAeMqhsjNBuLppXolh8V8kYt0wwuAW59jEnt0vdr+lzOh
         aAWmk3zgQypudHymFYhrQzhwqSIf2KCiqiTWqAqeePQuY3kVY18t5Cq1+TQAs5/SpCbc
         lGG2BJYPwYt1GocodDclUcWkXkb62i/W9Kz8uri+Lb7VtIRAyhN3cYRQ9K95J+pGPNv4
         f6Qiq/wkDj3olX9enJShP1SHafGfJQsZe9sy6yKan62+scAqm4Yoeo6jpTfjoqUq4a2Y
         M6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdRMbfvT7ToYO4IXf9aTfMV8O7SDeU1yIb+GInd1nZw=;
        b=ukSVyaiU//l7kuXIocw26oDf0HxGKMqXcAIWLrhUjqm5xTAsnO1DVKJq+KcoA5JlMC
         B9lJYc8+dj+UgK4Q0cNh5S9zdU8cPZQYWzDSiPQxf3VWN0yqixylCcJonkz+yuoa1qfU
         U2myuKdI0dFqowxCCgkMX43EjqOoRPHw5m7M/R15aOgkaaWXv0GgAU1/y9wUbvmvg0zN
         RCoow5NuPKRtKcEw4BG2xrcCfi9FZcNE6TIgsEeIdW86e9QAdOVlaGqflS7foKb/swJJ
         IIWWUERJm8h1S22C7pr8S3hKMaCjdUl3Z1FpDJ2/g1l/Ks+bH0J/r/k7V+fsTyN3Um9N
         SnQQ==
X-Gm-Message-State: APjAAAUA17+uH3A7ZcaIb6p00o2XekN9apNSAqbnFjzy96JHX5Cctwq/
        iR9OGSZ/ljvrsS2Gd81idQioJvjjkDys9Qa76bA=
X-Google-Smtp-Source: APXvYqyc3usFhtdUMBFJVhsK8kbJdVf5uAfgGNjp3RnRQcd67CMjzV5QLX70BxY68NmGPHOn4t6NFZ3U1CraR0TI1u0=
X-Received: by 2002:a92:465c:: with SMTP id t89mr19462451ila.263.1576961875969;
 Sat, 21 Dec 2019 12:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20191028171837.3907550-1-bjorn.andersson@linaro.org>
In-Reply-To: <20191028171837.3907550-1-bjorn.andersson@linaro.org>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Sat, 21 Dec 2019 13:57:45 -0700
Message-ID: <CAOCk7NqB2ZYewAb9cy=-atACGEF0Wi=b5QbAhFtQEPxU-KKzbA@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable ATH10K_SNOC
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:18 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The ath10k snoc is found on the Qualcomm QCS404 and SDM845, so enable
> the driver for this.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This also works for MSM8998, particularly the Lenovo Miix 630 laptop.

Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Tested-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e5e83dbf1433..c350ca25ba8e 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -308,6 +308,7 @@ CONFIG_USB_NET_PLUSB=m
>  CONFIG_USB_NET_MCS7830=m
>  CONFIG_ATH10K=m
>  CONFIG_ATH10K_PCI=m
> +CONFIG_ATH10K_SNOC=m
>  CONFIG_BRCMFMAC=m
>  CONFIG_MWIFIEX=m
>  CONFIG_MWIFIEX_PCIE=m
> --
> 2.23.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
