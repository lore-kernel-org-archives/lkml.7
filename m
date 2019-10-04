Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66914C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C9321A4C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eAVNcSdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbfJDGVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 02:21:33 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39067 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbfJDGVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 02:21:33 -0400
Received: by mail-ua1-f68.google.com with SMTP id b14so1706879uap.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3VA6KMsG3nx06bNmB0dVu0SsT6kYQkCPRD3KsBbwQUM=;
        b=eAVNcSdYZdHu2Tydt5eci09qeF80XduBLbw81dp6aYCwZtLUjglNwse6Z5WwlUx6d3
         oR+GjfPOewBt/WGmeeV/AWjVXS3hd7dyK4dIDbq3pMAcoMPVAEa1wS4TVv7GLYQ8bumz
         912qcbHDJCdo/mzZ9KJ+RMb8f6+dEcPqc2nkeuToFTH26lG5Oi+jNf3bIYHSQtgqEAgn
         SPNUB+y/mE9C7Ej2c4rhQ/W+FSf0MY4vTSKFOJ5PdcLEP/MGeF5Xrbw9eMTLhIUCgtXT
         E6ySS9Fv1Se7h68KEeFyn4BHxggAOw8v+yzm51iuKcfW0yDiGUwzZTereWGDwctgJk1C
         4YMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3VA6KMsG3nx06bNmB0dVu0SsT6kYQkCPRD3KsBbwQUM=;
        b=nIGacho6Oxql1+oMksBkeL1wJpSfYVTYUNSEIRSRnLGnxzbnTHVxgbadtPlAiO8zHI
         qjWtpmkmuXTRjVZmi+erNIVP33ecqCMf2UkP83p7vgswzJKj8vfc7S0+xAfvtF9sc2lG
         RAWSpITEneBydUuaZGLTfNeLgMfgu+MD5x9h9Ot9rWUMbk5zN+6sa3ujOJtC8cLN9OP3
         LNv3xbQwmUVgDoWE0ZusnKNKrznRp4zPv2WR4FyWSoIZdDzQXTxXSUScpwTeu2IDIyD6
         cXthLXI9PDu5KsnrIvIoXJHFvp4EtsDadL2ULiJXm+cg/3b2ECM/6y4xJdwYJZDimZCC
         rtEA==
X-Gm-Message-State: APjAAAW0mnaQMAm9djCFebPe2J3iyls7wO8dt0PH36xx++TAXxMdg77d
        yFFX6qo7q2BLMBuuylHWXre5ziRPU4srTiA0OtQ1+Q==
X-Google-Smtp-Source: APXvYqxUAWDAKSyRlKUVwmcQP5taPZrKlBCqAfpilhJXELmM3ge2ED1Kpw7lsSdHFyM2x1yd0lHq32mU/+8FdWLL6YM=
X-Received: by 2002:ab0:6190:: with SMTP id h16mr5000205uan.129.1570170091738;
 Thu, 03 Oct 2019 23:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190905122112.29672-1-ludovic.Barre@st.com> <20190905122112.29672-2-ludovic.Barre@st.com>
 <CAPDyKFpcb=dT0XBAGVL68t--xi5853Dzsgak-vbx5VcvxLZ4zA@mail.gmail.com>
In-Reply-To: <CAPDyKFpcb=dT0XBAGVL68t--xi5853Dzsgak-vbx5VcvxLZ4zA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Oct 2019 08:20:55 +0200
Message-ID: <CAPDyKFrRDHeVs6RpM=qTT1AogLnFWJLh2S4-wCcrYAON9XVKCA@mail.gmail.com>
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

On Fri, 4 Oct 2019 at 08:12, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 5 Sep 2019 at 14:21, Ludovic Barre <ludovic.Barre@st.com> wrote:
> >
> > From: Ludovic Barre <ludovic.barre@st.com>
> >
> > In some variants, the data timer starts and decrements
> > when the DPSM enters in Wait_R or Busy state
> > (while data transfer or MMC_RSP_BUSY), and generates a
> > data timeout error if the counter reach 0.
>
>
> >
> > -Define max_busy_timeout (in ms) according to clock.
> > -Set data timer register if the command has rsp_busy flag.
> >  If busy_timeout is not defined by framework, the busy
> >  length after Data Burst is defined as 1 second
> >  (refer: 4.6.2.2 Write of sd specification part1 v6-0).
>
> How about re-phrasing this as below:
>
> -----
> In the stm32_sdmmc variant, the datatimer is active not only during
> data transfers with the DPSM, but also while waiting for the busyend
> IRQs from commands having the MMC_RSP_BUSY flag set. This leads to an
> incorrect IRQ being raised to signal MCI_DATATIMEOUT error, which
> simply breaks the behaviour.
>
> Address this by updating the datatimer value before sending a command
> having the MMC_RSP_BUSY flag set. To inform the mmc core about the
> maximum supported busy timeout, which also depends on the current
> clock rate, set ->max_busy_timeout (in ms).
> -----
>
> Regarding the busy_timeout, the core should really assign it a value
> for all commands having the RSP_BUSY flag set. However, I realize the
> core needs to be improved to cover all these cases - and I am looking
> at that, but not there yet.
>
> I would also suggest to use a greater value than 1s, as that seems a
> bit low for the "undefined" case. Perhaps use the max_busy_timeout,
> which would be nice a simple or 10s, which I think is used by some
> other drivers.
>
> > -Add MCI_DATATIMEOUT error management in mmci_cmd_irq.
> >
> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> > ---
> >  drivers/mmc/host/mmci.c | 42 ++++++++++++++++++++++++++++++++++++-----
> >  drivers/mmc/host/mmci.h |  3 +++
> >  2 files changed, 40 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index c37e70dbe250..c30319255dc2 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -1075,6 +1075,7 @@ static void
> >  mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
> >  {
> >         void __iomem *base = host->base;
> > +       unsigned long long clks;
> >
> >         dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
> >             cmd->opcode, cmd->arg, cmd->flags);
> > @@ -1097,6 +1098,16 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
> >                 else
> >                         c |= host->variant->cmdreg_srsp;
> >         }
> > +
> > +       if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
> > +               if (!cmd->busy_timeout)
> > +                       cmd->busy_timeout = 1000;
> > +
> > +               clks = (unsigned long long)cmd->busy_timeout * host->cclk;
> > +               do_div(clks, MSEC_PER_SEC);
> > +               writel_relaxed(clks, host->base + MMCIDATATIMER);
> > +       }
> > +
> >         if (/*interrupt*/0)
> >                 c |= MCI_CPSM_INTERRUPT;
> >
> > @@ -1201,6 +1212,7 @@ static void
> >  mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >              unsigned int status)
> >  {
> > +       u32 err_msk = MCI_CMDCRCFAIL | MCI_CMDTIMEOUT;
> >         void __iomem *base = host->base;
> >         bool sbc, busy_resp;
> >
> > @@ -1215,8 +1227,11 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >          * handling. Note that we tag on any latent IRQs postponed
> >          * due to waiting for busy status.
> >          */
> > -       if (!((status|host->busy_status) &
> > -             (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND)))
> > +       if (host->variant->busy_timeout && busy_resp)
> > +               err_msk |= MCI_DATATIMEOUT;
> > +
> > +       if (!((status | host->busy_status) &
> > +             (err_msk | MCI_CMDSENT | MCI_CMDRESPEND)))
> >                 return;
> >
> >         /* Handle busy detection on DAT0 if the variant supports it. */
> > @@ -1235,8 +1250,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >                  * while, to allow it to be set, but tests indicates that it
> >                  * isn't needed.
> >                  */
> > -               if (!host->busy_status &&
> > -                   !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
> > +               if (!host->busy_status && !(status & err_msk) &&
> >                     (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
> >
> >                         writel(readl(base + MMCIMASK0) |
> > @@ -1290,6 +1304,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >                 cmd->error = -ETIMEDOUT;
> >         } else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
> >                 cmd->error = -EILSEQ;
> > +       } else if (host->variant->busy_timeout && busy_resp &&
> > +                  status & MCI_DATATIMEOUT) {
> > +               cmd->error = -ETIMEDOUT;
>
> It's not really clear to me what happens with the busy detection
> status bit (variant->busy_detect_flag), in case a MCI_DATATIMEOUT IRQ
> is raised, while also having host->busy_status set (waiting for
> busyend).
>
> By looking at the code a few lines above this, we may do a "return;"
> while waiting for the busyend IRQ even if MCI_DATATIMEOUT also is
> raised, potentially losing that from being caught. Is that really
> correct?

A second thought. That "return;" is to manage the busyend IRQ being
raised of the first edge due to broken HW. So I guess, this isn't an
issue for stm32_sdmmc variant after all?

I have a look at the next patches in the series..

[...]

Kind regards
Uffe
