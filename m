Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671A9C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7692082C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Cjg9TXWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfFNJi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:38:56 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42409 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNJi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:38:56 -0400
Received: by mail-vs1-f68.google.com with SMTP id 190so1354646vsf.9;
        Fri, 14 Jun 2019 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wpkxjv4XdUH50VTIe3/++vbOXy7Mm8zVzt0/ZIHrPWk=;
        b=Cjg9TXWK0MXbh3dVZzjbaoawkxwalweheGkXBUUBWY0/RY1JpQHqQKFMRrnwv5Uc1R
         ycZrDGIKabqz9bsqun8Cf5rHEUJmrVxEKHGvLC1qmKWa/QqiwZGenOOaP5qGcfDiULiW
         9wmzOzCwukfFdqmhTBvrOHNyZBYsSXZSwetDeeDb8EETXR0V0a7+THobGDO4UC/txrDy
         jBbenpX/Wi9wBtaMqQxy7qg9B0GMRIA78MbMSNhA/fT+GmC9D30axPUP5yKCN7DVqirk
         mlEKxLoVIdWBxL/Yf4IUITJMwIAI2i5MaMyD+jpwhyG3YvAmqEz0xmehnVUOdyBmnXLV
         wdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wpkxjv4XdUH50VTIe3/++vbOXy7Mm8zVzt0/ZIHrPWk=;
        b=T+r1rfV4VB9Qz4TBGFwhhEJXD5Ge7ks269cGbVDsswXwjccWmnNOwfCGVEscGYWJf5
         oSlq5FH0vAOLhApPB4+2ydevmnqGZnuYWWFd2geqBZOG2B1kby2CZoQy5zsN+KLyx1lz
         hNobQQm4VEmV+jswvZX/2s+hiPoGv0xGwPN+snAAncOX1ZZ48kpdqQJVqacfY1oZDycZ
         UY2lgGZuiNnVzUc1DExi1CURb/ifluQT+DmtK0cYNTOO5dV7Oys6gX3yWJAqm/ekXpjV
         CsZxFFeZ/Ys+v0WbVFEmkRAsyWKm5I0zx+XOXJ/G8HLHWOo1bA00ZgQIIr8KCC4rGyyC
         8GDw==
X-Gm-Message-State: APjAAAW2srGGEfzNvFADKll2hqbvVAwIwglO7gTl5prgDDHX9kIVr85i
        6uyKZYaf0uXKY6sc0WIExONLROqVls6QS+8LGbUiOA==
X-Google-Smtp-Source: APXvYqycFYeuVamoJ2frnNZ5OkXlMTiZZJnH68rl+uObHD4HFVhTfhTgc2IJqkBs82RPih+Gf41vG38LJ9sqIZq/8IA=
X-Received: by 2002:a05:6102:382:: with SMTP id m2mr40706013vsq.134.1560505135124;
 Fri, 14 Jun 2019 02:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190613154542.32438-1-sr@denx.de> <20190613170802.GE9224@smile.fi.intel.com>
 <CAGm1_ksNqh0ZVO+aHsdcS6XQHt3hfqWE3a=3waKWEp8Oc8HWcQ@mail.gmail.com> <0bf6629c-cedf-e1dd-b42b-989c6711d390@denx.de>
In-Reply-To: <0bf6629c-cedf-e1dd-b42b-989c6711d390@denx.de>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Fri, 14 Jun 2019 11:38:31 +0200
Message-ID: <CAGm1_ktOJEzW9bkkUaVe2ioUBAV4hNoSbQSg+EUHz2sr4ppF+g@mail.gmail.com>
Subject: Re: [PATCH 1/3 v6] serial: mctrl_gpio: Check if GPIO property exisits
 before requesting it
To:     Stefan Roese <sr@denx.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:29 AM Stefan Roese <sr@denx.de> wrote:
>
> On 14.06.19 11:04, Yegor Yefremov wrote:
> > On Thu, Jun 13, 2019 at 7:08 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >>
> >> On Thu, Jun 13, 2019 at 05:45:40PM +0200, Stefan Roese wrote:
> >>> This patch adds a check for the GPIOs property existence, before the
> >>> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> >>> support is added (2nd patch in this patch series) on x86 platforms using
> >>> ACPI.
> >>>
> >>> Here Mika's comments from 2016-08-09:
> >>>
> >>> "
> >>> I noticed that with v4.8-rc1 serial console of some of our Broxton
> >>> systems does not work properly anymore. I'm able to see output but input
> >>> does not work.
> >>>
> >>> I bisected it down to commit 4ef03d328769eddbfeca1f1c958fdb181a69c341
> >>> ("tty/serial/8250: use mctrl_gpio helpers").
> >>>
> >>> The reason why it fails is that in ACPI we do not have names for GPIOs
> >>> (except when _DSD is used) so we use the "idx" to index into _CRS GPIO
> >>> resources. Now mctrl_gpio_init_noauto() goes through a list of GPIOs
> >>> calling devm_gpiod_get_index_optional() passing "idx" of 0 for each. The
> >>> UART device in Broxton has following (simplified) ACPI description:
> >>>
> >>>      Device (URT4)
> >>>      {
> >>>          ...
> >>>          Name (_CRS, ResourceTemplate () {
> >>>              GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
> >>>                      "\\_SB.GPO0", 0x00, ResourceConsumer)
> >>>              {
> >>>                  0x003A
> >>>              }
> >>>              GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
> >>>                      "\\_SB.GPO0", 0x00, ResourceConsumer)
> >>>              {
> >>>                  0x003D
> >>>              }
> >>>          })
> >>>
> >>> In this case it finds the first GPIO (0x003A which happens to be RX pin
> >>> for that UART), turns it into GPIO which then breaks input for the UART
> >>> device. This also breaks systems with bluetooth connected to UART (those
> >>> typically have some GPIOs in their _CRS).
> >>>
> >>> Any ideas how to fix this?
> >>>
> >>> We cannot just drop the _CRS index lookup fallback because that would
> >>> break many existing machines out there so maybe we can limit this to
> >>> only DT enabled machines. Or alternatively probe if the property first
> >>> exists before trying to acquire the GPIOs (using
> >>> device_property_present()).
> >>> "
> >>>
> >>> This patch implements the fix suggested by Mika in his statement above.
> >>>
> >>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > I cannot compile the driver without adding #include <linux/property.h>
> > to drivers/tty/serial/serial_mctrl_gpio.c.
> >
> > My platform is AM335X (OMAP3). I've tried the patches both against the
> > main repo and also tty-next.
> >
> > Other than that everything is working.
>
> Thanks for reporting. I'll wait a bit for other review comments and
> tests (thanks Andy) and will then send v7 with this header included
> (and compile tested on OMAP3) later next week.
>
> BTW: Could you please add a Tested-by-tag with the next version?

Will do.
