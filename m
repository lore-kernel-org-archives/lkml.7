Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89FEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996902075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/3QlDIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfCDMYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:24:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40747 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfCDMYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:24:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id g20so4473744wmh.5;
        Mon, 04 Mar 2019 04:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FfE83CJWQGc26/PA0BK/e1ix8S6HMr+nApSNwsX0iRA=;
        b=b/3QlDIrxen2KIKm+IRaNHSdNncDKibcPzQL90+xZUmn55vdz9rOq9uuZggdeb8XnY
         6C3NsWugJyQyuGsgioHsFFuf9FHV2CMSxAOsTUDaN0/klFB8qhLgzfJY9ANFuf102ewt
         a75AF4vMvZnPiUycMEyr+QIXga4fqPRsnx+t+yo7zf35IwoWahPnEmwNwWxb+HISShwO
         WYpDzWjAOqc2a/6YOkbRL4cUJ3btgSgM48XfucDSNiTP2b08hfqHAQSmOLUx4HF3DXSa
         5u3OaKAZ1St90OxwZ99SwlzVU+ZL9wvP5u5UJCn3Msslg5LsnzpTcbJfvlWzCdBLdb5u
         AfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FfE83CJWQGc26/PA0BK/e1ix8S6HMr+nApSNwsX0iRA=;
        b=CNAZ4slxN245SK2PLaDNDN/fMq0frxNh2F8olChNWju7Po457xrkE5GjKqpp6qOFHK
         x37bPjUMt8ivJ/7JFFXs1ZPT3/Qdc89Ch7ZlipHYHuJllH7+99VqnLc100wsbGdozPxp
         NnlQ1rToxYnykUPkhzEPu7Wt1TwEgPDCeo+y/dVezuRwkbGIMfeWvvb7FLevOZxlGOYX
         ySO1iooP678BpooijgQqP5PWafNMIClWLm75icGa2DL8nFTRhGg8p/dhZzUANmVYgzNP
         3rjU4cWxSjiOnvJhQP2YBqOCr/MLyasO7NUBgjHq8mEAYkp6ulI+wK+0KOt4g6w88BSG
         eRSA==
X-Gm-Message-State: AHQUAuZw1JLZIZRyVQQefXxFYNIsZPNY+fVbm0tbiNaO38z7l4eFMS5h
        i6xx7i+WLboGvXVr8STlDGI=
X-Google-Smtp-Source: AHgI3IZFBlTWu0mCEKvpXFqOCjW6HWqSouZXUUNuGvrk8eQDyeJ0ugw1BrRLyrK9fNTsopNBKGM8YA==
X-Received: by 2002:a1c:7a1a:: with SMTP id v26mr10666419wmc.129.1551702282335;
        Mon, 04 Mar 2019 04:24:42 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id a20sm4471956wmb.17.2019.03.04.04.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 04:24:41 -0800 (PST)
Date:   Mon, 4 Mar 2019 13:24:40 +0100
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
Subject: Re: [PATCH v10 12/27] pwm: jz4740: Use regmap from TCU driver
Message-ID: <20190304122440.GD9040@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
 <20190302233413.14813-13-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
In-Reply-To: <20190302233413.14813-13-paul@crapouillou.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 08:33:58PM -0300, Paul Cercueil wrote:
> The ingenic-timer "TCU" driver provides us with a regmap, that we can
> use to safely access the TCU registers.
>=20
> While this driver is devicetree-compatible, it is never (as of now)
> probed from devicetree, so this change does not introduce a ABI problem
> with current devicetree files.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>=20
> Notes:
>          v9: New patch
>    =20
>          v10: No change
>=20
>  drivers/pwm/Kconfig      |  1 +
>  drivers/pwm/pwm-jz4740.c | 74 +++++++++++++++++++++++++++++++-----------=
------
>  2 files changed, 49 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a8f47df0655a..ace8ea4b6247 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -204,6 +204,7 @@ config PWM_IMX
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MACH_INGENIC
> +	select REGMAP

Sounds to me like "depends INGENIC_TCU" would be more appropriate here.

Thierry

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9GQgACgkQ3SOs138+
s6EqgBAApqtLwQJHI/GgZOOEuKM55A51SUJMeror7RMH60J/w9WxQFlAONPb0A/z
P1u0SlMe/PlBiotrDJQ6gb8Dx8a9zt684HH8kZKqT3ki9lYnVB2zIVMyLlBWEAUN
+YQcGPb8R9Wkv4XbZ8jIQy+xxOeMkX2yh1vFS/0cQKvkAiDAs2oLsZEmyGoUrV1P
X3KW8K/iiedGY3aUE1kUBbGpm+oSW8YIbOPH2pgGXCIGuuzHR1zsNqYBg0BAt3r6
jDFv2W80cjFcZRmMOp0EeecYbxhZ8yaDamPuRq5MltkrFQ8538emCg2WSh/fpev2
kke1YD0t0E26KlvyP8ov2p4z+vtWhXfHTQEnnN8Ki0uaCwIRkQ3jBahgFdzSFAJw
ml4LHrke7e7tYCINGuzDnzDGmjT9XSMEjJekgTIEaksigLX8HVhSE6Oo4bUXZv8d
334rSUcuBMmSM9BHkthhW/WQ/XcpgVHpIKlV0O51P28aroCefkW/LzRTxsJfAo1s
cSycUnOwPfHOi/WeRlGR/69RMUV+Gb+Qtt7tLnBO/P1QtrCinyT521uPOdLeBN03
1/plYR7omAhFIZFP28pmF5BapAR1YX3vgKHAqFOcynG15MezUvm/m0gqH+/0Tr52
tFm02vy9CXOjgyNkwX3emvywJ0RZW/R7K1WqrTU57SE3sj/w7Y4=
=MVmX
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
