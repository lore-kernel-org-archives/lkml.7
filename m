Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE017C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F30A22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566388047;
	bh=GV01KeAUYlu4sipMh9vrahDwfavjDPrAODfAHT5mdks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PWIh7+wD4Y72LAxnvNankADXh/FnAe9MDu6p6atDSpCTGRVpAY1dBa7TtCrjsQ1m6
	 +dKWDVFw8k/bo63bPF2NQRzXzNkIgIELqu4QouEv06QkSdvL3UBl/9cRYHGRN3+k6C
	 5w/8QZckg+4fnxrb5JPmobNaM4unlP4sBa+NMtP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfHULr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:47:26 -0400
Received: from mail-wr1-f100.google.com ([209.85.221.100]:46749 "EHLO
        mail-wr1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfHULrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:47:25 -0400
Received: by mail-wr1-f100.google.com with SMTP id z1so1706375wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 04:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zpJrwrxxvYiCGTqZfEB4v/W4+ZD+ic4TYT5QJIWQg24=;
        b=MlUsoHQ0Ed3igUywx6DF+R0hVR9jrkSDsQ5ZpF4zZ5FDO+PCjYz1Iw5UqaEszUBksN
         aXBLwNuHtrT8ri4QD6+p1rdSEiXCG8XJGEpNTZy/iFDUd68k8Hv+XB/rL9zVfs/cbue8
         rDClF+KU4CCJ9mXSU6e3hKC+u0wwng5wFKHImf47bNiBVtZZQOD3ZnQeJMoqiP0zoz4K
         3qIoE+uSaXMkx9nFKGSROcbauA1aqTSz66WSP3ehN1ZtlvWYiBzPAbAs61C1/vQy5thP
         pHqPvqEqm0loGjmlS0bdMWbeH0xZWtQUwNq5j4B9XxP7yzTKDbYEch/ig+gzg30NLxcD
         +NIQ==
X-Gm-Message-State: APjAAAVBO5pw/W5TFpld41frg1/3EmlBSYuuW6AgSdDY+OpzCvJ/WrPB
        3tPBTtIul1Yl60PSYNNdLucFUe9fiLSDyjSLU/kVEFUlXTuTqjlZruxa4o84nGzyUg==
X-Google-Smtp-Source: APXvYqy6S33ATvjywxWeTuhiD5Fb+Z2qKdNNoejAraiL4FisZvzUQzMX7gH9xgiySUhnp06RCUuXFQWmdii5
X-Received: by 2002:adf:ef07:: with SMTP id e7mr41792185wro.242.1566388044009;
        Wed, 21 Aug 2019 04:47:24 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id p1sm385228wrq.74.2019.08.21.04.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 04:47:23 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0P5H-00070S-Dq; Wed, 21 Aug 2019 11:47:23 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4CBF52742FCD; Wed, 21 Aug 2019 12:47:22 +0100 (BST)
Date:   Wed, 21 Aug 2019 12:47:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Li Yang <leoyang.li@nxp.com>, nandor.han@vaisala.com,
        Biwen Li <biwen.li@nxp.com>, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [v2] rtc: pcf85363/pcf85263: fix error that failed to run
 hwclock -w
Message-ID: <20190821114722.GF5128@sirena.co.uk>
References: <20190816080417.GB3545@piout.net>
 <CADRPPNRkqbWzGEvUJyi0Qff3oS6biO0v7BTrK1Jiz9AMnOYF=Q@mail.gmail.com>
 <20190816162825.GE3545@piout.net>
 <CADRPPNQwcGrVXLm8eHbXKmyecMhT6Mt9rNGnspJA1+MnV4K8oQ@mail.gmail.com>
 <20190820182224.GI4738@sirena.co.uk>
 <CADRPPNQ__XRW74e+Dq0BEjJq-onVi2dmb7qKrn2Lt_xr50VCCw@mail.gmail.com>
 <20190821112142.GD5128@sirena.co.uk>
 <20190821112413.GA27031@piout.net>
 <20190821113029.GE5128@sirena.co.uk>
 <20190821113856.GB27031@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline
In-Reply-To: <20190821113856.GB27031@piout.net>
X-Cookie: Sic transit gloria Monday!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2019 at 01:38:56PM +0200, Alexandre Belloni wrote:
> On 21/08/2019 12:30:29+0100, Mark Brown wrote:

> > What's the mechanism here?  It's a very strange thing to require.

> The clock control is on the first register, then you have sec, min,
> hour, day, mon, year.

> To be able to set the clock accurately, you need to first disable the
> clock, then set the time and date and finally reenable the clock in the
> first register. This should be done in a single i2c write.

Ugh, right.  And of course it would be silly to put the enable register
last or done some sort of strobe thing.

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1dL0kACgkQJNaLcl1U
h9BTEAf/YlFxsc7WReXJQuZ/Rye8kuOEKdbkAyvoCO5qMHoHTI7tJ7JQWqXFRNRG
PQkT/2cXa8Cun8QDL1q+dhU6VPWmJrBtoCnGLzKw8W4YpQAdWgbifOxxW5RqlzMK
lrmWzOxIUgFgxFC3hXVEpKOMNA+qp3JPB1M3dOcdFpdSG1IjslckJuOZ9t8Gdom7
rUfY5hbhQG+s9AHSvb/E2AmrlQUdbG3zD27fQ6NaiHC7u+lydsTdxqTwC0AghjVt
jL55LgHPDosJThjiYAtxtEHvDCvl06/9fXz/sZDETIKK+S1BpFlcj2FHtNpY8mMf
weRwLGDzmZSjzCBgjjnB3v8Srf6bKQ==
=r0gN
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
