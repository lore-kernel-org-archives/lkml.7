Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3D8C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383C520815
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lxiRTmNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfEOVS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:18:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42866 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfEOVS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:18:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id f23so1408005otl.9;
        Wed, 15 May 2019 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KECxhG00vBm0IlDH9n6KSnmJxztUTqeZiXx2Brec6f4=;
        b=lxiRTmNOWVZoT2dnKAkBE35aDOk0GpZXsTGuC/FrYuP4RFUSpzz6R4+NBThg8+7Caq
         FlqWM2pP9jcBvRD6saFfOMWkCHzRc1E18PMXTwKslca5pVeoIHTG/yn90g+1xn5lTV0t
         cTbe2XWURr41z9tc0od/mJbjPb7jnWdwYSVP9P71J4dF4GeSFzh0f5hEoscDHNtaNPxo
         bLI2In6ZENqM9Tlp9NfLSQ5eKXxinuapLsYOkFuGqd3wCCTQw1xZEvupjlx+7VL2DPXc
         iSEpXXk48IgJIxWDu66zafTBGCh4hisAMnd0cYOKcniZvGduISlfqnJyCewQt9gLYUfn
         PuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KECxhG00vBm0IlDH9n6KSnmJxztUTqeZiXx2Brec6f4=;
        b=NDNpP+5mX5dDElxaXhk2vW5jb/epoZ6SDIQGoJDLeggsGAe9rHck5WVdbTMusLOYVW
         1yRrfEC0McbGig25MYvSl94ceR2yPcHfogsiQG/BlMbaDyVVznJnRnCKbR6bXN6g7J6s
         Evj1jpfP3ctB19MucsUeI5GvQYUb+zc9S0WumdwCSJRjEiQ4m4ep8TXHLqUob0bDsZxO
         hg9SGDtEKPbDiZ9/zjU75HQFv/ztV5TchNEDiTn+PI8ze69N8bn+i9dqY6jEZirsMnFZ
         aaPayHNf+WyUxvX/Z1wrfBZRDGRfPnqSDUtgd+6e+3nuf/XDBLbNP8svjzmkTq/8N8Y0
         zICQ==
X-Gm-Message-State: APjAAAWd9n7qR6VpKPep4ymcERFSjTlM2rHWTsCF4Nv0uM+ehv9C02Z6
        fyCgQ5idjJF4dOoLEKzhkY+youaQQEb2r93tTyo=
X-Google-Smtp-Source: APXvYqyQOB61kbFWuMCaUd5x0vsZQMGyFvBi3SwJNnEy3rL9O+2ei3JvJEQX5nvmjaXp7fQunZiagCxcjb0d9Zgfb1Y=
X-Received: by 2002:a9d:5618:: with SMTP id e24mr3459779oti.38.1557955108329;
 Wed, 15 May 2019 14:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190513091548.16674-1-narmstrong@baylibre.com>
 <20190513091548.16674-3-narmstrong@baylibre.com> <CAFBinCAMoNDnxoQA9XHKy0Xo9MduxD1CvQXOeLZQ3zZ4ViWm7A@mail.gmail.com>
 <a54f7a4a-c280-6181-969f-4979dadb36b2@baylibre.com>
In-Reply-To: <a54f7a4a-c280-6181-969f-4979dadb36b2@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 15 May 2019 23:18:17 +0200
Message-ID: <CAFBinCCtNQmKKL8yw07DKOfPK=eusgCuYeBmwgiHm0SSVmuFPQ@mail.gmail.com>
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

On Wed, May 15, 2019 at 2:45 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 14/05/2019 19:58, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > On Mon, May 13, 2019 at 11:16 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> > [...]
> >> @@ -1158,15 +1183,27 @@ static int meson_mmc_probe(struct platform_device *pdev)
> >>          */
> >>         mmc->caps2 &= ~MMC_CAP2_HS400;
> >>
> >> -       /* data bounce buffer */
> >> -       host->bounce_buf_size = mmc->max_req_size;
> >> -       host->bounce_buf =
> >> -               dma_alloc_coherent(host->dev, host->bounce_buf_size,
> >> -                                  &host->bounce_dma_addr, GFP_KERNEL);
> >> -       if (host->bounce_buf == NULL) {
> >> -               dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
> >> -               ret = -ENOMEM;
> >> -               goto err_free_irq;
> >> +       if (host->ddr_access_quirk) {
> >> +               /*
> >> +                * The MMC Controller embeds 1,5KiB of internal SRAM
> >> +                * that can be used to be used as bounce buffer.
> >> +                * In the case of the G12A SDIO controller, use these
> >> +                * instead of the DDR memory
> >> +                */
> >> +               host->bounce_buf_size = SD_EMMC_SRAM_DATA_BUF_LEN;
> >> +               host->bounce_buf = host->regs + SD_EMMC_SRAM_DATA_BUF_OFF;
> >> +               host->bounce_dma_addr = res->start + SD_EMMC_SRAM_DATA_BUF_OFF;
> > I'm curious: why do you need to set bounce_dma_addr in this case?
>
> We still need the physical bounce buffer address since we write in the registers,
so writing bounce_dma_addr to SD_EMMC_CMD_DAT is needed to make it work?

> and we need the logical address to memcpy() in the buffer.
as far as I understand that is what we use the "bounce_buf" member
for, but I don't see why we need "bounce_dma_addr"

> >
> >> +       } else {
> >> +               /* data bounce buffer */
> >> +               host->bounce_buf_size = mmc->max_req_size;
> >> +               host->bounce_buf =
> >> +                       dma_alloc_coherent(host->dev, host->bounce_buf_size,
> >> +                                          &host->bounce_dma_addr, GFP_KERNEL);
> >> +               if (host->bounce_buf == NULL) {
> >> +                       dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
> >> +                       ret = -ENOMEM;
> >> +                       goto err_free_irq;
> >> +               }
> >>         }
> >>
> >>         host->descs = dma_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
> > if host->descs cannot be allocated then you need to conditionally skip
> > dma_free_coherent for the bounce buffer in the goto err_bounce_buf
> > case a few lines below (just like you did in meson_mmc_remove)
>
> It can be allocated, it's only useless. I can skip it but I don't want
> to break any logic in the driver.
I wasn't clear in my last email, I meant this error case:
  err_bounce_buf:
    dma_free_coherent(host->dev, host->bounce_buf_size, ...
when host->ddr_access_quirk is true then you skip the
dma_alloc_coherent call for bounce_buf


Martin
