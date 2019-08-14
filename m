Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D3C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C58E204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565775016;
	bh=oiEx3swFb2tjyBLF7BTmS3sWaWtT5PtsbtdpNxoJpzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BWVc6cKcmwfsoNtHqW/2uZkKDBsvn9qmWUsLZmb+Y2dhEoqxuyz8qMOCrNVBwdaTo
	 Ppsye5mSXuKkNDqsbvPnv1lyRdbbTFSlcs96sKTa80l36cRi2v0oQOaJ+yZyZ2U0xU
	 NQLyRlRi10ZWLngGRFYkFSFTz/vqkX3B861FrJjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfHNJaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:30:15 -0400
Received: from mail-ed1-f100.google.com ([209.85.208.100]:34834 "EHLO
        mail-ed1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfHNJaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:30:14 -0400
Received: by mail-ed1-f100.google.com with SMTP id w20so109299898edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 02:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v9qswxVy3dhs4GBr5jsRkUeG6VCbad8w9toRrnKPrhA=;
        b=kokv2WiVL2NeJT1tr7XNMK3EHxZ2WFprEyfv+HiM5sEf00n2jLyDPjw0to+7/CmWwD
         ZdzhQASYVqJN5NtArFlJ1TNLL9rBQqStE+7QiRCKwjaW0/XAuFQMqWPbznWe4smEdpJM
         bVetpaMCHOOge3QfkDwJ0AK92Ydj83jliU37spLO3Sa7s5B9A1nNgcNwl5/tsZN6KJ1/
         DS9UTjKVKPeA+gvcaxJUe9dgmMo6yH2LAE1TJ2TrGC+gy3vNoN6cYBHUYM9VZw6bhrJS
         t8tgyh5r4x0XlY3gbWPhwgcV85ev97X/C3AovRc73L4E/a1bIV30OMh2dg/EO2oOOuRG
         B/6w==
X-Gm-Message-State: APjAAAXEuLOdCT9Ts873Nj9Tl23ue1Q0hbICk2XKi6d+QkQlkOOWNaO/
        gmV2fFgbccuHvUz1SBE9pJCdYbRdNA+Er925SK51hGzqABee4lJlvhla00DbJhA7cA==
X-Google-Smtp-Source: APXvYqyn2COYFbRgFubQJiRoUpBUtvfPHPFcJS7BJSMtk+eyrvFPgPJaildqaSGQJ5Xqjr4NHfOpp16s8q6E
X-Received: by 2002:a50:eb8f:: with SMTP id y15mr46657373edr.31.1565775012649;
        Wed, 14 Aug 2019 02:30:12 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id dd24sm47927ejb.47.2019.08.14.02.30.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 02:30:12 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxpbg-0004iH-3X; Wed, 14 Aug 2019 09:30:12 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3A9C92742B4F; Wed, 14 Aug 2019 10:30:11 +0100 (BST)
Date:   Wed, 14 Aug 2019 10:30:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     codekipper@gmail.com
Cc:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v5 02/15] ASoC: sun4i-i2s: Add set_tdm_slot functionality
Message-ID: <20190814093011.GD4640@sirena.co.uk>
References: <20190814060854.26345-1-codekipper@gmail.com>
 <20190814060854.26345-3-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline
In-Reply-To: <20190814060854.26345-3-codekipper@gmail.com>
X-Cookie: Bridge ahead.  Pay troll.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2019 at 08:08:41AM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> Codecs without a control connection such as i2s based HDMI audio and
> the Pine64 DAC require a different amount of bit clocks per frame than

This isn't a universal property of CODECs without a control, and it's
something that CODECs with control can require too.

>  	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
> -				      params_width(params));
> +				      i2s->tdm_slots ?
> +				      i2s->slot_width : params_width(params));

Please write normal conditional statements unless there's a strong
reason to do otherwise, it makes things more legible.

> +static int sun4i_i2s_set_dai_tdm_slot(struct snd_soc_dai *dai,
> +				      unsigned int tx_mask,
> +				      unsigned int rx_mask,
> +				      int slots, int width)
> +{
> +	struct sun4i_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> +
> +	i2s->tdm_slots =3D slots;
> +
> +	i2s->slot_width =3D width;
> +
> +	return 0;
> +}

No validation of the parameters here?

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1T1KIACgkQJNaLcl1U
h9CHugf6AjRO807eogpoF+xMNPWXjrK1Id3f+lBIjI+eQIHyysNsaOoU2cQm/xpC
oDixIET5TAwZtKrSpkmHPVk9ZdJFE8nzoUiZMauPOO+HKM9gxv73e4YXXimy08Id
KWmW6ajMPF2vgbrlU9j4HyPF/PxSxlDeqz4gzzhQ0SITqZa4TVFCdgM5xGuoAOLT
FVoipx99YfkemyMLeUmW+WS9z+cgq9EHznThZa/kKkdCxJLErL4JPuhOQ2s7o5JH
fB9HoFqiF8YFLE3tkcUf7qhIwq5913DuC2PH3bX4GPleK1PfH41JvD0+QBj1Aw00
BLuoNb+o7HReyWJhvgG0NOHxFgnQgw==
=bgB5
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
