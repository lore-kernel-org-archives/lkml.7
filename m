Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ABBC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E331F20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Is0jCGfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfDYVZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:25:13 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46632 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfDYVZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:25:12 -0400
Received: by mail-vs1-f68.google.com with SMTP id e2so712483vsc.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYfL/yrYqMtfoK2MidzpiQqewGxhX2aw5SDN0ul+GWI=;
        b=Is0jCGfGFSZybHyR9WPV7ctdY/V9GzJEnJFDreqBBRTWwqxJIcztJC7VUTB9kIrnE/
         VFY9cCM5PjpX5H+3S1VUAvAm2qRc+h/TaLUeIwiB4I9Sht2vTl3pYRyAXYqRNWOCJoCs
         E+K3ORfrJLFbP6DL9mvsvnjAzI1lWw3yGbsms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYfL/yrYqMtfoK2MidzpiQqewGxhX2aw5SDN0ul+GWI=;
        b=TPq8tFUTh5JhtyxTLAfBiMkPEQKkcwAAAz26Xgk14eEV0fOsBFx9atNxnEZit5x0vv
         80PcO3Mg4snTTqgI0qyqeMwt+zq9B1arj2j1tPhdoArdFEHETD6ufjAiJFa5JuVaxoXR
         J1JWvrDuKW9jkfiMM6UIjq2QsfYNAbvrwFWzvZbdmro13C/X2uZ+P8USmuXWmU5ikLql
         HnuGAXvSduXYiVfB0sM1/pZ2eXTs7R7bEFLCMN5NUNwhR+pD03bb+q+UZi4IVL50E22/
         QJCvOzXdyGyYSwHvqDaJyEejWSTt1LvcpBWEdTxo7fTLGPF53WZ+ESUAqzcDyhgP6sns
         4C+g==
X-Gm-Message-State: APjAAAVhhqCjT2c+amUFWFXCK95ptM6jfJECWyDQG81Wa0NNVsi4vyGy
        ymVWoIw0NQ62P3Gd8+uGX1VqysUkXow=
X-Google-Smtp-Source: APXvYqxjzywoa0sJHQGGB0jU/dxQ/PXv8Chqh0jiP4IqEjVeqsHqYFkMQzlPgiq1ZExE1rGQia4/HQ==
X-Received: by 2002:a67:f342:: with SMTP id p2mr3034219vsm.118.1556227511182;
        Thu, 25 Apr 2019 14:25:11 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id e198sm6407551vsc.3.2019.04.25.14.25.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 14:25:09 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id w140so317434vkd.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:25:09 -0700 (PDT)
X-Received: by 2002:a1f:1e48:: with SMTP id e69mr13797503vke.16.1556227509276;
 Thu, 25 Apr 2019 14:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190410221237.160856-1-dianders@chromium.org> <CANBLGcwmNowj9GSmE3bbo1t1o6EF8q-RiJftfdOQnJB9_8aSKg@mail.gmail.com>
In-Reply-To: <CANBLGcwmNowj9GSmE3bbo1t1o6EF8q-RiJftfdOQnJB9_8aSKg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Apr 2019 14:24:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UW6d2QHzxx-Vtr+WwC1dkpUfCjxCLnfaP5S2UQxRh1oQ@mail.gmail.com>
Message-ID: <CAD=FV=UW6d2QHzxx-Vtr+WwC1dkpUfCjxCLnfaP5S2UQxRh1oQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Disable SDIO interrupts while suspended to
 fix suspend/resume
To:     Emil Renner Berthing <emil.renner.berthing@gmail.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 24, 2019 at 1:19 AM Emil Renner Berthing
<emil.renner.berthing@gmail.com> wrote:
>
> Hi Douglas,
>
> Unfortunately this seems to beak resume on my rk3399-gru-kevin. I have
> a semi-complicated setup with my rootfs as a btrfs on dmcrypt on
> mmcblk0 which is the dw_mmc, so I'm guessing something goes wrong when
> waking up the dm_mmc which probably wasn't suspended before this
> patch. It's not 100% consistent though. Sometimes I see it resume the
> first time I try suspending, but then 2nd time I suspend it won't come
> back.

Thanks for testing!

Can you give me more details about your kernel version?  Any local
patches?  What config are you using?

I tried booting up my rk3388-gru-kevin on the Chrome OS 4.19 kernel (I
know, not quite fully upstream, but linuxnext just crashed upon boot
for me when I tried it).  I have this patch in place and I booted from
SD card.  I ran a Chrome OS tool which will test 20 cycles of
suspend/resume (uses the RTC to schedule a wakeup):

suspend_stress_test -c20 --suspend_min=15 --suspend_max=20

...and I didn't see failures.

...so I'm pretty baffled.  On rk3399-gru-kevin you should have no SDIO
devices unless you've managed to cram an SDIO card into your micro SD
slot.  Specifically WiFi is connected via PCIE.

As I wrote Shawn, I'm pretty sure my patch is a effectively a no-op in
these cases.  "client_sdio_enb" should always be 0 and thus runtime
suspend and resume should just be:

spin_lock_irqsave(&host->irq_lock, irqflags);
int_mask = mci_readl(host, INTMASK);
mci_writel(host, INTMASK, int_mask);
spin_unlock_irqrestore(&host->irq_lock, irqflags);

...other than changing the timing slightly that shouldn't do anything at all.


My first guess is that this patch is your (un)lucky shirt, as in
"every time I wear my lucky shirt I win at slots in Las Vegas".  Since
the problem you're seeing doesn't happen every time I'm going to guess
that you got lucky in that it seemed to go away when you reverted my
patch.


> Let me know if I can do something to help debug this.

Assuming the failure and this patch aren't just correlated by luck...

Logs would be a start.  If you don't have serial console then
hopefully you've got console-ramoops working?  Then if it's wedged you
can do the warmest reset you can (Alt-topRowVolUp-R) and hopefully the
ramoops will give you some logs.

Presumably you could also add some logs to double-check that all my
assertions are true.  That is:

1. host->client_sdio_enb should always be false in __dw_mci_enable_sdio_irq()

2. In __dw_mci_enable_sdio_irq() confirm that the int_mask we are
writing is the same as the one we're reading.  AKA the "if (enb) ...
else ..." makes no change to the value of int_mask.


Assuming my assertions are correct then pretty much everything is
_supposed_ to be a no-op on your system, so you can start gutting
things one at a time and see when the problem goes away:

a) Delete the call from suspend.  Does it fix it?

b) Delete the call from resume.  Does it fix it?

c) Delete parts of __dw_mci_enable_sdio_irq().  Get rid of the
mci_wirtel().  Does it fix it?  What about if you get rid of the read
and the write and just have the spinlock?

===

If I can help with real-time debugging let me know.  I'm in California
time zone and can be found as dianders in the #linux-rockchip channel
on freenode.



-Doug
