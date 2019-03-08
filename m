Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D16C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8967F2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epBVeoos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfCHKWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:22:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37007 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfCHKWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:22:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id w6so20750742wrs.4;
        Fri, 08 Mar 2019 02:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IpZDsQhgbJoZdZVetbX8Dzz68rld3uU7ePrvGFTagJo=;
        b=epBVeoos4I1Kw6ngvIgmb7IQJ5FC943s4RNA+w13IUFY5mngW9IZXCx9cCzy6+yo9z
         l5fiOzRYttup7XRApbdlnJ1I9dcyiauoBq6yJEtPJpRhgDzdN1Bvj20CiLo64KEtMX5Y
         SuiW32c76NRcRwm0Z9BfCMOK00Pn6IyJjCesCG6B+rJ2c5ch9w5rZWhq7xRqOijReyBA
         ItqbmS/NAOg/2HBdYO8pQnrLRyJU0J1HBCBkEVzbnrtrflRs+ik/nVK+bFe4bC6muKRq
         BMSZfKZb6Ww2phpGp1/t9ZUBN0r2c2PNM8UXMUvRx/YypKYsssLvCz82SAspeGuadSCA
         WFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IpZDsQhgbJoZdZVetbX8Dzz68rld3uU7ePrvGFTagJo=;
        b=efZaeZiWNlE3TRoSsOS/awHdrIyUNiD1dfvK1WBECC0nWch1OThcsfXgVHrb5Dw/6T
         bOzOAWu3mbYmqV8aySwHz2vpVV+Y/1ndcgvc/Cx6kgPvsuyS5yHZSDl0XYKh0GEAyFl4
         zWInCHf98QXPv2ZDGD0PnkEPiQF28ldlCleGTjb5EcgQpJxbguHi/DnuVU08JR9MPKPp
         bA6jiw3RB3G6w6/4qWI13AzEp5gRGR0gRDn2UqwqXpVjHziHZ7joXaL8hYs8Mwb4gleC
         +aXDhG+ZrVPmM0wO/7abyDwKST5gKSUWED4sdLL+r8QHGhCfJuyI8oRum2IpkmLW7+q+
         nBTg==
X-Gm-Message-State: APjAAAWwdkjZ1LzfT04NsT4cA/kJ6a2l8OEpgTf3WofAyBOYs/R0/ix2
        pFxRIJC3G1ZjLrMiPv8Olw0=
X-Google-Smtp-Source: APXvYqwDj1yp6Ih80l2irqW8VBdNZs5+DZ2AGEZE0+vY1UwJGRXjunNx3YZxlcDzRpEAtMp5+kFssA==
X-Received: by 2002:adf:9e47:: with SMTP id v7mr10709141wre.190.1552040547819;
        Fri, 08 Mar 2019 02:22:27 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id b12sm5806810wrx.33.2019.03.08.02.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 02:22:27 -0800 (PST)
Date:   Fri, 8 Mar 2019 11:22:25 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v10 04/27] clocksource: Add a new timer-ingenic driver
Message-ID: <20190308102225.GC22655@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
 <20190302233413.14813-5-paul@crapouillou.net>
 <20190304122250.GC9040@ulmo>
 <1551723186.4932.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <1551723186.4932.0@crapouillou.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2019 at 07:13:05PM +0100, Paul Cercueil wrote:
> Hi Thierry,
>=20
> On Mon, Mar 4, 2019 at 1:22 PM, Thierry Reding <thierry.reding@gmail.com>
> wrote:
> > On Sat, Mar 02, 2019 at 08:33:50PM -0300, Paul Cercueil wrote:
> > [...]
> > >  diff --git a/drivers/clocksource/ingenic-timer.c
> > > b/drivers/clocksource/ingenic-timer.c
[...]
> > >  +static u64 notrace ingenic_tcu_timer_read(void)
> > >  +{
> > >  +	unsigned int channel =3D ingenic_tcu->cs_channel;
> > >  +	u16 count;
> > >  +
> > >  +	count =3D readw(ingenic_tcu_base + TCU_REG_TCNTc(channel));
> >=20
> > Can't yo do this via the regmap?
>=20
> I could, but for the sched_clock to be precise the function must return
> as fast as possible. That's the rationale behind the use of readw() here.
>=20
> That's also the reason why ingenic_tcu_base is global and exported, so
> that the OS Timer driver can use it as well.

Is the path through the regmap really significantly slower than the
direct register access? Anyway, if you need the global anyway, might as
well use it.

[...]
> > >  +	// Register the sched_clock at the very end as there's no way to
> > > undo it
> > >  +	rate =3D clk_get_rate(tcu->cs_clk);
> > >  +	sched_clock_register(ingenic_tcu_timer_read, 16, rate);
> >=20
> > Oh wow... so you managed to nicely encapsulate everything and now this
> > seems to be the only reason why you need to rely on global variables.
> >=20
> > That's unfortunate. I suppose we could go and add a void *data parameter
> > to sched_clock_register() and pass that to the read() function. That way
> > you could make this completely independent of global variables, but
> > there are 73 callers of sched_clock_register() and they are spread all
> > over the place, so sounds a bit daunting to me.
>=20
> Yes, that's the main reason behind the use of a global variables.
> Is there a way we could introduce another callback, e.g. .read_value(),
> that would receive a void *param? Then the current .read() callback
> can be deprecated and the 73 callers can be migrated later.

Yeah, I suppose that would be possible. I'll defer to Daniel and Thomas
on this. They may not consider this important enough.

> > >  +
> > >  +	return 0;
> > >  +
> > >  +err_tcu_clocksource_cleanup:
> > >  +	ingenic_tcu_clocksource_cleanup(tcu);
> > >  +err_tcu_clk_cleanup:
> > >  +	ingenic_tcu_clk_cleanup(tcu, np);
> > >  +err_tcu_intc_cleanup:
> > >  +	ingenic_tcu_intc_cleanup(tcu);
> > >  +err_clk_disable:
> > >  +	clk_disable_unprepare(tcu->clk);
> > >  +err_clk_put:
> > >  +	clk_put(tcu->clk);
> > >  +err_free_regmap:
> > >  +	regmap_exit(tcu->map);
> > >  +err_iounmap:
> > >  +	iounmap(base);
> > >  +	release_mem_region(res.start, resource_size(&res));
> > >  +err_free_ingenic_tcu:
> > >  +	kfree(tcu);
> > >  +	return ret;
> > >  +}
> > >  +
> > >  +TIMER_OF_DECLARE(jz4740_tcu_intc,  "ingenic,jz4740-tcu",
> > > ingenic_tcu_init);
> > >  +TIMER_OF_DECLARE(jz4725b_tcu_intc, "ingenic,jz4725b-tcu",
> > > ingenic_tcu_init);
> > >  +TIMER_OF_DECLARE(jz4770_tcu_intc,  "ingenic,jz4770-tcu",
> > > ingenic_tcu_init);
> > >  +
> > >  +
> > >  +static int __init ingenic_tcu_probe(struct platform_device *pdev)
> > >  +{
> > >  +	platform_set_drvdata(pdev, ingenic_tcu);
> >=20
> > Then there's also this. Oh well... nevermind then.
>=20
> The content of ingenic_tcu_platform_init() could be moved inside
> ingenic_tcu_init(). But can we get a hold of the struct device before the
> probe function is called? That would allow to set the drvdata and regmap
> without relying on global state.

I'm not sure if the driver core is ready at this point. It's likely it
isn't, otherwise there'd be no need for TIMER_OF_DECLARE(), really. I
also vaguely recall looking into this a few years ago because of some
similar work I was but I eventually gave up because I couldn't find a
way that would allow both the code to execute early enough and still
use the regular driver model.

Platform device become available at arch_initcall_sync (3s), while the
TIMER_OF_DECLARE code runs way earlier than any of the initcalls, so I
don't think there's a way to do it. Unless perhaps if the timers can
be initialized later. I'm not sure if that's possible, and might not be
worth it just for the sake of being pedantic.

Thierry

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyCQl4ACgkQ3SOs138+
s6FwaxAAhFukhP2XtK/Q+gbHvCxe+dGRdbj+yiW2HETrTg+p4NXttEfL00si0i/l
o+o7ILOilnDLIm4HCGkPhY1gOzVaJWz6NpJDIbXCuPIScp3LKq5em+t+nU7ek7R+
91L9c4sAfBTeTYSY7oxy/yi7X7LDKFKEvPjeLNg+N4jys8Qte9ofkjY1hQvRJjJ3
R9H/6PwDaH1e6tSkCOEqmKJh37dCiHg3xuTAP6L+8VZ61FjPvJPLSBnGDzYGRpCW
af1Pp1o5Htc20GvF7SwgQOvXd0q+w8iiks39HiWiPBwjjXTWtBWCRgCCg/axhCSJ
ZqMqZg5LzpWwYtXBJ6BgO7ytypyWg6+fYOeeB8W0bbs1nLhBDyEtTE5jD+yZDKLd
k6xzBjgoX2cwNj6oC2WonkPZ9NUylv+ywHlaFfU5WZsWwZouw/NLhWzBGZphL3ZC
Ic3yRs0Y2RwzP1k369pMG+T4ZrzvTvqHuHKqKkH2AhF6fjhkgbsRhvn5I6im7udj
+OyfxMngwmmrJp8Nowsw1EfxCPtu4gVa8ffXCT865e8wJYfWPR8V8T3YvROZsG8q
tvlPLOMgw+0mkbeYoYR0TOS8s8PkrCxYE4U2FGusISGqF5NnKXq0J2C6iv9ZAyvv
EIgou6aiGfVE39fISzW48iXcFFL/WNfanae0YNLTcHeP7vwv86s=
=vng8
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
