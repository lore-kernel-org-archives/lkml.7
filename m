Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6F2C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1732084F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kz2jzjhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfENR6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:58:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38437 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfENR6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:58:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id u199so12818762oie.5;
        Tue, 14 May 2019 10:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbgR9sIIi020lB4uMc6drG+hzB7QuAOCTK+0TBCg8Cc=;
        b=kz2jzjhPKbEnQayS8dgCy5rubRTQIqMh2n4HuPMUyO1VSNt3vJVG3lRGzuhbsI7p3E
         n5/wGiKy0e9r4F73sN9EtnuBGim238QQ5IXF5Kg2gjaXohTQqng7UWygNuC1ygsw4VxO
         M+8UD/VB0e1f5gHNJ5O+jT/vi6m/8R5TT1B1SR0/EbOy5+baCCimbQfw+Ouljrb9YPGu
         625otuoxIyGC/IELiz1fY+/4lN6Eb0wqhrrG9xleiIuzj7FxDFLVYYI8nlUC3sT+Hwjz
         KX51hfprCqpxSkRn/DY8eE8dlw9qG4vCtS4Wli4x7zRqP6P0Rw2srvdyHRSt6iYncg3/
         uT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbgR9sIIi020lB4uMc6drG+hzB7QuAOCTK+0TBCg8Cc=;
        b=e3zicUTg5uVndCPA1bBDnfYR4jrL+JKaK6f1f0Oha0Y3fL68wt9F9RYTxUeiuIDyKP
         Os5mTcMPP1zgLE9hcNVf9tOl+X0ympQECP5dG/Hukg4YN723uH2Zb4xHo9K+ejKN/DNK
         aTIDFWKSu9OMk4g/EEeCs/5MohERUCyXYI/msSMuJ4b6VTt5DlJjsujw+0B1j4F5lMln
         NonkyVBfy8yA/cHvGJn23GK7ISixHI4X/hB9W/Io1YA6Meom0JBubO7FohSKgfqQyUOS
         FZHyg+kB7j4PqnwPEuIFmereSOLvoT+7L6kOHo07x14k4uHqiSBIudzSLQY0nlirWIEY
         GvJg==
X-Gm-Message-State: APjAAAWMB3y25PZdfFQj9n8t3ueclr2WdfwTMKrIknVF79xvvb1rTljT
        TjWwRYkT6zMTUNAZAV30Wrg7y8YphEuxrEp66x+GRocwbLs=
X-Google-Smtp-Source: APXvYqysSJO7wFng5taFNsIZOMTqAUX0pN7PyrW8jgVBQnbRhhf71UhUYZKIQp8b0gAYrWujo+I5sI1OdRoLfcqfyqo=
X-Received: by 2002:aca:5b06:: with SMTP id p6mr3946699oib.129.1557856691277;
 Tue, 14 May 2019 10:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190513091548.16674-1-narmstrong@baylibre.com> <20190513091548.16674-3-narmstrong@baylibre.com>
In-Reply-To: <20190513091548.16674-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 May 2019 19:58:00 +0200
Message-ID: <CAFBinCAMoNDnxoQA9XHKy0Xo9MduxD1CvQXOeLZQ3zZ4ViWm7A@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: meson-gx: add ddr-access-quirk
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     ulf.hansson@linaro.org, khilman@baylibre.com,
        baylibre-upstreaming@groups.io, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, May 13, 2019 at 11:16 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> @@ -1158,15 +1183,27 @@ static int meson_mmc_probe(struct platform_device *pdev)
>          */
>         mmc->caps2 &= ~MMC_CAP2_HS400;
>
> -       /* data bounce buffer */
> -       host->bounce_buf_size = mmc->max_req_size;
> -       host->bounce_buf =
> -               dma_alloc_coherent(host->dev, host->bounce_buf_size,
> -                                  &host->bounce_dma_addr, GFP_KERNEL);
> -       if (host->bounce_buf == NULL) {
> -               dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
> -               ret = -ENOMEM;
> -               goto err_free_irq;
> +       if (host->ddr_access_quirk) {
> +               /*
> +                * The MMC Controller embeds 1,5KiB of internal SRAM
> +                * that can be used to be used as bounce buffer.
> +                * In the case of the G12A SDIO controller, use these
> +                * instead of the DDR memory
> +                */
> +               host->bounce_buf_size = SD_EMMC_SRAM_DATA_BUF_LEN;
> +               host->bounce_buf = host->regs + SD_EMMC_SRAM_DATA_BUF_OFF;
> +               host->bounce_dma_addr = res->start + SD_EMMC_SRAM_DATA_BUF_OFF;
I'm curious: why do you need to set bounce_dma_addr in this case?

> +       } else {
> +               /* data bounce buffer */
> +               host->bounce_buf_size = mmc->max_req_size;
> +               host->bounce_buf =
> +                       dma_alloc_coherent(host->dev, host->bounce_buf_size,
> +                                          &host->bounce_dma_addr, GFP_KERNEL);
> +               if (host->bounce_buf == NULL) {
> +                       dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
> +                       ret = -ENOMEM;
> +                       goto err_free_irq;
> +               }
>         }
>
>         host->descs = dma_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
if host->descs cannot be allocated then you need to conditionally skip
dma_free_coherent for the bounce buffer in the goto err_bounce_buf
case a few lines below (just like you did in meson_mmc_remove)


Martin
