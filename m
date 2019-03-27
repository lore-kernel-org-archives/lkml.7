Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EABCC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD2D2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mo/yD2Kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfC0OsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:48:01 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45167 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbfC0OsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:48:01 -0400
Received: by mail-ua1-f67.google.com with SMTP id c13so4265672uao.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R815A1FJQxQZH+hP8PNI4aTyVidcMt4Kw7CGKUhXijo=;
        b=mo/yD2KjBlqN8CIPBEd+hBTgvhhRNlfYKOwnk0LQjhE3KsMeq7ooZ+c3dJc5XBzqoW
         AR1MWdvEsqBQ7toJ2TUVTHoCwfiTdAUMvcfmBHrH74i1ykXDp2hU0RMDGmNTXIJIvXra
         pkNIFMa09eVfcAH8JgE77yU04k/cviRF4Zui5Woi/B8O+DK94avd4rr7j7M2h75Whsuc
         t2MiMAwOGp1Kdv4bRM+nMagO7CnpHgDDnSCc5SDvUUeSz2eDnnyTPY8HD2mAV2aNOX/c
         1wtRpU2zm0TkXwslr/MCd+RQZiH1HzEgMlsYq63PNOBl+rZRUA/84lhwB9Sg3Mr+MWaX
         T6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R815A1FJQxQZH+hP8PNI4aTyVidcMt4Kw7CGKUhXijo=;
        b=ma6t64W+/m9E+p9R1Nx4lnVXikh4lnVwAkxpE4wAwWy4MtEZCy85KuMhQlfAGcAV9B
         O/FesvvYigPRC8dYnMyTHQ6tPQQv+SqEhq9FPFj+3tVs2FFnWFZ++lohqixh85Y97Ciw
         rM96pHftt19PMUdjoHzeXBvGcHp5allY+4q17PNj8kG6mo0NDmxJ7veJgIQqE1wQVYMy
         79WLO74S5bur5ycEPE26GGxiHFZ30kVfctFOooUfDVoh4uIDlLx0f8xOzzGN13EY6NsF
         sCKz6cfl5ChOTV99tcBK5eMWaxMucpjMccNA0gIh2tLbLI9Krh8hVc7pI7cit7aQdsKD
         rxRQ==
X-Gm-Message-State: APjAAAUDlJxMxM4TX8h1DFIvioT0gAGpqEui/bs/Fng5eTPABsKX7y8i
        c7D0ruU7yC+xrM9LO+wbzDMafYAFjVraAF953YXuHw==
X-Google-Smtp-Source: APXvYqzWBAl7p5eYw4lQsReAPBgLme1SkDBBeWNtLWO6yV2X7gJx0zt1vomi6wegXW/G4Ivx/ViDWTk3gRYLeE+ZYrU=
X-Received: by 2002:ab0:6383:: with SMTP id y3mr21538620uao.129.1553698079903;
 Wed, 27 Mar 2019 07:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
 <1553677532-3539-5-git-send-email-ludovic.Barre@st.com> <CAPDyKFrGRojw5jmGZ_J-nmP4bHqd0BnKwyKweAr6aLD4C4NMPQ@mail.gmail.com>
 <bef06e28-4521-af86-adf4-bc904280707a@st.com>
In-Reply-To: <bef06e28-4521-af86-adf4-bc904280707a@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Mar 2019 15:47:23 +0100
Message-ID: <CAPDyKFqh1pZhaiS9D22egZjDb_SL3_shs4Gr4PJUZVAXCbW5aA@mail.gmail.com>
Subject: Re: [PATCH V4 4/5] mmc: mmci: stm32: define get_dctrl_cfg
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

On Wed, 27 Mar 2019 at 15:44, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
>
>
> On 3/27/19 11:54 AM, Ulf Hansson wrote:
> > On Wed, 27 Mar 2019 at 10:05, Ludovic Barre <ludovic.Barre@st.com> wrote:
> >>
> >> From: Ludovic Barre <ludovic.barre@st.com>
> >>
> >> This patch defines get_dctrl_cfg callback for sdmmc variant.
> >> sdmmc variant has specific stm32 transfer modes.
> >> sdmmc data transfer mode selection could be:
> >> -Block data transfer ending on block count.
> >> -SDIO multibyte data transfer.
> >> -MMC Stream data transfer (not used).
> >> -Block data transfer ending with STOP_TRANSMISSION command.
> >>
> >> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> >> ---
> >>   drivers/mmc/host/mmci.h             |  5 +++++
> >>   drivers/mmc/host/mmci_stm32_sdmmc.c | 18 ++++++++++++++++++
> >>   2 files changed, 23 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> >> index 35c91d0..82e9f94 100644
> >> --- a/drivers/mmc/host/mmci.h
> >> +++ b/drivers/mmc/host/mmci.h
> >> @@ -131,6 +131,11 @@
> >>   /* Control register extensions in the Qualcomm versions */
> >>   #define MCI_DPSM_QCOM_DATA_PEND        BIT(17)
> >>   #define MCI_DPSM_QCOM_RX_DATA_PEND BIT(20)
> >> +/* Control register extensions in STM32 versions */
> >> +#define MCI_DPSM_STM32_MODE_BLOCK      (0 << 2)
> >> +#define MCI_DPSM_STM32_MODE_SDIO       (1 << 2)
> >> +#define MCI_DPSM_STM32_MODE_STREAM     (2 << 2)
> >> +#define MCI_DPSM_STM32_MODE_BLOCK_STOP (3 << 2)
> >>
> >>   #define MMCIDATACNT            0x030
> >>   #define MMCISTATUS             0x034
> >> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> >> index cfbfc6f..8e83ae6 100644
> >> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> >> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> >> @@ -265,10 +265,28 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host *host, unsigned int pwr)
> >>          }
> >>   }
> >>
> >> +static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
> >> +{
> >> +       u32 datactrl;
> >> +
> >> +       datactrl = mmci_dctrl_blksz(host);
> >> +
> >> +       if (host->mmc->card && mmc_card_sdio(host->mmc->card) &&
> >> +           host->data->blocks == 1)
> >> +               datactrl |= MCI_DPSM_STM32_MODE_SDIO;
> >> +       else if (host->data->stop && !host->mrq->sbc)
> >> +               datactrl |= MCI_DPSM_STM32_MODE_BLOCK_STOP;
> >
> > Just a question here. Does this mean that the controller sends the
> > stop command automatically when a transfer has finished successfully?
>
> The controller not sends the stop command, this bit is just an
> information for the Data State Machine to know how the data transfer
> finish.

Okay, thanks for clarifying!

Kind regards
Uffe
