Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEC3C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8832147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="BIgVMtnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfCKUwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:52:18 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41044 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbfCKUwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552337532; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAYOZELSccEKSBPbHE4V3eEftTDyZTpp36j9E5JQ3jI=;
        b=BIgVMtnVwd5QwyHK2BtEEqhHNhzUqIiC3AUNz1AtaynR4D4EB2BYCCYptV+o2QS2axcMKY
        3QsrTXpCpkg0IHSmykB+vYveWPQ9Cl5kdAlJV56fa3M6ra/krK/2UUNyZbi9FvBd2W6fvr
        UQnJQ9itGGSGP218qAYHOIyJgAKteZc=
Date:   Mon, 11 Mar 2019 17:52:07 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v10 04/27] clocksource: Add a new timer-ingenic driver
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Message-Id: <1552337527.24876.0@crapouillou.net>
In-Reply-To: <20190308102225.GC22655@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
        <20190302233413.14813-5-paul@crapouillou.net> <20190304122250.GC9040@ulmo>
        <1551723186.4932.0@crapouillou.net> <20190308102225.GC22655@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

Le ven. 8 mars 2019 =E0 7:22, Thierry Reding <thierry.reding@gmail.com>=20
a =E9crit :
> On Mon, Mar 04, 2019 at 07:13:05PM +0100, Paul Cercueil wrote:
>>  Hi Thierry,
>>=20
>>  On Mon, Mar 4, 2019 at 1:22 PM, Thierry Reding=20
>> <thierry.reding@gmail.com>
>>  wrote:
>>  > On Sat, Mar 02, 2019 at 08:33:50PM -0300, Paul Cercueil wrote:
>>  > [...]
>>  > >  diff --git a/drivers/clocksource/ingenic-timer.c
>>  > > b/drivers/clocksource/ingenic-timer.c
> [...]
>>  > >  +static u64 notrace ingenic_tcu_timer_read(void)
>>  > >  +{
>>  > >  +	unsigned int channel =3D ingenic_tcu->cs_channel;
>>  > >  +	u16 count;
>>  > >  +
>>  > >  +	count =3D readw(ingenic_tcu_base + TCU_REG_TCNTc(channel));
>>  >
>>  > Can't yo do this via the regmap?
>>=20
>>  I could, but for the sched_clock to be precise the function must=20
>> return
>>  as fast as possible. That's the rationale behind the use of readw()=20
>> here.
>>=20
>>  That's also the reason why ingenic_tcu_base is global and exported,=20
>> so
>>  that the OS Timer driver can use it as well.
>=20
> Is the path through the regmap really significantly slower than the
> direct register access? Anyway, if you need the global anyway, might=20
> as
> well use it.

About 10% slower.

> [...]
>>  > >  +	// Register the sched_clock at the very end as there's no=20
>> way to
>>  > > undo it
>>  > >  +	rate =3D clk_get_rate(tcu->cs_clk);
>>  > >  +	sched_clock_register(ingenic_tcu_timer_read, 16, rate);
>>  >
>>  > Oh wow... so you managed to nicely encapsulate everything and now=20
>> this
>>  > seems to be the only reason why you need to rely on global=20
>> variables.
>>  >
>>  > That's unfortunate. I suppose we could go and add a void *data=20
>> parameter
>>  > to sched_clock_register() and pass that to the read() function.=20
>> That way
>>  > you could make this completely independent of global variables,=20
>> but
>>  > there are 73 callers of sched_clock_register() and they are=20
>> spread all
>>  > over the place, so sounds a bit daunting to me.
>>=20
>>  Yes, that's the main reason behind the use of a global variables.
>>  Is there a way we could introduce another callback, e.g.=20
>> .read_value(),
>>  that would receive a void *param? Then the current .read() callback
>>  can be deprecated and the 73 callers can be migrated later.
>=20
> Yeah, I suppose that would be possible. I'll defer to Daniel and=20
> Thomas
> on this. They may not consider this important enough.
>=20
>>  > >  +
>>  > >  +	return 0;
>>  > >  +
>>  > >  +err_tcu_clocksource_cleanup:
>>  > >  +	ingenic_tcu_clocksource_cleanup(tcu);
>>  > >  +err_tcu_clk_cleanup:
>>  > >  +	ingenic_tcu_clk_cleanup(tcu, np);
>>  > >  +err_tcu_intc_cleanup:
>>  > >  +	ingenic_tcu_intc_cleanup(tcu);
>>  > >  +err_clk_disable:
>>  > >  +	clk_disable_unprepare(tcu->clk);
>>  > >  +err_clk_put:
>>  > >  +	clk_put(tcu->clk);
>>  > >  +err_free_regmap:
>>  > >  +	regmap_exit(tcu->map);
>>  > >  +err_iounmap:
>>  > >  +	iounmap(base);
>>  > >  +	release_mem_region(res.start, resource_size(&res));
>>  > >  +err_free_ingenic_tcu:
>>  > >  +	kfree(tcu);
>>  > >  +	return ret;
>>  > >  +}
>>  > >  +
>>  > >  +TIMER_OF_DECLARE(jz4740_tcu_intc,  "ingenic,jz4740-tcu",
>>  > > ingenic_tcu_init);
>>  > >  +TIMER_OF_DECLARE(jz4725b_tcu_intc, "ingenic,jz4725b-tcu",
>>  > > ingenic_tcu_init);
>>  > >  +TIMER_OF_DECLARE(jz4770_tcu_intc,  "ingenic,jz4770-tcu",
>>  > > ingenic_tcu_init);
>>  > >  +
>>  > >  +
>>  > >  +static int __init ingenic_tcu_probe(struct platform_device=20
>> *pdev)
>>  > >  +{
>>  > >  +	platform_set_drvdata(pdev, ingenic_tcu);
>>  >
>>  > Then there's also this. Oh well... nevermind then.
>>=20
>>  The content of ingenic_tcu_platform_init() could be moved inside
>>  ingenic_tcu_init(). But can we get a hold of the struct device=20
>> before the
>>  probe function is called? That would allow to set the drvdata and=20
>> regmap
>>  without relying on global state.
>=20
> I'm not sure if the driver core is ready at this point. It's likely it
> isn't, otherwise there'd be no need for TIMER_OF_DECLARE(), really. I
> also vaguely recall looking into this a few years ago because of some
> similar work I was but I eventually gave up because I couldn't find a
> way that would allow both the code to execute early enough and still
> use the regular driver model.
>=20
> Platform device become available at arch_initcall_sync (3s), while the
> TIMER_OF_DECLARE code runs way earlier than any of the initcalls, so I
> don't think there's a way to do it. Unless perhaps if the timers can
> be initialized later. I'm not sure if that's possible, and might not=20
> be
> worth it just for the sake of being pedantic.
>=20
> Thierry

I think for the time being I can't really go around using the global=20
variables.
Hopefully that's something that can be fixed in the future.

-Paul
=

