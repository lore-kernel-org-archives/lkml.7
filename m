Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990C8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5D020815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWeN8FfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfCDOJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:09:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42067 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfCDOJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:09:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so5689505wrg.9;
        Mon, 04 Mar 2019 06:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nN/HouzY1Flz0hUlrqZq76NzSUguswjwokKqk+UDjrY=;
        b=PWeN8FfKA53N1mZ8qKYZTUfrYQLWDi+/alwe4KG7FlD/YmLmOA0AR/el9Il5nfS/SH
         1XpLIOU5bFsVHxco0DsyZF9G+j3f68TxDsPo//FoguHCykXISwkF+T2myDj78SyIakMG
         G4IT/LeHruhMH7f1ZGNYfeCvBIK4Q5hhuVE90EfYlw4fi8KDAtVeqe0RQvklqeFtHplK
         nJ/94tmwMvd6///jjbios5JlXP4cgVHLb7xoGWF192oOBJDe8uRJ13gdlUUSYXK27kYo
         YQm09pgAHyFXusFCxWptw5dR9EdtKwZLFmtJQF/CMt8fSy6UevoK0cJu+yINf/W4Rm+3
         QXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nN/HouzY1Flz0hUlrqZq76NzSUguswjwokKqk+UDjrY=;
        b=pdxkHbUMam1EpbZ+71gRvTkngaYbHB2pCUfx6uuWZNzRkkODn3Ju6W0v9iUxf07gW6
         hA+hEPaSU4dkY8uFayFoIBvN5tpraCTLhXAY7G79ObQ+hKab+JHUlKk2wl2YXO92q/SV
         9cFXB5oI5ExHknv2bKgW6HyOMvnir+sPh55/fKnUmZC+QbFy+94GxteLoyurVEFyha+Z
         s8Sa+wulbHxZtIsV6smQFtczTNh3bbNrydjQspQl4U9s2l/gm3R0fJ4y2z9ZhzjeYQ4+
         lRvf2dok7++zVXFlFyRP2gflxS0aIacnf6Rt2IzdP2P5pl44vYQw0xfOOcna2ZRJw1nY
         JIOQ==
X-Gm-Message-State: APjAAAVHczqkIP1uzHqgH+BqRbVNriC2+/v8EAwEOAZ1ypQphRvYoN36
        t1GfvpxaOpOIpX0k2Rbd6Cqjt91dlRCfZcN15KA=
X-Google-Smtp-Source: APXvYqzoCOdC5LJTLGJu0zpc+6GKgd7bxxxwD7bjDRYP+7udgDhhQ9Q3Uw3tzG+uSIH9EstmB/NXLd5CwxXMyLLhWd0=
X-Received: by 2002:a5d:4711:: with SMTP id y17mr13554464wrq.141.1551708586530;
 Mon, 04 Mar 2019 06:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20190203094233.12177-1-hdegoede@redhat.com> <CAHp75Veb-QarB-9mQtNWcrL5qr0-ZeXwgscBeS-O-=cgpOjE_w@mail.gmail.com>
In-Reply-To: <CAHp75Veb-QarB-9mQtNWcrL5qr0-ZeXwgscBeS-O-=cgpOjE_w@mail.gmail.com>
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
Date:   Mon, 4 Mar 2019 16:09:18 +0200
Message-ID: <CAKErNvpXbqOzQRogHEyEnS1WHmJ005YemB33bL54Jx6QDBKHrg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_int0002_vgpio: Only implement
 irq_set_wake on Bay Trail
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 8:20 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Feb 3, 2019 at 11:42 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Commit c3b8e884defa ("platform/x86: intel_int0002_vgpio: Implement
> > irq_set_wake"), was written to fix some wakeup issues on Bay Trail (BYT)
> > devices.
> >
> > We've received a bug report that this causes a suspend regression on some
> > Cherry Trail (CHT) based devices.
> >
> > To fix the issues this causes on CHT devices, this commit modifies the
> > irq_set_wake support so that we only implement irq_set_wake on BYT devices,
> >
>
> Pushed to my review and testing queue, thanks!

Kernel 5.0 was released without this patch, is it still planned to merge it?

> > Fixes: c3b8e884defa ("platform/x86: intel_int0002_vgpio: ... irq_set_wake")
> > Reported-and-tested-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/platform/x86/intel_int0002_vgpio.c | 32 ++++++++++++++++++----
> >  1 file changed, 26 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
> > index 4b8f7305fc8a..78787934b572 100644
> > --- a/drivers/platform/x86/intel_int0002_vgpio.c
> > +++ b/drivers/platform/x86/intel_int0002_vgpio.c
> > @@ -51,11 +51,14 @@
> >  #define GPE0A_STS_PORT                 0x420
> >  #define GPE0A_EN_PORT                  0x428
> >
> > -#define ICPU(model)    { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> > +#define BAYTRAIL                       0x01
> > +#define CHERRYTRAIL                    0x02
> > +
> > +#define ICPU(model, data) { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, data}
> >
> >  static const struct x86_cpu_id int0002_cpu_ids[] = {
> > -       ICPU(INTEL_FAM6_ATOM_SILVERMONT),       /* Valleyview, Bay Trail  */
> > -       ICPU(INTEL_FAM6_ATOM_AIRMONT),          /* Braswell, Cherry Trail */
> > +       ICPU(INTEL_FAM6_ATOM_SILVERMONT, BAYTRAIL), /* Valleyview, Bay Trail  */
> > +       ICPU(INTEL_FAM6_ATOM_AIRMONT, CHERRYTRAIL), /* Braswell, Cherry Trail */
> >         {}
> >  };
> >
> > @@ -135,7 +138,7 @@ static irqreturn_t int0002_irq(int irq, void *data)
> >         return IRQ_HANDLED;
> >  }
> >
> > -static struct irq_chip int0002_irqchip = {
> > +static struct irq_chip int0002_byt_irqchip = {
> >         .name                   = DRV_NAME,
> >         .irq_ack                = int0002_irq_ack,
> >         .irq_mask               = int0002_irq_mask,
> > @@ -143,10 +146,22 @@ static struct irq_chip int0002_irqchip = {
> >         .irq_set_wake           = int0002_irq_set_wake,
> >  };
> >
> > +static struct irq_chip int0002_cht_irqchip = {
> > +       .name                   = DRV_NAME,
> > +       .irq_ack                = int0002_irq_ack,
> > +       .irq_mask               = int0002_irq_mask,
> > +       .irq_unmask             = int0002_irq_unmask,
> > +       /*
> > +        * No set_wake, on CHT the IRQ is typically shared with the ACPI SCI
> > +        * and we don't want to mess with the ACPI SCI irq settings.
> > +        */
> > +};
> > +
> >  static int int0002_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev = &pdev->dev;
> >         const struct x86_cpu_id *cpu_id;
> > +       struct irq_chip *irq_chip;
> >         struct gpio_chip *chip;
> >         int irq, ret;
> >
> > @@ -195,14 +210,19 @@ static int int0002_probe(struct platform_device *pdev)
> >                 return ret;
> >         }
> >
> > -       ret = gpiochip_irqchip_add(chip, &int0002_irqchip, 0, handle_edge_irq,
> > +       if (cpu_id->driver_data == BAYTRAIL)
> > +               irq_chip = &int0002_byt_irqchip;
> > +       else
> > +               irq_chip = &int0002_cht_irqchip;
> > +
> > +       ret = gpiochip_irqchip_add(chip, irq_chip, 0, handle_edge_irq,
> >                                    IRQ_TYPE_NONE);
> >         if (ret) {
> >                 dev_err(dev, "Error adding irqchip: %d\n", ret);
> >                 return ret;
> >         }
> >
> > -       gpiochip_set_chained_irqchip(chip, &int0002_irqchip, irq, NULL);
> > +       gpiochip_set_chained_irqchip(chip, irq_chip, irq, NULL);
> >
> >         return 0;
> >  }
> > --
> > 2.20.1
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
