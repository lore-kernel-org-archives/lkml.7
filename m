Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1BCC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920E5206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLsayv8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDCQdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:33:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37486 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:33:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so9088732wmf.2;
        Wed, 03 Apr 2019 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ci5kdgs4zzNiCOU9xoCRy1kxCFGKN5w3XnpTfFuIRAw=;
        b=rLsayv8YSyXVzG7sagbDHu3zNZNh9nRh1i+hAchCWUxcU8/5BkmJOnnVwUlY08GGLy
         MCJSc1hvPCyF8VNXp0SuQfTgBea2V44WASUoszxpsZ3M16JeIsednWyulyer3zveqls4
         tnJVSXDUdWQVGhwe1bNG7HfjClUgVq30vaxJpWOo0QIlpNySMiv2KlbOQi5R3A7oQ9ow
         U9zlNoA7aOb4lyiej2zU4AiQ8MjPkbJmnIzITWiP1ZKGW7LW2FhvsP3D+smGkGMxGNOr
         zkOMj0GdiDXNG6oWnl6CXukRPHDwJ2eIyc0J5bS4YEUn4Ao9ZrjGtyqJeKpdYCekOFbK
         N16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ci5kdgs4zzNiCOU9xoCRy1kxCFGKN5w3XnpTfFuIRAw=;
        b=ipxFeiwVg9RNXBLWDuhu5vZT6/evp+MdalhK6KMVyLVPwf2R+sR4gcWJcD+nx1TpGu
         HZXbevTA50JVF3e6kxJ9JtXOzo13wq6Rdoym0JCIuYV2VQM6Enn1b98cu9zLrspbKUKk
         xfSrTTesTETPW7s29UYWHld3Df2E59/kkLn9/oRqwbg1z72Q/YSa+O893On2zsDr8Lfz
         cqNvE5ZqNk/mmZPITKkZQsJ1GP9m5VKe2tKdMbIudroMnDNe1XreSrHo2DYo8Zt5JDFS
         72B56MEULLTxDzXO7F8/8ILfEb6bDiLK2Dbyn5cEbJ2UHzOBXCyE/s31F/SAM0TM/Lw2
         Ijhw==
X-Gm-Message-State: APjAAAUvmKDkxckdkrSsF0sJhcHhNH8qAJ8tCowYCWUihf3VXe7WX507
        Uc5TvvhHHOwk+Jm8+Ujec5Eg/VYo
X-Google-Smtp-Source: APXvYqwfFdxdz2pXSWOnhqD2XpU6E0eYdTWF2hyZ+B0FkEyOoLDW3n7hAqXNDu0tIhcCiSmLXc5r1A==
X-Received: by 2002:a1c:4cf:: with SMTP id 198mr587259wme.125.1554309180837;
        Wed, 03 Apr 2019 09:33:00 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id u17sm4529028wmu.36.2019.04.03.09.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:32:59 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:32:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 3/5] media: uapi: Add RGB bus formats for the
 GiantPlus GPM940B0 panel
Message-ID: <20190403163259.GS5238@ulmo>
References: <20190314122622.7597-1-paul@crapouillou.net>
 <20190314122622.7597-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="D+M1YvVlDncl3vD5"
Content-Disposition: inline
In-Reply-To: <20190314122622.7597-3-paul@crapouillou.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D+M1YvVlDncl3vD5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2019 at 01:26:20PM +0100, Paul Cercueil wrote:
> The GiantPlus GPM940B0 is a 24-bit TFT panel where the RGB components
> are transferred sequentially on a 8-bit bus.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>     v2: New patch
>=20
>  include/uapi/linux/media-bus-format.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Please make sure you Cc the media maintainers on this one when you send
the next version. Adding them now.

>=20
> diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/m=
edia-bus-format.h
> index d6a5a3bfe6c4..f31724d6cd40 100644
> --- a/include/uapi/linux/media-bus-format.h
> +++ b/include/uapi/linux/media-bus-format.h
> @@ -34,7 +34,7 @@
> =20
>  #define MEDIA_BUS_FMT_FIXED			0x0001
> =20
> -/* RGB - next is	0x101b */
> +/* RGB - next is	0x101d */
>  #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
> @@ -54,6 +54,8 @@
>  #define MEDIA_BUS_FMT_RGB888_1X24		0x100a
>  #define MEDIA_BUS_FMT_RGB888_2X12_BE		0x100b
>  #define MEDIA_BUS_FMT_RGB888_2X12_LE		0x100c
> +#define MEDIA_BUS_FMT_RGB888_3X8_BE		0x101b
> +#define MEDIA_BUS_FMT_RGB888_3X8_LE		0x101c

The list looks roughly sorted, but these are not. That said, there are
others that don't seem like they are sorted either. All the more
important to get feedback from the media maintainers.

Thierry

--D+M1YvVlDncl3vD5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyk4DoACgkQ3SOs138+
s6HScg/9GyEDoCdxMtlPqDRYKP5xRAlt0XNtZfHL5ibuM/8vU6LU6b5JqAZIpi4a
vJSzJitF9SE7vm7nBcmjZlKvxrOL9AusPveEVlmxuXniokaG5l+H5Tj2so7ut3hc
ogYvh5Ofi9IgaI/PDkkfkqHdKABo+khmgorlMALjAhEyUC+315D4LU/bcoxpycgz
gZNjhlzSeTgG7VIbbnl8lyoMgVJvwktahzO2RDkV4gDmLeJXmQY7Tq8ADE6RWKls
xejx/kyRwdvPl87nESKw5qbtHY0Z4cAwnH9j/MDsYPtvFKCei9fJj+7/5nByGtuV
O9cdE7aKo26mzLOOEH7vc8+bMBYllIgBILmDyGC/KCbXN4ATWABX7Wg8g7oM+xaS
n8vfaRG627LIOYRNq3XTRutW17mFyjze8D1e1RHNIVEUrX0OtDA4g2hIQn2lm7o2
zb/FfV7AH24L7n4z9i/uy5GOrAZseztoThqUt2MnRhVr2BXY5mt4caV3LEHMDdBJ
qR7BpJbn2gZ3b+IITh8468TdowwMhEDoGEALIv8FeaKXePyKdPmDF03fSueMOfj4
4PFN4yHOADhz5XdP2tG+Lnl0vIOxImAf4bBOzYRXXpu19j1WfgAYNgLXI+RExKuJ
sHnXe+Jm2Jtj417ICallpwjt/YVaBvM3ONvsTgi3uNmPYq1zOWk=
=yjYj
-----END PGP SIGNATURE-----

--D+M1YvVlDncl3vD5--
