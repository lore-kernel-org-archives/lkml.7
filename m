Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F08C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B0E20828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFqzysaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfCFJBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:01:20 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45016 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfCFJBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:01:19 -0500
Received: by mail-vs1-f68.google.com with SMTP id r201so1754118vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 01:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfs0fH1ZF1JcvLZ65vGUEAo6nzQMnrf7DhgZMObwKF4=;
        b=gFqzysazUh5Xjeow5jpekciXXnyiKa2zM6llC0i3GN/8Zd4oCnPJywNKwx5D+fls80
         WFHor4XWsvM/Yw6bJggLWDwS05sVjnV0Z/HzNACeIxhDMkI/pBXtIfwgNTrfK5qEfkw1
         M1rfi6Mg81TCzB9u6AHPzuofvitJrI6wPB6KHatQlYeUL8DasVgROgwvFHZPLXHu8CZD
         f95/29ES3huqosesyMRQU79jSsjo+/GOtlbCWVmQpW//9lSETsBFqzOmXzOg4G573qsf
         R+1Cc422Fxh1dMsXxvDJBmMcgbUvlnHq+WmXOvuPuEyc0cPWmKDyj9xoyOPVst8wUtF5
         nZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfs0fH1ZF1JcvLZ65vGUEAo6nzQMnrf7DhgZMObwKF4=;
        b=NjVx501yGxk7yAeSRXdTYwOw5S7b7R2X93/qWLuYNXn4Ce+06+8jm6fhsF5G2sf9o3
         fS4MsopplGeDngMMq7jn/G++xKEpgjEbBUaA9tPKfKxglwGT1JkP34Y2wCaGxab9eEby
         Q7GWCf1lqu67NwPfCtpcax4WkUBc8lnOuWkT/pgLZsoINLX+Hvt6PzqElLOmvxS35yJt
         qoCTCJI9bebboc7aXqLCG+t8ehyxcZhTx/wbrYJlPzn03cuIGTC0u1JhZx3Fy+FNSoK6
         0Z9inG+TFicADQgKy+ho+tbx0Q9FzE5wjms85wGav/CsUGKzS6+jenvekuM30nASYjH8
         6RwQ==
X-Gm-Message-State: APjAAAUXHkCQT8Hz6Zk9E8x8i7LxSjzLMV7AJ98uHJulfhpNB10F6Aqh
        /76EhHJeST7hL1cvr5qMJ51SHXLp0c60R2YyfdR8VA==
X-Google-Smtp-Source: APXvYqzN7fYdenI+cvtHDaOpwsCG8LijtZXmh2QuxBQbPaH63Y2CLBOwFMMT2WyOreDbtw3VlM2QrrcLocQ6xUa2xQU=
X-Received: by 2002:a67:8055:: with SMTP id b82mr3384656vsd.200.1551862878371;
 Wed, 06 Mar 2019 01:01:18 -0800 (PST)
MIME-Version: 1.0
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com> <1551802205-32188-2-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1551802205-32188-2-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Mar 2019 10:00:42 +0100
Message-ID: <CAPDyKFo_O36=N9wM2jFnUvkga1TFjPMibr+0MRU6bLOpq7nH7g@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: mmci: avoid fake busy polling
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019 at 17:10, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> The busy status bit could occurred even if no busy response is
> expected (example cmd11). On sdmmc variant, the busy_detect_flag
> reflects inverted value of d0 state, it's sampled at the end of a
> CMD response and a second time 2 clk cycles after the CMD response.
> To avoid a fake busy, the busy status could be checked and polled
> only if the command has RSP_BUSY flag.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Before I review this, can you tell what HW you have tested this on?

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 387ff14..4901b73 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1220,12 +1220,13 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>              unsigned int status)
>  {
>         void __iomem *base = host->base;
> -       bool sbc;
> +       bool sbc, busy_resp;
>
>         if (!cmd)
>                 return;
>
>         sbc = (cmd == host->mrq->sbc);
> +       busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
>
>         /*
>          * We need to be one of these interrupts to be considered worth
> @@ -1239,8 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         /*
>          * ST Micro variant: handle busy detection.
>          */
> -       if (host->variant->busy_detect) {
> -               bool busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
> +       if (busy_resp && host->variant->busy_detect) {
>
>                 /* We are busy with a command, return */
>                 if (host->busy_status &&
> @@ -1253,7 +1253,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>                  * that the special busy status bit is still set before
>                  * proceeding.
>                  */
> -               if (!host->busy_status && busy_resp &&
> +               if (!host->busy_status &&
>                     !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
>                     (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
>
> @@ -1508,6 +1508,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>  {
>         struct mmci_host *host = dev_id;
>         u32 status;
> +       bool busy_resp;
>         int ret = 0;
>
>         spin_lock(&host->lock);
> @@ -1550,9 +1551,15 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>                 }
>
>                 /*
> -                * Don't poll for busy completion in irq context.
> +                * Don't poll for:
> +                * -busy completion in irq context.
> +                * -no busy response expected.
>                  */
> -               if (host->variant->busy_detect && host->busy_status)
> +               busy_resp = host->cmd ?
> +                       !!(host->cmd->flags & MMC_RSP_BUSY) : false;
> +
> +               if (host->variant->busy_detect &&
> +                   (!busy_resp || host->busy_status))
>                         status &= ~host->variant->busy_detect_flag;
>
>                 ret = 1;
> --
> 2.7.4
>
