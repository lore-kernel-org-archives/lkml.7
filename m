Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8A7C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEEE21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYoUYWIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390979AbfEXLLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:11:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46536 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390865AbfEXLLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:11:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id o11so274309pgm.13;
        Fri, 24 May 2019 04:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7J3y/fRv6XMK7gAKFuZ39eh40Af0wWeNJ4E0Zu6iH0=;
        b=HYoUYWIh3uxH3NcvCusp33T+XJZGa3fl3oPvO7fB2blpt4QwpbEZ766Q6PdGDR/jo0
         6aSBiNvJpU5mDgahFRvLB9LBIE2cUeHXTyFTHszceQw8jfChjmoT29ycbO6G4mLcjkFM
         pHmIEiwTY7vIw5+kqnuhBDwVnP5a0U+mlm3P/Z74RJ6ALUTXP6fXK8OpIH9JE+0F4oEp
         UMbXXoMwNDDjUD4OvuQVRdpp07ivomZNl79TGq401M3SdkdgZKlsxtTzM6YfVwppXTC0
         aPua41Z1j5GWqWXGUY7VMsobwPUDzDvp/uzkRzVojgE11zv26SIUT8a71z36yQBTprjB
         U8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7J3y/fRv6XMK7gAKFuZ39eh40Af0wWeNJ4E0Zu6iH0=;
        b=mHLV9fA11ZNU+paXL2N30QMK3/hfDBpooKjUHTBPhu02JGkkB7CjVD1nRWHwnYxnE7
         8h7AgAe4NKECFlMHYG6krBPXSXLEYcieL5cPCU3h/FzCh3a65Ivpp/wIiCsaRpkJgFTk
         6cE60Me17zMlVjCnmiO1WNL9LFa5LaPq6b52IlQpStD22AW0njU5OzCEVPpGDvwOSpdw
         33HE01UcwSIgN3AUggo5yKKj5woRvitZKQmnqiZMkzmqVMxwhsV9aExkAnSqo925mkd/
         JSglaXmVNILGextcuQtX0PhubGIw2cttWB3ERjQaqNB9YCfp06Ho5OlPKTk3VY3RVV6r
         5NtQ==
X-Gm-Message-State: APjAAAVVa+HM5hyMJmTqWoXnyKG4G2Fy9Py6JQsIcUxXaNo+dWy7PZKu
        rz5kUJYSapQGvMaYCNrjpt3SfKcuiiVzMROISW1yfVttl5s=
X-Google-Smtp-Source: APXvYqzYyUtbyEanugU1hCluTgnfxJNvdrqZABRyTDBTH6kPu9nHnVaBSweAUERuV3/ZxPF8YN2yIXwMP9HRBBhe+Vg=
X-Received: by 2002:a63:4d0b:: with SMTP id a11mr16877570pgb.74.1558696275115;
 Fri, 24 May 2019 04:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190524094825.16151-1-sr@denx.de> <20190524102002.GT2781@lahna.fi.intel.com>
In-Reply-To: <20190524102002.GT2781@lahna.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 May 2019 14:11:04 +0300
Message-ID: <CAHp75VcMVrYv1MXmmqE9fDXShS=Y8pPdWZ4f1neo=ne88TLZDg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] serial: mctrl_gpio: Check if GPIO property exisits
 before requesting it
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Stefan Roese <sr@denx.de>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 1:21 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Fri, May 24, 2019 at 11:48:24AM +0200, Stefan Roese wrote:
> > This patch adds a check for the GPIOs property existence, before the
> > GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> > support is added (2nd patch in this patch series) on x86 platforms using
> > ACPI.
> >
> > Here Mika's comments from 2016-08-09:
> >
> > "
> > I noticed that with v4.8-rc1 serial console of some of our Broxton
> > systems does not work properly anymore. I'm able to see output but input
> > does not work.
> >
> > I bisected it down to commit 4ef03d328769eddbfeca1f1c958fdb181a69c341
> > ("tty/serial/8250: use mctrl_gpio helpers").
> >
> > The reason why it fails is that in ACPI we do not have names for GPIOs
> > (except when _DSD is used) so we use the "idx" to index into _CRS GPIO
> > resources. Now mctrl_gpio_init_noauto() goes through a list of GPIOs
> > calling devm_gpiod_get_index_optional() passing "idx" of 0 for each. The
> > UART device in Broxton has following (simplified) ACPI description:
> >
> >     Device (URT4)
> >     {
> >         ...
> >         Name (_CRS, ResourceTemplate () {
> >             GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
> >                     "\\_SB.GPO0", 0x00, ResourceConsumer)
> >             {
> >                 0x003A
> >             }
> >             GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
> >                     "\\_SB.GPO0", 0x00, ResourceConsumer)
> >             {
> >                 0x003D
> >             }
> >         })
> >
> > In this case it finds the first GPIO (0x003A which happens to be RX pin
> > for that UART), turns it into GPIO which then breaks input for the UART
> > device. This also breaks systems with bluetooth connected to UART (those
> > typically have some GPIOs in their _CRS).
> >
> > Any ideas how to fix this?
> >
> > We cannot just drop the _CRS index lookup fallback because that would
> > break many existing machines out there so maybe we can limit this to
> > only DT enabled machines. Or alternatively probe if the property first
> > exists before trying to acquire the GPIOs (using
> > device_property_present()).
> > "
> >
> > This patch implements the fix suggested by Mika in his statement above.
> >

We have a board where ASL provides _DSD for CTS and RxD pins.
I'm afraid this won't work on it.

Basically we need to understand the use of the GPIOs in UART. In our
case it's an out-of-band wake up source for UART.
Simply requiring GPIOs to be present is not enough.

Perhaps property like 'modem-control-gpio-in-use' (this seems a bad
name, given for sake of example).

> > Signed-off-by: Stefan Roese <sr@denx.de>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>



-- 
With Best Regards,
Andy Shevchenko
