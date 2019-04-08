Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F7FC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A75921473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTGcX3vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDHNb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:31:58 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33523 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfDHNb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:31:57 -0400
Received: by mail-yw1-f67.google.com with SMTP id l5so4927014ywa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G9VPWjDU11pJOhL/2BMMgekm0GjE3j5AMoXdnY1fJ54=;
        b=OTGcX3vjyadq3eM401I8BejnBFwj5312peBFEwUUksVhW2XkiUO+1H3tGrah9hTqg1
         qediCgSu0auLc5yqRx6ZSuFmHBbqNn+ZgYu5h6cWZ5GSXOZ/x2NJXlY3Sy2dAcjV4Ovw
         h2Eztc5esVGAhhzpweI4IM3tixo/8NjkgkmTpWEw83T31AbQ2ASYeO/zpb57D3qA7L14
         vA+w46rtWrLeWLUGgxjxcGZQZMFiHERbZW7Ejj6A7DN0dC1p5mFhZeaY+jT14Yx39AUo
         0upMSyEwFTrhZRqr+tMwuvAFDhgDJ/B4apypbyFdAVeF5fzDpP3Q4DrEJuRkumtPRuLm
         1sgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G9VPWjDU11pJOhL/2BMMgekm0GjE3j5AMoXdnY1fJ54=;
        b=DWcWCnewH/pEMr+U/kT1SNjYDv9gjNLhAKu/cu7gkbeW1SQLRQaw3rwcOjJhU+Brp1
         B2SyKGvuXUP4MCdg+a3dPJxWLLltsK/UINyxX7EbdtCXduakOknOb/XmXgV/UqmoJ6H5
         rnd/HtWwjPTpvnj2mOk7HnGNXe0h08e5zcFmUNVQ9DBM5BXs8fCaIJIyO6iXYGOtETOf
         RsCnpRMV+T1kFt3MiBSpfdeYQxhCV5Oz6SWhyFUUR3xl0xV0LMxv6jpcHya2+vVE0kDX
         vslvqwOlbTo9XGHpRca1lREYkgbEit1yM0inR38LR0c7t4j5ssLXtsagHdNuLsw7UkBY
         wyyw==
X-Gm-Message-State: APjAAAV24ScIf6yibQtLCY+9TwxLyTzz7WO5nmw3PN+sNRLpzPOzYQhX
        biQrnjhwhmE3Klp27GseiqnGiYyMhCnIo+q6p+0spA==
X-Google-Smtp-Source: APXvYqw8GuYUJgZmZMJgIxYv5LbC6THoBH5c9f0dJ/Usb5OyMGxvPZAzRA06/arLCNDE7L3kCIrDLcqKuEk492Rcq4A=
X-Received: by 2002:a81:3c14:: with SMTP id j20mr23304745ywa.367.1554730315766;
 Mon, 08 Apr 2019 06:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190404171007.160878-1-ncrews@chromium.org> <20190404171007.160878-2-ncrews@chromium.org>
 <20190405201534.GA4426@roeck-us.net> <20190406084157.GA27043@amd>
 <CAE_wzQ9WG1+K1ZzVoii8ukDe_g+4Ha0bh6YvsRhceinwPjC+Kw@mail.gmail.com>
 <20190407221846.GB6327@amd> <CAE_wzQ_5Ha6hNt28_+j-pF3mAdXXifv9CuotDCeXff8KC1DNmA@mail.gmail.com>
 <20190408094113.GB30958@amd>
In-Reply-To: <20190408094113.GB30958@amd>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 8 Apr 2019 06:31:44 -0700
Message-ID: <CABXOdTcrQELWVc5SwPHAk6BP5wq=kQg6K_g-7p+Y73tPFAFTdQ@mail.gmail.com>
Subject: Re: Keyboard backlight LED naming was Re: [PATCH v5 2/3]
 platform/chrome: Add Wilco EC keyboard backlight LEDs support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dmitry Torokhov <dtor@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Nick Crews <ncrews@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 2:41 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > > > > This document also states "The naming scheme above leaves scope
> > > > > > for further attributes should they be needed". It does not perm=
it,
> > > > > > however, to redefine one of the fields to mean "location", much=
 less
> > > > > > the declaration that a devicename of "platform" shall refer to =
an
> > > > > > "internal" backlight, or that there shall be no more than one
> > > > > > "internal" backlight in a given system.
> > > > >
> > > > > "platform" is as good devicename as "wilco" or "chromeos".
> > > >
> > > > No, because "platform" is not a device, it is something that you ar=
e
> > > > trying to assign a magic meaning to.
> > >
> > > "chromeos" is not a device, either.
> >
> > I agree, it is not a device name. We do not assign any specific
> > meaning to it though. We could change it to "cros_ec" if so desired
> > and nothing should break.
>
> Yes. And you can also change it to "platform" and nothing will break
> :-). Can we end the discussion here?
>
> If not, lets take a look at existing names:
>
> ./drivers/platform/x86/asus-laptop.c:           cdev->name =3D "asus::kbd=
_backlight";
> ./drivers/platform/x86/samsung-laptop.c:                samsung->kbd_led.=
name =3D "samsung::kbd_backlight";
> ./drivers/platform/x86/thinkpad_acpi.c:         .name           =3D "tpac=
pi::kbd_backlight",
> ./drivers/platform/x86/toshiba_acpi.c:          dev->kbd_led.name =3D "to=
shiba::kbd_backlight";
> ./drivers/platform/x86/asus-wmi.c:              asus->kbd_led.name =3D "a=
sus::kbd_backlight";
> ./drivers/platform/x86/dell-laptop.c:   .name           =3D "dell::kbd_ba=
cklight",
> ./drivers/platform/chrome/cros_kbd_led_backlight.c:     cdev->name =3D "c=
hromeos::kbd_backlight";
> ./drivers/hwmon/applesmc.c:     .name                   =3D "smc::kbd_bac=
klight",
> ./drivers/hid/hid-asus.c:       drvdata->kbd_backlight->cdev.name =3D "as=
us::kbd_backlight";
> ./drivers/hid/hid-google-hammer.c:      kbd_backlight->cdev.name =3D "ham=
mer::kbd_backlight";
> ./drivers/input/misc/ims-pcu.c:          "pcu%d::kbd_backlight", pcu->dev=
ice_no);
>
> asus, samsung, toshiba, asus, dell, chromeos... Those are really not
> device names, either. But in these cases, LED is probably controlled
> by EC, or by ACPI BIOS talking to the EC. People usually call such
> devices "platform devices".
>
> (Linux Platform Device Driver - CodeProject
> =EF=BF=BChttps://www.codeproject.com/tips/1080177/linux-platform-device-d=
river
> A platform device is one which is hardwired on the board and hence not
> hot-pluggable. )
>
> You can take a look at discussion around micmute LED.
>
> Thus "platform" is quite suitable name in your case, and incidentaly,
> it will be more useful for userspace than "cros_ec".
>
No, it isn't. All those name are at least roughly associated with the
driver name, and they all do reflect the abbreviated driver name.
"platform" isn't, and is prone to duplicates.

If you want the location reflected in the led sysfs atttribute name,
say so. "platform" is neither a driver name nor a location. On a side
note, appending a number to the attribute name is not a good idea. In
addition to not being backward compatible, it would be prone to
renumbering at each reboot.

Guenter

>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
