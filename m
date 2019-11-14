Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ABFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE8C206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Um9OcmrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKNOAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:00:44 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43374 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfKNOAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:00:44 -0500
Received: by mail-vk1-f196.google.com with SMTP id k19so1475666vke.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 06:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJUZgKfy2YSWGNuA2+MgdU+Nr8ygHAVvjPLQAD+YtDs=;
        b=Um9OcmrFedBxkdzVXkY2EtsXLNyskuS4YLklz4fMGWFnU+aiTFGvjT8HDml+M1ErlU
         fsS2HvnmMPNZaNx6nyozf0V53f0VFp6xcqjCO4j/SyTSgEV9iAZTihxeQ7PGyd40EuHI
         OGz9A8awTDEhr1M6aH8bcBqUsMGiHgm5h+0V1RUhWC11o6vNM9h2zQrntTdVYVL1M3Bi
         hGaYX+MdnaFWX2GO5NxAwLqTuwWz0rIophmlgo4k9FYQyL4ySZg8VtdTMLPk4AS4wTA6
         3AnLRIeEb6T64QF23YubjnKP0+NtmPoxHR7Du0y3xfiCBv8QQcETgLbxDir5/+in1E5+
         f+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJUZgKfy2YSWGNuA2+MgdU+Nr8ygHAVvjPLQAD+YtDs=;
        b=i4UwaaP57iM6mwHXG0JsMgObkcU96ieuRBpDbJnTqkxxbEK4xqzS6vkRA3+MvMnvow
         tRv2Noo2eTUGkwMqBg7zs+L6Ds+dk+vVBiGPtHyOLBO3UY01tmdb2rITUP44XRIMMwDJ
         BtLD4k+G9CC1Xv83LFqrpSbCyXEAb0Aq8bf6TApeHR9MAvbEgEbmtSPhJj4w0m+kMdUm
         c66nIW7ITvywDoyKsTh84/+iGe0oI6gP1zuHP+cY+fWT4TpgZb4NYLgOWuVyvCxbyawB
         VZG9tq7aOrM+NGtKbHquTrI2NkMV/CNgTwyC04KxDht9O/IbXe7zTzGZPW6O/CYQNChU
         qkvQ==
X-Gm-Message-State: APjAAAX+WhKYbuMLMtEe3+0u+LH5l+laTQjSW6X8NEyDZFieeTjSy1Mc
        3oKDAA0Feq2k4J6jNDPV4jLVIN3oLx9T8KSq3jbMwA==
X-Google-Smtp-Source: APXvYqxglOLg8xzv1EZ/UOAGOFLRVXU+F1KB1IDk6i8iCyI7W7PmXp6Hxwdfvs1NSaryF11w4xB1Cg/GYOTyEXWRt/c=
X-Received: by 2002:a1f:fe0a:: with SMTP id l10mr5151920vki.59.1573740043247;
 Thu, 14 Nov 2019 06:00:43 -0800 (PST)
MIME-Version: 1.0
References: <1573736352-3597-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1573736352-3597-1-git-send-email-eugen.hristev@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 15:00:07 +0100
Message-ID: <CAPDyKFrrzNXxYywPW8cAZN86jBPoOFWt295o9ANm+0BrF4dehg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix quirk2 overwrite
To:     Eugen.Hristev@microchip.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 at 13:59, <Eugen.Hristev@microchip.com> wrote:
>
> From: Eugen Hristev <eugen.hristev@microchip.com>
>
> The quirks2 are parsed and set (e.g. from DT) before the quirk for broken
> HS200 is set in the driver.
> The driver needs to enable just this flag, not rewrite the whole quirk set.
>
> Fixes: 7871aa60ae00 ("mmc: sdhci-of-at91: add quirk for broken HS200")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Applied for fixes, adding a stable tag, thanks!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-of-at91.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 496844a..5fe6684 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -389,7 +389,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>         pm_runtime_use_autosuspend(&pdev->dev);
>
>         /* HS200 is broken at this moment */
> -       host->quirks2 = SDHCI_QUIRK2_BROKEN_HS200;
> +       host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>
>         ret = sdhci_add_host(host);
>         if (ret)
> --
> 2.7.4
>
