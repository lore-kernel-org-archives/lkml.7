Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B28FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4C62171F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcPlPd+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDCOgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:36:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37086 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:36:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so8562417wmf.2;
        Wed, 03 Apr 2019 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qahxl4P1f/0UVNIaRxLSC+1lJ4cfDzlJdCSlDofuEtI=;
        b=TcPlPd+gvChl9DEnr86mZwVX9Xmes72ia38v94rbfYv+XqdaA7h3+3hm2Q+6Ft5RLv
         /NS2CD15k/9mJ97RQ360cXkRBIUksNIvNwu3PixlK+gRxC1wUqkMKPCB3FCQZ4SoVsvN
         CkFHOgm2TV0x1qmeycIWYw6pft0/ssINutQs22G5nc6VC0iCmp+M1qxIRNChRfLT2nnL
         7J/2Ez2iu2zbAPxLP+2Ts+MbbAFWgWlz2/UCi7xHwWQIXBZ0Fi2P6lQgsIDz0MH6tMQY
         ag5AIZTm8EprhruNOg8UsCuysnlFu40QdScXyW8vFn/GMepGbbXppY1xdnqp18UWzuPh
         zDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qahxl4P1f/0UVNIaRxLSC+1lJ4cfDzlJdCSlDofuEtI=;
        b=fffEBOFLDjAHUl8ZXhutqBDkk/jItYPP3+zDpFReLd+670mskdvUfjqmmWb9cKeYIY
         dE9yh8nQb/FOOoSOQkUnKegpdoxZ318P+ANFBzR7Ol0i6VR075o+mSf9FAPU0fzRFU3u
         jnlBJkQmnLNF3FgagMPR7NEolCufUJ0hn2Dm/9vuMRlhtz/MysTH5Fpk/n5TRtYoftjw
         2pC+/Itqfsg9qRaZvLsJ9V69L2IDduAeBq29zg8LjH5uHUhD2rwOZ0QBqELUghv/LQ18
         fnIk3jbsn5Z0cR7KlYmDIbtCqx0fuZnmyjTH/Ty72ujj4kTqR54D4G9XGL22iwq3PXyx
         PwEQ==
X-Gm-Message-State: APjAAAWR3T+H2jOdrwi/XC2XkXqmF1lApwRMHv12NOF6yAVMiE1S/f3P
        U/OWkXGlwPsaQWqWu8CXlEU=
X-Google-Smtp-Source: APXvYqytPnXnFKl3g7LEGHXizPL/jSrsbyvSXWC7hoKdm09iBNY8ggLssP6LmneWmezskIF4imFR7A==
X-Received: by 2002:a1c:20c1:: with SMTP id g184mr183329wmg.137.1554302206933;
        Wed, 03 Apr 2019 07:36:46 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id r30sm43576492wrr.46.2019.04.03.07.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 07:36:46 -0700 (PDT)
Date:   Wed, 3 Apr 2019 16:36:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/12] ARM: at91: move SoC specific definitions to SoC
 folder
Message-ID: <20190403143645.GJ5238@ulmo>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
 <20190403141120.32754-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4vpci17Ql0Nrbul2"
Content-Disposition: inline
In-Reply-To: <20190403141120.32754-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4vpci17Ql0Nrbul2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2019 at 04:11:09PM +0200, Alexandre Belloni wrote:
> Move linux/atmel_tc.h to the SoC specific folder include/soc/at91.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/clocksource/tcb_clksrc.c                   | 2 +-
>  drivers/misc/atmel_tclib.c                         | 2 +-
>  drivers/pwm/pwm-atmel-tcb.c                        | 2 +-
>  include/{linux/atmel_tc.h =3D> soc/at91/atmel_tcb.h} | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
>  rename include/{linux/atmel_tc.h =3D> soc/at91/atmel_tcb.h} (99%)
>=20
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_c=
lksrc.c
> index 43f4d5c4d6fa..138a12090149 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -11,7 +11,7 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <linux/syscore_ops.h>
> -#include <linux/atmel_tc.h>
> +#include <soc/at91/atmel_tcb.h>
> =20
> =20
>  /*
> diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
> index ac24a4bd63f7..194f774ab3a1 100644
> --- a/drivers/misc/atmel_tclib.c
> +++ b/drivers/misc/atmel_tclib.c
> @@ -1,4 +1,3 @@
> -#include <linux/atmel_tc.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> @@ -10,6 +9,7 @@
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <linux/of.h>
> +#include <soc/at91/atmel_tcb.h>
> =20
>  /*
>   * This is a thin library to solve the problem of how to portably alloca=
te
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index 0d0f8376bc35..d7e92fd552e4 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -17,7 +17,7 @@
>  #include <linux/ioport.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> -#include <linux/atmel_tc.h>
> +#include <soc/at91/atmel_tcb.h>

Sort this below the linux/* includes. With that:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--4vpci17Ql0Nrbul2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlykxPoACgkQ3SOs138+
s6EnbQ/2MFXgA2oFM7gYZLm5GaXwaFWSpnwbu8jcyubOcu5sy+IjqVlD+HMaJqoh
jayHE7tjtVfgXd742qIYSMjhb2LTXgGZa7kCP5Li/Ui7jwdnf2B/VhFlY9NrZkgO
4S8Q5WeEEdH5QZ5nNgHgwRVLUC5nF1obrMHM/TfkV3WUeSMwg4V1SzJFF7vE6kuZ
h0BnY6mFyizaiQTaV/CCiwsVIkif0NJO2jsm1OUkpGnJDNbQXIloW6uGAuA3C+DB
0qIJrgUaQFTXrbuj3OMk30ifEOR6bexsW2XyRXeKsjWeQvf1FRIBoH6vPd9q19zX
o7Zp83ye8a0AAg2AHTLidOnKw3FU8Om4cuNt2/aQtQ18ptV4MJL42PHJ6QwDTdyu
7J5FhD0dC8aC9Ad00qXf/+gKg1FJvJ0G4ec2I+5E805fBZewuCOJHk+iRw8tvXb9
ZWjgLejATP3RRT3OggvFeeubK1+yhQ8KTUqw+QyneV/imThalC6mWeJQ1LWjj1gu
DM6eOVa76scfpgio+Kh6trM1J+uRQNhiblbXp9job8Hr+ok3wqPhcSw0+qPzE6zx
fYyQ3BNMyDChnu/+zlra1Hc9bjmvOqZWzWLA43emj0yHT+9xrVUmtZ5qx9NwJTld
ALaeiWXFs7Ae1lCfgKAvlvbKIIXy1yxBYGmXtORdlQZ7zWna/g==
=Yvcc
-----END PGP SIGNATURE-----

--4vpci17Ql0Nrbul2--
