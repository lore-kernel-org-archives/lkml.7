Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E3FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0102081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dl+Cv1Fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392956AbfIFJmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:42:55 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38187 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392945AbfIFJmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:42:55 -0400
Received: by mail-vk1-f196.google.com with SMTP id s72so1138995vkh.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 02:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1acCT3X7tahrzO0L0DdB9ZLq6w38Z+JmFcSM24mK7gU=;
        b=Dl+Cv1FsD3JojHuch2qrIjEqwKrSdME9y6y5p4FKULS1447tAXv+N5n8QBCKSk7exo
         qq6S8R51npw9Nq1kCNNhv/wkiY0tH++EyjezwDZhwlXI8wv2OABEyOKgNCJMftGqMbLG
         pcb+KYbPbqyZKveh+sR7lfItYtKN801JxTv232y/G6lp4g5NBd/yG36TrNuH4G1gms2g
         diarmAyUx5Zf0NaKooUnFAxHqCfGeQOP7lojj9JMR8j+EW4YAe7S5+u14BfNpWgtEgxk
         VrV/IDYHGPHoUhQzDs3P5aRLGvS/G3DvV++PROjE7nYdtYrzIR4zk6negQJU0U0QRsJf
         nXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1acCT3X7tahrzO0L0DdB9ZLq6w38Z+JmFcSM24mK7gU=;
        b=sgEo30fWjAqIxgkP/dzgY49dvE6mnsq8SlPYaPDrF8h8S5SRG+W7nTmJy2LeWgi2BT
         7tECDQLROeoarLaK3a4FfRhidBji6cU3hTVyPM/elYWXtxTH/ytfW99ZKaG/KEQqxp/7
         5biKEdAumgnnhUOdsvZf0yYBeYKOnaG/vxsjp3GAJL0GFGoczXckwo4FNEJd3iB6HtsB
         arj4+2NMPRM5W1G/BQTMNNUVWAlKR3qwIrCGJ1/x07mtWzmC8MgLUOpz2kMtcstVupfU
         WExUPEqWKOX+Q1wObXp0SYprQLTb7z6RFCeYMzNyQhCxz0ArZWtNZMqSpMzV5Y7sgonN
         yMuQ==
X-Gm-Message-State: APjAAAUS2YKDmXXQflCCWDeEbbb6ebdcLS+I76IeDHDyQrJczeJcnJ9/
        yva/YbQ7P7sM0pFAxZYCt+yHZ6xs0oaekhN/NdTASQ==
X-Google-Smtp-Source: APXvYqzx8L7Fpi5zs4PG0KwsoVFBDYRFCL3teSoqezc8aYLJQfevyVucnbioxTQO5WHHaHGTx8G6pUdvtuNHId77dq0=
X-Received: by 2002:a1f:5602:: with SMTP id k2mr3606760vkb.36.1567762973650;
 Fri, 06 Sep 2019 02:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-9-ulf.hansson@linaro.org>
 <20190905184337.GA133864@google.com>
In-Reply-To: <20190905184337.GA133864@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Sep 2019 11:42:17 +0200
Message-ID: <CAPDyKFqL1vQR2MG1hAX-Fs53E19k0R9k86RBKMu1B2o2wSBkNw@mail.gmail.com>
Subject: Re: [PATCH 08/11] mmc: core: Fixup processing of SDIO IRQs during
 system suspend/resume
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019 at 20:43, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Tue, Sep 03, 2019 at 04:22:04PM +0200, Ulf Hansson wrote:
> > System suspend/resume of SDIO cards, with SDIO IRQs enabled and when using
> > MMC_CAP2_SDIO_IRQ_NOTHREAD is unfortunate still suffering from a fragile
> > behaviour. Some problems have been taken care of so far, but more issues
> > remains.
> >
> > For example, calling the ->ack_sdio_irq() callback to let host drivers
> > re-enable the SDIO IRQs is a bad idea, unless the IRQ have been consumed,
> > which may not be the case during system suspend/resume. This may lead to
> > that a host driver re-signals the same SDIO IRQ over and over again,
> > causing a storm of IRQs and gives a ping-pong effect towards the
> > sdio_irq_work().
> >
> > Moreover, calling the ->enable_sdio_irq() callback at system resume to
> > re-enable already enabled SDIO IRQs for the host, causes the runtime PM
> > count for some host drivers to become in-balanced. This then leads to the
> > host to remain runtime resumed, no matter if it's needed or not.
> >
> > To fix these problems, let's check if process_sdio_pending_irqs() actually
> > consumed the SDIO IRQ, before we continue to ack the IRQ by invoking the
> > ->ack_sdio_irq() callback.
> >
> > Additionally, there should be no need to re-enable SDIO IRQs as the host
> > driver already knows if they were enabled at system suspend, thus also
> > whether it needs to re-enable them at system resume. For this reason, drop
> > the call to ->enable_sdio_irq() during system resume.
> >
> > In regards to these changes there is yet another issue, which is when there
> > is an SDIO IRQ being signaled by the host driver, but after the SDIO card
> > has been system suspended. Currently these IRQs are just thrown away, while
> > we should at least make sure to try to consume them when the SDIO card has
> > been system resumed. Fix this by calling sdio_signal_irq() after system
> > resumed the SDIO card.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/core/sdio.c     | 2 +-
> >  drivers/mmc/core/sdio_irq.c | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> > index c557f1519b77..3114d496495a 100644
> > --- a/drivers/mmc/core/sdio.c
> > +++ b/drivers/mmc/core/sdio.c
> > @@ -1015,7 +1015,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
> >               if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
> >                       wake_up_process(host->sdio_irq_thread);
> >               else if (host->caps & MMC_CAP_SDIO_IRQ)
> > -                     host->ops->enable_sdio_irq(host, 1);
> > +                     sdio_signal_irq(host);
>
> You could possibly limit this to cards that remain powered during
> suspend, but doing it always should do no harm.

Good point. That's actually why I included the change in patch7 ("mmc:
core: WARN if SDIO IRQs are enabled for non-powered card in suspend")

In principle it means that host->sdio_irqs must not be greater than 0,
if the card isn't powered.

Hmm, perhaps we should convert the WARN to return an error code
instead, just to be really safe. What do you think?

>
> >       }
> >
> >  out:
> > diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> > index d7965b53a6d2..900871073bd7 100644
> > --- a/drivers/mmc/core/sdio_irq.c
> > +++ b/drivers/mmc/core/sdio_irq.c
> > @@ -115,7 +115,8 @@ static void sdio_run_irqs(struct mmc_host *host)
> >       mmc_claim_host(host);
> >       if (host->sdio_irqs) {
> >               process_sdio_pending_irqs(host);
> > -             host->ops->ack_sdio_irq(host);
> > +             if (!host->sdio_irq_pending)
> > +                     host->ops->ack_sdio_irq(host);
> >       }
> >       mmc_release_host(host);
> >  }
>
> I'm by no means a SDIO expert, but as far as I can tell this looks
> good. I verified that this patch fixes a problem with SDIO interrupts
> that are ignored while suspending.
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Thanks, I add your tested by tag as well!

Kind regards
Uffe
