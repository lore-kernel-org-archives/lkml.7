Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC06C04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 01:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FCC2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 01:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cV8CDih8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfENBiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 21:38:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35451 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfENBiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 21:38:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id c15so9348781qkl.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 18:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwRPJV1ea5/fubxrHAnDt8q85ACTUpNCnRonfvDrwtQ=;
        b=cV8CDih8rYP1Q2P21ENTjW7+9KHarjnNarh3p+yta6mBnxR3GWMtJ+F9aPtbPrgmmG
         X+DiLrn5IlCaW7mpsL9/U0ujHeFG2aNeIn9QmS2ZUcIoDhQcUHCUg3kwoTnsR0XXvXwE
         FaEg81DlK47GL87NGWbxzH/nAjQTjMixtBP3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwRPJV1ea5/fubxrHAnDt8q85ACTUpNCnRonfvDrwtQ=;
        b=MqCPXD8Ufwc9Pc3NHXlykYUxCIoGlhFtFOHqQKMxryhU5n8he7BEEGEy95YLDOJHua
         nMIktnS4RnBfIcKsbTyWKbw22JkwpWtTeqC4W9Dif4z2/xHskAghA7JZof+urxmc+gcH
         ulm93WNeZTWZ/VlHde6Tz+spU9TR7C7njvQD6XBrmM0kKWQFCDM0i61shrIMialV3Je0
         JOag7lPcxKp2RTmyYknGqozjJcTEjs1SL4A+3nBkEM7RryiqhYexrtBBvCb6xgl0Zwnb
         H+hwEokwf9ksnmCf+eqzePiAraga7lnqaijQoaeS03xuhmVJrznoJ7qoEKwAtb1pe23y
         x9Zg==
X-Gm-Message-State: APjAAAW1p/OXmIlYGLZ+Ufi9rLsbuhSQdLMK8AoB+81uT8rQArqSp4Sw
        U76fZUYhkfUYCpjKBEKR9SiPNMNiyML6VG5NIZ1iEg==
X-Google-Smtp-Source: APXvYqzsJpqxHDJ2qevMSmT1HPJa1iHE7NRKTlyDxcyCq4T4aHwPxe7bd9ialVJHGfZ/iY2dzrt8lG7EoBq9Zw90IgI=
X-Received: by 2002:a37:2e05:: with SMTP id u5mr26568027qkh.124.1557797889779;
 Mon, 13 May 2019 18:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190429035515.73611-1-drinkcat@chromium.org> <20190429035515.73611-3-drinkcat@chromium.org>
 <155778659317.14659.136626364818483852@swboyd.mtv.corp.google.com>
In-Reply-To: <155778659317.14659.136626364818483852@swboyd.mtv.corp.google.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 14 May 2019 09:37:58 +0800
Message-ID: <CANMq1KBMd7eR3dP=V9gJ6G4OgE6DsXad_gzvuNJ25_pee4+6eg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: mediatek: Update cur_mask in mask/mask ops
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 6:29 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Nicolas Boichat (2019-04-28 20:55:15)
> > During suspend/resume, mtk_eint_mask may be called while
> > wake_mask is active. For example, this happens if a wake-source
> > with an active interrupt handler wakes the system:
> > irq/pm.c:irq_pm_check_wakeup would disable the interrupt, so
> > that it can be handled later on in the resume flow.
> >
> > However, this may happen before mtk_eint_do_resume is called:
> > in this case, wake_mask is loaded, and cur_mask is restored
> > from an older copy, re-enabling the interrupt, and causing
> > an interrupt storm (especially for level interrupts).
> >
> > Instead, we just record mask/unmask changes in cur_mask. This
> > also avoids the need to read the current mask in eint_do_suspend,
> > and we can remove mtk_eint_chip_read_mask function.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> It looks an awful lot like you should just use IRQCHIP_MASK_ON_SUSPEND
> here. Isn't that what's happening? All non-wake irqs should be masked at
> the hardware level so they can't cause a wakeup during suspend and on
> resume they can be unmasked?

No, this is for an line that has both wake and interrupt enabled. To
reword the commit message above:
 1. cur_mask[irq] = 1; wake_mask[irq] = 1; EINT_EN[irq] = 1 (interrupt
enabled at hardware level)
 2. System suspends, resumes due to that line (at this stage EINT_HW
== wake_mask)
 3. irq_pm_check_wakeup is called, and disables the interrupt =>
EINT_EN[irq] = 0, but we still have cur_mask[irq] = 1
 4. mtk_eint_do_resume is called, and restores EINT_EN = cur_mask, so
it reenables EINT_EN[irq] = 1 => interrupt storm.

This patch fixes the issue in step 3. So that the interrupt can be
re-enabled properly later on, sometimes after mtk_eint_do_resume, when
the driver is ready to handle it.

Also, IRQCHIP_MASK_ON_SUSPEND does not handle lines that are enabled
as a wake source, but without interrupt enabled (e.g. cros_ec driver
does that), which we do want to support.

> > diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
> > index 737385e86beb807..7e526bcf5e0b55c 100644
> > --- a/drivers/pinctrl/mediatek/mtk-eint.c
> > +++ b/drivers/pinctrl/mediatek/mtk-eint.c
> > @@ -113,6 +113,8 @@ static void mtk_eint_mask(struct irq_data *d)
> >         void __iomem *reg = mtk_eint_get_offset(eint, d->hwirq,
> >                                                 eint->regs->mask_set);
> >
> > +       eint->cur_mask[d->hwirq >> 5] &= ~mask;
> > +
> >         writel(mask, reg);
> >  }
> >
> > @@ -123,6 +125,8 @@ static void mtk_eint_unmask(struct irq_data *d)
> >         void __iomem *reg = mtk_eint_get_offset(eint, d->hwirq,
> >                                                 eint->regs->mask_clr);
> >
> > +       eint->cur_mask[d->hwirq >> 5] |= mask;
> > +
> >         writel(mask, reg);
> >
> >         if (eint->dual_edge[d->hwirq])
> > @@ -384,7 +375,6 @@ static void mtk_eint_irq_handler(struct irq_desc *desc)
> >
> >  int mtk_eint_do_suspend(struct mtk_eint *eint)
> >  {
> > -       mtk_eint_chip_read_mask(eint, eint->base, eint->cur_mask);
> >         mtk_eint_chip_write_mask(eint, eint->base, eint->wake_mask);
> >
>
>
> This alone looks like, write out the mask to only allow wake interrupts.

Yes, and enable wake interrupts that may not be in cur_mask.
