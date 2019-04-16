Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A059AC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E1F206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfDPQE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:04:26 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57643 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfDPQE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:04:26 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 632AD60014;
        Tue, 16 Apr 2019 16:04:18 +0000 (UTC)
Message-ID: <0189da8d91652dd3ecf729b03029ab9db5a24f99.camel@hadess.net>
Subject: Re: [RFC v3] iio: input-bridge: optionally bridge iio acceleometers
 to create a /dev/input interface
From:   Bastien Nocera <hadess@hadess.net>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Eric Piel <eric.piel@tremplin-utc.net>,
        linux-input@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Date:   Tue, 16 Apr 2019 18:04:16 +0200
In-Reply-To: <d52cf9ee5944c90c69f6e74a46d844cef51e487e.1555362312.git.hns@goldelico.com>
References: <d52cf9ee5944c90c69f6e74a46d844cef51e487e.1555362312.git.hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having written a "bridge" myself (I called it a "proxy"[1]), I have a
few comments.

[1]: https://github.com/hadess/iio-sensor-proxy

Let's start with the easy ones ;) there's a typo in the subject line.

The subject line also says "optionally" but there doesn't seem to be
any ways to disable the feature if it's shipped by the kernel used.

On Mon, 2019-04-15 at 23:05 +0200, H. Nikolaus Schaller wrote:
> Some user spaces (e.g. some Android devices) use /dev/input/event*
> for handling
> the 3D position of the device with respect to the center of gravity
> (earth).
> This can be used for gaming input, auto-rotation of screens etc.
> 
> This interface should be the standard for such use cases because it
> is an abstraction
> of how orientation data is acquired from sensor chips. Sensor chips
> may be connected
> through different interfaces and in different positions. They may
> also have different
> parameters. And, if a chip is replaced by a different one, the values
> reported by
> the device position interface should remain the same, provided the
> device tree reflects
> the changed chip.

I don't understand this section of the commit message. The IIO drivers
are already that abstraction interface, no?

> This did initially lead to input accelerometer drivers like
> drivers/input/misc/bma150.c
> or drivers/misc/lis3lv02d/
> 
> But nowadays, new accelerometer chips mostly get iio drivers and
> rarely input drivers.
> 
> Therefore we need something like a protocol stack which bridges raw
> data and input devices.
> It can be seen as a similar layering like TCP/IP vs. bare Ethernet.
> Or keyboard
> input events vs. raw gpio or raw USB access.

This can be done in user-space, reading the data from the IIO driver,
and using uinput to feed it back. Why is doing this at the kernel level
better?

> This patch bridges the gap between raw iio data and the input device
> abstraction
> so that accelerometer measurements can additionally be presented as
> X/Y/Z accelerometer
> channels (INPUT_PROP_ACCELEROMETER) through /dev/input/event*.
> 
> There are no special requirements or changes needed for an iio
> driver.

The user-space daemon I wrote supports both IIO drivers and input
drivers for accelerometers. How do I know from user-space whether a
device is proxied or not?

> There is no need to define a mapping (e.g. in device tree).
> 
> This driver simply collects the first 3 accelerometer channels as X,
> Y and Z.
> If only 1 or 2 channels are available, they are used for X and Y
> only. Additional
> channels are ignored.

In what cases are 2 dimensional accelerometers used?

> Scaling is done automatically so that 1g is represented by value 256
> and
> range is assumed to be -511 .. +511 which gives a reasonable
> precision as an
> input device.
> 
> If a mount-matrix is provided by the iio driver, it is also taken
> into account
> so that the input event automatically gets the correct orientation
> with respect
> to the device.
>
> If this extension is not configured into the kernel it takes no
> resources (except
> source code).
> 
> If it is configured, but there is no accelerometer, there is only a
> tiny penalty
> for scanning for accelerometer channels once during probe of each iio
> device.
> 
> If it runs, the driver polls the device(s) once every 100 ms. A mode
> where the
> iio device defines the update rate is not implemented and for further
> study.
> 
> If there is no user-space client, polling is not running.

Is the bridge going to modify the IIO device's settings behind other
possible consumer's backs, such as threshold values, and triggers?

> The driver is capable to handle multiple iio accelerometers and they
> are
> presented by unique /dev/input/event* files. The iio chip name is
> used to define
> the input device name so that it can be identified (e.g. by udev
> rules or evtest).

As you can probably guess, I'm not overly enthusiastic about this piece
of code. If it had existed 5 years ago, I probably wouldn't have
written iio-sensor-proxy, but then somebody else would have had to for
the rest of the IIO sensors that can be consumed.

To me, this bridge has all the drawbacks of a simple user-space
implementation using uinput, without much of the benefits of being an
exclusive user of the IIO accelerometers, such as being able to change
the update rate, or using triggers depending on the usage.

What am I missing? Why shouldn't this live in user-space?

Cheers

