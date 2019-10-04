Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA35C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7178A20862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpFnppB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbfJDGNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 02:13:30 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41155 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388232AbfJDGN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 02:13:29 -0400
Received: by mail-vs1-f66.google.com with SMTP id l2so3378322vsr.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 23:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlYxemLyGEw2z7tzBw1cpulBtK9wmECqFWdHMP2WOUo=;
        b=jpFnppB/F4Z075p99ZTBhY5zAVoG46Q7/SnMiOdezjKLrflNe6s8JRs6xRJvgERdrw
         aEPfEcfKl4SQwW7u6Sd4l/dI06qV4pDy0Eex8B0tXg5Wj+vZZRMG5TSX2TPXodlbxwvg
         FHYKaA+FLGIT3mYgPi8RK+U5O4Nfh0stmkbM2GE2BBYqkwNEtdbFy6JziNs14DBCeO+O
         CNaIPw72WB8BNEp/Ri6OcQxZ2zqEQv8r9mTDJXvg7wDrFOkY9JPrCe0AekBpyIOiap3+
         NZM03X0fyhLA3OrMANTCBZWOxOgEOadAl9Yy0ffZ+rThltRJtUIisJpKxoreADXRfq18
         qffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlYxemLyGEw2z7tzBw1cpulBtK9wmECqFWdHMP2WOUo=;
        b=pnO6hqeGMkWc4q8VL1MjW/TjtBKIVgsW7WImPO8J45b6lK5ehANyjkYrBdVis3wKud
         Abx3ivbeClU2qIhoL2GOT6d5c3phuXtHnNpwEvzoMtCiWblBis63dYwEV7O8hI2I0c8x
         9IxPRIVxVwmaxY+5bWIClM91udo1YO0Oabi+q/oVOGd4kTqeh4YHcasdWfO9ZapaGv5Z
         JJ5JgqPWU3QSi5ij42waa16WYNdyce8qiY177D9bU4TuuavIg9qyIqGPR1Be//JtMA/R
         hUV0blfZeRIv+QWbeRJEp7MU3vdCY6t4yF7TAH8tKaTuCImOOojM8Mxazj/clGFIXJ2N
         nsEQ==
X-Gm-Message-State: APjAAAW9UV8hL56BKvQLdNkRZEKGMhlpzxfHL4vH2XeI7kv/nMfQZwSx
        /n/5QKOBhXF1krBuf9xQZkGgL2VkGmu7kCd2L8I/lQ==
X-Google-Smtp-Source: APXvYqwe4FiRLNALsADBsQ1M2wb6h4k6tCXwHwPsKcPofn8xLo+JhI+CH7xO3En2d3+P52nm5VQNA4f1xN+2Jgppu2Q=
X-Received: by 2002:a67:e414:: with SMTP id d20mr7072671vsf.191.1570169608232;
 Thu, 03 Oct 2019 23:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190905122112.29672-1-ludovic.Barre@st.com> <20190905122112.29672-2-ludovic.Barre@st.com>
In-Reply-To: <20190905122112.29672-2-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Oct 2019 08:12:51 +0200
Message-ID: <CAPDyKFpcb=dT0XBAGVL68t--xi5853Dzsgak-vbx5VcvxLZ4zA@mail.gmail.com>
Subject: Re: [PATCH V6 1/3] mmc: mmci: add hardware busy timeout feature
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

On Thu, 5 Sep 2019 at 14:21, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> In some variants, the data timer starts and decrements
> when the DPSM enters in Wait_R or Busy state
> (while data transfer or MMC_RSP_BUSY), and generates a
> data timeout error if the counter reach 0.


>
> -Define max_busy_timeout (in ms) according to clock.
> -Set data timer register if the command has rsp_busy flag.
>  If busy_timeout is not defined by framework, the busy
>  length after Data Burst is defined as 1 second
>  (refer: 4.6.2.2 Write of sd specification part1 v6-0).

How about re-phrasing this as below:

-----
In the stm32_sdmmc variant, the datatimer is active not only during
data transfers with the DPSM, but also while waiting for the busyend
IRQs from commands having the MMC_RSP_BUSY flag set. This leads to an
incorrect IRQ being raised to signal MCI_DATATIMEOUT error, which
simply breaks the behaviour.

Address this by updating the datatimer value before sending a command
having the MMC_RSP_BUSY flag set. To inform the mmc core about the
maximum supported busy timeout, which also depends on the current
clock rate, set ->max_busy_timeout (in ms).
-----

Regarding the busy_timeout, the core should really assign it a value
for all commands having the RSP_BUSY flag set. However, I realize the
core needs to be improved to cover all these cases - and I am looking
at that, but not there yet.

I would also suggest to use a greater value than 1s, as that seems a
bit low for the "undefined" case. Perhaps use the max_busy_timeout,
which would be nice a simple or 10s, which I think is used by some
other drivers.

> -Add MCI_DATATIMEOUT error management in mmci_cmd_irq.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 42 ++++++++++++++++++++++++++++++++++++-----
>  drivers/mmc/host/mmci.h |  3 +++
>  2 files changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index c37e70dbe250..c30319255dc2 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1075,6 +1075,7 @@ static void
>  mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>  {
>         void __iomem *base = host->base;
> +       unsigned long long clks;
>
>         dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
>             cmd->opcode, cmd->arg, cmd->flags);
> @@ -1097,6 +1098,16 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>                 else
>                         c |= host->variant->cmdreg_srsp;
>         }
> +
> +       if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
> +               if (!cmd->busy_timeout)
> +                       cmd->busy_timeout = 1000;
> +
> +               clks = (unsigned long long)cmd->busy_timeout * host->cclk;
> +               do_div(clks, MSEC_PER_SEC);
> +               writel_relaxed(clks, host->base + MMCIDATATIMER);
> +       }
> +
>         if (/*interrupt*/0)
>                 c |= MCI_CPSM_INTERRUPT;
>
> @@ -1201,6 +1212,7 @@ static void
>  mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>              unsigned int status)
>  {
> +       u32 err_msk = MCI_CMDCRCFAIL | MCI_CMDTIMEOUT;
>         void __iomem *base = host->base;
>         bool sbc, busy_resp;
>
> @@ -1215,8 +1227,11 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>          * handling. Note that we tag on any latent IRQs postponed
>          * due to waiting for busy status.
>          */
> -       if (!((status|host->busy_status) &
> -             (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND)))
> +       if (host->variant->busy_timeout && busy_resp)
> +               err_msk |= MCI_DATATIMEOUT;
> +
> +       if (!((status | host->busy_status) &
> +             (err_msk | MCI_CMDSENT | MCI_CMDRESPEND)))
>                 return;
>
>         /* Handle busy detection on DAT0 if the variant supports it. */
> @@ -1235,8 +1250,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>                  * while, to allow it to be set, but tests indicates that it
>                  * isn't needed.
>                  */
> -               if (!host->busy_status &&
> -                   !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
> +               if (!host->busy_status && !(status & err_msk) &&
>                     (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
>
>                         writel(readl(base + MMCIMASK0) |
> @@ -1290,6 +1304,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>                 cmd->error = -ETIMEDOUT;
>         } else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
>                 cmd->error = -EILSEQ;
> +       } else if (host->variant->busy_timeout && busy_resp &&
> +                  status & MCI_DATATIMEOUT) {
> +               cmd->error = -ETIMEDOUT;

It's not really clear to me what happens with the busy detection
status bit (variant->busy_detect_flag), in case a MCI_DATATIMEOUT IRQ
is raised, while also having host->busy_status set (waiting for
busyend).

By looking at the code a few lines above this, we may do a "return;"
while waiting for the busyend IRQ even if MCI_DATATIMEOUT also is
raised, potentially losing that from being caught. Is that really
correct?

>         } else {
>                 cmd->resp[0] = readl(base + MMCIRESPONSE0);
>                 cmd->resp[1] = readl(base + MMCIRESPONSE1);
> @@ -1583,6 +1600,20 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         spin_unlock_irqrestore(&host->lock, flags);
>  }
>
> +static void mmci_set_max_busy_timeout(struct mmc_host *mmc)
> +{
> +       struct mmci_host *host = mmc_priv(mmc);
> +       u32 max_busy_timeout = 0;
> +
> +       if (!host->variant->busy_detect)
> +               return;
> +
> +       if (host->variant->busy_timeout && mmc->actual_clock)
> +               max_busy_timeout = ~0UL / (mmc->actual_clock / MSEC_PER_SEC);
> +
> +       mmc->max_busy_timeout = max_busy_timeout;
> +}
> +
>  static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct mmci_host *host = mmc_priv(mmc);
> @@ -1687,6 +1718,8 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         else
>                 mmci_set_clkreg(host, ios->clock);
>
> +       mmci_set_max_busy_timeout(mmc);
> +
>         if (host->ops && host->ops->set_pwrreg)
>                 host->ops->set_pwrreg(host, pwr);
>         else
> @@ -1957,7 +1990,6 @@ static int mmci_probe(struct amba_device *dev,
>                         mmci_write_datactrlreg(host,
>                                                host->variant->busy_dpsm_flag);
>                 mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> -               mmc->max_busy_timeout = 0;
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
