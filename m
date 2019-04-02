Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BAEC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B621B20830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Gz5di+vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfDBIJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:09:12 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54958 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfDBIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:09:11 -0400
Received: by mail-it1-f193.google.com with SMTP id a190so2127192ite.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cD6a2K0R+OeE9cLnlIxDmzz+nzRzszf7+31cO/GFuy4=;
        b=Gz5di+vyz7Rzaaq/nO2DsTK6DmVt2KY9xsbWHtkmhtrcDdkJBx/sC+jFJ2gzfkgoW7
         VpLrCIKI/541snMkUdKu3kamG+3kA2jQ4bNIcEMkLBfY4R49srz2EJsllv11RmvsH1va
         AOCY7GaADhVaCk2ABt9puUHQiro4mfQQxrZjyM2HBUTyMZuEHH0bvvIuRG4/6mkj4bMV
         rnF54ikmmE4mq/qtrO2DpmdN+0OnMNO2bJJ9PjILylnY+AtDz1dJ14Txsm6t0akMCEDx
         H0k9LgAuSKUHKxzdbh/hNo4X9wc4ajV3F7VnMKchry/1tLP29dY+7FBLMS9nGKon3VPS
         vI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cD6a2K0R+OeE9cLnlIxDmzz+nzRzszf7+31cO/GFuy4=;
        b=p6TEMNRB0edAFTDwQxQv2ppBUtvJb9MwJV5hk1aXdG/w22kEH6J1k4OdVAHcIvWtYX
         ADOWES7GpN0onUdQgN2juHsZlvHrTQD94TgdxuPauPRWn2INKW6gi8h5vYfJDUy5dZ1k
         YiKtI3OsFq6GhzD39O/hEpM9S36Rxuk1CztG8SsuiKZZiGQZRSsI7B8DqSrEUVMtzbxw
         BPWqE/JhU9ioaWiykCVGQV5zu2+eT5Ky4f2cfgLjnsfzqoFoUd+TRNaV1KoH+whaPl3T
         yCOCK8yv/Ti0S9JvjkKLmj2KzrYbt86VmAOHf1V54MN7/Iid3n2FSbZyFFiXC+7+Q4Is
         Dy2Q==
X-Gm-Message-State: APjAAAWQEX2xf0PfCWiY3lkyt/Zuh8sF6t7aecDSijX6u+bkvX7xj35o
        UjhD8Ooe2onEQMotWXjuqPQd969lW4GYa6H8CmllbQ==
X-Google-Smtp-Source: APXvYqy0eZMNo06yef6TrYzI9y6Rz3I8sLG8rH5e3O+XqFQpGaWnHXgVI3L60tO7P1s7AYh5gS8xAEM8nur+jnF1zrk=
X-Received: by 2002:a02:b053:: with SMTP id q19mr27544086jah.21.1554192550730;
 Tue, 02 Apr 2019 01:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190318174228.18194-1-brgl@bgdev.pl> <20190318174228.18194-6-brgl@bgdev.pl>
 <20190402074103.GG4187@dell>
In-Reply-To: <20190402074103.GG4187@dell>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 2 Apr 2019 10:08:59 +0200
Message-ID: <CAMRc=Mekomya5A_tj3RKSeno1EaBoGNAFJajPfyB1cHP7c+L6w@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 05/11] mfd: core: document mfd_add_devices()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 2 kwi 2019 o 09:41 Lee Jones <lee.jones@linaro.org> napisa=C5=82(a):
>
> On Mon, 18 Mar 2019, Bartosz Golaszewski wrote:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add a kernel doc for mfd_add_devices().
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/mfd/mfd-core.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index 94e3f32ce935..0898a8db1747 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -269,6 +269,20 @@ static int mfd_add_device(struct device *parent, i=
nt id,
> >       return ret;
> >  }
> >
> > +/**
> > + * mfd_add_devices - register a set of child devices
>
> "register child devices"
>
> > + *
> > + * @parent: Parent device for all sub-nodes.
> > + * @id: Platform device id. If >=3D 0, each sub-device will have its c=
ell_id
> > + *      added to this number and use it as the platform device id.
> > + * @cells: Array of mfd cells describing sub-devices.
> > + * @n_devs: Number of sub-devices to register.
> > + * @mem_base: Parent register range resource for sub-devices.
> > + * @irq_base: Base of the range of virtual interrupt numbers allocated=
 for
> > + *            this MFD device. Unused if @domain is specified.
> > + * @domain: Interrupt domain used to create mappings for HW interrupt =
numbers
> > + *          specificed in sub-devices' IRQ resources.
>
> Spelling.
>
> > + */
> >  int mfd_add_devices(struct device *parent, int id,
> >                   const struct mfd_cell *cells, int n_devs,
> >                   struct resource *mem_base,
>
> How about this:
>
> /**
>  * mfd_add_devices - register child devices
>  *
>  * @parent:     Pointer to parent device.
>  * @id:         Can be PLATFORM_DEVID_AUTO to let the Platform API take c=
are
>  *              of device numbering, or will be added to a device's cell_=
id.
>  * @cells:      Array of (struct mfd_cell)s describing child devices.
>  * @n_devs:     Number of child devices to register.
>  * @mem_base:   Parent register range resource for child devices.
>  * @irq_base:   Base of the range of virtual interrupt numbers allocated =
for
>  *              this MFD device. Unused if @domain is specified.
>  * @domain:     Interrupt domain to create mappings for hardware interrup=
ts.
>  */
>

Sure, looks good to me.

FYI the latest version of this series is v7, but the mfd driver didn't
change since v6.

Bart
