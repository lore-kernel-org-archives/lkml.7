Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB37FC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C4A25E1D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I+3FK4aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfE3RMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:12:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42646 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfE3RMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:12:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id y15so3596664ljd.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MS5GP2o2j4MsC3xAnq76TY5vOFimmYu19QXyMMf8qfw=;
        b=I+3FK4aj0Fg1tAEydAQR8SHs+eyiemP/kh4Ui4TUSOyoCl8TAnL5EDjK+ZyNBjzZdf
         /GKl0riIOey/Ok/ms7KAoxIWmCrqBKTyp37mJa9EyzaZF9ayVr4Ph0cVj7nWEevxvmSW
         8S8guVC4+pHCX906HYRdZyAEbKCE3xVvVQXjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MS5GP2o2j4MsC3xAnq76TY5vOFimmYu19QXyMMf8qfw=;
        b=VDj4HXs8ATqMi5FTxLANGw51lnSGeJB/Txxk4jatMDsNPm9rUIB+aHinSa5bKaJoiZ
         +gRfpEIdhDjkcSdg4p86dWerH/gEUR4peVImUgyY5j8+CoNTr4OLM6ndmbrKRb3zmoch
         0JuwuYnQDg7i+kele3yvYlsbJPXaL0C0XtHbQhPObZktEFmj3amXHqshm+cTn6/8v2Xn
         5H9TXNTnoZZO1OLwBceoUi6gWm9YinTxqMm+gFeznjkd66E3Arz500qOZxo+TAzml+ht
         8CpzJ3N1pO74J2kctF3W3Ff4VBtRRb2fLOG7TE2UwG5vq8X0dzyJWCwtFg3tm1HBNvnk
         k5Xw==
X-Gm-Message-State: APjAAAU3UVynruR4djGh2N45dfA0K24EHPfkWBvVy1PTM5RY1GH5fjVz
        +HaAP1olNHLm2+cwcw6T6Z0qS9HX1CE=
X-Google-Smtp-Source: APXvYqzltib1O9+O3d/GyXHh2CMugrzT61z3P6HAnLKFPeZWn7adMDoVTlk2ptOJ3YCj2b28PCI1Iw==
X-Received: by 2002:a2e:574d:: with SMTP id r13mr2651449ljd.104.1559236365235;
        Thu, 30 May 2019 10:12:45 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id i1sm585563lfc.86.2019.05.30.10.12.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 10:12:41 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id e13so6767824ljl.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:12:41 -0700 (PDT)
X-Received: by 2002:a2e:86da:: with SMTP id n26mr2735865ljj.212.1559236360161;
 Thu, 30 May 2019 10:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190429035515.73611-1-drinkcat@chromium.org> <20190429035515.73611-3-drinkcat@chromium.org>
 <155778659317.14659.136626364818483852@swboyd.mtv.corp.google.com>
 <CANMq1KBMd7eR3dP=V9gJ6G4OgE6DsXad_gzvuNJ25_pee4+6eg@mail.gmail.com>
 <155786487644.14659.17142525593824613967@swboyd.mtv.corp.google.com> <CANMq1KCNzn-5sYJZGivUedsNaQfVW_MjgDZn27W6sz8Fk3beNA@mail.gmail.com>
In-Reply-To: <CANMq1KCNzn-5sYJZGivUedsNaQfVW_MjgDZn27W6sz8Fk3beNA@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 30 May 2019 10:12:03 -0700
X-Gmail-Original-Message-ID: <CAE=gft6jxR9Lt7tLwm6VKy9_shMVW7wf3g6rBGEqtB7oNH0hUA@mail.gmail.com>
Message-ID: <CAE=gft6jxR9Lt7tLwm6VKy9_shMVW7wf3g6rBGEqtB7oNH0hUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: mediatek: Update cur_mask in mask/mask ops
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 1:05 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Wed, May 15, 2019 at 4:14 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Nicolas Boichat (2019-05-13 18:37:58)
> > > On Tue, May 14, 2019 at 6:29 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > Quoting Nicolas Boichat (2019-04-28 20:55:15)
> > > > > During suspend/resume, mtk_eint_mask may be called while
> > > > > wake_mask is active. For example, this happens if a wake-source
> > > > > with an active interrupt handler wakes the system:
> > > > > irq/pm.c:irq_pm_check_wakeup would disable the interrupt, so
> > > > > that it can be handled later on in the resume flow.
> > > > >
> > > > > However, this may happen before mtk_eint_do_resume is called:
> > > > > in this case, wake_mask is loaded, and cur_mask is restored
> > > > > from an older copy, re-enabling the interrupt, and causing
> > > > > an interrupt storm (especially for level interrupts).
> > > > >
> > > > > Instead, we just record mask/unmask changes in cur_mask. This
> > > > > also avoids the need to read the current mask in eint_do_suspend,
> > > > > and we can remove mtk_eint_chip_read_mask function.
> > > > >
> > > > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > >
> > > > It looks an awful lot like you should just use IRQCHIP_MASK_ON_SUSPEND
> > > > here. Isn't that what's happening? All non-wake irqs should be masked at
> > > > the hardware level so they can't cause a wakeup during suspend and on
> > > > resume they can be unmasked?
> > >
> > > No, this is for an line that has both wake and interrupt enabled. To
> > > reword the commit message above:
> >
> > Is my understanding correct that there isn't a different "wake up"
> > register that can be written to cause a GPIO to be configured to wake
> > the system from suspend? The only way to do so is to leave the GPIO
> > unmasked in the hardware by having EINT_EN[irq] = 1? And thus any
> > interrupts that we don't want to wake us up during suspend should be
> > masked in the hardware?
>
> Yes, that's my understanding as well.
>
> And then, what this driver does is to emulate the behaviour of a
> controller that would actually have separate irq and wake enable
> registers.
>
> > If that's true, the code here that's trying to keep track of enabled
> > irqs and wakeup enabled irqs can be replaced with the irqchip flag so
> > that wakeup irqs are not masked while non-wakeups are masked.
>
> Correct, but with the caveat that I don't see anything that definitely
> requires an interrupt to be enabled to be a wake source. See below...
>
> >
> > >  1. cur_mask[irq] = 1; wake_mask[irq] = 1; EINT_EN[irq] = 1 (interrupt
> > > enabled at hardware level)
> > >  2. System suspends, resumes due to that line (at this stage EINT_HW
> > > == wake_mask)
> > >  3. irq_pm_check_wakeup is called, and disables the interrupt =>
> > > EINT_EN[irq] = 0, but we still have cur_mask[irq] = 1
> > >  4. mtk_eint_do_resume is called, and restores EINT_EN = cur_mask, so
> > > it reenables EINT_EN[irq] = 1 => interrupt storm.
> > >
> > > This patch fixes the issue in step 3. So that the interrupt can be
> > > re-enabled properly later on, sometimes after mtk_eint_do_resume, when
> > > the driver is ready to handle it.
> >
> > Right, we'd rather not see irqchip drivers working around the genirq
> > layer to do these things like tracking cur_mask and wake_mask. That
> > leads to subtle bugs and makes the driver maintain state across the
> > irqchip callbacks and system suspend/resume.
> >
> > >
> > > Also, IRQCHIP_MASK_ON_SUSPEND does not handle lines that are enabled
> > > as a wake source, but without interrupt enabled (e.g. cros_ec driver
> > > does that), which we do want to support.
> >
> > Hmm. I thought that even if the irq is disabled by a driver, that would
> > be a lazy disable so it isn't really masked in the hardware. Then if an
> > interrupt comes in during suspend on a wake configured irq line, the
> > hardware will have left it unmasked because IRQCHIP_MASK_ON_SUSPEND in
> > combination with lazy disable would mean that the line is left unmasked
> > (ignoring whatever this mediatek driver is doing to mask and unmask in
> > PM hooks).
>
> At the very least, that's not what happens with this system. The
> interrupt is definitely not kept enabled in suspend, and the system
> would not wake from an EC interrupt. (see also this series, BTW:
> https://patchwork.kernel.org/cover/10921121/).
>
> > Just reading Documentation/power/suspend-and-interrupts.txt I'm led to
> > believe that the cros_ec driver shouldn't call disable_irq() on the
> > interrupt if it wants to wakeup from it:
> >
> > "Calling enable_irq_wake() causes suspend_device_irqs() to treat the
> > given IRQ in a special way.  Namely, the IRQ remains enabled, by on the
> > first interrupt it will be disabled, marked as pending and "suspended"
> > so that it will be re-enabled by resume_device_irqs() during the
> > subsequent system resume.  Also the PM core is notified about the event
> > which causes the system suspend in progress to be aborted (that doesn't
> > have to happen immediately, but at one of the points where the suspend
> > thread looks for pending wakeup events)."
>
> I think this describes the behaviour when you keep both enabled.
>
> > I suppose the problem is an irq line disabled in hardware that has
> > wakeup armed on it? Is this even valid? Shouldn't an irq be enabled for
> > wakeup to work?
>
> I couldn't really find a definite answer, but there are a bunch of
> examples of other drivers in the kernel:
>  - drivers/extcon/extcon-usb-gpio.c:usb_extcon_suspend
>  - drivers/hid/i2c-hid/i2c-hid.c:i2c_hid_suspend
>  - drivers/mfd/max77843.c:max77843_suspend
> (not exhaustive, this is quite hard to grep for...)
>
> > We could immediately unmask those lines in the hardware when the
> > set_wake() callback is called. That way the genirq layer can use the
> > driver to do what it wants with the hardware and the driver can make
> > sure that set_wake() will always cause the wakeup interrupt to be
> > delivered to genirq even when software has disabled it.
> >
> > But I think that there might be a problem with how genirq understands
> > the masked state of a line when the wakeup implementation conflates
> > masked state with wakeup armed state. Consider this call-flow:
> >
> >         irq masked in hardware, IRQD_IRQ_MASKED is set
> >         enable_irq_wake()
> >           unmask_irq in hardware
> >         IRQD_WAKEUP_ARMED is set
> >         <suspend and wakeup from irq>
> >         handle_level_irq()
> >           mask_ack_irq()
> >             mask_irq()
> >               if (irqd_irq_masked()) -> returns true and skips masking!
> >             if (desc->irq_data.chip->irq_ack)
> >               ...
> >           irq_may_run()
> >             irq_pm_check_wakeup()
> >               irq_disable()
> >                 mask_irq() -> does nothing again
> >
> > In the above flow, we never mask the irq because we thought it was
> > already masked when it was disabled, but the irqchip implementation
> > unmasked it to make wakeup work. Maybe we should always mask the irq if
> > wakeup is armed and we're trying to call mask_irq()? Looks hacky.
> >
> > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > index 51128bea3846..20257d528880 100644
> > --- a/kernel/irq/chip.c
> > +++ b/kernel/irq/chip.c
> > @@ -411,7 +411,7 @@ static inline void mask_ack_irq(struct irq_desc *desc)
> >
> >  void mask_irq(struct irq_desc *desc)
> >  {
> > -       if (irqd_irq_masked(&desc->irq_data))
> > +       if (!irqd_is_wakeup_armed(&desc->irq_data) && irqd_irq_masked(&desc->irq_data))
> >                 return;
> >
> >         if (desc->irq_data.chip->irq_mask) {
>
> I'm... really not sure what's the best approach here. But basically,
> yes, if we can find a way to properly handle wake and interrupt
> behaviour for drivers with a single mask, that'd be good.
> IRQCHIP_MASK_ON_SUSPEND only seems to be doing half of the work, since
> it does not cover the disable+wake source case.
>
> Thanks,

I finally got around to studying this patch. This series seems okay to
me. The underlying problem is really that the hardware IRQ enabled
state is out of sync with what Linux thinks. This happens during
suspend because Linux thinks the irq is disabled, but due to the
hardware constraints on this platform, the interrupt has to be enabled
for it to be a wake source. So the mtk driver re-enables the
interrupt, and then has to find a way to get back in sync with Linux's
IRQ mask state.

One possible approach is mentioned above by Stephen: stop calling
disable_irq in the cros EC driver. Then both linux and mtk agree the
interrupt is enabled at suspend time. I think this ran into other
problems though, where the EC gets its interrupt but is unable to
silence it because the underlying SPI bus is still suspended.

The other approach, taken here, is to mask the interrupt when it first
comes in, getting Linux and mtk back in agreement that yes, the
interrupt is masked. Outside of enlightening the generic IRQ core
about these types of interrupts that need to get re-enabled to be wake
sources, this seems like a reasonable approach.
-Evan
