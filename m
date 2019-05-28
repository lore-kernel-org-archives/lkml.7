Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F1FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738392075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5vlq0fA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfE1Hlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:41:44 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35019 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfE1Hln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:41:43 -0400
Received: by mail-vs1-f68.google.com with SMTP id q13so12183285vso.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 00:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1vGN/kzzR5Fvs1V+frWiaUjVK/pSpV0oxUQjIS8ijsM=;
        b=G5vlq0fAtwDVkOkfBP2QoDt1YEgVybU9XYwYxfr77EwtQYmXJtwF0Se2SLiRbWygug
         uweyGlm3MM63NmP5XYWc+1VIg3lu323ebw2/DD+PrGK2L/sfswbJSxYn3bR9+2N+GV6G
         6p/AnLDq35nD5IMEQRiGZ8u/KM2daatFWSiTTW+GSngTXp52QXv4a5CMi4hc1VEnVJfo
         ynMmhOxfxGdLOBBBTkYnnuNJE5ynQcUmjA/h2bACdpqdKcXvRKmYxKZvI2E397mWj9eE
         nHTSH6OkcRYNz+6lSyCvTogEJ4o9LrsCqPFdZDvCssza0sBLgzG/s3H/knojtFphR3kS
         sxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vGN/kzzR5Fvs1V+frWiaUjVK/pSpV0oxUQjIS8ijsM=;
        b=kZGaLQw12CO2EKYqarH8erlokI2N0Jd6jkFcgc+t1ovZyzKq7O3wHY68TTKJUEMiWo
         y0psTqxITPoqA3hzH8LBhfk5ppFVM7z5Xsg85w02cgWXiiGjNf2scE4njBeQDJzlzvfQ
         IOMnTVLI+WZQKBDQNRlZ3Z8Xe5G3wxQs06iE5K4H1Ii1zX8XGi4wF8C9rs7D8pVMieGd
         wJrODMZUgyGo6bqkTOUOobTG+30oFkfyf0nQ3xxqg7Y71eV7PSXYPea1jUJqhgFfGHeR
         f18VhmKtZ81bkoBLzHllQLqQ2SM9KovItq0LuJTz367vSpuUyO8rHfFjUUD1Eqs+9N3v
         qyKA==
X-Gm-Message-State: APjAAAVZdyliyfIznEzequ6x0Dnq36YlGizroUlHq7ETn6BW3XVcOHhU
        FrMJlzHxcm+1TcaKM02/Fr9tPFDVxDWnwUptpLVS1A==
X-Google-Smtp-Source: APXvYqwjgGJ9xI1ypM5cwafmspEINThHEkUuBleRNr6hXc3OObAFYQky7TEHIC6X7c81UilG4iahZhy/s5LJJdgQVqo=
X-Received: by 2002:a67:ebc5:: with SMTP id y5mr71189644vso.34.1559029302928;
 Tue, 28 May 2019 00:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190501175457.195855-1-rrangel@chromium.org> <20190501175457.195855-2-rrangel@chromium.org>
In-Reply-To: <20190501175457.195855-2-rrangel@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 May 2019 09:41:07 +0200
Message-ID: <CAPDyKFq8T0kdJsPfk6ue2OaQUO9L_oOwnxDw=-FVboZRyKJPdA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mmc: sdhci: Quirk for AMD SDHC Device 0x7906
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2019 at 19:55, Raul E Rangel <rrangel@chromium.org> wrote:
>
> AMD SDHC 0x7906 requires a hard reset to clear all internal state.
> Otherwise it can get into a bad state where the DATA lines are always
> read as zeros.
>
> This change requires firmware that can transition the device into
> D3Cold for it to work correctly. If the firmware does not support
> transitioning to D3Cold then the power state transitions are a no-op.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Does this also solve the problem you tried to fix in patch1, without patch1?

Should this have a stable tag?

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-pci-core.c | 51 ++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 99b0fec2836b..532fbcbd373b 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -25,6 +25,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/scatterlist.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/gpio.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/mmc/slot-gpio.h>
> @@ -1498,11 +1499,59 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>         return 0;
>  }
>
> +static u32 sdhci_read_present_state(struct sdhci_host *host)
> +{
> +       return sdhci_readl(host, SDHCI_PRESENT_STATE);
> +}
> +
> +void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +       struct pci_dev *pdev = slot->chip->pdev;
> +       u32 present_state;
> +
> +       /*
> +        * SDHC 0x7906 requires a hard reset to clear all internal state.
> +        * Otherwise it can get into a bad state where the DATA lines are always
> +        * read as zeros.
> +        */
> +       if (pdev->device == 0x7906 && (mask & SDHCI_RESET_ALL)) {
> +               pci_clear_master(pdev);
> +
> +               pci_save_state(pdev);
> +
> +               pci_set_power_state(pdev, PCI_D3cold);
> +               pr_debug("%s: power_state=%u\n", mmc_hostname(host->mmc),
> +                       pdev->current_state);
> +               pci_set_power_state(pdev, PCI_D0);
> +
> +               pci_restore_state(pdev);
> +
> +               /*
> +                * SDHCI_RESET_ALL says the card detect logic should not be
> +                * reset, but since we need to reset the entire controller
> +                * we should wait until the card detect logic has stabilized.
> +                *
> +                * This normally takes about 40ms.
> +                */
> +               readx_poll_timeout(
> +                       sdhci_read_present_state,
> +                       host,
> +                       present_state,
> +                       present_state & SDHCI_CD_STABLE,
> +                       10000,
> +                       100000
> +               );
> +       }
> +
> +       return sdhci_reset(host, mask);
> +}
> +
>  static const struct sdhci_ops amd_sdhci_pci_ops = {
>         .set_clock                      = sdhci_set_clock,
>         .enable_dma                     = sdhci_pci_enable_dma,
>         .set_bus_width                  = sdhci_set_bus_width,
> -       .reset                          = sdhci_reset,
> +       .reset                          = amd_sdhci_reset,
>         .set_uhs_signaling              = sdhci_set_uhs_signaling,
>  };
>
> --
> 2.21.0.593.g511ec345e18-goog
>
