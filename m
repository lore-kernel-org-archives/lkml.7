Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97567C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C71420883
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553445092;
	bh=+qLfnQ10YSK0PMT1IpXVQBR9aseZbtNDbB79Vhg5IR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gEv2UThxpD0u2Ll9QUyBGbaQbJ01wwjaamNtBc9WUUD5Q8gLUwTqrCO9P1u3Dlawu
	 AnlGPkMfdtmvzjsEJhKgEOdyFxzAmnERUdyuwOkLcmyo0IvrSsWtWTPeotPBy8Sj1y
	 Zr5eCe9tJCDfesTvvMsiMZl1kgoLGayIjbOvEfZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfCXQba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfCXQba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:31:30 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35EB20883;
        Sun, 24 Mar 2019 16:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553445088;
        bh=+qLfnQ10YSK0PMT1IpXVQBR9aseZbtNDbB79Vhg5IR0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WqApMDzITf5UecXBilQWdcmRcpO+WAkFW8dJhWbcnlLYzKuFiwXJ+Ch+QTHc7MpHf
         FF1ZKnV92pq0CcqtRTIZ/UOb2vynlawlwGRIBxrU2MIKSYQfMpwO0/lusH8xSCgOs2
         z0372mdA/LKyQSGa7q4vsKkkgJiGyJiLknuiiC3E=
Date:   Sun, 24 Mar 2019 16:31:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        "Hennerich, Michael" <michael.hennerich@analog.com>,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        dragos.bogdan@analog.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com
Subject: Re: Help on testing ad5933 driver
Message-ID: <20190324163123.6324f6d7@archlinux>
In-Reply-To: <CA+U=DsoWsWSfyrSneZfoWzXeYjO0u+G0PPtsPQi9ov11w+pcRQ@mail.gmail.com>
References: <20190321193913.q46gq3h7h63ltpgp@smtp.gmail.com>
        <CA+U=DsoWsWSfyrSneZfoWzXeYjO0u+G0PPtsPQi9ov11w+pcRQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 22:34:21 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Mar 21, 2019 at 9:39 PM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Hello, would anyone mind helping me test ad5933 driver on actual
> > hardware?  I went through this
> > (https://oslongjourney.github.io/linux-kernel/experiment-one-iio-dummy/)
> > tutorial so I was able to load iio_simple_dummy driver, create and
> > inspect some dummy devices.  Now, as Jonathan has asked me, I would like
> > to test ad5933 driver on an EVAL-AD5933 board which was donated to FLUSP
> > (https://flusp.ime.usp.br/).
> >
> > So far I've been hesitating to plug this device on my Debian distro
> > since this
> > (https://www.analog.com/media/en/technical-documentation/user-guides/UG-364.pdf)
> > user guide for Windows says not to connect it before driver
> > installation. Is there something that could harm the board if plugged
> > on a computer without a proper driver?
> >  
> 
> You should take into account that a lot of eval boards have their eval
> SW written for Windows.
> This is something of a legacy-thing, because most corporations have
> been running their computers (for work & dev & offices) on Windows.
> 
> So, you shouldn't take things ad-literam (to the letter) when reading
> stuff for Windows and when writing code for Linux.
> 
> > I also didn't understand the hardware configuration showed on this
> > (https://wiki.analog.com/resources/tools-software/linux-drivers/iio-impedance-analyzer/ad5933)
> > page.  
> 
> Hmm, that doc was written a while ago.
> The newer eval board doesn't look like the one in the wiki.
> 
> Also, since the eval SW was targeted for Windows, getting it to work
> for Linux (and IIO) implies some hacking/reverse-engineering.
> The reason for this (reverse-engineering) is because [traditionally]
> eval boards are meant to highlight characteristics of the chip, so if
> using Windows, this should be simple.
> 
> Unfortunately, the docs aren't helping in this case. So, in this case,
> I would get some volt-meter & oscilloscope to help.
> It looks to me that U2 is the AD5933 on the eval-board.
> Worst case, you can solder directly to the pins and link them to a
> Raspberry PI [on the I2C], power, ground, etc.
> But, you can take a look at the T1 to T8 (if I didn't miss anything)
> and connect to them, and see what each of them is for.
> Hopefully, one of those test-points is for I2C, in which case you can
> attach wires to them and connect them to a host.
> I did not find a good doc for them yet.

Circuit diagrams at the end of the datasheet for the eval board...

Definitely start with i2c, as SPI can be considerably more irritating
to get working (I've been on an off trying to deal with some reflections
on a similar dev board for weeks whereas i2c tends to be more resilient).

Hmm.. Normally there are some test points on the bus lines, but here there
don't seem to be.  I definitely would solder to the chip only as a last resort.
Here your best bet is the pads of R15 and R16. If that is no good
find someone with a hot air gun (electronics lap) and lift U4 (the rom
for the USB chip) as that will give some reasonable pads to solder to.

It's possible you'll need to cut tracks on the way out of the usb chip, but
you normally don't need to for i2c.

Using the existing USB power supply is probably a good plan, but make sure to
connect 0V between your host (raspberry pi or similar) and the dev board.

Annoyingly the datasheet is missing the normal art work for the PCB so we
can't actually tell you where any of these components is.  The photo's on
the website aren't too bad though.  I'd wonder if those two long tracks
(3,4 below the CLK socket) are the i2c traces. If they are then some
careful work may let you solder nicely onto the pair of vias at the left
hand end. 

https://www.analog.com/-/media/analog/en/evaluation-board-images/images/eval-ad5933ebztop-web.gif?h=500&thn=1&hash=2226724BDCF5C3ED7854F8C55C51BB9C595CEF3D

Note an oscilloscope is really useful when debugging your wiring so I'd
try and borrow one of those for when you first try to talk to it!

Feel free to ask for more advice if you need it.

Jonathan

> 
> But anyway, I would ask some HW guy to help here (because I'm a SW guy
> mostly),and get help on figuring out the eval board
> 
> >
> > Any advice will be greatly appreciated.
> > Thanks in advance,
> >
> > Marcelo  

