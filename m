Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805E6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAFA2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz/9GpaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCDLFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:05:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32951 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfCDLFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:05:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so5050872wrw.0;
        Mon, 04 Mar 2019 03:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vkh+emjnnehC0a61TJAj3pwsHMRC4VLx1k8vVqN/naM=;
        b=bz/9GpaYrv2ITlH1yk9nhO76xzDAhzHX17Gsf2A9yzG16segrOEb9Ufefxb4OtcWOE
         mJ/htHKvW4JOXr1PUAcFUrWv0K2QHAsw8cUkuW2NiwdsslOEj35MC7JkkyHfWpwBSoAe
         2kTQbtW7GBhN7JdNRU+IyodzdTNhY0d6bMwGhgdXqlhN9O2TJ8BzWMwsVf/pTt/i6Iw8
         ObfafZllFwdkVtYMsiKAEusAaQM/wfIwxx4pj2BVmG71o6l5uplUwAkph7rVs5Dsh+kZ
         T4jm2/dUihPTr04msvt245U2iVH+ixtIljxu/0dK1vG3xq2Nidt1R1dAgsCV5yeCsGdo
         tIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vkh+emjnnehC0a61TJAj3pwsHMRC4VLx1k8vVqN/naM=;
        b=qK3xxiDxHxniGR7w+wp6GiGpgXss7wa867mgqXqSFrHVlLVqF8Sz1PxZE2prp4v/AI
         WxyXfU5iWQdelK0zi6v4ojXri+KyGNbhjd8YW45P16VfaaOtKH+3Jaze/7GSI6mO/SmO
         U5/3+a0Wg1fw9uvN1xJ/RPCltrrqDJF1ByygA6iHNvP/IIs/9E7m/oWe+3amF1I4Raq2
         NcEUnGj91qqkB5dsxQIw8+s6wevUc81B3y744CftGC5CUULP98job0OBViOlsgIdwF4R
         UD0NspwPFoQPYCsDrcxnKkzPjqDxuamYB22VoTSkPChpJiZ2BLywvc48fW144RJ60bEL
         DgSg==
X-Gm-Message-State: APjAAAVM8XpsIBgQM0AjNGdS3R6HXXIxlpolH9jVWKBYtaX8dtj6Ga+P
        X/ApR1A0ac5xJCjv/p86z/I=
X-Google-Smtp-Source: APXvYqwEShJZ9+oZ03eV/kVi4uQerK1+/3lnqkADexCndrT7h+74IWS46HnWSNlm0ZySvqS0NT5Niw==
X-Received: by 2002:a5d:650d:: with SMTP id x13mr12402300wru.119.1551697519552;
        Mon, 04 Mar 2019 03:05:19 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id w10sm8174573wru.5.2019.03.04.03.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 03:05:18 -0800 (PST)
Date:   Mon, 4 Mar 2019 12:05:17 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Claudiu.Beznea@microchip.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, bbrezillon@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 5/7] pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's
 PWM
Message-ID: <20190304110517.GB5121@ulmo>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <1551284609-14594-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <1551284609-14594-6-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 04:24:35PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Add compatible string for SAM9X60 HLCDC's PWM.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 3 +++
>  1 file changed, 3 insertions(+)

I guess it makes more sense for this to go in with the MFD changes
rather than through the PWM tree, so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9Bm0ACgkQ3SOs138+
s6EWQxAAkN1EcQnql995goLfgqGi63WG+AC7uBVsPlv8MeYUyuk5uXHwpZIfL1Yk
U7vnC6E6EByjVnj18T/faZzqMgUJJlTzmVbPBT9C2D/GW7Hg9Sz6SCIg0tiNYaFY
uN095C/+FfnAxeqmBtufXU5dQQeYSG1kxs4H6mj6Ypl71Jw0h8fg5PoXpRTM6ZOL
s8KdHnFgZPFBYg3lioKV6UBrTWnV59YUPPbBChDam7jVv9muKp+VKGct7PRC9f64
LAfmR82g8dLP1HTv6IkYhLYU6gioCBUPuk3HAMb0MndUF4szMEUOJk4Z/UxMpnzN
xMcrHiiiEfkzvS9ugK9VAGGnMV63NmtpntaItyBsLvdEairrenqI2ci45QqgrHSu
IFartnXKU87MrPj2cm6kzR6T0Zv1o/xO3WfCSskU1euKqrRpSxHkYuM30nEP/ro+
0Fxi2UzOEZenAOgVEQra+Yi+OPXbAW12kdgsNRo7zo9tuvUgXBH1ekJM6okcZNOd
/kgD3Sacjp9PgDml/jzouuSsfPLITSqYLVQWMIHTn6Wrgl31p0+iv4e2wxRB7dPW
7iFts1ZqEA1oe6OyFBo7dOoljEcP7Mjjwipl9VUgm8n1lVyauLWUqUdpxtBXJA6/
MVNpUZvMZ2thGGVEpAvRwbCZ2lF+i3Zi0lWzwao3dnHgHp9hj54=
=/1Mc
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
