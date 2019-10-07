Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90E2C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A854020659
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpxlm6n8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfJGGtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 02:49:14 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:32912 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfJGGtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 02:49:14 -0400
Received: by mail-vs1-f67.google.com with SMTP id p13so8202932vso.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 23:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L4l7r81RJwm9C7hr+S0v5tSYxoGtALeVwL6UoE3dEWs=;
        b=fpxlm6n8YbFqzao86Z/I3k1+keYrLEefk1LMTtUpV/fUlYMBXdJPkAE57hy7X5dIQI
         oT6n5Rb9HRzC9mtgu1QI00/BlV2zxTGFP/Rrk/dvZBqwAROL+NTJhdjyM7wUTdkzgsnq
         oBjozVWsJNKaUPNfPLo/5jafaMJP1pSI57xcwZ/rN1TFvjub+hD67cJ4e0Ly3AxhH3Sj
         iMEowL9Hq0kGDaWt4Y2IlVYTO7Wa0/WBtHDHio/lNpPqzETIv7x6nhUz2FRoC3TWdNZ1
         zYCrppCTwKNYSbHVDH7c/HpZTHDb0PP3r+H7F8Gl9ug91FJMlQAlGLlEQGRgwMRTk+2D
         TtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L4l7r81RJwm9C7hr+S0v5tSYxoGtALeVwL6UoE3dEWs=;
        b=PM7Erj+7ytDKqvYdTy3UV3CaC1fjlWHXbbolLbFJ0ahtjc/Dl3rN9mzu/IUX7Z5fHF
         z4FsR3ZeumgM8Mn8X48aAWCQDCQj3AXG2iXtfb3s8Vau2GJFYKJa1pLDPPfJLU3cNk+z
         nliGOiW8A2eNN2tkX8T7fnFUY/XwjoF5sTl9xXwTSZF4AhezHJlLrP96BLMeNXi+4oMr
         2KMRGi0bWwPhvSULk0+RWHgiL6PGugKgFmwd7JzkAzIlz/2dEMwEwhztwoTivXSJ8wB2
         RttBdKTpYe+RThYefLqZfmADkUSBn5cttVAZtetoLSQh4s6V5Ja5jyp6WuBBmQoaweQ2
         6vSQ==
X-Gm-Message-State: APjAAAUEKtGUPJfH8Dx5sqKn5M4NBNnWSRmtbM0Y/KxFKY4zYpdOxQwQ
        zoCbrEJvVdXxo7NT5L8gm35t6Z+cSAIxppfP7TggKA==
X-Google-Smtp-Source: APXvYqwf7WgLbxsPlihSI5TEH2gar51Fyk/IOzjyQkIiit4sL/kvIpGq5UTfp/frSl9QNp+DljlOl4kCawa38pTQmHA=
X-Received: by 2002:a67:fc5a:: with SMTP id p26mr14091177vsq.200.1570430952994;
 Sun, 06 Oct 2019 23:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190905122112.29672-1-ludovic.Barre@st.com> <20190905122112.29672-2-ludovic.Barre@st.com>
 <CAPDyKFpcb=dT0XBAGVL68t--xi5853Dzsgak-vbx5VcvxLZ4zA@mail.gmail.com>
 <CAPDyKFrRDHeVs6RpM=qTT1AogLnFWJLh2S4-wCcrYAON9XVKCA@mail.gmail.com> <da9072ce-852c-a46c-ecdf-ea6bfd89ef79@st.com>
In-Reply-To: <da9072ce-852c-a46c-ecdf-ea6bfd89ef79@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Oct 2019 08:48:35 +0200
Message-ID: <CAPDyKFp0sia9RC1kX0nmfB2g4Wvk+Y_o1wM8yatrzTeHpRd_vg@mail.gmail.com>
Subject: Re: [PATCH V6 1/3] mmc: mmci: add hardware busy timeout feature
To:     Ludovic BARRE <ludovic.barre@st.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2019 at 14:59, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> Le 10/4/19 =C3=A0 8:20 AM, Ulf Hansson a =C3=A9crit :
> > On Fri, 4 Oct 2019 at 08:12, Ulf Hansson <ulf.hansson@linaro.org> wrote=
:
> >>
> >> On Thu, 5 Sep 2019 at 14:21, Ludovic Barre <ludovic.Barre@st.com> wrot=
e:
> >>>
> >>> From: Ludovic Barre <ludovic.barre@st.com>
> >>>
> >>> In some variants, the data timer starts and decrements
> >>> when the DPSM enters in Wait_R or Busy state
> >>> (while data transfer or MMC_RSP_BUSY), and generates a
> >>> data timeout error if the counter reach 0.
> >>
> >>
> >>>
> >>> -Define max_busy_timeout (in ms) according to clock.
> >>> -Set data timer register if the command has rsp_busy flag.
> >>>   If busy_timeout is not defined by framework, the busy
> >>>   length after Data Burst is defined as 1 second
> >>>   (refer: 4.6.2.2 Write of sd specification part1 v6-0).
> >>
> >> How about re-phrasing this as below:
> >>
> >> -----
> >> In the stm32_sdmmc variant, the datatimer is active not only during
> >> data transfers with the DPSM, but also while waiting for the busyend
> >> IRQs from commands having the MMC_RSP_BUSY flag set. This leads to an
> >> incorrect IRQ being raised to signal MCI_DATATIMEOUT error, which
> >> simply breaks the behaviour.
> >>
> >> Address this by updating the datatimer value before sending a command
> >> having the MMC_RSP_BUSY flag set. To inform the mmc core about the
> >> maximum supported busy timeout, which also depends on the current
> >> clock rate, set ->max_busy_timeout (in ms).
>
> Thanks for the re-phrasing.
>
> >> -----
> >>
> >> Regarding the busy_timeout, the core should really assign it a value
> >> for all commands having the RSP_BUSY flag set. However, I realize the
> >> core needs to be improved to cover all these cases - and I am looking
> >> at that, but not there yet.
> >>
> >> I would also suggest to use a greater value than 1s, as that seems a
> >> bit low for the "undefined" case. Perhaps use the max_busy_timeout,
> >> which would be nice a simple or 10s, which I think is used by some
> >> other drivers.
>
> OK, I will set 10s, the max_busy_timeout could be very long for small
> frequencies (example, 25Mhz =3D> 171s).
>
> >>
> >>> -Add MCI_DATATIMEOUT error management in mmci_cmd_irq.
> >>>
> >>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> >>> ---
> >>>   drivers/mmc/host/mmci.c | 42 ++++++++++++++++++++++++++++++++++++--=
---
> >>>   drivers/mmc/host/mmci.h |  3 +++
> >>>   2 files changed, 40 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> >>> index c37e70dbe250..c30319255dc2 100644
> >>> --- a/drivers/mmc/host/mmci.c
> >>> +++ b/drivers/mmc/host/mmci.c
> >>> @@ -1075,6 +1075,7 @@ static void
> >>>   mmci_start_command(struct mmci_host *host, struct mmc_command *cmd,=
 u32 c)
> >>>   {
> >>>          void __iomem *base =3D host->base;
> >>> +       unsigned long long clks;
> >>>
> >>>          dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
> >>>              cmd->opcode, cmd->arg, cmd->flags);
> >>> @@ -1097,6 +1098,16 @@ mmci_start_command(struct mmci_host *host, str=
uct mmc_command *cmd, u32 c)
> >>>                  else
> >>>                          c |=3D host->variant->cmdreg_srsp;
> >>>          }
> >>> +
> >>> +       if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY)=
 {
> >>> +               if (!cmd->busy_timeout)
> >>> +                       cmd->busy_timeout =3D 1000;
> >>> +
> >>> +               clks =3D (unsigned long long)cmd->busy_timeout * host=
->cclk;
> >>> +               do_div(clks, MSEC_PER_SEC);
> >>> +               writel_relaxed(clks, host->base + MMCIDATATIMER);
> >>> +       }
> >>> +
> >>>          if (/*interrupt*/0)
> >>>                  c |=3D MCI_CPSM_INTERRUPT;
> >>>
> >>> @@ -1201,6 +1212,7 @@ static void
> >>>   mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >>>               unsigned int status)
> >>>   {
> >>> +       u32 err_msk =3D MCI_CMDCRCFAIL | MCI_CMDTIMEOUT;
> >>>          void __iomem *base =3D host->base;
> >>>          bool sbc, busy_resp;
> >>>
> >>> @@ -1215,8 +1227,11 @@ mmci_cmd_irq(struct mmci_host *host, struct mm=
c_command *cmd,
> >>>           * handling. Note that we tag on any latent IRQs postponed
> >>>           * due to waiting for busy status.
> >>>           */
> >>> -       if (!((status|host->busy_status) &
> >>> -             (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPE=
ND)))
> >>> +       if (host->variant->busy_timeout && busy_resp)
> >>> +               err_msk |=3D MCI_DATATIMEOUT;
> >>> +
> >>> +       if (!((status | host->busy_status) &
> >>> +             (err_msk | MCI_CMDSENT | MCI_CMDRESPEND)))
> >>>                  return;
> >>>
> >>>          /* Handle busy detection on DAT0 if the variant supports it.=
 */
> >>> @@ -1235,8 +1250,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc=
_command *cmd,
> >>>                   * while, to allow it to be set, but tests indicates=
 that it
> >>>                   * isn't needed.
> >>>                   */
> >>> -               if (!host->busy_status &&
> >>> -                   !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
> >>> +               if (!host->busy_status && !(status & err_msk) &&
> >>>                      (readl(base + MMCISTATUS) & host->variant->busy_=
detect_flag)) {
> >>>
> >>>                          writel(readl(base + MMCIMASK0) |
> >>> @@ -1290,6 +1304,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc=
_command *cmd,
> >>>                  cmd->error =3D -ETIMEDOUT;
> >>>          } else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_C=
RC) {
> >>>                  cmd->error =3D -EILSEQ;
> >>> +       } else if (host->variant->busy_timeout && busy_resp &&
> >>> +                  status & MCI_DATATIMEOUT) {
> >>> +               cmd->error =3D -ETIMEDOUT;
> >>
> >> It's not really clear to me what happens with the busy detection
> >> status bit (variant->busy_detect_flag), in case a MCI_DATATIMEOUT IRQ
> >> is raised, while also having host->busy_status set (waiting for
> >> busyend).
> >>
> >> By looking at the code a few lines above this, we may do a "return;"
> >> while waiting for the busyend IRQ even if MCI_DATATIMEOUT also is
> >> raised, potentially losing that from being caught. Is that really
> >> correct?
> >
> > A second thought. That "return;" is to manage the busyend IRQ being
> > raised of the first edge due to broken HW. So I guess, this isn't an
> > issue for stm32_sdmmc variant after all?
> >
> > I have a look at the next patches in the series..
>
> you're referring to "return" of ?
>         if (host->busy_status &&
>             (status & host->variant->busy_detect_flag)) {
>                 writel(host->variant->busy_detect_mask,
>                        host->base + MMCICLEAR);
>                 return;
>         }
>
> For stm32 variant (in patch 3/3): the "busy completion" is
> released immediately if there is an error or busyd0end,
> and cleans: irq, busyd0end mask, busy_status variable.

Right, thanks for clarifying!

>
> I could add similar action in patch 2/3 function: "ux500_busy_complete"
>
> static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32
> err_msk)
> {
>         void __iomem *base =3D host->base;
>
>         if (status & err_msk)
>                 goto complete;
> ...
> complete:
>         /* specific action to clean busy detection, irq, mask, busy_statu=
s */
> }
>
> what do you think about it?

For the legacy variant, the MCI_DATATIMEOUT isn't an issue as it can't
be raised while waiting for busyend. So, I think this is fine as is.

Kind regards
Uffe
