Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BAEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A97214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTr2EyKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfDWNkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:40:35 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40699 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfDWNkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:40:35 -0400
Received: by mail-ua1-f68.google.com with SMTP id b8so4766812uaq.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wan2BOg6TWyl9pUIAHF8/RutbUurdVatuZVJe8kK/f0=;
        b=ZTr2EyKNPCSOlvGhAOBAGCWk+1W/Sm+9QyHNv5Ekd8oLslRD2PkMeaqpNU8S8nQnGX
         Z4+rMzQ6rHRsaBhcLROGcybMfZcKzr6JkWNzxhII2fe2OgUsiLi2Yx5uwOH4GXcvaIgm
         T6glSKY4opIN31v7uhron0KWLKRJr/qn58uurLDD6+ScUm0xJoJkUUkXCUyd3GHBK4Gt
         FuA3M0Z1ReIz6NJHburo7yDZCw7AHNnqPoEpDcaB/HZ+b6aV8z8SIV9YzkBHjgeWsgm/
         7r3LuhLe8YKP+l5GSY7z43KxANjZYMJN6stZRCv6XBEc10fHIP4OXs0kxnmmO4LkTatb
         w0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wan2BOg6TWyl9pUIAHF8/RutbUurdVatuZVJe8kK/f0=;
        b=C8jr9lXb5w97S9T6Oh0ZpYBHev9aCqpjnpgRsJoDFyDmRsUeHCIaeIlaviZkngCnUt
         LGeL04Wz9hkHktW29CPXFW8YWm9vp53/O8B90/ZM+jjG0l+OFhul4p3eUQfjiC45nDnN
         SZxCr+uSnu3XKBVAdgFvW1yB14JtEYZRoptGtoiwcFxOHVN4EtQS9N9F6U8yz5pbNl49
         sFl9Yif+6cu+ZXNfgKg9csZblIwgW1ihLYP0KJRBUq0z9jMDUS3yc7/Uqm0h6Q55iw7F
         PK1p32LSN4hQdrgUWvlLhEvMWBCJLtYOyWbB/vTHcu76metuhoOhA0XN0ltL0hoNxegu
         cP4g==
X-Gm-Message-State: APjAAAUSgi0qnR7ArfcZC4fSGgaFBmsMAESYcXGDxsZl0RBCGUH7RS4O
        05fZZU7bXAq3skaNlHJCjGrGep17KS8mh5m40hIzRQ==
X-Google-Smtp-Source: APXvYqzRui32hONUXTiQIShraIENcErxpPta94A9F+KORN41hu+V0dB7dCeKoNEtOmQeffTZeFoWnRQk9+bA5DW9jrg=
X-Received: by 2002:ab0:2a53:: with SMTP id p19mr13070834uar.100.1556026833755;
 Tue, 23 Apr 2019 06:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com> <1551802205-32188-2-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1551802205-32188-2-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Apr 2019 15:39:57 +0200
Message-ID: <CAPDyKFoZuQ+hshZpj-qjchKf7enW4ChPd=r_QhK2xtuJcSvqxQ@mail.gmail.com>
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

I would appreciate a better explanation of what this patch really changes.

The above is giving some background to the behavior of sdmmc variant,
but at this point that variant doesn't even have the
->variant->busy_detect flag set.

>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
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

All the changes above makes perfect sense to me, but looks more like a
cleanup of the code, rather than actually changing the behavior.

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

This doesn't make sense to me, but I may be missing something.

host->busy_status is being updated by mmci_cmd_irq() and only when
MMC_RSP_BUSY is set for the command in flight. In other words,
checking for MMC_RSP_BUSY here as well is redundant. No?

> +
> +               if (host->variant->busy_detect &&
> +                   (!busy_resp || host->busy_status))
>                         status &= ~host->variant->busy_detect_flag;
>
>                 ret = 1;
> --
> 2.7.4
>

Kind regards
Uffe
