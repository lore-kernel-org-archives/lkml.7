Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A79C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADE72070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw6xpEkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbfDBQtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:49:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42494 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfDBQtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:49:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so17538116wrx.9;
        Tue, 02 Apr 2019 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8sihjgqoc5t6TF2f9uCFFXX89Tjhllt+FMOdISACn9Q=;
        b=Mw6xpEkID9Ze8TOAfz0xNvirqWstOcMj7mGuM81cRUuXiBfomgcwTPE0DnWtt+oaST
         CjfaJYJ05Z9ZofjpKE3Taj+1oUfjn+yWN1bB/9rKYng9D+7RU6kfzMyr7G7w2eaVAkUR
         r4f/WchtLY1gTfZht5GQqh6IqCeCAEvX3JubKW7YQklgLdtmjzmAcUBHesVKNCVB3gTD
         1wI31Gnq3nQCmxIhnHgJXOScWHMY7wVAHuvbZ8iYDfd/lCuVOgeVG3yw6RDgLFFPLJ87
         H3ZOLUUVTqRz89kK3UA+9q1YPjoXmzBlKGl7EC5Hf/QdHqGNtXcM1tslgzRX1eGICc2K
         nojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8sihjgqoc5t6TF2f9uCFFXX89Tjhllt+FMOdISACn9Q=;
        b=dD4+RXkFDaSPHa+lk42nytp5Zr94YlFA4i2DxXDsNoRmiDkLrRMhhmHh0ay5rc7R2F
         Ff1CQUVwZ1zp1Jf0/rUaoWI7qV+fDkku/0RW+2y1eNQCXtqy/JwHSLQyogGcAUY44/i4
         GHe1DgvhdQZ2rXWOvXz7gRFiG2a+Ex3QdG8TL55f7NGqabGXpyMQQPW591e5Z1VMa7Pc
         4Km2ffcNI3SRb7NrIf8l6CeWxU1pMWHtGhltg9Xvq5xokm+UpjkWL5QZ/SMY58cj0hnf
         BPu2h/UVb6UWPwICFdSC9/VM50dJgj1Qzb/qO6oerx+kQY+1XcZWJCRabaud0HXkI1HA
         SBlg==
X-Gm-Message-State: APjAAAX6T4n0j0Gj+rlywZaypPHif+SEJhhnFKn+PLNmQvXzY2yNWzQV
        4NVZzjxphx/Noqzlj5RlMok=
X-Google-Smtp-Source: APXvYqxcK8f2oeXM5J/LbLVVpt+JPWgGjPbsO0Qt9i4q3Rp4MBaxWfUSAkpjRKPjx/Ja1kqh0l7vqA==
X-Received: by 2002:a5d:46c9:: with SMTP id g9mr2869490wrs.211.1554223792970;
        Tue, 02 Apr 2019 09:49:52 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id p3sm16978395wrx.71.2019.04.02.09.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 09:49:52 -0700 (PDT)
Date:   Tue, 2 Apr 2019 18:49:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joseph Lo <josephl@nvidia.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clocksource/drivers/tegra: rework for compensation of
 suspend time
Message-ID: <20190402164951.GB7797@ulmo>
References: <20190402030234.13488-1-josephl@nvidia.com>
 <20190402144603.GE8017@ulmo>
 <01028c3a-8e2e-835b-f886-ca5b85474cd2@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <01028c3a-8e2e-835b-f886-ca5b85474cd2@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 11:50:20PM +0800, Joseph Lo wrote:
> On 4/2/19 10:46 PM, Thierry Reding wrote:
> > On Tue, Apr 02, 2019 at 11:02:34AM +0800, Joseph Lo wrote:
> > > Since the clocksource framework has the support for suspend time
> > > compensation. Re-work the driver to use that, so we can reduce the
> > > duplicate code.
> > >=20
> > > Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > > ---
> > >   drivers/clocksource/timer-tegra20.c | 63 +++++++++-----------------=
---
> > >   1 file changed, 20 insertions(+), 43 deletions(-)
> >=20
> > Nice!
> >=20
> > >=20
> > > diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksourc=
e/timer-tegra20.c
> > > index fdb3d795a409..919b3568c495 100644
> > > --- a/drivers/clocksource/timer-tegra20.c
> > > +++ b/drivers/clocksource/timer-tegra20.c
> > > @@ -60,9 +60,6 @@
> > >   static u32 usec_config;
> > >   static void __iomem *timer_reg_base;
> > >   #ifdef CONFIG_ARM
> > > -static void __iomem *rtc_base;
> > > -static struct timespec64 persistent_ts;
> > > -static u64 persistent_ms, last_persistent_ms;
> > >   static struct delay_timer tegra_delay_timer;
> > >   #endif
> > > @@ -199,40 +196,30 @@ static unsigned long tegra_delay_timer_read_cou=
nter_long(void)
> > >   	return readl(timer_reg_base + TIMERUS_CNTR_1US);
> > >   }
> > > +static struct timer_of suspend_rtc_to =3D {
> > > +	.flags =3D TIMER_OF_BASE | TIMER_OF_CLOCK,
> > > +};
> > > +
> > >   /*
> > >    * tegra_rtc_read - Reads the Tegra RTC registers
> > >    * Care must be taken that this funciton is not called while the
> > >    * tegra_rtc driver could be executing to avoid race conditions
> > >    * on the RTC shadow register
> > >    */
> > > -static u64 tegra_rtc_read_ms(void)
> > > +static u64 tegra_rtc_read_ms(struct clocksource *cs)
> > >   {
> > > -	u32 ms =3D readl(rtc_base + RTC_MILLISECONDS);
> > > -	u32 s =3D readl(rtc_base + RTC_SHADOW_SECONDS);
> > > +	u32 ms =3D readl(timer_of_base(&suspend_rtc_to) + RTC_MILLISECONDS);
> > > +	u32 s =3D readl(timer_of_base(&suspend_rtc_to) + RTC_SHADOW_SECONDS=
);
> > >   	return (u64)s * MSEC_PER_SEC + ms;
> > >   }
> > > -/*
> > > - * tegra_read_persistent_clock64 -  Return time from a persistent cl=
ock.
> > > - *
> > > - * Reads the time from a source which isn't disabled during PM, the
> > > - * 32k sync timer.  Convert the cycles elapsed since last read into
> > > - * nsecs and adds to a monotonically increasing timespec64.
> > > - * Care must be taken that this funciton is not called while the
> > > - * tegra_rtc driver could be executing to avoid race conditions
> > > - * on the RTC shadow register
> > > - */
> > > -static void tegra_read_persistent_clock64(struct timespec64 *ts)
> > > -{
> > > -	u64 delta;
> > > -
> > > -	last_persistent_ms =3D persistent_ms;
> > > -	persistent_ms =3D tegra_rtc_read_ms();
> > > -	delta =3D persistent_ms - last_persistent_ms;
> > > -
> > > -	timespec64_add_ns(&persistent_ts, delta * NSEC_PER_MSEC);
> > > -	*ts =3D persistent_ts;
> > > -}
> > > +static struct clocksource suspend_rtc_clocksource =3D {
> > > +	.name	=3D "tegra_suspend_timer",
> > > +	.rating	=3D 200,
> > > +	.read	=3D tegra_rtc_read_ms,
> > > +	.mask	=3D CLOCKSOURCE_MASK(32),
> > > +	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTO=
P,
> > > +};
> > >   #endif
> > >   static int tegra_timer_common_init(struct device_node *np, struct t=
imer_of *to)
> > > @@ -385,25 +372,15 @@ static int __init tegra_init_timer(struct devic=
e_node *np)
> > >   static int __init tegra20_init_rtc(struct device_node *np)
> > >   {
> > > -	struct clk *clk;
> > > +	int ret;
> > > -	rtc_base =3D of_iomap(np, 0);
> > > -	if (!rtc_base) {
> > > -		pr_err("Can't map RTC registers\n");
> > > -		return -ENXIO;
> > > -	}
> > > +	ret =3D timer_of_init(np, &suspend_rtc_to);
> > > +	if (ret)
> > > +		return ret;
> > > -	/*
> > > -	 * rtc registers are used by read_persistent_clock, keep the rtc cl=
ock
> > > -	 * enabled
> > > -	 */
> > > -	clk =3D of_clk_get(np, 0);
> > > -	if (IS_ERR(clk))
> > > -		pr_warn("Unable to get rtc-tegra clock\n");
> > > -	else
> > > -		clk_prepare_enable(clk);
> > > +	clocksource_register_hz(&suspend_rtc_clocksource, 1000);
> > > -	return register_persistent_clock(tegra_read_persistent_clock64);
> > > +	return 0;
> > >   }
> > >   TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rt=
c);
> > >   #endif
> >=20
> > I wonder if there's any reason left for the #ifdefs now. My recollection
> > is that these were only needed because register_persistent_clock() was
> > not available on 64-bit ARM. The new APIs seem to be available
> > regardless of architecture, so do we still need to differentiate?
> >=20
>=20
> Actually, only Tegra20/30 that doesn't have ARM arch timer support need
> this. The latter Tegra chips which have ARM arch timer support use TSC (
> time stamp counter or timer system counter depends on the chip it has
> different name) as the timer source in the PMC. And it uses OSC during
> runtime and switches to 32KHz always-on clock source to keep counting when
> the chip is in the SC7 or LP0 state.
>=20
> So I didn't change that for this reason.

Okay, looks good then.

Acked-by: Thierry Reding <treding@nvidia.com>

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyjkq8ACgkQ3SOs138+
s6Hysg//b9UgRbVlTL6mp0e8viRfpi09fLqkEMjeDRQaqZGdh+Kcau/GJuX+OJCp
PANjwQwYPYzZfP35IDT6Cc7Xvfct21ILCwKpfy8YustzIqHPdeBhvTzTm1gcf3JO
YeqTX6lXBkhsUlVRMj1+EpQoAKCLD2+95CrIq73uCCJgRp7+TuwDkzP/SD/PbPHa
GNquSSA2s8gUrrUr7eEA/Iy2WifrHd9s49M5agKrpv7kDcLKUmT6Ne9WOBBNrVBM
BV4cDafnRtNbaLXpu0d0Dy5p3i/+Vov43/dErt0/cLodHVDagyv0jfVTsue1zeqK
MsBP1R8QCKu2N/mdlEXvj/SEAKMqmKS+1ULHHBUbSe/HZ1lBkQIzTQ2iyCZ9aWXu
eDo6N4H1jkiRyvDpuZoCTM9gbpn6SsU0d9roLWU7p9EtgDY0SlHlEFh2k21MBdYs
wUAkUtvxGXISyYR7EeYVyrXnkrp08w5biPHO8AzdiMT3HciH6C9Gadlj5aClFReN
ZmPO+PYEAVQW+EVaKkrM3E3a3nr2CKchmr7nzgqK/3fOq3A65hCotnIMMctMFBfO
oee3GSoi0zZtSEd2b+E0vXGWk+BTXGWPboFvgkZI3yNEcUqYsqRlW5Xq5+gmYr98
Db0YEtoYBgvuk7LPouMzCb2hjmF8CZQplzAp4RUO7cTAlWDlP3o=
=d9bl
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
