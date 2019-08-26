Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2909DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C0F20874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b5l/BmE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfHZLjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:39:44 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45107 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbfHZLjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:39:44 -0400
Received: by mail-ua1-f66.google.com with SMTP id j6so2836305uae.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/ztN8aKj4HB6n/hOxgolZXF13lbGa3GFNj3CAvhcvI=;
        b=b5l/BmE/uVAAVYWaAv+kS/L9Dln+VeDeUv3DKBvJ12y7hQD/IWkxE91tg/AC8Lmvdq
         F9hi4/zJ0s4cpvU1RMIDXpUv0yy1YGe8BGC2qHwPmIIZWlELp5y7+4lV69+YRZ+l2JTw
         N8yGVg3ivX1VhHdKRJHQD/5Um4HTYVP8V68GLc0hIrzyisti2CHjVnOvluhphHrb1/9m
         6kdWGkG6QYX2PceBF7CeKTnERuC/pKDJJtUqhKObzN1KpzNMmrgVrudmwG1ga4lvNu6l
         pIbxv2nKiNFd7EMAHS62726BiC4F4R0ntwnsc0xvV1Xuo4GmDxhItwsFhfc//nGF1KVI
         sQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/ztN8aKj4HB6n/hOxgolZXF13lbGa3GFNj3CAvhcvI=;
        b=ZZv9PLOOI1jamGHc8qRpaoYLp/0AhBQKkdxAGEhHYjX0JO8/HrszeJaI4Ns/88TVbd
         9KkLD0q9yhi9CQHWuaL9I++roy6gqlu1fJJkK1kFkSXRYdpbRi3KhjJXv3hCHWbnpGb2
         d5A+EDv2C7jX/v0KycebmuEe3tkK6cSZdsBYqFA3lIMfBYsFJW1LOLEd5yrOzGc2vRiJ
         wd7kM3l0OPCOTOLxmWogibTAy7r9mOb61FtsJgEcV0ZAiu+SE08UJgKPp1h0eVm/68kX
         FswouFDfNxFyNmFCBzLIEKLG93iGs4qcX/u01g+SjyfB47QNpF0ghzLa+cKjtoakOlbV
         XqlQ==
X-Gm-Message-State: APjAAAXPFfysL+NKNEeOxnoNARxNexXGjdIPRhjTAOuom03xUF3SZb3u
        C3IFuSq6czyqcHaYwMkmCOnW8iAiQSNvIJ48uusojw==
X-Google-Smtp-Source: APXvYqz7S0pSN+WeOoO47//MqKvJ32+rI0KoknCDGuol7xTw/uTMylWuLA8O7lgaQMBaQaBJrYLQI9MjrkaBX78hK04=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr8159552uar.104.1566819582903;
 Mon, 26 Aug 2019 04:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190813095951.26275-1-ludovic.Barre@st.com> <20190813095951.26275-2-ludovic.Barre@st.com>
In-Reply-To: <20190813095951.26275-2-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 26 Aug 2019 13:39:06 +0200
Message-ID: <CAPDyKFpOj8g+eY-vTxW4Sk+wVYTP1-4jDJB=nE=24eSubBvN-g@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] mmc: mmci: add hardware busy timeout feature
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

On Tue, 13 Aug 2019 at 12:00, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> In some variants, the data timer starts and decrements
> when the DPSM enters in Wait_R or Busy state
> (while data transfer or MMC_RSP_BUSY), and generates a
> data timeout error if the counter reach 0.

I don't quite follow here, sorry. Can you please try to elaborate on
the use case(s) more exactly?

For example, what happens when a data transfer has just finished (for
example when MCI_DATAEND has been received) and we are going to send a
CMD12 to stop it? In this case the CMD12 has the MMC_RSP_BUSY flag
set.

Another example is the CMD5, which has no data with it.

>
> -Define max_busy_timeout (in ms) according to clock.
> -Set data timer register if the command has rsp_busy flag.
>  If busy_timeout is not defined by framework, the busy
>  length after Data Burst is defined as 1 second
>  (refer: 4.6.2.2 Write of sd specification part1 v6-0).

One second is not sufficient for all operations, like ERASE for
example. However, I understand that you want to pick some value, as a
safety. I guess that's fine.

I am thinking that if the command has the MMC_RSP_BUSY flag set, the
core should really provide a busy timeout for it. That said, maybe the
host driver should splat a WARN in case there is not busy timeout
specified.

> -Add MCI_DATATIMEOUT error management in mmci_cmd_irq.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 37 ++++++++++++++++++++++++++++++++-----
>  drivers/mmc/host/mmci.h |  3 +++
>  2 files changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index c37e70dbe250..c50586540765 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1075,6 +1075,7 @@ static void
>  mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>  {
>         void __iomem *base = host->base;
> +       unsigned long long clks = 0;
>
>         dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
>             cmd->opcode, cmd->arg, cmd->flags);
> @@ -1097,6 +1098,19 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>                 else
>                         c |= host->variant->cmdreg_srsp;
>         }
> +
> +       if (host->variant->busy_timeout && !host->mrq->data) {

Suppose this is a CMD12 command, having the MMC_RSP_BUSY flag set. The
command would then be sent to stop the transmission and then
host->mrq->data would also be set.

If I recall earlier what you stated about the new sdmmc variant, the
CMD12 is needed to exit the DPSM. Hence don't you need to re-program a
new value for the MMCIDATATIMER register for this scenario?

> +               if (cmd->flags & MMC_RSP_BUSY) {
> +                       if (!cmd->busy_timeout)
> +                               cmd->busy_timeout = 1000;
> +
> +                       clks = (unsigned long long)cmd->busy_timeout;
> +                       clks *= host->cclk;

Any problems with putting the above on one line?

> +                       do_div(clks, MSEC_PER_SEC);
> +               }
> +               writel_relaxed(clks, host->base + MMCIDATATIMER);

This is writing zero to MMCIDATATIMER in case the MMC_RSP_BUSY isn't
set, is that on purpose?

> +       }
> +
>         if (/*interrupt*/0)
>                 c |= MCI_CPSM_INTERRUPT;
>
> @@ -1203,6 +1217,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>  {
>         void __iomem *base = host->base;
>         bool sbc, busy_resp;
> +       u32 err_msk;
>
>         if (!cmd)
>                 return;
> @@ -1215,8 +1230,12 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>          * handling. Note that we tag on any latent IRQs postponed
>          * due to waiting for busy status.
>          */
> -       if (!((status|host->busy_status) &
> -             (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND)))
> +       err_msk = MCI_CMDCRCFAIL | MCI_CMDTIMEOUT;

You might as well move the initial assignment of err_msk to the its
declaration above.

> +       if (host->variant->busy_timeout && busy_resp)
> +               err_msk |= MCI_DATATIMEOUT;
> +
> +       if (!((status | host->busy_status) &
> +             (err_msk | MCI_CMDSENT | MCI_CMDRESPEND)))
>                 return;
>
>         /* Handle busy detection on DAT0 if the variant supports it. */
> @@ -1235,8 +1254,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>                  * while, to allow it to be set, but tests indicates that it
>                  * isn't needed.
>                  */
> -               if (!host->busy_status &&
> -                   !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
> +               if (!host->busy_status && !(status & err_msk) &&
>                     (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
>
>                         writel(readl(base + MMCIMASK0) |
> @@ -1290,6 +1308,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>                 cmd->error = -ETIMEDOUT;
>         } else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
>                 cmd->error = -EILSEQ;
> +       } else if (host->variant->busy_timeout && busy_resp &&
> +                  status & MCI_DATATIMEOUT) {
> +               cmd->error = -ETIMEDOUT;
>         } else {
>                 cmd->resp[0] = readl(base + MMCIRESPONSE0);
>                 cmd->resp[1] = readl(base + MMCIRESPONSE1);
> @@ -1948,6 +1969,8 @@ static int mmci_probe(struct amba_device *dev,
>          * Enable busy detection.
>          */
>         if (variant->busy_detect) {
> +               u32 max_busy_timeout = 0;
> +
>                 mmci_ops.card_busy = mmci_card_busy;
>                 /*
>                  * Not all variants have a flag to enable busy detection
> @@ -1957,7 +1980,11 @@ static int mmci_probe(struct amba_device *dev,
>                         mmci_write_datactrlreg(host,
>                                                host->variant->busy_dpsm_flag);
>                 mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> -               mmc->max_busy_timeout = 0;
> +
> +               if (variant->busy_timeout)
> +                       max_busy_timeout = ~0UL / (mmc->f_max / MSEC_PER_SEC);

It looks like the max busy timeout is depending on the current picked
clock rate, right?

In such case, perhaps it's better to update mmc->max_busy_timeout as
part of the ->set_ios() callback, as it's from there the clock rate
gets updated. Or what do you think?

> +
> +               mmc->max_busy_timeout = max_busy_timeout;
>         }
>
>         /* Prepare a CMD12 - needed to clear the DPSM on some variants. */
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 833236ecb31e..d8b7f6774e8f 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -287,6 +287,8 @@ struct mmci_host;
>   * @signal_direction: input/out direction of bus signals can be indicated
>   * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
>   * @busy_detect: true if the variant supports busy detection on DAT0.
> + * @busy_timeout: true if the variant starts data timer when the DPSM
> + *               enter in Wait_R or Busy state.
>   * @busy_dpsm_flag: bitmask enabling busy detection in the DPSM
>   * @busy_detect_flag: bitmask identifying the bit in the MMCISTATUS register
>   *                   indicating that the card is busy
> @@ -333,6 +335,7 @@ struct variant_data {
>         u8                      signal_direction:1;
>         u8                      pwrreg_clkgate:1;
>         u8                      busy_detect:1;
> +       u8                      busy_timeout:1;
>         u32                     busy_dpsm_flag;
>         u32                     busy_detect_flag;
>         u32                     busy_detect_mask;
> --
> 2.17.1
>

Kind regards
Uffe
