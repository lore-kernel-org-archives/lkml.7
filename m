Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6E1C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC0722CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566389706;
	bh=VGZTPAwEFySlPPXASsZQPbUHcTae/+X/wRKQPmmsLlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nrs0j2KppfjFWRFfXr7m0LW4YZObMUYeIn9eJhPIZmmosUonLSFHXL1UcBzRPdvgb
	 Nw1dldXwR9hjJcM8k7pzkF7H8KYBrkWeB0+O0mTUjUfknq8TYk45AHrEHN19gH0zlH
	 BRS/kZWc5QTzC5o7O8pNyFZRDTFTVU/9PR+Egh/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfHUMPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:15:05 -0400
Received: from mail-wm1-f97.google.com ([209.85.128.97]:33908 "EHLO
        mail-wm1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfHUMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:15:04 -0400
Received: by mail-wm1-f97.google.com with SMTP id e8so4653849wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 05:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VGZTPAwEFySlPPXASsZQPbUHcTae/+X/wRKQPmmsLlA=;
        b=efD0Wdmw1Kx/huExEsZZNhcqFjlt7Y7l1HxqwYBujhC1clW4zQJKGS/VynEcZmY8mF
         L2dMseC8sEQ9y3eDJ+N29vwbfJ4j8hXe2DDIwK6xP0oZ5ZMr57AvuPMTnaARLy/xh2kQ
         yF12oaLKHv5kTuOeKHHmbIH+QuJyt69BLWOG8bAOdDJBVH8LR4wN+3XsTvGVWtr8MMBs
         z93jlMmKkdmLUwj4f2iKmDbh6Yt2Msda4WKgCKtlaXbvpL94f8wJcKnGFF/JYt5UFxZ0
         MO1LwBL+htYxv5H0cyN8HxAXts0wpyGedhTVrP78x+mrXj4X3n/mmwZwL1I1zh08fKVA
         r2Nw==
X-Gm-Message-State: APjAAAV3kaJQr3P3BSRtiblr1D9mrxHgBA18U5tqS5tSfiIvDH6R9Scf
        rjOLlpbmzKKm8ixSIvbyJhXHWDj0s3dQGYve14CmA+2G/u1ao+FCVV0Ox4nrWwVUTQ==
X-Google-Smtp-Source: APXvYqx72VjNla/WwnS7IIJyQhWoevv0baJnS50eIJ+ckMwP5dp6AWm1BTVGmWHpbrM+BQLgBUNjnoOjjbBg
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr5774547wmf.100.1566389702638;
        Wed, 21 Aug 2019 05:15:02 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id w10sm327537wre.38.2019.08.21.05.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 05:15:02 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0PW2-00076s-8u; Wed, 21 Aug 2019 12:15:02 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7E7CB2742FCD; Wed, 21 Aug 2019 13:15:00 +0100 (BST)
Date:   Wed, 21 Aug 2019 13:15:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/21] ASoC: sun4i-i2s: Add support for DSP formats
Message-ID: <20190821121500.GI5128@sirena.co.uk>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
 <74cc9562e056627e14f186089d349022b65f59e7.1566242458.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5uO961YFyoDlzFnP"
Content-Disposition: inline
In-Reply-To: <74cc9562e056627e14f186089d349022b65f59e7.1566242458.git-series.maxime.ripard@bootlin.com>
X-Cookie: Sic transit gloria Monday!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5uO961YFyoDlzFnP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2019 at 09:25:28PM +0200, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> In addition to the I2S format, the controller also supports the DSP_*
> formats.

This doesn't seem to apply against current code, please check and
resend.

--5uO961YFyoDlzFnP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1dNcMACgkQJNaLcl1U
h9D3iQf/bXRJ2E8Ojq2kL+wJHey9oZmklhShBIGtZToXjBYiLvXOKxDZF0oAkhMI
gEFuZrDp/IDMtsTlXJ3OGhenBm6x6gQH+H2aTrUetM5G88JZ4c8kpJbG2s7Fvgvh
AE/yrrimb4wSW4LVbrmoe4e0N9M4V8VkG23BeJUBkQ3FVkcfTgVfLyoEdR+cvTlJ
Qyx58lTPdnnjkiW8df6XpND3ecO0sEyhdyJcNfLPNU/iXTuyK4wI30zujrwdRTyF
fJAfg4uzwkBDP3/vMftf6RwwDmK56MfRkeLYicwHkOTVWZsyht7TFuqW7k74Uy1J
UUaqo75QN/JdI7QkSurXjhmilrAIdw==
=cEmS
-----END PGP SIGNATURE-----

--5uO961YFyoDlzFnP--
