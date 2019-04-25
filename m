Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0455C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706CB2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfDYJjZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:39:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36449 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfDYJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:39:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id c35so8900724qtk.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WicqFYFpUiw+qNNhiHaf2HSIZJntSSUfbsdmPyw62lA=;
        b=YLlSDLwwlRuoT6hiK7AZ/3w5abqrqG/fVHRhwWGLQIdutmq/fQkQmHDAKy/MV47AjH
         Isn/nInMMKmvjQYmQWlHEdsAwMH2orz8yhGfQa80QuZ51f1hwZUchilFCOEfnhCBY8PA
         wAetUsEImXrJJM7wtG/aw+bQpUO2jshyOo87wFXumRfpJu8PLmum2mYw5vt8PFOUymtD
         G/LGe8lRD9WoBc62GgtZNPVPwd2RP1M+SMCNYByWA0xzXWyAptgaOzH4DX8Hp9yeJSIa
         n9xTukC7fA3NmAUkAi27kY/1/of4AI6vLUvSFBdo55n9s+LiB5ZEtM05iWfxdUc8BWL0
         o8aQ==
X-Gm-Message-State: APjAAAUaLqNQNEYns8yO6OvYTwnBb+azJCrLRIiJCYUUuXZe0oolV7I7
        w+/vdZkpSY+tjXXgRmjl8ZMRuy5PJErZXD8cCgrLSw==
X-Google-Smtp-Source: APXvYqyeCJHNw6YxhEW/naPC5YHx5lCIWEQ4euI9lL+E93h7JoxQomKXYJvQsUX2/iq2Rpr+osJS6uo7iaYfwLwqzBE=
X-Received: by 2002:a0c:8881:: with SMTP id 1mr2998874qvn.231.1556185163810;
 Thu, 25 Apr 2019 02:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190422031251.11968-1-ronald@innovation.ch> <20190422031251.11968-2-ronald@innovation.ch>
 <CAO-hwJLMZvBGheEtH_iU+mBtE4T3OsT6W+=1x-ewzGGP5Fxp4Q@mail.gmail.com> <20190425081948.GB31301@innovation.ch>
In-Reply-To: <20190425081948.GB31301@innovation.ch>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 25 Apr 2019 11:39:12 +0200
Message-ID: <CAO-hwJKcuptG6X7Y0jrQzyLUzZfsXoyWxMmk=v_aPxJh9iv4Gg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mfd: apple-ibridge: Add Apple iBridge MFD driver.
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-iio@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:19 AM Life is hard, and then you die
<ronald@innovation.ch> wrote:
>
>
>   Hi Benjamin,
>
> Thank you for looking at this.
>
> On Wed, Apr 24, 2019 at 04:18:23PM +0200, Benjamin Tissoires wrote:
> > On Mon, Apr 22, 2019 at 5:13 AM Ronald Tschalär <ronald@innovation.ch> wrote:
> > >
> > > The iBridge device provides access to several devices, including:
> > > - the Touch Bar
> > > - the iSight webcam
> > > - the light sensor
> > > - the fingerprint sensor
> > >
> > > This driver provides the core support for managing the iBridge device
> > > and the access to the underlying devices. In particular, since the
> > > functionality for the touch bar and light sensor is exposed via USB HID
> > > interfaces, and the same HID device is used for multiple functions, this
> > > driver provides a multiplexing layer that allows multiple HID drivers to
> > > be registered for a given HID device. This allows the touch bar and ALS
> > > driver to be separated out into their own modules.
> >
> > Sorry for coming late to the party, but IMO this series is far too
> > complex for what you need.
> >
> > As I read this and the first comment of drivers/mfd/apple-ibridge.c,
> > you need to have a HID driver that multiplex 2 other sub drivers
> > through one USB communication.
> > For that, you are using MFD, platform driver and you own sauce instead
> > of creating a bus.
>
> Basically correct. To be a bit more precise, there are currently two
> hid-devices and two drivers (touchbar and als) involved, with
> connections as follows (pardon the ugly ascii art):
>
>   hdev1  ---  tb-drv
>            /
>           /
>          /
>   hdev2  ---  als-drv
>
> i.e. the touchbar driver talks to both hdev's, and hdev2's events
> (reports) are processed by both drivers (though each handles different
> reports).
>
> > So, how about we reuse entirely the HID subsystem which already
> > provides the capability you need (assuming I am correct above).
> > hid-logitech-dj already does the same kind of stuff and you could:
> > - create drivers/hid/hid-ibridge.c that handles USB_ID_PRODUCT_IBRIDGE
> > - hid-ibridge will then register itself to the hid subsystem with a
> > call to hid_hw_start(hdev, HID_CONNECT_HIDRAW) and
> > hid_device_io_start(hdev) to enable the events (so you don't create
> > useless input nodes for it)
> > - then you add your 2 new devices by calling hid_allocate_device() and
> > then hid_add_device(). You can even create a new HID group
> > APPLE_IBRIDGE and allocate 2 new PIDs for them to distinguish them
> > from the actual USB device.
> > - then you have 2 brand new HID devices you can create their driver as
> > a regular ones.
> >
> > hid-ibridge.c would just need to behave like any other hid transport
> > driver (see logi_dj_ll_driver in drivers/hid/hid-logitech-dj.c) and
> > you can get rid of at least the MFD and the platform part of your
> > drivers.
> >
> > Does it makes sense or am I missing something obvious in the middle?
>
> Yes, I think I understand, and I think this can work. Basically,
> instead of demux'ing at the hid-driver level as I am doing now (i.e.
> the iBridge hid-driver forwarding calls to the sub-hid-drivers), we
> demux at the hid-device level (events forwarded from iBridge hdev to
> all "virtual" sub-hdev's, and requests from sub-hdev's forwarded to
> the original hdev via an iBridge ll_driver attached to the
> sub-hdev's).
>
> So I would need to create 3 new "virtual" hid-devices (instances) as
> follows:
>
>   hdev1  ---  vhdev1  ---  tb-drv
>                         /
>           --  vhdev2  --
>          /
>   hdev2  ---  vhdev3  ---  als-drv
>
> (vhdev1 is probably not strictly necessary, but makes things more
> consistent).

Oh, ok.

How about the following:

hdev1 and hdev2 are merged together in hid-apple-ibridge.c, and then
this driver creates 2 virtual hid drivers that are consistent

like

hdev1---ibridge-drv---vhdev1---tb-drv
hdev2--/           \--vhdev2---als-drv
>
> > I have one other comment below.
> >
> > Note that I haven't read the whole series as I'd like to first get
> > your feedback with my comment above.
>
> Agreed: let's first get the overall strategy stabilized (also so I
> can avoid having to rewrite the code too many more times ;-) ).
>
> [snip]
> > > +static __u8 *appleib_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> > > +                                 unsigned int *rsize)
> > > +{
> > > +       /* Some fields have a size of 64 bits, which according to HID 1.11
> > > +        * Section 8.4 is not valid ("An item field cannot span more than 4
> > > +        * bytes in a report"). Furthermore, hid_field_extract() complains
> >
> > this must have been fixed in 94a9992f7dbdfb28976b565af220e0c4a117144a
> > which is part of v5.1, so not sure you actually need the report
> > descriptor fixup at all.
>
> Wasn't aware of this change - thanks. Yes, with that the warning
> message should be gone and this fixup can be avoided.
>
> One thing I find strange, though, is that while 94a9992f7dbd changes
> the condition at which the warning is emitted, it still truncates the
> value to 32 bits, albeit completely silently now for lengths between
> 32 and 256 bits. I.e. I'm somewhat surprised that hid_field_extract()
> (and __extract() ) weren't updated to actually return the full values
> for longer fields. Either that, or the callers of hid_field_extract()
> changed to read longer fields in 32 bit chunks.

facepalm.

Yep this commit is just hiding the dust under the carpet. Let's raise
that and request a revert :/

Cheers,
Benjamin

>
>
>   Cheers,
>
>   Ronald
>
