Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D38CC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B7E2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACGp0e0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfFRLlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:41:32 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40247 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbfFRLla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:41:30 -0400
Received: by mail-ua1-f68.google.com with SMTP id s4so5593276uad.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 04:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OquRai3EL/XExl349Wm14w8fFke8wkLsWLanUHJ1x0Y=;
        b=ACGp0e0bbjN9+Q4/kCoX0brWtGvbzlyFg+9i2UVIrIq4DiMq2Lp/nKjKa27+XYaXi2
         WsMMZuxv2V1TVtw+543zlPN3fbNHt2VLwBdSD3FDvm9+etccnrOuqe6uwEL2AJCF2idj
         wnmJdkPPiJ7/ftYpONKRzTLc+K6Qv1QfrwjVRpdfV95wh3iL1nWwkg4IWaONxYKHiRSU
         vzWxcoczCmgF04mmB9w8F8tM7yrMc6r6IbwUu5GMaUToGRJYnGCaGnYxbENWlTtLgskO
         9KSoLzT2y77PlqysOmGv+XKSrEkfUpUIQcbdd1kATH8x6cxG4aUk8oS0C2F0kZ6+bQhb
         UlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OquRai3EL/XExl349Wm14w8fFke8wkLsWLanUHJ1x0Y=;
        b=S8HqilYqEb+lNHGj9XtfntIXyndrKHIJjQCaWrs/8zjX47yifUw4ptb0aceHtRz2Zj
         vkxPcp1ucYZ1nFx4CkXCeFCXddnN5LBafVbsKKUfkEQfuk4VrPwwe3QB0fyDhcuPcyJk
         IqF7RfqE4EWIaMucMNPwGmJxCqEDGBlhtcW0P5uE189nOhwfOJtFuIqAd884QcWk1uYO
         zv5log5OAKhu7xmUNnMP9V8NWOwaf7xtdcM0Bg7qhzyv+DyzYZmWsxa93xTEr2hdd+il
         P8ZhqiHsti+jyNfZ3T10i8EyyQr3dMLxthV35GhX8aO7SWXTU8reMwO1oq4NDQ1Lp2+g
         ce0w==
X-Gm-Message-State: APjAAAXkS4G0oqqQXur3rsoPBkmoQ6Z6uMCgq4gAKdW+ppGQCNOCUX09
        ntm11gu14b/cRgEe6odlEtpA2a9uFQokSlTLqAQ20Q==
X-Google-Smtp-Source: APXvYqyDx2iNOhICHPrjB4I0UdRvZse1KFSF6Oe9p6mWYhECI/wqjO25kBLfTIcatteCxBl8HLM3AQe0C18zFiyAX+8=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr13773698vsp.191.1560858089104;
 Tue, 18 Jun 2019 04:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190617201014.84503-1-rrangel@chromium.org> <20190617201014.84503-2-rrangel@chromium.org>
In-Reply-To: <20190617201014.84503-2-rrangel@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 18 Jun 2019 13:40:53 +0200
Message-ID: <CAPDyKFpdWRyb+0Cz=FZgVsOnaCRqik539F3QgJ676yVr-YCF0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci: sdhci-pci-o2micro: Check if controller
 supports 8-bit width
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 at 22:10, Raul E Rangel <rrangel@chromium.org> wrote:
>
> The O2 controller supports 8-bit EMMC access.
>
> JESD84-B51 section A.6.3.a defines the bus testing procedure that
> `mmc_select_bus_width()` implements. This is used to determine the actual
> bus width of the eMMC.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Applied for next, thanks!

Kind regards
Uffe



> ---
> I tested this on an AMD chromebook.
>
> $ cat /sys/kernel/debug/mmc1/ios
> clock:          200000000 Hz
> actual clock:   200000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    9 (mmc HS200)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
>
> Before this patch only 4 bit was negotiated.
>
>  drivers/mmc/host/sdhci-pci-o2micro.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index dd21315922c87..9dc4548271b4b 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -395,11 +395,21 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_pci_chip *chip;
>         struct sdhci_host *host;
> -       u32 reg;
> +       u32 reg, caps;
>         int ret;
>
>         chip = slot->chip;
>         host = slot->host;
> +
> +       caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +
> +       /*
> +        * mmc_select_bus_width() will test the bus to determine the actual bus
> +        * width.
> +        */
> +       if (caps & SDHCI_CAN_DO_8BIT)
> +               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> +
>         switch (chip->pdev->device) {
>         case PCI_DEVICE_ID_O2_SDS0:
>         case PCI_DEVICE_ID_O2_SEABIRD0:
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
