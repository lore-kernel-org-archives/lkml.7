Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2D8C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04A020693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564517714;
	bh=2DeioQljBl/BZ/jhEzrVarLl6wiGsnZWbH39DDDmTOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jrfplXnfKC43NQC8dSeOpgrypMHhGiB+rVuj2nA7G9mL7t2zU6VPbhVL9+tjIvuTh
	 fMIZCNIy9xihGlqFKvBzZMogssCUACsmlHk+R8Ed/ZL/Lk0og4HbsQHeZ0NEnLZltK
	 f22cDk9uFLUNrLFbUd9ki/7CnfPG9vBMCbJmZ4yM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfG3UPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbfG3UPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:15:11 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209D8208E3;
        Tue, 30 Jul 2019 20:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564517710;
        bh=2DeioQljBl/BZ/jhEzrVarLl6wiGsnZWbH39DDDmTOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFu58bGBlKK44NLLQM02UuP3JakqHRxL6Np1HRFBUshugmLj4N0VIYhocimbjGQc6
         +QM1FGMPsaFV1nVRWhAVYm2R5hTQTUfODu1Ahmzu65oQdY4lOi+S5eOLkxNRujoZbv
         JwCi263N+ix+C8SM1actbJqnVwwSt8m4gMXgk/0A=
Received: by earth.universe (Postfix, from userid 1000)
        id 8BE6A3C0943; Tue, 30 Jul 2019 22:15:07 +0200 (CEST)
Date:   Tue, 30 Jul 2019 22:15:07 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] HSI: ssi_protocol: Mark expected switch fall-throughs
Message-ID: <20190730201507.wvxy7bit7y2l5tsn@earth.universe>
References: <20190729224519.GA23078@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="taiuty7vd5dvkqvq"
Content-Disposition: inline
In-Reply-To: <20190729224519.GA23078@embeddedor>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--taiuty7vd5dvkqvq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 29, 2019 at 05:45:19PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
>=20
> This patch fixes the following warning (Building: arm):
>=20
> drivers/hsi/clients/ssi_protocol.c: In function =E2=80=98ssip_set_rxstate=
=E2=80=99:
> drivers/hsi/clients/ssi_protocol.c:291:6: warning: this statement may fal=
l through [-Wimplicit-fallthrough=3D]
>    if (atomic_read(&ssi->tx_usecnt))
>       ^
> drivers/hsi/clients/ssi_protocol.c:294:2: note: here
>   case RECEIVING:
>   ^~~~
>=20
> drivers/hsi/clients/ssi_protocol.c: In function =E2=80=98ssip_keep_alive=
=E2=80=99:
> drivers/hsi/clients/ssi_protocol.c:466:7: warning: this statement may fal=
l through [-Wimplicit-fallthrough=3D]
>     if (atomic_read(&ssi->tx_usecnt) =3D=3D 0)
>        ^
> drivers/hsi/clients/ssi_protocol.c:472:3: note: here
>    case SEND_IDLE:
>    ^~~~
>=20
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Thanks, queued to hsi-next.

-- Sebastian

>  drivers/hsi/clients/ssi_protocol.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi=
_protocol.c
> index 9aeed98b87a1..504d00ec1ea7 100644
> --- a/drivers/hsi/clients/ssi_protocol.c
> +++ b/drivers/hsi/clients/ssi_protocol.c
> @@ -290,7 +290,7 @@ static void ssip_set_rxstate(struct ssi_protocol *ssi=
, unsigned int state)
>  		/* CMT speech workaround */
>  		if (atomic_read(&ssi->tx_usecnt))
>  			break;
> -		/* Otherwise fall through */
> +		/* Else, fall through */
>  	case RECEIVING:
>  		mod_timer(&ssi->keep_alive, jiffies +
>  						msecs_to_jiffies(SSIP_KATOUT));
> @@ -465,9 +465,10 @@ static void ssip_keep_alive(struct timer_list *t)
>  		case SEND_READY:
>  			if (atomic_read(&ssi->tx_usecnt) =3D=3D 0)
>  				break;
> +			/* Fall through */
>  			/*
> -			 * Fall through. Workaround for cmt-speech
> -			 * in that case we relay on audio timers.
> +			 * Workaround for cmt-speech in that case
> +			 * we relay on audio timers.
>  			 */
>  		case SEND_IDLE:
>  			spin_unlock(&ssi->lock);
> --=20
> 2.22.0
>=20

--taiuty7vd5dvkqvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1ApUcACgkQ2O7X88g7
+po30RAAnTpQP30nHUBPDb5bMaH+xIpDedxkJfYqxatFNGAHYJrFkE1XPsicpDOL
rjhcs/QIUabdJxDqcbGmB7sKv/RpGPYtV1h7n091zbRyfTtrJ7F5/cyYY7xjkdPr
8XtyFgiK7o8Nc45UrZ0Zod0vcxG4E6sjFU489M3h1hVHhnnJdGE0gW5bU4JARcSe
6rkzquxz+aNC1rPIDfOOXWRw9DwI9/YRuNl2y3rakeJSXDB6TfPl7Nk/Z+3ZgKg/
rZucVptRaoGjHB26YBOlHxAxNvhYnl/iOpVy9giOIPs39JjWTbsfpxGTvbIEshge
95XyLlMI3iOvkU5esviVBjzSsm+vN9t/2GyzIhPeqRvOgcspej9NYkZd1nQpMyO6
tSzWK1wTQ/JzPow0WhCp52SlkdfzA9KD6W5KYf1/GPXtHsUiA+2e4PGFTCJDW9I3
gmPAymQZ8dO5/f0M7RjueIO33ig/qUTC1YB/ziplLMlE0WxGxuWaVG3rbOR4lMcL
BZG9DHdclldyrkuDFbnyZgEkVK406oX1rShYiVIUdKpy+mxiuyM7f45p+2043gWo
QxjwWRmsZ1T++jXDwckHnUGUoXxm4U+OJSpAde/I5XtazivvwOPxdnT4jMLYmxEp
sDdGtBGi/ErTDpWZkgpJwA0oswVdiqsxXBhdYBc1WHtCKihlsMg=
=vsr6
-----END PGP SIGNATURE-----

--taiuty7vd5dvkqvq--
