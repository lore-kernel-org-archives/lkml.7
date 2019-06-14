Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D533DC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920E621473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WNIKPxvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfFNJFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:05:14 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45345 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfFNJFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:05:14 -0400
Received: by mail-vs1-f68.google.com with SMTP id n21so1284338vsp.12;
        Fri, 14 Jun 2019 02:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/a0f97mPGlD2P5Dx/9WW1LokwMOUS4gZ/0oye+66jk=;
        b=WNIKPxvEFWviZdk8kKxRaLe0Q3z8DSJ75vAQgtAQaKpg8QEmIG3oLv4PXm970n2fr3
         fVIdTWlMCuUMoYdcpf7LDB9FHOer/GIk1FlRw/8H32b4o31OUKM/CiCPSjhAYoX7Ej8U
         pxvvqQy/OH3fT5rlXmixuZ8oDIF/sq9LuSteHPaee5p9A4e1S+TeX5db6PXsf8S6zFFV
         lJNzRK9hF+Wtd5fWGMFLvOcXwkXp7XnSNj0y7HphkWcA0K/Of+2cjffGaQgZYG7/tjCi
         hlk/zkJm3PW9/wuTXI9Rm3ZGkK4b3Fga038h3mmtxtEK89G/mJpv7rj8mH+9fU/w/oci
         3PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/a0f97mPGlD2P5Dx/9WW1LokwMOUS4gZ/0oye+66jk=;
        b=lzTyh0zWJfnQw10j7V21aclsL1UBYLzFKvjT2Dv2OdU9XOcJJhIN9qILR1aueBV9ck
         e/cUtFhqWcf0OYn5NHKriC06UDUoDUy/mG17GhagyWbZwhouOsqU1Bw0TQ02r9wctW2A
         IOLu3B34KZOB+DZbXn+3jramLnfdY/keVaBSd22x7c5xj+SpZNTk93S+56EaG4PztD+d
         glT7NMJeUkj3PwNxtYwc8AUv87/U9wu4jdByjOM1nJU0qKLe56TfRLCmoFtYXJg9mAYv
         GyiWBwYi9H6IDzNWxVG7RVgG52BxHlS/KnyrI81N/6MQCpwhZm1e4tyn4gsKAJM2pWBC
         XnxA==
X-Gm-Message-State: APjAAAUJO2tlp5kOYjfNxpXHdKtjvaeOhcooLxjrFbvnYybZWmkXFHTb
        3jmDNM5RlSa6Ml9c+pUOoJvWb3EHEc7RM3eSTEb2aLSb
X-Google-Smtp-Source: APXvYqzR4KwxVZ+qK1GKT9qFoj0vgTzCAs1sVFqw0tE1f/yc6xpbYHRIcfegXlm+BIdDD1QK6gbJgNxno6NgFssOKa4=
X-Received: by 2002:a67:e446:: with SMTP id n6mr12264061vsm.142.1560503112834;
 Fri, 14 Jun 2019 02:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190613154542.32438-1-sr@denx.de> <20190613170802.GE9224@smile.fi.intel.com>
In-Reply-To: <20190613170802.GE9224@smile.fi.intel.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Fri, 14 Jun 2019 11:04:48 +0200
Message-ID: <CAGm1_ksNqh0ZVO+aHsdcS6XQHt3hfqWE3a=3waKWEp8Oc8HWcQ@mail.gmail.com>
Subject: Re: [PATCH 1/3 v6] serial: mctrl_gpio: Check if GPIO property exisits
 before requesting it
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stefan Roese <sr@denx.de>, linux-serial@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 7:08 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 13, 2019 at 05:45:40PM +0200, Stefan Roese wrote:
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
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I cannot compile the driver without adding #include <linux/property.h>
to drivers/tty/serial/serial_mctrl_gpio.c.

My platform is AM335X (OMAP3). I've tried the patches both against the
main repo and also tty-next.

Other than that everything is working.

Yegor

> > Signed-off-by: Stefan Roese <sr@denx.de>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Yegor Yefremov <yegorslists@googlemail.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > ---
> > v6:
> > - No change
> >
> > v5:
> > - Simplified the code a bit (Andy)
> > - Added gpio_str == NULL handling (Andy)
> >
> > v4:
> > - Add missing free() calls (Johan)
> > - Added Mika's reviewed by tag
> > - Added Johan to Cc
> >
> > v3:
> > - No change
> >
> > v2:
> > - Include the problem description and analysis from Mika into the commit
> >   text, as suggested by Greg.
> >
> >  drivers/tty/serial/serial_mctrl_gpio.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> > index 39ed56214cd3..65348887a749 100644
> > --- a/drivers/tty/serial/serial_mctrl_gpio.c
> > +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> > @@ -116,6 +116,19 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
> >
> >       for (i = 0; i < UART_GPIO_MAX; i++) {
> >               enum gpiod_flags flags;
> > +             char *gpio_str;
> > +             bool present;
> > +
> > +             /* Check if GPIO property exists and continue if not */
> > +             gpio_str = kasprintf(GFP_KERNEL, "%s-gpios",
> > +                                  mctrl_gpios_desc[i].name);
> > +             if (!gpio_str)
> > +                     continue;
> > +
> > +             present = device_property_present(dev, gpio_str);
> > +             kfree(gpio_str);
> > +             if (!present)
> > +                     continue;
> >
> >               if (mctrl_gpios_desc[i].dir_out)
> >                       flags = GPIOD_OUT_LOW;
> > --
> > 2.22.0
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
