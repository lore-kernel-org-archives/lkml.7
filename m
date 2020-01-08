Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBF9C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E021720692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578494097;
	bh=+ijf0zU1Olk+MDBlOFcuEutR1Sxne0PzsMS79mJVqac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sI1wYvm0pptACXyLNmLeybOD99nwyD7cFsOb7IdIsnDetHnFA1jkeM5jfwJhwktVM
	 QWC/BJ+Krm8UXx+L36H/3Y+sM3XHprrg7/XNFyn/XKwOzYTz06vDv1InxRaRCLkzfm
	 9max5/aD5obnGBZn6Q1R1HyV1BJF/WvZ344pBDQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgAHOe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:34:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44357 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgAHOez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:34:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so2584686lfa.11;
        Wed, 08 Jan 2020 06:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=824DREfVtGOqPtnTTEqvugWfuWheR7SX+op0ZpMFy3Y=;
        b=BYkHgMeYBiaJp9vlWGlrMmEt3MWURf8MWfH5VoiCvUpXBVQFk1kCpQ+voiDULXlBBW
         7wVK9Sn74ihMPE39/nSaWWG2mioQhs18asmVZcOkhnwUw2mSgckXG8ynCialVC0Dn8PR
         izmDEbQuUmTdx0BYAytA4RCPOM8mPlRzsZhUjgKcMkUGuKDX5ypCX9O+Ng/+n+0epCmU
         9EDSJ9RoMpqJk/v1WLZgJdZjH4EsDyfRmqbpm8jt01KVcD777MKZuO6BOJWNnmTafSL5
         QSTZUNwsWm+gfvD6mIlWp30/8nMeYcGuGNT9+cHIyoKtrWtOnzLn1ia50iIVLRWLQzh2
         /gYA==
X-Gm-Message-State: APjAAAVu20sQBz/1hVymzeiTW1ZnMxlFNhMydKsWemoU+GF52XtXLOr6
        TVIaZn3qC+DgXvbcw0eFU68=
X-Google-Smtp-Source: APXvYqzJ/GZfoSbWjRky7RjaYlwFm779nafQGw+LCathmyKCM1XCYls2ZNGIatzNHbo6oybj0iTBvg==
X-Received: by 2002:ac2:5498:: with SMTP id t24mr2915482lfk.84.1578494093653;
        Wed, 08 Jan 2020 06:34:53 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id g27sm1496050lfj.49.2020.01.08.06.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 06:34:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ipCQI-0001Es-1a; Wed, 08 Jan 2020 15:35:02 +0100
Date:   Wed, 8 Jan 2020 15:35:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 5/7] USB: serial: f81232: Set F81534A serial port with
 RS232 mode
Message-ID: <20200108143502.GJ30908@localhost>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-6-hpeter+linux_kernel@gmail.com>
 <20191023115300.GU24768@localhost>
 <f3a8b0bd-79f7-3bef-4d07-69774c87873a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3a8b0bd-79f7-3bef-4d07-69774c87873a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Sorry about the late reply. Had a change to look into this again today.

On Thu, Oct 24, 2019 at 04:52:01PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Hi Johan,
> 
> Johan Hovold 於 2019/10/23 下午 07:53 寫道:
> > On Mon, Sep 23, 2019 at 10:24:47AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> >> The Fintek F81532A/534A/535/536 is USB-to-2/4/8/12 serial ports device
> >> and the serial ports are default disabled. Each port contains max 3 pins
> >> GPIO and the 3 pins are default pull high with input mode.
> >>
> >> When the serial port had activated (running probe()), we'll transform the
> >> 3 pins from GPIO function publicly to control Tranceiver privately use.
> > 
> > I'm not sure I understand what you're saying here.
> > 
> >> We'll default set to 0/0/1 for control transceiver to RS232 mode.
> >>
> >> Otherwise, If the serial port is not active, the 3 pins is in GPIO mode
> >> and controlled by global GPIO device with VID/PID: 2c42/16f8.
> > 
> > Does this mean that you can control the three GPIOs either through the
> > serial device or through the gpio-control device (which are two separate
> > USB devices)?
> 
> Yes, when 1 F81534A connect to Host, it'll report device as following.
> 	virtual HUB
> 		GPIO Device.
> 		serial port 1
> 		...
> 		serial port n

Could you post lsusb -v output for this with a couple of UARTs enabled?

> The link are F81534A pin-out:
> 	https://imgur.com/a/AZHqQ1N

Do you have a datasheet for the device?

I think I'm starting to get an idea of how this work, but I really don't
like having to spend this much time on detective work just to understand
how the hw works.

> So we can control F81534A series all GPIO pins via GPIO Device.
> Serial ports are also control MODE0_x,  MODE1_x,  MODE2_x
> (e.g. UART1 MODE0_1,  MODE1_1,  MODE2_1), but when Serial ports
> is h/w disabled (DTR pull low), the mode pin will change to GPIO pin.

So you tie a ports DTR pin, even though it's normally an output, and use
that at boot to determine whether the UART should be enabled or not?

And the GPIO device can only control a pin if the corresponding port is
disabled?

Can you read back the enable state of each port?

> > Ok, so you reset the tranceiver config on every probe.
> > 
> > Are the three GPIOs always connected to one particular tranceiver, or
> > are they truly general purpose?
> > 
> > In the latter case, it doesn't seem like a good idea to drive pins 0
> > and 1 low here as you have know idea what they're used for.
> 
> If we want to change the mode pin to GPIO pin, it need do h/w disable.
> It the serial ports are activated, the 3 pin will be mode pin and set
> default 0/0/1 to RS232 mode due to this driver not implement RS422/485
> currently.

What about devices using a different tranceiver? Should the state of the
mode pins ultimately be tied to VID/PID (can your customers change
VID/PID)?

Johan
