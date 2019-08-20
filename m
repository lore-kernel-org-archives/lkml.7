Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F14C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AC922DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322747;
	bh=C0TZoOnjdSroAJfjPrY79Em0RwrSlnpToIAz4oVtwxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=di6K+GBc7cXKPATcdgvFf8pJtGr6RECn9iEkDekZ3Su+238iUFhTKgKoWk/aRK/rJ
	 8sIykmyVprpbs9MD5cjqDz40a+N1XxsLqXWdVloVd4WjIGhFna63g15TxVL0O9fWE3
	 o9P6nRMXNTAai2d5yuoftfVMNVo1bk4ghOtX859c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfHTRjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:39:06 -0400
Received: from mail-wr1-f97.google.com ([209.85.221.97]:38662 "EHLO
        mail-wr1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfHTRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:39:06 -0400
Received: by mail-wr1-f97.google.com with SMTP id g17so13288888wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m7ao7ORH60h0tFo771t8XxOyJrM0P+fZjWuoPCMruUU=;
        b=TOGKcirGshBV3cwSO/PBKAw9E4ZQPPspTl5gOgrpcuh1V22vvyW/7/ZIV9UT09lcjA
         2jtCAuu2noWqe1HGK4EOATbx6wqzzpwBlXU8NwRYZ6nSzuvQpiz5gkqVHXHQt5iDbajP
         ebKpSsSNPIYZZKzCebTSaMu+CQ3Zk3uCAtJzGPznBlKk29In5adidyVw5KyP5KkejSkQ
         nHDp2jdPmDWHDarFoeboMp2WpVyZmpwmgFEPkQyCicOT0ZwHiSSjwGP99IEAJgpsK1gb
         HgPhbcoAkDsm+DDhvgYS8J7TfApXAl5GjmnMtiTXFA3JTKPemEUQcdzxZ/i0NlBoEgMp
         /mKQ==
X-Gm-Message-State: APjAAAUBCX+3u6FaJ2/gW2avTYxFIYsOwpq61OiWOHwEO6/10WspjL5p
        NQSVWxf/ekhkQQjxLUHWdHUwa0yF25MHx/dox1Cxy4exeE3DGMMoh0oMS6XZAiLkMw==
X-Google-Smtp-Source: APXvYqzLzv/aLlzn2NHdKvwVs2INSBhJKvCzoIitnolVH0fpSkwLd7iHz1QYiEa9AY9Z0BuWcUR9HGgkrZ69
X-Received: by 2002:a5d:6307:: with SMTP id i7mr36464585wru.144.1566322744775;
        Tue, 20 Aug 2019 10:39:04 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id f9sm2448wmj.34.2019.08.20.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:39:04 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0864-00031g-Cu; Tue, 20 Aug 2019 17:39:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 593B12742B4A; Tue, 20 Aug 2019 18:39:03 +0100 (BST)
Date:   Tue, 20 Aug 2019 18:39:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/21] ASoC: sun4i-i2s: Use the actual format width
 instead of an hardcoded one
Message-ID: <20190820173903.GA5702@sirena.co.uk>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
 <fcf77b3bee47b54d81d1a3f4f107312f44388f5a.1566242458.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <fcf77b3bee47b54d81d1a3f4f107312f44388f5a.1566242458.git-series.maxime.ripard@bootlin.com>
X-Cookie: When in doubt, lead trump.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2019 at 09:25:18PM +0200, Maxime Ripard wrote:

>  		regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
>  				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> -				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
> +				   SUN8I_I2S_FMT0_LRCK_PERIOD(params_physical_width(params)));

This doesn't build for me:

In file included from sound/soc/sunxi/sun4i-i2s.c:16:
sound/soc/sunxi/sun4i-i2s.c: In function =E2=80=98sun4i_i2s_set_clk_rate=E2=
=80=99:
sound/soc/sunxi/sun4i-i2s.c:360:57: error: =E2=80=98params=E2=80=99 undecla=
red (first use in this function); did you mean =E2=80=98parameq=E2=80=99?
        SUN8I_I2S_FMT0_LRCK_PERIOD(params_physical_width(params)));
                                                         ^~~~~~
=2E/include/linux/regmap.h:75:42: note: in definition of macro =E2=80=98reg=
map_update_bits=E2=80=99
  regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
                                          ^~~
sound/soc/sunxi/sun4i-i2s.c:360:8: note: in expansion of macro =E2=80=98SUN=
8I_I2S_FMT0_LRCK_PERIOD=E2=80=99
        SUN8I_I2S_FMT0_LRCK_PERIOD(params_physical_width(params)));

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1cMDYACgkQJNaLcl1U
h9A5+wf/R8kszzb6oMjGJWYnQJj4y8zrub+Ef7frMS3FakQtrfpNijxNi57HOXai
jJvL1rK1E89FeYJlt5rPq9DJGlWe8dS9dMvhuz7JhsYl5cn+8m4o1LoUbH6Inv5k
95bWW3IC9IBXhd6MiQwBZZpZ79T1UjHu9UfOF5dOEQ059wu8JCYvA0y/PzyH6kq8
w1MO/wGVaEHT/DMsAs66Mp5/3Ju8DAn9ZaE7ZhrgIsBphf/P+/BZHPU/pQjFEVag
f0ayDyQwRU1t26KvNeIRQpnUXV/N7ZF7j/uQ2mUQDTPjViBLS0uzUw/5bklcAT24
w+0X+AVImMFg+yfuBP7oOP25UCjzbQ==
=C0WO
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
