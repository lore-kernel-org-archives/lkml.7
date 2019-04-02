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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86CEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F52020693
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi2bZdRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbfDBOqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:46:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34467 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731530AbfDBOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:46:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so17051915wrq.1;
        Tue, 02 Apr 2019 07:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MwjCCGTxgkAmdndEGq++weJ/jiz+EjWccWUiOzDO7+E=;
        b=Qi2bZdRDe7Od+n3IRK+vQk1TpgbLKoy2Tb6Y2/5cXhQsWl0CqcCK8cTYZOyCG9tJEe
         Qb4vpH/R03XaU/5sY1gFSSfsFWwra3o4jaNV1QeFgJh01Mrsx6CphwZILOs/aSPp7VPZ
         y63r81KW1qFt9MZr8i0lVlQaH56uGaaGLHg48d09CUVpnUq/fItGPQ7bO+/+Tlcji16w
         tcHNRyPz5pjOZPNPn4ej+mgiEZaqLzUiKrfQDbFwPtk861/h+2lyxR3oJHWk5VaHDcli
         3u+5tWy9VETkpzEM7/RhdIxZkmL5MkfHT1VtmcUY8eSW2VYDt4cAUbkmW7TED3vYUUcR
         ri9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MwjCCGTxgkAmdndEGq++weJ/jiz+EjWccWUiOzDO7+E=;
        b=SxqUuvrs5G7cJZ7p3pL9MAlpWNhG8pt8OUerAPCvoWmLqtJneA83DxmB8v7uNowaj+
         U1LzXtBI+TAXW2TUZrnJtVbDEx+rTJnOtKf/gx/4SO90I9/iW4O+TMOg5MFcLHxXZP+A
         /nLAuIbr9HZpeXSsO6TxuFk2Wd9JErY99XdNNlW3B8O13QR1UJkHiGVEGbzH54Q+4Biv
         w4/c2lDik9Cs4oQMOR9qPhMbGhzbs6q/B21D3lOdaVOgregYcSHrI+ZcIlLc/1fG7T3T
         3g8iraZIqTF8jcw2Riie43K8YHDZIGvrIYsZ4gMGXveCvl+BUc+5O/5zsQOyLVC4rB/i
         wLug==
X-Gm-Message-State: APjAAAU3jj+NJzalebfh2Al2lnNmwr41/ovCfpMV54xmunBsajaXiZ5a
        UaBtmNpRq+TAcSPVAwxTl4g=
X-Google-Smtp-Source: APXvYqzZlkgOElYI1LqXts4akZJ7BW4kq23ZaVmF9JxYfHSIaDGYwb5EtKP/98wkQIhN9luUwy+O7A==
X-Received: by 2002:adf:db0c:: with SMTP id s12mr20860736wri.184.1554216364892;
        Tue, 02 Apr 2019 07:46:04 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id f11sm15255051wrm.30.2019.04.02.07.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 07:46:04 -0700 (PDT)
Date:   Tue, 2 Apr 2019 16:46:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joseph Lo <josephl@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/tegra: rework for compensation of
 suspend time
Message-ID: <20190402144603.GE8017@ulmo>
References: <20190402030234.13488-1-josephl@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline
In-Reply-To: <20190402030234.13488-1-josephl@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 11:02:34AM +0800, Joseph Lo wrote:
> Since the clocksource framework has the support for suspend time
> compensation. Re-work the driver to use that, so we can reduce the
> duplicate code.
>=20
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  drivers/clocksource/timer-tegra20.c | 63 +++++++++--------------------
>  1 file changed, 20 insertions(+), 43 deletions(-)

Nice!

>=20
> diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/ti=
mer-tegra20.c
> index fdb3d795a409..919b3568c495 100644
> --- a/drivers/clocksource/timer-tegra20.c
> +++ b/drivers/clocksource/timer-tegra20.c
> @@ -60,9 +60,6 @@
>  static u32 usec_config;
>  static void __iomem *timer_reg_base;
>  #ifdef CONFIG_ARM
> -static void __iomem *rtc_base;
> -static struct timespec64 persistent_ts;
> -static u64 persistent_ms, last_persistent_ms;
>  static struct delay_timer tegra_delay_timer;
>  #endif
> =20
> @@ -199,40 +196,30 @@ static unsigned long tegra_delay_timer_read_counter=
_long(void)
>  	return readl(timer_reg_base + TIMERUS_CNTR_1US);
>  }
> =20
> +static struct timer_of suspend_rtc_to =3D {
> +	.flags =3D TIMER_OF_BASE | TIMER_OF_CLOCK,
> +};
> +
>  /*
>   * tegra_rtc_read - Reads the Tegra RTC registers
>   * Care must be taken that this funciton is not called while the
>   * tegra_rtc driver could be executing to avoid race conditions
>   * on the RTC shadow register
>   */
> -static u64 tegra_rtc_read_ms(void)
> +static u64 tegra_rtc_read_ms(struct clocksource *cs)
>  {
> -	u32 ms =3D readl(rtc_base + RTC_MILLISECONDS);
> -	u32 s =3D readl(rtc_base + RTC_SHADOW_SECONDS);
> +	u32 ms =3D readl(timer_of_base(&suspend_rtc_to) + RTC_MILLISECONDS);
> +	u32 s =3D readl(timer_of_base(&suspend_rtc_to) + RTC_SHADOW_SECONDS);
>  	return (u64)s * MSEC_PER_SEC + ms;
>  }
> =20
> -/*
> - * tegra_read_persistent_clock64 -  Return time from a persistent clock.
> - *
> - * Reads the time from a source which isn't disabled during PM, the
> - * 32k sync timer.  Convert the cycles elapsed since last read into
> - * nsecs and adds to a monotonically increasing timespec64.
> - * Care must be taken that this funciton is not called while the
> - * tegra_rtc driver could be executing to avoid race conditions
> - * on the RTC shadow register
> - */
> -static void tegra_read_persistent_clock64(struct timespec64 *ts)
> -{
> -	u64 delta;
> -
> -	last_persistent_ms =3D persistent_ms;
> -	persistent_ms =3D tegra_rtc_read_ms();
> -	delta =3D persistent_ms - last_persistent_ms;
> -
> -	timespec64_add_ns(&persistent_ts, delta * NSEC_PER_MSEC);
> -	*ts =3D persistent_ts;
> -}
> +static struct clocksource suspend_rtc_clocksource =3D {
> +	.name	=3D "tegra_suspend_timer",
> +	.rating	=3D 200,
> +	.read	=3D tegra_rtc_read_ms,
> +	.mask	=3D CLOCKSOURCE_MASK(32),
> +	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
> +};
>  #endif
> =20
>  static int tegra_timer_common_init(struct device_node *np, struct timer_=
of *to)
> @@ -385,25 +372,15 @@ static int __init tegra_init_timer(struct device_no=
de *np)
> =20
>  static int __init tegra20_init_rtc(struct device_node *np)
>  {
> -	struct clk *clk;
> +	int ret;
> =20
> -	rtc_base =3D of_iomap(np, 0);
> -	if (!rtc_base) {
> -		pr_err("Can't map RTC registers\n");
> -		return -ENXIO;
> -	}
> +	ret =3D timer_of_init(np, &suspend_rtc_to);
> +	if (ret)
> +		return ret;
> =20
> -	/*
> -	 * rtc registers are used by read_persistent_clock, keep the rtc clock
> -	 * enabled
> -	 */
> -	clk =3D of_clk_get(np, 0);
> -	if (IS_ERR(clk))
> -		pr_warn("Unable to get rtc-tegra clock\n");
> -	else
> -		clk_prepare_enable(clk);
> +	clocksource_register_hz(&suspend_rtc_clocksource, 1000);
> =20
> -	return register_persistent_clock(tegra_read_persistent_clock64);
> +	return 0;
>  }
>  TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
>  #endif

I wonder if there's any reason left for the #ifdefs now. My recollection
is that these were only needed because register_persistent_clock() was
not available on 64-bit ARM. The new APIs seem to be available
regardless of architecture, so do we still need to differentiate?

Thierry

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyjdakACgkQ3SOs138+
s6HcVw/+LuMdZgQke1X++Jfjr7/7JpGMznffzO518GTbknew4gEUJMzmBXKkcO2u
KKs84gfd3Qz7TBqjIfFaqcW8BzgntKUxXE7+aFD3rZPn9cCqIDUjWB0YhyOFPWUu
SGDdRlBByUHIYDI1uhTE7CYmbYSgBJ4ZOSTeZcmARuqgBs0SlzpKKzD9NiIAMZu+
RjPlVxUegnmzJ4hMbFmScH/PdSLDdvuKNe+IErEF164quMvSZiU4NQIuVHj4Jo0N
gULaJamKMxZPZGboYM92t5E5bv9P/S+/D5rGI3Z+rIvrr97qaoWKeuwTt4/fola/
Hpe42iEuwUIvogSHQFdrJUcHl24wxRKgkwNjoXSI/dMCkXIV+RL5BAgB9ULocFCS
H8v6Kd+vgpKmfSqejLPcdV6Dw45aUrhuUpqMzmMUOAyyxbzLTMxT57XagT5m35hK
iZqGM0UzEo+RX7i3Yzk5LR9/1fngFFeA3g/IRiIzTb4p9997SA5Rh3QZVB6cpJll
BJ3geuFBaiJl5binR4mScTwTXehlco1HorAdGv6WmMOrkPH6vEJq1Q56PyjnGp9n
7DA3owb897JsZ0kJTP5VH/NCOrFZch0NSqnJAtr6Xj6obIJKdmjnti0fV8QD7STl
l0suLGIzjGAKNXkbrE10BQqrIUJ9fvNh5k+ois2LmE3cKVNR4wI=
=JGMg
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
