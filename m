Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55C5C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA9D20661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bt1mMHWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfCEWZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:25:31 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46588 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfCEWZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:25:30 -0500
Received: by mail-qt1-f195.google.com with SMTP id z25so10695373qti.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 14:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGoWjj5ooYH5rGp2EYHR0JqeMyqSYmk37bo/l9iSFjo=;
        b=Bt1mMHWOMGsDABWxjGvxlo4fwpe2GWJQ5EhqnPZ3i1cwbIdmz2WebSlbJPqFeqFx+M
         6aO07QlOITX3xqYYIzJGZg123WKpSJSPVCku1cssI0Dz8tJllEByjlUhX+DbiHUDh51X
         4b+J+croKdvw07XJ7IqIV6gP8t9hoTDn6ba2ZG0biHHqcJYjmN8ysqp1vuBMJTRmKbzS
         GO8ot2luewskvHOXRO2UCdoKovgFpeG0i7xXGXP07TTp3RybQE28jGnkaLt3xv8KSPip
         C1HsPR2YEIpU61tmH7iD4tBqB43whNSDX4zPMp4rc1LiwshPU0E/r0Qass08qClw4dvW
         5/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGoWjj5ooYH5rGp2EYHR0JqeMyqSYmk37bo/l9iSFjo=;
        b=CtUExd8Wyd+gML//UuU5HEs3+EpIaS90ve4BDL9V32EipNLINnRGteYugj35TC6r8T
         sZhgAYbxQI+U9idr7d+OYe7mM4CocPtn/VUg6mb/fQne1yhMdAwBScz6RGA1AjeZppKi
         sgqcGA0M+fQ2oMWpicilquL9Pij3i7L53MsO97vvLXEpiN6vUqEw81e4BQnz8CmvU8jy
         l8S2+7eZdFFGRbBjcgW9nlsf1cWEfGg9w6dj0NcEavr0XA1YiQgLL4Fmx/97f1OQpphy
         kYXfMAkrZmamFbjQvu/tAqsGptZxzfVuKCjTaH7I90xChyXaKEY7m1sxn/YVz6j8Onie
         BXrw==
X-Gm-Message-State: APjAAAWzsZPYStPcwEmzwVJst8JLXepth6aUHK+fTA1+rS7BC2GXS5RJ
        Bff1Zk1IALbB/clgYeSB/zhxkdhGG8MT2jpNTD+DCw==
X-Google-Smtp-Source: APXvYqxBTZzPlsFbhFTARE+H/UtChk/eNEsrjCrYZQxFJyVThdkpskptMnc/5TvJiCol7F2kYJalugaZpYBMaZFWal4=
X-Received: by 2002:ac8:1789:: with SMTP id o9mr3371213qtj.234.1551824729217;
 Tue, 05 Mar 2019 14:25:29 -0800 (PST)
MIME-Version: 1.0
References: <1408683219-7939-1-git-send-email-srinivas.kandagatla@linaro.org> <1408683272-7984-1-git-send-email-srinivas.kandagatla@linaro.org>
In-Reply-To: <1408683272-7984-1-git-send-email-srinivas.kandagatla@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Mar 2019 23:25:16 +0100
Message-ID: <CACRpkdZtUJim0d0iC26d-Z8xBckdCX7uwh_v4PhJSKkHEcmmrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mmc: mmci: Support any block sizes for ux500v2 and
 qcom variant
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Chris Ball <chris@printf.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@arm.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for top-posting, patch included for context.

I saw today that Brian has the Nexus 5 working with Broadcom/Cypress
4339 over SDIO on the MMCI.

Brian are you managing to use the WLAN without this patch or is this
something you stacked up to make it work? (If you want context I
can forward the rest of the conversation where we discuss how to
fix it properly.)

I discussed this patch several times with Ulf and I think Niklas looked
at it too, but we never got around to fix it up properly.

Yours,
Linus Walleij


On Fri, Aug 22, 2014 at 6:54 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> For the ux500v2 variant of the PL18x block, any block sizes are
> supported. This will make it possible to decrease data overhead
> for SDIO transfers.
>
> This patch is based on Ulf Hansson patch
> http://www.spinics.net/lists/linux-mmc/msg12160.html
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>         enabled this support on qcom variant.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/mmci.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index c11cb05..533ad2b 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -77,6 +77,7 @@ static unsigned int fmax = 515633;
>   * @qcom_fifo: enables qcom specific fifo pio read logic.
>   * @reversed_irq_handling: handle data irq before cmd irq.
>   * @qcom_dml: enables qcom specific dma glue for dma transfers.
> + * @any_blksize: true if block any sizes are supported
>   */
>  struct variant_data {
>         unsigned int            clkreg;
> @@ -102,6 +103,7 @@ struct variant_data {
>         bool                    qcom_fifo;
>         bool                    reversed_irq_handling;
>         bool                    qcom_dml;
> +       bool                    any_blksize;
>  };
>
>  static struct variant_data variant_arm = {
> @@ -194,6 +196,7 @@ static struct variant_data variant_ux500v2 = {
>         .pwrreg_clkgate         = true,
>         .busy_detect            = true,
>         .pwrreg_nopower         = true,
> +       .any_blksize            = true,
>  };
>
>  static struct variant_data variant_qcom = {
> @@ -212,6 +215,7 @@ static struct variant_data variant_qcom = {
>         .explicit_mclk_control  = true,
>         .qcom_fifo              = true,
>         .qcom_dml               = true,
> +       .any_blksize            = true,
>  };
>
>  static int mmci_card_busy(struct mmc_host *mmc)
> @@ -239,10 +243,11 @@ static int mmci_card_busy(struct mmc_host *mmc)
>  static int mmci_validate_data(struct mmci_host *host,
>                               struct mmc_data *data)
>  {
> +       struct variant_data *variant = host->variant;
> +
>         if (!data)
>                 return 0;
> -
> -       if (!is_power_of_2(data->blksz)) {
> +       if (!is_power_of_2(data->blksz) && !variant->any_blksize) {
>                 dev_err(mmc_dev(host->mmc),
>                         "unsupported block size (%d bytes)\n", data->blksz);
>                 return -EINVAL;
> @@ -796,7 +801,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>         writel(host->size, base + MMCIDATALENGTH);
>
>         blksz_bits = ffs(data->blksz) - 1;
> -       BUG_ON(1 << blksz_bits != data->blksz);
>
>         if (variant->blksz_datactrl16)
>                 datactrl = MCI_DPSM_ENABLE | (data->blksz << 16);
> --
> 1.9.1
>
