Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53930C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196EF2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561709508;
	bh=CmnzrJlfA2PCuIyNDSecK7GZRrmqzT7wPUEXM+fsAJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GCclVtTux73VzVhtWKX5SmKlMMg0QPAOtTmPz1GZVsu2ICL0LdKSgYHvMTvduANBp
	 AkYCnZPChbyZhnU7GD/ZpNIszkZdzi8w+EO/LH+rOTX2JYeKTccJOv4LmmimrsGVPU
	 O/Rq1Pk3o9w1weaod47SnmbBzoAUw48nWdbCVjNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfF1ILr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:11:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45487 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfF1ILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:11:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so5047767lje.12;
        Fri, 28 Jun 2019 01:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S1iefBjhRA2yoJKT8SLbKMzNPB1tKuDijn/VkBdvWiI=;
        b=a+U6UL9VC1ozGo1pcln1npabWwW1wSysU4ITtt37PhyBBHgqylE8MdDPFxq7Ib8FJY
         5z3cgOB2WlpKzXSuYPqGFdXNQkjs+qxdSdF+I85VfJWf3l6HmDrRBKg2xl4imwIY00ua
         r5rG+o/u13zKSl8p/TmKVJcUc9/7G5Wk1lS4QgkeR2etSQEk0CGPLnKKKhXHRY4uWAgT
         GWDcMD3IoChZWCQXwvA8OGTanOtSoXG+5Q5RekPF5GoHy1hbH22iPavs57o0FekGMzMZ
         8/3KJDaMjq5qH6uNiiWm1OGDV4XcIaGiySsqu70fnFlNz/W90IuzwkfWTCk2l+pHYLUN
         HGFg==
X-Gm-Message-State: APjAAAX0uNyBHpRNAVsyxvnKTWzJd8pChBsN9rbspp0w0siLk3DRqPgf
        pU4AmgJh4uGM0FcIjpihxDc=
X-Google-Smtp-Source: APXvYqxCUA8Zri8ObG/R3mOYCyAbmjM/C3DDb54VuGlg110x6XBjc+/vtiyqTemwgD9cAwF7EyewoQ==
X-Received: by 2002:a2e:5d5a:: with SMTP id r87mr5360202ljb.196.1561709503821;
        Fri, 28 Jun 2019 01:11:43 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v14sm490936ljh.51.2019.06.28.01.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 01:11:42 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1hglyv-0004Jb-5A; Fri, 28 Jun 2019 10:11:41 +0200
Date:   Fri, 28 Jun 2019 10:11:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cp210x: Add cp2108 GPIOs support
Message-ID: <20190628081141.GJ508@localhost>
References: <20190514105358.18818-1-fancer.lancer@gmail.com>
 <20190603125205.GC3668@localhost>
 <20190615225634.fyckt4e7gpnd5fid@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615225634.fyckt4e7gpnd5fid@mobilestation>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 01:56:36AM +0300, Serge Semin wrote:

> > > +/* CP2108 interfaces, gpio (per interface), port-blocks number, GPIO block. */
> > > +#define CP2108_IFACE_NUM		4
> > > +#define CP2108_GPIO_NUM			4
> > > +#define CP2108_PB_NUM			5
> > > +#define CP2108_GPIO_PB			1
> > 
> > Please try to give these more descriptive names; I'd prefer COUNT over
> > NUM when used as a suffix.
> > 
> > Perhaps slap an INDEX suffix on CP2108_GPIO_PB etc.
> 
> Ok. Added CNT and IDX suffixes.

Please spell out COUNT, no need to be that terse here.

> > > +/*
> > > + * CP2108 default pins state. There are five PBs. Each one is with its specific
> > > + * pins-set (see USB Express SDK sources or SDK-based smt application
> > > + * https://github.com/fancer/smt-cp210x for details).
> > > + */
> > > +struct cp2108_state {
> > > +	__le16	mode[CP2108_PB_NUM];	/* 0 - Open-Drain, 1 - Push-Pull */
> > > +	__le16	low_power[CP2108_PB_NUM];
> > > +	__le16	latch[CP2108_PB_NUM];	/* 0 - Logic Low, 1 - Logic High */
> > > +} __packed;
> > 
> > Ok, so you use mode[CP2108_GPIO_PB] to get the pin modes below;
> > what are the other "PB"s used for? Why is it a "port" block, if all 16
> > pins allocated to four different ports are accessible through one block?
> > 
> > Please try to make the comment self-contained (even if you leave some
> > details out). And perhaps we shouldn't refer to proprietary code in
> > here, and in any case the link may go away.
> > 
> 
> Ok added a bit more detailed information regarding the port blocks. But
> I'd prefer to keep the link. First of all I can't provide the complete
> description of the fields here because it would take too much space and
> in fact is pointless since only a single port block with GPIOs is utilized.
> So the link and the SDK info are a good reference to find some details
> (especially due to lacking such an info in the chip datasheet).

I never said it had to be complete, just self-contained for what it's
used for here. I don't want to go browsing random vendor code to figure
out what the code is doing when reviewing or modifying kernel code.

> Secondly even though the code is distributed under the Silicon Labs
> specific license it is open-source.

But it's not necessarily GPL compatible, which is what we care about
here.

Then again, you've already used it as reference for the protocol, so
let's keep it in.

> Finally the link may go away only
> if I removed the application from my github account, which I don't
> intend to.

Ok, didn't notice it was your account.

> > > +/*
> > > + * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 73 bytes.
> > > + * Reset/Suspend latches describe default states after reset/suspend of the
> > > + * pins. The rest are responsible for alternate functions settings of the
> > > + * chip pins (see USB Express SDK sources or SDK-based smt application
> > > + * https://github.com/fancer/smt-cp210x for details).
> > > + */
> > > +struct cp2108_config {
> > > +	struct cp2108_state reset_latch;
> > > +	struct cp2108_state suspend_latch;
> > > +	u8	ip_delay[CP2108_IFACE_NUM];
> > > +	u8	enhanced_fxn[CP2108_IFACE_NUM];
> > > +	u8	enhanced_fxn_dev;
> > > +	u8	ext_clock_freq[CP2108_IFACE_NUM];
> > > +} __packed;
> > > +
> > > +/* CP2108 port alternate functions fields */

So it's really the enhanced_fxn field above right (and not about pin
alternate functions only).

> > > +#define CP2108_GPIO_TXLED_MODE		BIT(0)
> > > +#define CP2108_GPIO_RXLED_MODE		BIT(1)
> > > +#define CP2108_GPIO_RS485_MODE		BIT(2)
> > > +#define CP2108_GPIO_RS485_LOGIC		BIT(3)
> > > +#define CP2108_GPIO_CLOCK_MODE		BIT(4)
> > > +#define CP2108_DYNAMIC_SUSPEND		BIT(5)
> > 
> > No GPIO infix?
> 
> No, because this refers to all pins state when the chip being suspended
> (whether the suspend_latch state is pushed to the pins at the suspend USB
> state), while the rest of the macros are defined for the GPIOs alternative
> functions. I'll add the MODE suffix though.

Ok, does the pins maintain their state if DYNAMIC_SUSPEND is set or cleared?

> > > +	int result, bufsize = sizeof(buf.single);
> > 
> > One declaration per line please, especially when initialising.
> 
> Done. Though I can't remember this being requirement in the kernel
> coding style. Could you give me a link to the corresponding statement?

It's actually mentioned in passing in the coding style, but with a
different motivation.

The general idea is just to avoid unnecessarily terse code.

> > > +
> > > +	/*
> > > +	 * Move the GPIO clock alternative function bit value to the fourth bit
> > > +	 * as the corresponding GPIO pin reside. It shall make the generic
> > > +	 * cp210x GPIO request method being suitable for cp2108 as well.
> > > +	 */
> > 
> > This isn't entirely clear, please try to rephrase.
> > 
> > Which functions are available on which pins? Do the function defines
> > need to be renamed to reflect the pin numbers as for CP2104?
> 
> I wouldn't rename the macros'es, since they describe the functions of
> enhanced_fxn bits. BTW CP2104 doesn't do any renaming anyway, while it
> is doing the same thing as I am here. Instead I added a more descriptive
> comment, so the code hackers would see the reason of the BITs copy-pasting.

My point was that the corresponding macros for cp2104 includes the pin
number in the name (e.g. CP2104_GPIO1_RXLED_MODE), which makes it clear
on which pin each alternate function is available.

> > > +	priv->gpio_altfunc &= ~BIT(3);
> > > +	if (priv->gpio_altfunc & CP2108_GPIO_CLOCK_MODE)
> > > +		priv->gpio_altfunc |= BIT(3);
> > > +
> > > +	/*
> > > +	 * Open-drain mode in combination with a high latch value is used
> > > +	 * to emulate the GPIO input pin.
> > > +	 */
> > > +	priv->gpio_input &= ~priv->gpio_pushpull;
> > 
> > Input mode should only be set when the reset latch value is 1 (see
> > cp2104).
> 
> Yes, and this code does the same thing as the loop in cp2104, but in a single
> line. BTW the cp2104 cp2104_gpioconf_init() method can be simplified in the
> same way.stash@{0}stash@{0}

Not in a single line, you initialised gpio_input to the latch values
several lines above. Please keep the logic in one place, and use
temporaries where appropriate to make the code self-documenting.

I'd prefer a comment here along the lines of those in the other gpio
init functions (e.g. "set input mode iff open-drain and high latch
value").

> It should be also noted that in v2 I fixed a cp2108-related bug in the
> cp210x_gpio_get()/cp210x_gpio_set() methods. So aside from the requested
> alterations the logic of the cp2108 GPIOs setter/getter is bit different
> now.

Ah, guess you had only tested the first port's pins? Possibly another
reason for adding a dedicated cp2108 callback.

I'll comment on the patch itself.

Johan
