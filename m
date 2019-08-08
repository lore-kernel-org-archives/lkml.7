Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BEBC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266F22173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QW+HXSNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403773AbfHHPXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:23:38 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45745 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732680AbfHHPXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:23:37 -0400
Received: by mail-vk1-f193.google.com with SMTP id e83so18788272vke.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNB3Zm9MMvwDRnXaJ2FS/3pgiFUqCEAjWklwwyvURzI=;
        b=QW+HXSNaJIeMSgjFtPBC8shR+iNt9+afsMRJmza60ge+Uo5qwyV5gFbqtGRm1umBx/
         OS2BYWlgkFU1xeCsJn+PyYOqe6JQKr3WdGoL/qGN1mXfmapaYVh+6T5MOBlg1ISWAkSx
         cHZgDJM37VcRbC+RBdKUFsjAtywZh4EA+OSAy1mLa6+fg4luQnJR8jUCGj7gY2sdEOXZ
         2qTK2rkaNWXhAd8gK6sItZ+AZ8oCKSdzfhIkgxsZMzSnMk6r/fkT6T/uRmIujgVbrLAo
         NRsj1iJiOiwLaAxgR1PGDzGNdTQSIofv43CI6Swq2iZJsoV5g/3Il2jpP/j03FmsExZu
         sY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNB3Zm9MMvwDRnXaJ2FS/3pgiFUqCEAjWklwwyvURzI=;
        b=hMLXh/V6f3Rt7mhasr3HaaGx62myQmzrOCsxsM+hPIS78KM6lvfHhl9nl9824Wjc9J
         9tw5KjIStOAGK+HYwvgHWpQFpv1GB8wF+PxrtRykDVlm7gnQeziaVBq+km3dOozJGf6z
         hPOTIlMm6A7+8c9j5m41/DIbWPx0lohHv/4hSOgG08vMqjDKx7RZLMKi0dSkgNBQR+tN
         AgyLEna95gRgtq03M/YJV11J9ckkNQk4gW5NIaPLCbNJUQDY7FlhwBY0FAm/MOk6qmee
         rtxIBkb1kwS+GusD4vOCm1g79omCEAm7i4CkWzb8WBLyF/CVdOiUS0qcrRhVSZSnmOqC
         mXmg==
X-Gm-Message-State: APjAAAXWxzc80QL6a2hR7mam+7zBHu/DLBv2i8cDhLcA1ysXglhuj6WM
        v82A9QQKzR2LSwANRKdfQNQDw2ecm13Uvdr13+ejqw==
X-Google-Smtp-Source: APXvYqy4vBIhIEDkHZGbjPTFMN0MG3rSPoqUvYTRP/e/2YG84U7QfZw+MjtJ98ys313+siGvTnSpq6E/mbY+mp2X4wk=
X-Received: by 2002:a1f:3f45:: with SMTP id m66mr6091559vka.17.1565277816177;
 Thu, 08 Aug 2019 08:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Aug 2019 17:23:00 +0200
Message-ID: <CAPDyKFrUr8_VP1JLRk48zR8_p1Y62wKLBnS0iTgdhUSArwD49Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-at91: add quirk for broken HS200
To:     Eugen.Hristev@microchip.com
Cc:     Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 at 10:35, <Eugen.Hristev@microchip.com> wrote:
>
> From: Eugen Hristev <eugen.hristev@microchip.com>
>
> HS200 is not implemented in the driver, but the controller claims it
> through caps.
> Remove it via quirk.
> Without this quirk, the mmc core will try to enable hs200, which will fail,
> and the eMMC initialization will fail.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Should this be applied as a fix and possibly tagged for stable?

In such case, do you have a specific commit that it fixes?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 57fe3b2..3a8c6d8 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -370,6 +370,9 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>         pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>         pm_runtime_use_autosuspend(&pdev->dev);
>
> +       /* HS200 is broken at this moment */
> +       host->quirks2 = SDHCI_QUIRK2_BROKEN_HS200;
> +
>         ret = sdhci_add_host(host);
>         if (ret)
>                 goto pm_runtime_disable;
> --
> 2.7.4
>
