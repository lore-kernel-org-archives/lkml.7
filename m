Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEC6C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0B420661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEY6t285"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfCFJuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:50:15 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34320 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfCFJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:50:15 -0500
Received: by mail-vs1-f66.google.com with SMTP id h7so1827374vsl.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 01:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYGx/05f3pFj8L/hPCABZq2kRoRRjtRTmW249CzO1a8=;
        b=hEY6t285cP6ZBHUnL86m4ynB3V84L9yvKoc7WMeCHBIP3mXp++gC0Ab2wbm2Iik1Fq
         g+2VBV2FICDs/uzBB/EMJyYHi5c4ZJobD6xmpy2L8igyAGc36Qzj6gbvJL6rBWRwxhtC
         QKdeqhtckBe0gE6NimDqZf77mCbadJvsQ7uafJCFe47q9B1XV5JqFqwnmt9k5zBCaH+l
         7Iblf9ohGTP8FDzIAPuYP47G06pEQBkNCduP2UHFSV/Id7dxOllwR4dcLHYOB9ddoQsb
         rws5/VXpnVlWUu3o0SLlGuAn7ObdUtHOz9Mb8V5aPrD0TxT9kdOuVUt3seINkDlwnygu
         NRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYGx/05f3pFj8L/hPCABZq2kRoRRjtRTmW249CzO1a8=;
        b=D2Veko7f1WoFnIoDMlG6lNgULUww/ukjZ8VMUPvPmh/WFNM+bfjkVld4iW/fh4o2Oj
         dqX3GF1hET/sh5vzQrycXjFtgM1enYTcdkQNBK+ycoNkP3h4or2bYgD8zO04PAX8iRZN
         2Hq5488wnZgH1UByl69RHKuzuIlEFG9TcmQXJT6KwOeyoLBJILEDIlNp34VMtI9VEXnO
         h3WRDPDxvrAVzGvgXIh2xzs9L1dLu1z7zDK0WiiEynWK74OPDGhkMID8hVT7V7t08/wp
         sgPRhnoUQbwuq4hY3GHBWy8ZZ5wsEQ1/GecDWqD75fX4SmpazBDBFGU4BaHkD/NCyEwf
         Rk3Q==
X-Gm-Message-State: APjAAAVKnq4ko4CtCc65dR/bs0UAkNQEuB3IRqx8FtMTy4jz53nIWf/Y
        Qxb/xbie6OMep+a/eIMPEQKjeKnf0U+ME2dehoJkNF3c
X-Google-Smtp-Source: APXvYqymp7qOtk2IkJLycAhfxwi8OB9/yojc0tLyue9/RGEtDKSMKStNYcU8Sua5FGQgrMSaNoJzIeVh5CeukxAzymQ=
X-Received: by 2002:a67:768f:: with SMTP id r137mr3384762vsc.35.1551865813425;
 Wed, 06 Mar 2019 01:50:13 -0800 (PST)
MIME-Version: 1.0
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
 <1551802205-32188-2-git-send-email-ludovic.Barre@st.com> <CAPDyKFo_O36=N9wM2jFnUvkga1TFjPMibr+0MRU6bLOpq7nH7g@mail.gmail.com>
 <5b531f55-b8a0-5a83-4a7c-727013a66820@st.com>
In-Reply-To: <5b531f55-b8a0-5a83-4a7c-727013a66820@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Mar 2019 10:49:37 +0100
Message-ID: <CAPDyKFp=AO27hmG9u8JHrRa3JW7RNMbxC8+vMb2y_qGo=mLWQg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: mmci: avoid fake busy polling
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019 at 10:04, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> Hi Ulf
>
> On 3/6/19 10:00 AM, Ulf Hansson wrote:
> > On Tue, 5 Mar 2019 at 17:10, Ludovic Barre <ludovic.Barre@st.com> wrote:
> >>
> >> From: Ludovic Barre <ludovic.barre@st.com>
> >>
> >> The busy status bit could occurred even if no busy response is
> >> expected (example cmd11). On sdmmc variant, the busy_detect_flag
> >> reflects inverted value of d0 state, it's sampled at the end of a
> >> CMD response and a second time 2 clk cycles after the CMD response.
> >> To avoid a fake busy, the busy status could be checked and polled
> >> only if the command has RSP_BUSY flag.
> >>
> >> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> >
> > Before I review this, can you tell what HW you have tested this on?
>
> I tested on stm32mp157c (stm32_sdmmc variant)

Okay, I see. So we need to get this tested for the ux500v2 variant as
well. I try to get some time to do that, soon.

However it seems like you could benefit from having one of those
boards yourself. It would speed up the process, as you wouldn't have
to rely on me doing the test. :-) Is there a chance of you could dig
up some of these old boards from somewhere?

Kind regards
Uffe

>
> >
> > Kind regards
> > Uffe
> >
> >> ---
> >>   drivers/mmc/host/mmci.c | 19 +++++++++++++------
> >>   1 file changed, 13 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> >> index 387ff14..4901b73 100644
> >> --- a/drivers/mmc/host/mmci.c
> >> +++ b/drivers/mmc/host/mmci.c
> >> @@ -1220,12 +1220,13 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >>               unsigned int status)
> >>   {
> >>          void __iomem *base = host->base;
> >> -       bool sbc;
> >> +       bool sbc, busy_resp;
> >>
> >>          if (!cmd)
> >>                  return;
> >>
> >>          sbc = (cmd == host->mrq->sbc);
> >> +       busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
> >>
> >>          /*
> >>           * We need to be one of these interrupts to be considered worth
> >> @@ -1239,8 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >>          /*
> >>           * ST Micro variant: handle busy detection.
> >>           */
> >> -       if (host->variant->busy_detect) {
> >> -               bool busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
> >> +       if (busy_resp && host->variant->busy_detect) {
> >>
> >>                  /* We are busy with a command, return */
> >>                  if (host->busy_status &&
> >> @@ -1253,7 +1253,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >>                   * that the special busy status bit is still set before
> >>                   * proceeding.
> >>                   */
> >> -               if (!host->busy_status && busy_resp &&
> >> +               if (!host->busy_status &&
> >>                      !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
> >>                      (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
> >>
> >> @@ -1508,6 +1508,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
> >>   {
> >>          struct mmci_host *host = dev_id;
> >>          u32 status;
> >> +       bool busy_resp;
> >>          int ret = 0;
> >>
> >>          spin_lock(&host->lock);
> >> @@ -1550,9 +1551,15 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
> >>                  }
> >>
> >>                  /*
> >> -                * Don't poll for busy completion in irq context.
> >> +                * Don't poll for:
> >> +                * -busy completion in irq context.
> >> +                * -no busy response expected.
> >>                   */
> >> -               if (host->variant->busy_detect && host->busy_status)
> >> +               busy_resp = host->cmd ?
> >> +                       !!(host->cmd->flags & MMC_RSP_BUSY) : false;
> >> +
> >> +               if (host->variant->busy_detect &&
> >> +                   (!busy_resp || host->busy_status))
> >>                          status &= ~host->variant->busy_detect_flag;
> >>
> >>                  ret = 1;
> >> --
> >> 2.7.4
> >>
