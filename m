Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA2FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BD42075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsHSfgRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfCUIzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:55:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34221 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbfCUIzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:55:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id v64so3889184pfb.1;
        Thu, 21 Mar 2019 01:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MNbXPJNYn+bCTgn+s9eastxxUodZqHiV3+a42J+XH5Q=;
        b=WsHSfgRvNzK6/KpyJJgHUd2L1Wy5mIjfC5w1P80a6YTI2HMz417Vz7lXfISfcYdtli
         MqVIhZ1D4bsaC4JUGupjZOSMZS7ltOsLXDCLtnLuUyv5fS7KPU3VWn4OYbATgQJvyzks
         LqR6jatsxsKcIVK0wZJ2SqzoMEmGzms81me8GZ17299+MPxwKzRYOZ7lHmwezdkkfMrW
         j/mzLVoVrJfJmWuYtRvYQhD+jlWJNJhNrAyaROOao8BPsxs504SglHjVdzG68VxHxIj7
         SnzMK2LGE4uWKHpGz8QO+J7YAWIA+hbnKZ0+aS80ccHue21cmsXdNl+LcXiicuym1/Dn
         XFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MNbXPJNYn+bCTgn+s9eastxxUodZqHiV3+a42J+XH5Q=;
        b=Cw50rMV5g3uwscI9NMG6xvBr7pLULuf3Gh6m98HtX0iTyh2xVanKUBOwtTrWYYPzYA
         FIDPVU0/7o8VVgUv6Bn3g8t+ORHbTzQa3ekwH3ujgr/mhWW+RsUEGDTW+FwAWUn4PDwt
         CKYRP8vADPNu1mbyicRIzyhs5RgSSv9ofp0VYBHT2oPtlagjzjvn95zqeUEIDtQFuksu
         HhY8M9dHKPSrMeg8IKHLpnpQO9mktSHFlWmJTzf9imBXJl5RtSj9h5tqpVQepb3p3k1Q
         vrSKt1aDZ5WycTJS9OEf1Z144kt+c+E0ZigEjUvc6TZGwSYAyH+AnSDMsahUE4pdbjHo
         cUhQ==
X-Gm-Message-State: APjAAAUtNAr95it96uFncP+3PN0Y1yfCOgqVB3Jg0g+qkwodt158yKnY
        staGdtZmtHn9CjbLgKm5Iu80AGe3kwxDpTJ2i/k=
X-Google-Smtp-Source: APXvYqzdA5BhIUqYWPhaO9DTOy6BMmcWyOQePPYQ/gTSKRhp5GuJT/Sst9UF+XkWDtMDFA+Qizo0m9H/oRBC1uDXVxE=
X-Received: by 2002:a65:5acc:: with SMTP id d12mr2277570pgt.337.1553158539182;
 Thu, 21 Mar 2019 01:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <LaQHUFs--3-1@tutanota.com> <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
 <9151d116-958c-9298-9427-fe803a163e9f@redhat.com> <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
 <CAHp75VcOG9H8u+tZyNN682r7+jsRZi8VoPPZ2uJPch1gNyFgmQ@mail.gmail.com> <220FEDBD-9A71-4C14-A7D6-3850D515865F@canonical.com>
In-Reply-To: <220FEDBD-9A71-4C14-A7D6-3850D515865F@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Mar 2019 10:55:27 +0200
Message-ID: <CAHp75VeavkzZDYK4CWAC62GciynQ3KYgmPpPRwsd3RcLFw4jxA@mail.gmail.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        hotwater438@tutanota.com, Jiri Kosina <jikos@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dmitry Torokhov <dtor@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 6:08 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> at 01:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Wed, Mar 20, 2019 at 6:55 PM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >> at 23:39, Hans de Goede <hdegoede@redhat.com> wrote:
> >>> On 3/20/19 3:37 PM, Benjamin Tissoires wrote:

> >> Recently we found that Elan touchpad doesn=E2=80=99t like GpioInt() fr=
om its _CRS.
> >> Once the Interrupt() is used instead, the issue goes away.
> >
> > IIRC i2c core tries to get interrupt from Interrupt() resource and
> > then falls back to GpioInt().
> > See i2c_acpi_get_info() and i2c_device_probe().
>
> Here=E2=80=99s its ASL:

>              Name (SBFB, ResourceTemplate ()
>              {
>                  I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
>                      AddressingMode7Bit, "\\_SB.PCI0.I2C4",
>                      0x00, ResourceConsumer, , Exclusive,
>                      )
>              })
>              Name (SBFG, ResourceTemplate ()
>              {
>                  GpioInt (Level, ActiveLow, ExclusiveAndWake, PullUp, 0x0=
000,
>                      "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>                      )
>                      {   // Pin list
>                          0x0012
>                      }
>              })
>              Name (SBFI, ResourceTemplate ()
>              {
>                  Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive=
AndWake, ,, )
>                  {
>                      0x0000003C,
>                  }
>              })

>              Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource S=
ettings
>              {

>                  If ((OSYS < 0x07DC))
>                  {
>                      Return (SBFI) /* \_SB_.PCI0.I2C4.TPD0.SBFI */
>                  }

This will return only Interrupt() resource

>
>                  Return (ConcatenateResTemplate (SBFB, SBFG))

This one I2cSerialBus() and GpioInt().

>              }


>          }
>      }
>
> Change SBFG to SBFI in its _CRS can workaround the issue.
> Is ASL in this form possible to do the flow you described?

Since it's enumerated in Linux as I2C device, it means it gets I2C and
GPIO resources.
So, no, it's not possible.

What are you describing might tell us about one of the following:
- touchpad should be switched to PS/2 mode in order to get working
- GPIO resource is not correct / bug in GPIO driver

I don't believe the first one is a case here.
If GPIO resource is not correct and main OS has some quirks, we need
to do similar in Linux.
Otherwise, debugging GPIO driver, starting from what exactly (pin
number, pin settings, etc) gets i2c-hid module.

Note, ACPICA and related stuff is done in order to be Windows compatible.
If you have settings in BIOS that defines OS to boot, it should be
chosen Windows.

--=20
With Best Regards,
Andy Shevchenko
