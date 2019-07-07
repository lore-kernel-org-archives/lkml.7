Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFBDC0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 02:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610982083E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 02:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="meQffMhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfGGCNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 22:13:42 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36960 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfGGCNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 22:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1562465617; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fznRMUZAZm3iHbL6qyuoO4hMPI4FOSHJ7kLY24FuOZI=;
        b=meQffMhT7/byhhbXYDtJprcmMUATZqkEpI4hd/tl1CTIQpbwPpKL89XDPJuGJoZs1xXYOl
        Ll9syGbefwxlBQmfKwnalmU4Phk/ERo+/kUKCFpZNrPFfY7s6C5i0V1XXjsm/WPD0yd+L8
        V/7mBH4OZfdNPMa2cY/1IwKj2Q3cOKQ=
Date:   Sat, 06 Jul 2019 22:13:13 -0400
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        od@zcrc.me, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1562465593.2019.0@crapouillou.net>
In-Reply-To: <20190625094756.GC1516@ulmo>
References: <20190522163428.7078-1-paul@crapouillou.net>
        <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
        <20190621135608.GB11839@ulmo> <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
        <1561386717.20436.0@crapouillou.net> <20190625094756.GC1516@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mar. 25 juin 2019 =E0 5:47, Thierry Reding <thierry.reding@gmail.com>=20
a =E9crit :
> On Mon, Jun 24, 2019 at 04:31:57PM +0200, Paul Cercueil wrote:
>>=20
>>=20
>>  Le lun. 24 juin 2019 =E0 13:28, Daniel Thompson=20
>> <daniel.thompson@linaro.org> a
>>  =E9crit :
>>  > On Fri, Jun 21, 2019 at 03:56:08PM +0200, Thierry Reding wrote:
>>  > >  On Fri, Jun 21, 2019 at 01:41:45PM +0100, Daniel Thompson=20
>> wrote:
>>  > >  > On 22/05/2019 17:34, Paul Cercueil wrote:
>>  > >  > > When the driver probes, the PWM pin is automatically=20
>> configured
>>  > > to its
>>  > >  > > default state, which should be the "pwm" function.
>>  > >  >
>>  > >  > At which point in the probe... and by who?
>>  > >
>>  > >  The driver core will select the "default" state of a device=20
>> right
>>  > > before
>>  > >  calling the driver's probe, see:
>>  > >
>>  > >  	drivers/base/pinctrl.c: pinctrl_bind_pins()
>>  > >
>>  > >  which is called from:
>>  > >
>>  > >  	drivers/base/dd.c: really_probe()
>>  > >
>>  >
>>  > Thanks. I assumed it would be something like that... although=20
>> given
>>  > pwm-backlight is essentially a wrapper driver round a PWM I=20
>> wondered why
>>  > the pinctrl was on the backlight node (rather than the PWM node).
>>  >
>>  > Looking at the DTs in the upstream kernel it looks like ~20% of=20
>> the
>>  > backlight drivers have pinctrl on the backlight node. Others=20
>> presumable
>>  > have none or have it on the PWM node (and it looks like support=20
>> for
>>  > sleeping the pins is *very* rare amoung the PWM drivers).
>>=20
>>  If your PWM driver has more than one channel and has the pinctrl=20
>> node, you
>>  cannot fine-tune the state of individual pins. They all share the=20
>> same
>>  state.
>=20
> But that's something that could be changed, right? We could for=20
> example
> extend the PWM bindings to allow describing each PWM instance via a=20
> sub-
> node of the controller node. Pin control states could be described on=20
> a
> per-channel basis that way.

There could be an API to dynamically add/remove pin groups to a given
pinctrl state. The PWM driver would start with an empty (no groups)
"default" state, then when enabling e.g. PWM1, the driver would call
a function to add the "pwm1" pin group to the "default" state.

Does that sound like a good idea?

Thanks,
-Paul


>>  > >  > > However, at this
>>  > >  > > point we don't know the actual level of the pin, which may=20
>> be
>>  > > active or
>>  > >  > > inactive. As a result, if the driver probes without=20
>> enabling the
>>  > >  > > backlight, the PWM pin might be active, and the backlight=20
>> would
>>  > > be
>>  > >  > > lit way before being officially enabled.
>>  > >  > >
>>  > >  > > To work around this, if the probe function doesn't enable=20
>> the
>>  > > backlight,
>>  > >  > > the pin is set to its sleep state instead of the default=20
>> one,
>>  > > until the
>>  > >  > > backlight is enabled. Whenk the backlight is disabled, the=20
>> pin
>>  > > is reset
>>  > >  > > to its sleep state.
>>  > >  > Doesn't this workaround result in a backlight flash between
>>  > > whatever enables
>>  > >  > it and the new code turning it off again?
>>  > >
>>  > >  Yeah, I think it would. I guess if you're very careful on how=20
>> you
>>  > > set up
>>  > >  the device tree you might be able to work around it. Besides=20
>> the
>>  > > default
>>  > >  and idle standard pinctrl states, there's also the "init"=20
>> state. The
>>  > >  core will select that instead of the default state if=20
>> available.
>>  > > However
>>  > >  there's also pinctrl_init_done() which will try again to=20
>> switch to
>>  > > the
>>  > >  default state after probe has finished and the driver didn't=20
>> switch
>>  > > away
>>  > >  from the init state.
>>  > >
>>  > >  So you could presumably set up the device tree such that you=20
>> have
>>  > > three
>>  > >  states defined: "default" would be the one where the PWM pin is
>>  > > active,
>>  > >  "idle" would be used when backlight is off (PWM pin inactive)=20
>> and
>>  > > then
>>  > >  another "init" state that would be the same as "idle" to be=20
>> used
>>  > > during
>>  > >  probe. During probe the driver could then switch to the "idle"
>>  > > state so
>>  > >  that the pin shouldn't glitch.
>>  > >
>>  > >  I'm not sure this would actually work because I think the way=20
>> that
>>  > >  pinctrl handles states both "init" and "idle" would be the same
>>  > > pointer
>>  > >  values and therefore pinctrl_init_done() would think the driver
>>  > > didn't
>>  > >  change away from the "init" state because it is the same=20
>> pointer
>>  > > value
>>  > >  as the "idle" state that the driver selected. One way to work=20
>> around
>>  > >  that would be to duplicate the "idle" state definition and
>>  > > associate one
>>  > >  instance of it with the "idle" state and the other with the=20
>> "init"
>>  > >  state. At that point both states should be different (different
>>  > > pointer
>>  > >  values) and we'd get the init state selected automatically=20
>> before
>>  > > probe,
>>  > >  select "idle" during probe and then the core will leave it=20
>> alone.
>>  > > That's
>>  > >  of course ugly because we duplicate the pinctrl state in DT,=20
>> but
>>  > > perhaps
>>  > >  it's the least ugly solution.
>>  > >  Adding Linus for visibility. Perhaps he can share some insight.
>>  >
>>  > To be honest I'm happy to summarize in my head as "if it flashes=20
>> then
>>  > it's not
>>  > a pwm_bl.c's problem" ;-).
>>=20
>>  It does not flash. But the backlight lits way too early, so we have=20
>> a 1-2
>>  seconds
>>  of "white screen" before the panel driver starts.
>=20
> I think this always goes both ways. If you set the sleep state for the
> PWM on backlight probe with this patch, you may be able to work around
> the problem of the backlight lighting up too early. But what if your
> bootloader had already enabled the backlight and is showing a splash
> screen during boot? Your patch would turn off the backlight and then=20
> it
> would turn on again after everything else was initialized. That's one
> type of flashing.
>=20
> What we need in this case are explicit pin control states that will
> enable fine-grained control over what happens. Anything implicit is
> bound to fail because it bakes in an assumption (either that the
> backlight is off during boot, or that it has been turned on already).
>=20
> Ideally we'd need to detect that the backlight is on and if it is we
> just don't do anything with it. Actually, I think that's what we want
> even if the backlight is off. During probe the backlight state should
> not be modified. You only want to modify it when you know that some
> display driver is going to take over. If you can't seamlessly=20
> transition
> to the kernel display driver, flashing may be okay. If your display
> driver can take over seamlessly, then the backlight is likely already=20
> in
> the desired state anyway.
>=20
> Thierry

=

