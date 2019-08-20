Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20221C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADAE22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566325349;
	bh=NR2PNGTBj2Ayh7JYEBW6jlJcbOTazJsR2jdieZr7OKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A4GXCtAjw6RgYF6lf9iLiGrguB6ula8tDEYTC5n9Q2k7g8Og0T/WLEg9ibO2TraJT
	 FC/cCFVWkv22mzOlu1yQboyevo2XidJ0XoV5ncgF4SPj9Z7Mz8qvgnv8FepmjnWfFR
	 HMmm/r7CEU4KhmBZ8qT8/GJFbGVOYpmVmVnAMz+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfHTSW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 14:22:27 -0400
Received: from mail-ed1-f97.google.com ([209.85.208.97]:41411 "EHLO
        mail-ed1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbfHTSW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 14:22:27 -0400
Received: by mail-ed1-f97.google.com with SMTP id w5so7404709edl.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 11:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NR2PNGTBj2Ayh7JYEBW6jlJcbOTazJsR2jdieZr7OKM=;
        b=VDklawTzrZuZDEHpI+FBbsV9XHYJ4Fsb2PTMV5RtwmOvrEF/8YX0tCg2E0WAGtP1fk
         HcqEYdymOuRCPbjZ3DuA7ZOhCRbB6p48+plzrQXyNbDWfFQGwK+qYhT7tw3tXi2eP2vo
         dHIKJZs0SAUUU1nTwrlr5mR6BH/ucH7FogqMvmbvpc8zUu1rdzZUs9TSIr5qIoMDjQoc
         vUDK1K8ZwA6J8rThH/+Gc3XZVNG+cu5Ng2cMaeVZeA052Y3MJH78XYebvbzhu13DgKbT
         t29ufxEDi5qG2oZLkpCx1B8YOb1lDtJBid5YkrsOlvUihiEzWz5LnPLUySUpms0yKntU
         Nr5w==
X-Gm-Message-State: APjAAAWO8T8/WIJSF+9rtJOBbHAZkAgJCNlukRJkj0+X5IINkFZrUb2V
        XQRxGZyIcDa2YrSadTV18OLpQp+bDpuZFw7gN/lrLYcximj9X3PdBrVz4lUp5xeVkw==
X-Google-Smtp-Source: APXvYqx+CTiwFr1QwQk7cRBWMES9QXV0lxv8/m4Eyo9SNeMlbU7AuoA5rNcbBKrLCRF1Crb1fdQUZsoIV+E7
X-Received: by 2002:a50:b875:: with SMTP id k50mr32683032ede.232.1566325345649;
        Tue, 20 Aug 2019 11:22:25 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id me6sm122372ejb.79.2019.08.20.11.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 11:22:25 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i08m0-0003Br-UB; Tue, 20 Aug 2019 18:22:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3470D2742B4A; Tue, 20 Aug 2019 19:22:24 +0100 (BST)
Date:   Tue, 20 Aug 2019 19:22:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        nandor.han@vaisala.com, Biwen Li <biwen.li@nxp.com>,
        a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [v2] rtc: pcf85363/pcf85263: fix error that failed to run
 hwclock -w
Message-ID: <20190820182224.GI4738@sirena.co.uk>
References: <20190816024636.34738-1-biwen.li@nxp.com>
 <20190816080417.GB3545@piout.net>
 <CADRPPNRkqbWzGEvUJyi0Qff3oS6biO0v7BTrK1Jiz9AMnOYF=Q@mail.gmail.com>
 <20190816162825.GE3545@piout.net>
 <CADRPPNQwcGrVXLm8eHbXKmyecMhT6Mt9rNGnspJA1+MnV4K8oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6lCXDTVICvIQMz0h"
Content-Disposition: inline
In-Reply-To: <CADRPPNQwcGrVXLm8eHbXKmyecMhT6Mt9rNGnspJA1+MnV4K8oQ@mail.gmail.com>
X-Cookie: It's the thought, if any, that counts!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6lCXDTVICvIQMz0h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2019 at 02:40:47PM -0500, Li Yang wrote:
> On Fri, Aug 16, 2019 at 11:30 AM Alexandre Belloni

> > Most of the i2c RTCs do address wrapping which is sometimes the only way
> > to properly set the time.

> Adding Mark and Nandor to the loop.

Is there a specific question or something here?

--6lCXDTVICvIQMz0h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1cOl8ACgkQJNaLcl1U
h9BjnAf+JasBDezU/5IgpHDFc80ChLOoHUNgI9IyaopUZvdSwEi/QerwIKVw//Vw
gXezgpTsalSWbdyBhWEozA7guXOovO1uX4BRN9+81S8e6/RdZ7RUuv7/QX2fSgW6
Wz0Jvxx4NgnVb2qXRCpqIKsbHWVRZmGDAuSP61kqfFd+ih0BrZbOjiK3nq2TQ1at
lCu6WwCwdUEicVBKQbHNAelujZNNjaW8R0KnKa4OwwVU0KNDC/TCMVbcnpUaZ43O
PLWvbgHWJ0wJgEFmQkOiIV362ogz+iBM6LUcXwDJAmqYRy17Ec3OOuwO167heevO
nyXbEur1lhluFlhHZmH9GFKXOHrFiQ==
=sZs9
-----END PGP SIGNATURE-----

--6lCXDTVICvIQMz0h--
