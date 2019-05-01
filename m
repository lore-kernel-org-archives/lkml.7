Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78661C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32709207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bIfWBSIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEAX6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 19:58:39 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34027 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEAX6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 19:58:38 -0400
Received: by mail-vs1-f68.google.com with SMTP id b23so366831vso.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 16:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRQ5pz9uPXwsISxqvh3bR/6vg4eDgpzQJxN66ATgxRs=;
        b=bIfWBSIawzPHvd2rcG/g2Aj4FB9S6F8w9a48ZYPSAxKA8S28JVG3C9EInd67aWyYuV
         18VZRmETBaPJZ1Ae+SOkHd8KTUCK54tOvP8PeI3gCgxcRdwoUTReR66QQKzNWx1DFQDC
         8OysOT2EBdnI7erWaDtovetHazfugNaUnGNqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRQ5pz9uPXwsISxqvh3bR/6vg4eDgpzQJxN66ATgxRs=;
        b=Ivoyb8xH9TtqI6mXImVR/RTYtwSgmlaWnaKbf/AIesdncjIFRIyeSgs2na5TMJ5Yby
         /l1+p7r7LaHTkGuMgHTEKR4b0KFTd67MEzrGB0cxiQJ9AUWw8ZRG5x0jX3qEGccFN0rq
         S/N6NZ0c/QMuU46xFtXP2DFzrLxyQlHH7dDg/dhXd1YFco1CJFL/268z2wHPaCzcg2V3
         x87riMeCg2j5w+4n6/9qxvX0ygM2zgdkICRyoitYEeTleJav/usfDk95r3XDGoRRttY5
         ksABKUunm+/7FKe9ze200Dp+oKavPcNCJsZl1f552s6r5sG0ODgsbhaCOWqKw5zBNytt
         NTTQ==
X-Gm-Message-State: APjAAAXfTBdiC4JgYNaGN9qQw8oNMlPi9JJdt4wnlOF7YNKkqLSp3Iwh
        OMn9qLZLdf4UJqYnrlZoCiITlcvqBY4=
X-Google-Smtp-Source: APXvYqxyqjLr0sqH8MTalNInBgGRiIU79B1cfW/vZ/gEJViv8r5M1B2yfq779owHZMkTpZNOli4QSg==
X-Received: by 2002:a05:6102:98:: with SMTP id t24mr374599vsp.239.1556755117148;
        Wed, 01 May 2019 16:58:37 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id s194sm16609889vkf.37.2019.05.01.16.58.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:58:35 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id x2so133333vkx.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 16:58:34 -0700 (PDT)
X-Received: by 2002:a1f:b654:: with SMTP id g81mr290796vkf.18.1556755113799;
 Wed, 01 May 2019 16:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190418001356.124334-1-dianders@chromium.org> <20190418001356.124334-2-dianders@chromium.org>
In-Reply-To: <20190418001356.124334-2-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 1 May 2019 16:58:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UGjQz9Di=NL_r_g1Hofqv-FWBywfSm9Vu6gGr22wzPrA@mail.gmail.com>
Message-ID: <CAD=FV=UGjQz9Di=NL_r_g1Hofqv-FWBywfSm9Vu6gGr22wzPrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] usb: dwc2: bus suspend/resume for hosts with DWC2_POWER_DOWN_PARAM_NONE
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        William Wu <william.wu@rock-chips.com>,
        linux-usb@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, Chris <zyw@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Julius Werner <jwerner@chromium.org>,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Wed, Apr 17, 2019 at 5:15 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> This is an attempt to rehash commit 0cf884e819e0 ("usb: dwc2: add bus
> suspend/resume for dwc2") on ToT.  That commit was reverted in commit
> b0bb9bb6ce01 ("Revert "usb: dwc2: add bus suspend/resume for dwc2"")
> because apparently it broke the Altera SOCFPGA.
>
> With all the changes that have happened to dwc2 in the meantime, it's
> possible that the Altera SOCFPGA will just magically work with this
> change now.  ...and it would be good to get bus suspend/resume
> implemented.
>
> This change is a forward port of one that's been living in the Chrome
> OS 3.14 kernel tree.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This patch was last posted at:
>
> https://lkml.kernel.org/r/1446237173-15263-1-git-send-email-dianders@chromium.org
>
> ...and appears to have died the death of silence.  Maybe it could get
> some bake time in linuxnext if we can't find any proactive testing?
>
> I will also freely admit that I don't know tons about the theory
> behind this patch.  I'm mostly just re-hashing the original commit
> from Kever that was reverted since:
> * Turning on partial power down on rk3288 doesn't "just work".  I
>   don't get hotplug events.  This is despite dwc2 auto-detecting that
>   we are power optimized.
> * If we don't do something like this commit we don't get into as low
>   of a power mode.

OK, I spent the day digging more into this patch to confirm that it's
really the right thing to do.  ...and it still seems to be.

First off: I'm pretty sure the above sentence "If we don't do
something like this commit we don't get into as low of a power mode."
is totally wrong.  Luckily it's "after the cut" and not part of the
commit message.  Specifically I did a bunch of power testing and I
couldn't find any instance saving power after this patch.

...but, then I looked more carefully at all the history of this
commit.  I ended up at:

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/306265/

...where I said that this fixes a resume speed regression.  More
details could be found at the linked bug, AKA:

https://bugs.chromium.org/p/chromium/issues/detail?id=548336

...but, sadly, I wasn't as verbose as I usually am and didn't describe
my exact testing setup.  So I tried to reproduce.  ...and I was able
to.  I tested on an rk3288-veyron-jerry with an empty USB hub plugged
into the left port (the host port) and my "servo 2" debug board hooked
up to the right port.  The "power_Resume" test in Chrome OS certainly
showed a regression in 3.14 when doing a suspend/resume cycle.


Digging into the logs in 3.14, before this patch I saw this in the logs:

usb 3-1: reset high-speed USB device number 2 using dwc2
usb 3-1.7: reset high-speed USB device number 3 using dwc2

...after this patch:

usb 3-1: USB disconnect, device number 2
usb 3-1.7: USB disconnect, device number 3
usb 3-1: new high-speed USB device number 4 using dwc2
usb 3-1: New USB device found, idVendor=1a40, idProduct=0201, bcdDevice= 1.00
usb 3-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 3-1: Product: USB 2.0 Hub [MTT]
usb 3-1.7: new high-speed USB device number 5 using dwc2
usb 3-1.7: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
usb 3-1.7: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 3-1.7: Product: USB 2.0 Hub

...so basically my belief is that without this patch we're just sorta
leaving the device hanging and it get confused on resume.  After this
patch we behave slightly better.

I tested on 4.19 and found much the same.  There:

usb 2-1: reset high-speed USB device number 2 using dwc2
usb 2-1.7: reset high-speed USB device number 3 using dwc2

vs.

usb 2-1.7: USB disconnect, device number 3
usb 2-1: USB disconnect, device number 2
usb 2-1: new high-speed USB device number 4 using dwc2
usb 2-1: New USB device found, idVendor=1a40, idProduct=0201, bcdDevice= 1.00
usb 2-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 2-1: Product: USB 2.0 Hub [MTT]
usb 2-1.7: new high-speed USB device number 5 using dwc2
usb 2-1.7: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
usb 2-1.7: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 2-1.7: Product: USB 2.0 Hub


On 4.19 I didn't actually notice a the same resume time regression,
presumably because things are happening more asynchronously there (I
didn't confirm this).  ...but in any case it seems like the right
thing to do to actually do the suspend.


I'll also re-iterate once more that I'm not claiming that my patch
helps with "partial power down".  It merely makes the "power savings
disabled" case work more properly.


I'll also note that my patch is already in Felipe's "testing/next"
branch which I continue to believe is correct and good.

-Doug
