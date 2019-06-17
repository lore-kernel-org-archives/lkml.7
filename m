Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637FAC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D45120652
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYRGE1HF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfFQHrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 03:47:47 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37049 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFQHrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:47:47 -0400
Received: by mail-vs1-f68.google.com with SMTP id v6so5532783vsq.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 00:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MY3tGGLQYLdVpFw8r18hUsv6GICSapuyFtcuKuaoUEA=;
        b=ZYRGE1HFozqJdEnhT1Aq/4xm+obkmNZrwpLYS6CqA8W4IsHsooLzuhUj9jUSZ1pXMC
         IsXK1DN3/8Mq5xMzyHVJMekFzoPBD2onXipXv6T6czln5mJD7VqZU06BrnLXZaJQIYuY
         GelMtbVdclV+tc4E1i8u6QZ0XUsBjyZoLoHKm5nJHdI/KqH6iijuAZ5gJJhFzUbF9/Se
         +d0PwpL9FYuscR3eumeYjxhDhQBzbuINEQC+U6SZeB3RRxCEfIHtq7tM5fHj8IBH+IVM
         LVPADPXiZyM/rBVAiiOgU2IkNKSgrteIJ3daMDxF7Jks6qjq+ry/Fluln+qx7YV2FdPP
         QVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MY3tGGLQYLdVpFw8r18hUsv6GICSapuyFtcuKuaoUEA=;
        b=O3WB1onr6VxBR0uIJ9WhhV3eHybBObIok3ePK53xPRXERKOS+fuwfGiIIqpZl3fY71
         fca2CW/lo/UNWVlCILsnd1Z+FWR6yEp3QfFwczQNvG2Wuj3gxOYl+9aeIbrTTAcubeOh
         JOTFwhnEpg3boE/9p1FDoKa3R2q0r6kp4p8qm3gjyFzAiX3ZuEbJ6C9utt29DlyTamHd
         Z3r2l6RpiBEw/JjHjLteH6KgPoJgTzik3Xd3/d19VV+vu/W6IlVA1ExoerX1CiWV3H4m
         t4fZzO8W5F6RAHdFczNrN1n1ZOxASsg9+m1BGIHTpA5IXkT+C2hRsQn6kGFHiDjZgzEl
         RdfA==
X-Gm-Message-State: APjAAAWd45y9LACm2041xl6W5y9XFGWmQoS5pK1ZPw9vVC7FfpvelLiw
        7Ilgg6qB9wUKhAAtZm+Re0CnoSqpOHt0KeYtlqsB7g==
X-Google-Smtp-Source: APXvYqyiVUylNuTkYLjx9KI91CAaUXCepGMea+Uy268M4YUvBMxIeXwcC02Sm1UIK2FsXcJpIkuX3opSJ31nZGo10h8=
X-Received: by 2002:a67:7a90:: with SMTP id v138mr11089584vsc.200.1560757665797;
 Mon, 17 Jun 2019 00:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <1560489970-30467-1-git-send-email-jjian.zhou@mediatek.com>
 <CAPDyKFrXU4bpKeB7Aa15j2nHqUCn-bk+YKn9_vkznmi+PS8H7A@mail.gmail.com> <1560751020.3103.25.camel@mhfsdcap03>
In-Reply-To: <1560751020.3103.25.camel@mhfsdcap03>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 09:47:07 +0200
Message-ID: <CAPDyKFqs2ngPfR_SM2MEssFVDDw=S7G_Oy7V7x-bP9_aFm5XDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mediatek: fix SDIO IRQ interrupt handle flow
To:     jjian zhou <jjian.zhou@mediatek.com>
Cc:     =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?WW9uZyBNYW8gKOavm+WLhyk=?= <yong.mao@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 at 07:57, jjian zhou <jjian.zhou@mediatek.com> wrote:
>
> On Fri, 2019-06-14 at 17:46 +0800, Ulf Hansson wrote:
> > On Fri, 14 Jun 2019 at 07:26, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
> > >
> > > From: jjian zhou <jjian.zhou@mediatek.com>
> > >
> > > SDIO IRQ is triggered by low level. It need disable SDIO IRQ
> > > detected function. Otherwise the interrupt register can't be cleared.
> > > It will process the interrupt more.
> > >
> > > Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> > > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > > Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> > > ---
> > >  drivers/mmc/host/mtk-sd.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > > index c518cc2..29992ae 100644
> > > --- a/drivers/mmc/host/mtk-sd.c
> > > +++ b/drivers/mmc/host/mtk-sd.c
> > > @@ -1389,10 +1389,12 @@ static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> > >         struct msdc_host *host = mmc_priv(mmc);
> > >
> > >         spin_lock_irqsave(&host->lock, flags);
> > > -       if (enb)
> > > +       if (enb) {
> > >                 sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> > > -       else
> > > +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > > +       } else {
> > >                 sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> >
> > Rather than clearing SDC_CFG_SDIOIDE in the irq handler, you need to
> > do it here. As otherwise when the mmc core calls
> > host->ops->enable_sdio_irq() to disable the SDIO IRQ, it may stay
> > enabled.
> >
>
> Thank you for your review.
>
> I remove the spin lock in "__msdc_enable_sdio_irq" and add
> spin lock in "msdc_enable_sdio_irq". The modification of
> "__msdc_enable_sdio_irq" and "msdc_enable_sdio_irq" is as following.
>
> static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb)
> {
>         if (enb) {
>                 sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
>                 sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
>         } else {
>                 sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
>                 sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
>         }
> }
>
> static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> {
>         unsigned long flags;
>         struct msdc_host *host = mmc_priv(mmc);
>         spin_lock_irqsave(&host->lock, flags);;
>         __msdc_enable_sdio_irq(host, enb);
>         spin_unlock_irqrestore(&host->lock, flags);
>
>         if (enb)
>                 pm_runtime_get_noresume(host->dev);
>         else
>                 pm_runtime_get_noidle(host->dev);
> }
>
> > > +       }
> > >         spin_unlock_irqrestore(&host->lock, flags);
> > >  }
> > >
> > > @@ -1422,6 +1424,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
> > >                 spin_lock_irqsave(&host->lock, flags);
> > >                 events = readl(host->base + MSDC_INT);
> > >                 event_mask = readl(host->base + MSDC_INTEN);
> > > +               if ((events & event_mask) & MSDC_INT_SDIOIRQ)
> > > +                       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> >
> > As stated above, I suggest you move this into __msdc_enable_sdio_irq()
> > and thus call that function from here instead. Well, that doesn't work
> > as is, because of the spin lock, so you rather need to make a
> > sub-function of __msdc_enable_sdio_irq, that don't take/releases the
> > lock.
> >
> > I hope that was clear. If not, I can post a patch to show you what I mean.
> >
>
> I also modify this part handler in msdc_irq.
>
>         spin_lock_irqsave(&host->lock, flags);
>         events = readl(host->base + MSDC_INT);
>         event_mask = readl(host->base + MSDC_INTEN);
>         if ((events & event_mask) & MSDC_INT_SDIOIRQ)
>                 __msdc_enable_sdio_irq(host, 0);
>         /* clear interrupts */
>         writel(events & event_mask, host->base + MSDC_INT);
>
>         mrq = host->mrq;
>         cmd = host->cmd;
>         data = host->data;
>         spin_unlock_irqrestore(&host->lock, flags);
>
>         if ((events & event_mask) & MSDC_INT_SDIOIRQ)
>                 sdio_signal_irq(host->mmc);
>
> I also will add spin lock in the "msdc_ack_sdio_irq".
>
> Looking forward to your suggestions.

Seems reasonable, please post a new version, then I will review again.

[...]

Kind regards
Uffe
