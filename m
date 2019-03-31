Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC58C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 11:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF4020870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 11:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554030356;
	bh=V2gjzo5qisFRUiXcNybqVoNr8zk87r0pPbf3OaQnyY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ra+3vNecu80KEIp70BwpDdFVecT2K2J4jQYA6xDWvDp6YwIa9GbfVPfz0ACFFueJP
	 A0oLjRZyvhXIW5VKCON87m6P/PEMz6yVdElnKTtPX6R66Xs2twtX7mzH0Ko1QdMgUI
	 K9P5YmYSq+UqH//vG78oBdRlu4C+kLv2JM5MuDp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfCaLFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 07:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfCaLFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 07:05:52 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9BE2085A;
        Sun, 31 Mar 2019 11:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554030350;
        bh=V2gjzo5qisFRUiXcNybqVoNr8zk87r0pPbf3OaQnyY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r4mBrtgNXO413qI9GG7m9O2AushiAx+CsbRem6pLDqfinegYsOMKoG54bWlAhYDtM
         PX9Mu/Gei4ovAZs6UYxJqVeLl7lbogx/HfvkFs/H56Uc2weWVR4NgIeirxTDzVUOPW
         d7hguOiLmBdCzpvMTUQhy5FvF8t0AHD2v8C5heNQ=
Date:   Sun, 31 Mar 2019 12:05:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFC 0/4] iio-input-bridge so that accelerometers which only
 have an iio driver can still present evdev input events
Message-ID: <20190331120545.78192269@archlinux>
In-Reply-To: <890047F6-E288-41F0-A8D0-B91CC5A3A0A4@goldelico.com>
References: <cover.1552941573.git.hns@goldelico.com>
        <20190324182920.66242add@archlinux>
        <890047F6-E288-41F0-A8D0-B91CC5A3A0A4@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 18:42:44 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi Jonathan,
> 
> > Am 24.03.2019 um 19:29 schrieb Jonathan Cameron <jic23@kernel.org>:
> > 
> > On Mon, 18 Mar 2019 21:39:30 +0100
> > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> > 
> > 	  
> >> Some user spaces (e.g. some Android) use /dev/input/event* for handling the 3D
> >> position of the device with respect to the center of gravity (earth). This can
> >> be used for gaming input, rotation of screens etc.
> >> 
> >> This should be the standard because this interface is an abstraction of how
> >> this data is acquired from sensor chips. Sensor chips may be connected through
> >> different interfaces and in different positions. They may also have different
> >> parameters. And, if a chip is replaced by a different one, the values reported
> >> by the device position interface should remain the same.
> >> 
> >> But nowadays, new accelerometer chips usually just get iio drivers and rarely
> >> an evdev input driver.
> >> 
> >> Therefore we need something like a protocol stack: input device vs. raw data.
> >> It can be seen as a similar layering like TCP/IP vs. bare Ethernet. Or keyboard
> >> input events vs. raw gpio or raw USB access.
> >> 
> >> This patch set bridges the gap between raw iio data and the input device abstraction
> >> so that accelerometer measurements can also be presented as X/Y/Z accelerometer
> >> channels (INPUT_PROP_ACCELEROMETER) through /dev/input/event*.
> >>   
> > Hi,
> > 
> > I've kind of run out of time today and want to give this a detailed look.  
> 
> No problem, please take the time it needs.
> 
> > 
> > In the meantime a few initial comments.
> > 
> > 1. Resend the whole series cc'ing the linux-input list and maintainer.  
> 
> Ok!
> 
> > 2. In the vast majority of devices the interrupt pin is connected for an
> >   accelerometer. and they support data ready signals.  My gut feeling is
> >   that should be the preferred mode.  
> 
> Mine too, and the commit message 1/4 describes this by 
> 
> "If it runs, the driver polls the device(s) once every 100 ms. A mode where the
> iio device defines the update rate is not implemented and for further study."

Absolutely, I saw that, just wanted to encourage this avenue ;) It's particularly
good if we have a controllable frequency device and can have it self clock
at a rather that makes sense for human input.  Also lets the gamers run at
2kHz if they really want to ;)

> 
> But I didn't manage to get this correctly set up for in-kernel iio on demand
> (start/stop when a process does an open/close - it was simpler to start/stop
> polling).
> 
> Here I am lacking some understanding of details of the subsystems and their
> capabilities.
> 
> Therefore I focussed on the polling case to leave the interrupt driven case
> for later improvements. Also, since 100ms doesn't seem to be a big resource
> burden.

One thing the IIO consumer interfaces have always lacked is nice fallback
between the buffered / interrupt mode and polled read_raw modes.  In theory
if should be possible to elegantly assume that we have a self clocking sensor
but if it doesn't actually support that, fall back to polling and still have
it come out of the buffered interface.  The snag has always been that we
currently end up adding, non-trivial, code to the IIO drivers to support
buffered modes and we don't want to put that burden on all drivers.

> 
> I am also not sure if we really want to process every fidget detected by the
> raw sensor to the input subsystem. This could require more resources than
> polling with 100ms distance.

Agreed. Thankfully most such sensors also have frequency controls so we
can normally get to a sensible level.  Input gets to do all the filtering
etc beyond that.

> 
> >  It was for that use case that we originally
> >   put all the demux and multiple buffer code in IIO. The original series for
> >   that actually had an input bridge.
> > https://lore.kernel.org/linux-iio/1351679431-7963-5-git-send-email-jic23@kernel.org/  
> 
> Oh, nice! I wasn't aware of that. If I had known, we might have based our
> code on it.

You probably noticed in the comments, it was never finished!  The problem is that
all my boards are headless so I never cared ;)  Good to have someone looking
at this problem who does.

> 
> It seems to be a good blueprint to understand how to set up the callbacks.
> 
> What I do not understand is where the "iio map" comes from in your approach.
> 
> From device tree? That would IMHO be against the rule that DTS should describe
> hardware but bridging data to a different user-space interface is not related
> to hardware description.

This has long been an 'argument' on what exactly makes up hardware description.
The problem is that usecases really are hardware description.  There has to
be some means fo knowing what the thing is for, to dictate what software
support we supply.  Whether that is in userspace or kernel or as you have
done is assumed "if plausible" is an open question.

Back when this was originally proposed, there weren't clear rules on this in
DT.  It's hard to argue this is any different from hwmon, though Mark in
particular really dislikes the iio-hwmon interface.  It has the problem that
no one has ever come up with a better one.  Only potential option is to create
abstract devices to represent the fact a given ADC channel is used for
measuring a 'board voltage' or something like that.  They provide no useful
meaning that is actually different from putting them in the iio-hwmon bindings.

The same is kind of true here with the reality being we need to know what
the 'driver' of the acceleration is.  

Could have a binding for 'human' vs 'bridge' vs 'car' :)

> 
> So our approach does not need a specific mapping.
> 
> > 
> > 3. It's going to be a hard sell to have it 'always' map an accelerometer in IIO
> >   to an input device when configured.  There are lots of other accelerometer use
> >   cases where this would be crazy.  In the repost, give some comentary perhaps on
> >   the following options:
> >   a) Explicit binding - like the iio-hwmon bridge.
> >   b) A userspace bridge (I even wrote one of those years ago using uevent)
> >   c) Some sort of userspace triggered way of creating these on demand.  
> 
> Basically, if you have one of these many other use cases, one can just keep this
> bridge unconfigured. Then, it does not eat up memory or code space or processor
> cycles.

That's a non starter.   Lots of people aren't going to tune their kernel to
'unconfigure' some support because they want to turn a feature off.  Take
a raspberry pi for instance. If it has an accelerometer, the question of whether
anyone wants to use it is down to whether there is a screen attached or not.

> 
> Its only use case is to map iio accelerometers to input devices which are
> really used as input devices, i.e. gaming, device orientation etc. Other use
> cases (e.g. industrial sensor grid data aggregator) should not consider this as
> an alternative interface and use e.g. libiio of course.
> 
> Those (handheld) devices in mind usually have only a single accelerometer chip, but
> there are exceptions like the GTA04 and the Pyra which can have two of them (with
> different precision, mounting orientation and functions). Maybe there are some
> devices with more than two. So these iio devices should be reported separately
> but the data (X,Y,Z) should mainly agree on input device level.

There are lots of two sensor cases where the sensors don't agree, mainly because
they are connected by a hinge (screen and keyboard on laptops for example).
Doesn't matter really though.

> 
> In the two-sensor case, our proposed driver simply creates two distinct /dev/input/event
> files which can be given fixed file names by udev instead of inventing a new trigger
> to create these on demand. IMHO it should not be handled differently from plugging in
> multiple mice or joysticks or other gaming devices to USB.

Alternative UDEV can pick up on a new IIO device and poke an interface to register
an input device from it.  We've talked about allowing iio_maps to be instantiated
via configfs and it may be that is the modern choice for how to do this.

> 
> And, this driver converts "raw" accelerometer data into a higher abstraction level
> input event in a way that user-space becomes independent of the specific chip set
> and its orientation. This is like hiding different flash hardware interfaces
> by MTD or file systems. All the hardware details are hidden and shielded. Or it
> is like mapping gpios or alternatively an i2c scanner chio into standardized key codes.
> 
> Finally, there is no polling (in this polling setup) if no process opens the input device.
> So the only waste of 'always' mapping 'all' accelerometers but not using them are some
> data structure allocations in the kernel and duration of probe().
Sure, it's not a heavy burden - but it is conceptually dubious to register an
interface because 'it might' be wanted.  I'd like Dmitry and the input lists
view on this (plus others in IIO!)

> 
> > 4. Input has polled modes. Don't reinvent them.  
> 
> Haven't heard of, but that is what a RFC is good for.
> 
> Anyways, if we use iio interrupts we don't need it, because the information flow
> should go from the chip to the iio driver to the input bridge to the input subsystem
> and only then notify user space (wake up the process running a select on the event
> device file).
> 
> Now, there is something I have learned from studying your comment and struct input_dev.
> 
> Although I did not find polled modes, I can simplify our approach significantly
> since we do not have to count open/close ourselves and define a mutex for that.
> 
> This is already done by the input_dev. So I should improve this part of our patches
> before resending to input list. Thanks for inpsiring this.
> 
I see from the next mail you found the polled code.  Dmitry would have kicked back
on that if you hadn't (we have had this a few times before ;)

> > 5. The patch break up is very very random.  Just have one patch :)  
> 
> Well, it tries to have small pieces in a specific order that you can bisect and
> do not run into compile problems (e.g. adding Makefile before code).
> 
> But I can squash it. Seems to make sense since it is not really useful to know
> which of these pieces breaks other things. It can only be the driver
> and bisect will still pin-point it.

Quite. It's really one new function so keeping it in one patch is fine.

Patch break up of large new changes is always an interesting one.  Sometimes
it's much easier to review a 2000 line patch than 5 smaller ones, but
conversely a 2000 line patch doesn't always fit into lunch time ;)
> 
> > 
> > Anyhow, I'll take a look in detail but may be a little while.  
> 
> No reason to hurry. We can wait.
> 
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Thanks and BR,
> Nikolaus
Great to have this 'hole' filled at last. I've been moaning about it for
years but never actually got interested enough to do it myself!

Jonathan

> 
> > 
> >   
> >> 
> >> H. Nikolaus Schaller (4):
> >>  iio: input-bridge: optionally bridge iio acceleometers to create a
> >>    /dev/input
> >>  iio: input-bridge: add iio-input-bridge to Makefile
> >>  iio: input-bridge: add IIO_INPUT_BRIDGE kernel config option
> >>  iio: input-bridge: make the iio-input-bridge driver called by iio-core
> >> 
> >> drivers/iio/Kconfig                    |   7 +
> >> drivers/iio/Makefile                   |   1 +
> >> drivers/iio/industrialio-core.c        |  12 +
> >> drivers/iio/industrialio-inputbridge.c | 420 +++++++++++++++++++++++++
> >> drivers/iio/industrialio-inputbridge.h |  28 ++
> >> 5 files changed, 468 insertions(+)
> >> create mode 100644 drivers/iio/industrialio-inputbridge.c
> >> create mode 100644 drivers/iio/industrialio-inputbridge.h
> >>   
> >   
> 

