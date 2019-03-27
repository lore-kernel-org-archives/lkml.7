Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A374C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99C9206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfC0QMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:12:13 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45699 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfC0QMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:12:13 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h9B9p-00016N-BI; Wed, 27 Mar 2019 17:12:05 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h9B9n-00021I-CH; Wed, 27 Mar 2019 17:12:03 +0100
Date:   Wed, 27 Mar 2019 17:12:03 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Tal Shorer <tal.shorer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-gpio@vger.kernel.org
Subject: Re: [Patch v3 2/2] tracing: gpio: add Kconfig option for
 enabling/disabling trace events
Message-ID: <20190327161158.GA26067@taurus.defre.kleine-koenig.org>
References: <CAFDyS3Nuq8FPx4z5GW1Ht+NBGd+8O9rjPZ+DaMU1XU1QYgA=2g@mail.gmail.com>
 <1438432079-11704-1-git-send-email-tal.shorer@gmail.com>
 <1438432079-11704-4-git-send-email-tal.shorer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <1438432079-11704-4-git-send-email-tal.shorer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 01, 2015 at 03:27:58PM +0300, Tal Shorer wrote:
> Add a new options to trace Kconfig, CONFIG_TRACING_EVENTS_GPIO, that is
> used for enabling/disabling compilation of gpio function trace events.
>=20
> Signed-off-by: Tal Shorer <tal.shorer@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  include/trace/events/gpio.h | 4 ++++
>  kernel/trace/Kconfig        | 7 +++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/include/trace/events/gpio.h b/include/trace/events/gpio.h
> index 927a8ad..2da73b9 100644
> --- a/include/trace/events/gpio.h
> +++ b/include/trace/events/gpio.h
> @@ -1,6 +1,10 @@
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM gpio
> =20
> +#ifndef CONFIG_TRACING_EVENTS_GPIO
> +#define NOTRACE
> +#endif
> +
>  #if !defined(_TRACE_GPIO_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _TRACE_GPIO_H
> =20
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 3b9a48a..67a1731 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -635,6 +635,13 @@ config TRACE_ENUM_MAP_FILE
> =20
>  	If unsure, say N
> =20
> +config TRACING_EVENTS_GPIO
> +	bool "Trace gpio events"
> +	depends on GPIOLIB
> +	default y
> +	help
> +	  Enable tracing events for gpio subsystem
> +

It happened a few times to me since this patch was merged (in 4.4-rc1)
that I worked on a system with tracing enabled but
/sys/kernel/debug/tracing/events/gpio were missing because of
CONFIG_TRACING_EVENTS_GPIO=3Dn. This is annoying and I wonder what is the
motivating purpose of allowing to disable gpio events. There is no other
event type that can be disabled with kconfig symbols. Theoretically the
overhead should be so small, that having these events enabled
unconditionally should be fine, shouldn't it?

Best regards
Uwe

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlyboMkACgkQwfwUeK3K
7AmWjgf/fn7Is0y04lkAl6ET2ZTTC4yh7aLtitivQZ7q6GrULaPfhWO8GEj7lOxR
Q7N9N3WZrqtR/TWAd4VuYsDPpQoLkWrFSgQS4qh1okV1evmTnRUuWkiAluLvizLS
tU29YxSf4TPNgcn91hpFMNIGbPMBPolnWLF718VtaRXhowz4RvqNQMplGnUc0G53
yZ+d3EganFx8pgVpG1NIBhgT5Pi/oRV/URDF1epZEOgHA+2VifrE04Um+dzugo3U
xGBaP4rWCT8HSWPFQM6JgpMyjVzKQ0wsKzxIgQtgX6et11IrWtytMZxgaz0L1U1p
w1Rp1uJCw0HagsV6zo4idA2auO5Kgw==
=/vx7
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
