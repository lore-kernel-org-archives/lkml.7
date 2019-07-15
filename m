Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F03C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A008B20659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrf+T3xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbfGOT4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:56:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43170 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfGOT4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:56:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so8214140pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LcjZDPgdL7DrGBvMmJVL7aqjwkNf4gUG0/jK3NFbFQU=;
        b=hrf+T3xib0rwcl64f3eIU+EwrwfrXUdPQ26av7rw/B4o18aGkqFo6P01Iofzv92Mpc
         OQrSZ8JoDrEcf9yyDqvPS7vCZY8J8b33Fr3K6WW9GMF+DC9uVHy+2HFlBuzSTjEkA5Jr
         vc7SiXyV7bLfQ1MSgA0w5g8PEK4KpdsZgP7RpOzjcaIc+Lkr5WHyYJnlbAQLKBVSklY0
         qO4rOrNL4eAi2YZTbdrmLj0aNZmY9QiJnPJQ718NoAeMh/zSaeslzjjD6x9qA77pSbEu
         7sW3stgc1yfa1PUQAZuqVpiUWO9X1jSb3oZWnK9o62qaKIjJmPbY2WsIEcvihUIjfPm2
         NtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LcjZDPgdL7DrGBvMmJVL7aqjwkNf4gUG0/jK3NFbFQU=;
        b=EWeLryl5ecQOCuYUNgon+enSUnFHIEgGRCeXYt7w8NemANMPwPYsTHRWMfEiGMiMae
         CQv/7C3Tefj8VavQxdxCwBgwNaMQu59SJS94dPz3UCap6iWZHkIiBkppJN+KvEvMdbKB
         Ngj+CFKm+bWQ2Oi/3TdPY/+Q1f7IsO64E9EYZ5YvjaIiJYWWUf425EOSKONRMxceTnB3
         oJeZLnYizFhFhNWpl1N/659blrNbugutvdRgQ5MSp46DrG+p153PRZ1yOQFk6csMyIFI
         OlvaW3zVG4EGMfyNDlDMZX47f0J32vZmen2kZUbGur3Ilg1c94klc5eKuDoSD1+FWXA/
         6Yqg==
X-Gm-Message-State: APjAAAXzHEj4R6xy/AeRKpy9VxkbCs8zbeo9SwxbzaowP091cZGctcxe
        xEgD5VGRBa4sX0P/FkZetzHksA==
X-Google-Smtp-Source: APXvYqxB9Cq3Zi+SN8ixEnppL8O5MrNd4YnvwkmIbrtsv5YUv51Z4sqECdVIJlbifY1uB8cDY1vtBg==
X-Received: by 2002:a63:f118:: with SMTP id f24mr29576121pgi.322.1563220563511;
        Mon, 15 Jul 2019 12:56:03 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id i6sm18347978pgi.40.2019.07.15.12.56.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 12:56:02 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:55:57 -0700
From:   Benson Leung <bleung@google.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Always release lock when
 returning from _read()
Message-ID: <20190715195557.GA29926@google.com>
References: <20190715191017.98488-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20190715191017.98488-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

On Mon, Jul 15, 2019 at 12:10:17PM -0700, Matthias Kaehlcke wrote:
> Before doing any actual work cros_ec_accel_legacy_read() acquires
> a mutex, which is released at the end of the function. However for
> 'calibbias' channels the function returns directly, without releasing
> the lock. The next attempt to acquire the lock blocks forever. Instead
> of an explicit return statement use the common return path, which
> releases the lock.
>=20
> Fixes: 11b86c7004ef1 ("platform/chrome: Add cros_ec_accel_legacy driver")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel=
/cros_ec_accel_legacy.c
> index 46bb2e421bb9..27ca4a64dddf 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -206,7 +206,8 @@ static int cros_ec_accel_legacy_read(struct iio_dev *=
indio_dev,
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		/* Calibration not supported. */
>  		*val =3D 0;
> -		return IIO_VAL_INT;
> +		ret =3D IIO_VAL_INT;
> +		break;

The value of ret is not used below this. It seems to be only used in
case IIO_CHAN_INFO_RAW. In fact, with your change,
there's no return value at all and we just reach the end of
cros_ec_accel_legacy_read.

>  	default:
>  		return -EINVAL;
>  	}
> --=20
> 2.22.0.510.g264f2c817a-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXSzaTQAKCRBzbaomhzOw
wk+uAQC2kr7TrcEA7sZDr1CfCnwy7ezLa1KBU1fssk52WQk7rgD+Nq9rH2+JjQUQ
TbnpM4wbsH86aDwIx3uwf6xGtfGxnAc=
=C/Ao
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
