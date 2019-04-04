Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE57EC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69780206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFpOz+9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfDDGzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:55:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42886 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDDGzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:55:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so668533plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vx0O0iEpOiOKhCclt6sNW+D4t+d7kp/aGeMgIwxZxc0=;
        b=zFpOz+9Irr7tiVhuBeeTHeKjjtdiCtjF4t1yamLGMj5KmcENd8yOgYwdEBUnZpSIFH
         M28PJwbVxk+ft/CUq2QMgRJomMhPMOZ4aH1JfE5EANTYJlPu6TeRL/LqngFN+OVfMGL1
         +Cka+/E7MUiZcurRUbIl9qWy72/ihMnzYJ+z7uFRfSSEiZ3g17+FEwQHcy/LKxT9dOnT
         MrHzyiVx3Lf2m5kqX8knYIk3Y8b+Z8Ybs+7/CsotrRhb7dfAu1565DXKot8LaqbEGJbM
         hgzQ2ezYaRRAvdjLEgZaS2tFWl+y3phONYKLZgTmWgUwJ5pOPL9OLm2/WQAH4qPpjoui
         x3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vx0O0iEpOiOKhCclt6sNW+D4t+d7kp/aGeMgIwxZxc0=;
        b=EXLexYVXnkIe3inNtiOnaf8Kq+Oa4OjJY+LMKzAripe9o9w3vFPacJOk2JjmVyyWCx
         75cL/qlYcDl0oxJm4sqJsZDZ2swCFnbRbcDtFYODhxrPMXDv8HJCS5X8fQ+PpTIsRZqf
         36gpuedDqEcT0JRGuRlbBIw9HDbwYfbJkIOLMiLjBNgvGT15ZB6jCkLe4yKDLI8f703P
         F81ZQZ4yhxYq80REjkQRTT79Xw+fJXNBWkYk+Uo72xdiQa7J6r8Rzt2fzpcWA/PbB0nO
         oxmpG6d1Z/AMUhocMEkhLO1efieobgYviUBd3TSdHfehk+4MDzvoAokM7+oSm2i2KadP
         SgQg==
X-Gm-Message-State: APjAAAXV5WJqtxCr0vT48w1Ok7F6XvFhE0aUm/bPCtJWcBCquKZN12Sl
        tEeapXcdI7p+2f5GUU2SFmhgiA==
X-Google-Smtp-Source: APXvYqxCSPY1sgR0Kq1ehi9dm4MAV09W+rU4HhE+3s2ywK7ymmAC1ZD+rK24CRHVdri8s0e9oNH+ig==
X-Received: by 2002:a17:902:7481:: with SMTP id h1mr4666272pll.206.1554360903157;
        Wed, 03 Apr 2019 23:55:03 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id r11sm39031809pga.87.2019.04.03.23.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 23:55:01 -0700 (PDT)
Date:   Thu, 4 Apr 2019 07:54:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Message-ID: <20190404065452.GD6830@dell>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <39efebe0396dd42de30d37c6f3c1ef2926c90210.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <20190403073152.GM4187@dell>
 <20190403084732.GA3493@localhost.localdomain>
 <20190403093015.GJ11301@dell>
 <20190403101003.GC3493@localhost.localdomain>
 <20190403112559.GP11301@dell>
 <85b20828bb4fb51e6df1d5d9d1c1f667db3a7c48.camel@fi.rohmeurope.com>
 <20190404025234.GB6830@dell>
 <6775a75d1ee3ab96123d84b077881beedc358d12.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6775a75d1ee3ab96123d84b077881beedc358d12.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Apr 2019, Vaittinen, Matti wrote:

> On Thu, 2019-04-04 at 03:52 +0100, Lee Jones wrote:
> > On Wed, 03 Apr 2019, Vaittinen, Matti wrote:
> > 
> > > On Wed, 2019-04-03 at 12:25 +0100, Lee Jones wrote:
> > > > On Wed, 03 Apr 2019, Matti Vaittinen wrote:
> > > > 
> > > > > On Wed, Apr 03, 2019 at 10:30:15AM +0100, Lee Jones wrote:
> > > > > > On Wed, 03 Apr 2019, Matti Vaittinen wrote:
> > > > > > 
> > > > > > > Hello Lee,
> > > > > > > 
> > > > > > > Thanks for taking a look on this again =) I agree with most
> > > > > > > of
> > > > > > > the
> > > > > > > comments and correct them at next version.
> > > > > > > 
> > > > > > > On Wed, Apr 03, 2019 at 08:31:52AM +0100, Lee Jones wrote:
> > > > > > > > On Mon, 25 Mar 2019, Matti Vaittinen wrote:
> > > > > > > > 
> > > > > > > > > ROHM BD70528MWV is an ultra-low quiescent current
> > > > > > > > > general
> > > > > > > > > purpose single-chip power management IC for battery-
> > > > > > > > > powered
> > > > > > > > > portable devices.
> > > > > > > > > 
> > > > > > > > > Add MFD core which enables chip access for following
> > > > > > > > > subdevices:
> > > > > > > > > 	- regulators/LED drivers
> > > > > > > > > 	- battery-charger
> > > > > > > > > 	- gpios
> > > > > > > > > 	- 32.768kHz clk
> > > > > > > > > 	- RTC
> > > > > > > > > 	- watchdog
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Matti Vaittinen <
> > > > > > > > > matti.vaittinen@fi.rohmeurope.com>
> > > > > > > > > + * Mapping of main IRQ register bits to sub irq
> > > > > > > > > register
> > > > > > > > > offsets so
> > > > > > > > 
> > > > > > > > "sub-IRQ"
> > > > > > > > 
> > > > > > > > > + * that we can access corect sub IRQ registers based
> > > > > > > > > on
> > > > > > > > > bits that
> > > > > > > > 
> > > > > > > > "sub IRQ" is also fine, but please standardise.
> > > > > > > > 
> > > > > > > > I do prefer "sub-IRQ" though.
> > > > > > > 
> > > > > > > I'll go with "sub-IRQ" then
> > > > > > > 
> > > > > > > > > +
> > > > > > > > > +#define WD_CTRL_MAGIC1 0x55
> > > > > > > > > +#define WD_CTRL_MAGIC2 0xAA
> > > > > > > > > +/**
> > > > > > > > > + * bd70528_wdt_set - arm or disarm watchdog timer
> > > > > > > > > + *
> > > > > > > > > + * @data:	device data for the PMIC instance we
> > > > > > > > > want to
> > > > > > > > > operate on
> > > > > > > > > + * @enable:	new state of WDT. zero to disable, non
> > > > > > > > > zero to enable
> > > > > > > > > + * @old_state:	previous state of WDT will be filled
> > > > > > > > > here
> > > > > > > > > + *
> > > > > > > > > + * Arm or disarm WDT on BD70528 PMIC. Expected to be
> > > > > > > > > called only by
> > > > > > > > > + * BD70528 RTC and BD70528 WDT drivers. The
> > > > > > > > > rtc_timer_lock
> > > > > > > > > must be taken
> > > > > > > > > + * by calling bd70528_wdt_lock before calling
> > > > > > > > > bd70528_wdt_set.
> > > > > > > > > + */
> > > > > > > > > +int bd70528_wdt_set(struct rohm_regmap_dev *data, int
> > > > > > > > > enable, int *old_state)
> > > > > > > > 
> > > > > > > > Why doesn't this reside in the watchdog driver?
> > > > > > > 
> > > > > > > If my memory serves me right we shortly discussed this
> > > > > > > already
> > > > > > > during v8
> > > > > > > review ;) Cant blame you though as I have seen some of the
> > > > > > > mail
> > > > > > > traffic
> > > > > > > going through your inbox :D
> > > > > > > 
> > > > > > > The motivation to have the functions exported from MFD is
> > > > > > > to
> > > > > > > not create
> > > > > > > sirect dependency between RTC and WDT. There may be cases
> > > > > > > where
> > > > > > > we want
> > > > > > > to leave either RTC or WDT out of compilation. MFD is
> > > > > > > always
> > > > > > > needed so
> > > > > > > the dependency from MFD to RTC/WDT does not harm.
> > > > > > > 
> > > > > > > (Here's some discussion necromancy if you are interested in
> > > > > > > re-
> > > > > > > reading
> > > > > > > how we did end up with this implementation:
> > > > > > > https://lore.kernel.org/lkml/20190212091723.GZ20638@dell/)
> > > > > > > 
> > > > > > > I hope you are still Ok with having the WDT control
> > > > > > > functions
> > > > > > > in MFD.
> > > > > > 
> > > > > > OOI, why does the RTC need to control the WDT?
> > > > > 
> > > > > I thought I had a comment about this somewhere in code... O_o
> > > > > Must
> > > > > have
> > > > > been in some development branch I had :/
> > > > > 
> > > > > Anyways, setting the RTC counter may cause watchdog to trigger.
> > > > > It
> > > > > is not
> > > > > further explained why but I would guess watchdog uses RTC
> > > > > counter
> > > > > to check
> > > > > if it should've been pinged already. So RTC needs to disable
> > > > > watch
> > > > > dog for
> > > > > the duration of hwclock setting and enable it again after the
> > > > > new
> > > > > time is
> > > > > set. I can add a comment about this to MFD driver if it helps
> > > > > :)
> > > > 
> > > > How does the user select between using the RTC and the WDT?
> > > > 
> > > > Or are the generally both enabled at the same time?
> > > > 
> > > 
> > > Both RTC and WDT can be enabled at the same time. But they are not
> > > required to be used. When WDT is enabled, it uses current RTC time
> > > as
> > > 'base' (and RTC time is running no matter if we have the RTC driver
> > > here or not) - and time-out gets scheduled to specified amount of
> > > time
> > > into future. (Same setting timeout into the future happens when WDT
> > > is
> > > pinged).
> > > 
> > > When we set RTC, we disable WDT (if it was enabled), set clock and
> > > re-
> > > enable WDT. This causes the previously used time-out value to be
> > > set to
> > > WDT again. This works Ok because BD70528 does not support 'short
> > > ping
> > > detection'. Only side-effect will be one 'prolonged' WDT feeding
> > > period
> > > when RTC is set. (absolute time when RTC was set minus absolute
> > > time
> > > when previous WD ping or enable was done) longer than reqular
> > > period.
> > > 
> > > So user should not need to care about this 'dependency'. Basically
> > > the
> > > only possible problem I see is that someone could accidentally hang
> > > the
> > > system with something that keeps setting the RTC time - this would
> > > then
> > > prevent watch dog from doing the reset. This, I believe, is a
> > > corner
> > > case which I don't consider now - and if this is considered to be
> > > an
> > > issue then such a system may disable the RTC driver and do RTC
> > > setting
> > > in a what-ever-manner sees practical.
> > > 
> > > I'm not sure if I answered to question you asked though =)
> > 
> > I think you answered it just fine.
> > 
> > So my suggestion is to have the RTC depend on the WRT via Kconfig,
> > and
> > place this WRT code in the WRT driver where it belongs.  These
> > functions can be exported from the WRT driver and the RTC can call
> > into them in the same way it calls into the MFD driver currently.
> 
> Yes, we could. But then we need to always compile the watch dog driver
> when we want to use RTC. It is not a huge driver though so it probably
> won't matter. So, I don't like this but I can do it so if you insist :]
> 
> > Avoiding a dependency on the WRT would seem strange, because there is
> > one.
> 
> The dependency is artificial. It's caused by the current driver design.
> If watchdog is not used, then RTC has no reason to touch the watchdog
> block. RTC works just fine without watchdog. So from HW point there is
> no dependency.

Great.

> Actually, now that I thik of it the right way to do this would have
> been the function pointer in parent data as was done in original patch
> set. HW-colleagues tend to re-use HW blocks, and we like to re-use our
> drivers. If the next PMIC from ROHM uses same RTC block but does not
> provide watchdog - then it is cleanest solution to fall back to
> function pointer and leave it to NULL when there is no WDT or when WDT
> is unused. Another option is to export dummy function - which is not so
> nice.

I think the converse is true.

Pointers to functions outside of a subsystem API context are generally
horrible.  It's much nicer to call a function which can be easily
stubbed out in a header file based on a Kconfig option.  It's how most
kernel APIs work.

Have a look for yourself how many there are:

 git grep -A5 inline -- include/linux/

> Additional benefit from function pointer would have been that the
> function pointer can be only used by drivers which have acces to it.
> This exported function is globally visible. The WDT disable/enable is
> very specific procedure and it actually would be nicer design to not
> have it visible globally. It is not intended to be used by anything
> else besides the WDT and RTC here.

Why would anything else try to use it?

There are 1000's of exported functions in the kernel.  If it's
properly namespaced a consumer would have to purposely call it, which
if they really wanted to, they could do anyway.  I don't really see
your point.

> But I can't say there will be PMIC with same RTC and no WDT coming from
> ROHM. Also, I am not terribly excited about the option of changing this
> back to function-pointer as I already removed the pointer from parent
> data and this changed parent data is already adapted to all sub drivers
> - so this is all just babbling. Maybe it is just my huge ego shouting
> there - 'I was right, I must have the final say'.

No, a call-back function would be a back-step.

Ego or no ego, you're wrong. =:-D

> As a side note, I already did submit v12 with other styling fixes but
> which left the WDT function in MFD. If you still see the WDT functions
> should be exported from WDT - then please ignore the v12. I'll do v13
> at the afternoon (my time, which is only a bit after noon your time I
> guess) which will export these functions from WDT. (Well, I had to try
> once more :D)

Please keep the WDT code in the WDT driver.  Create a little stub for
the cases where the WDT driver is not enabled - job done.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
