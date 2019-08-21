Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA146C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A085020870
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566387034;
	bh=miyV1yAhYGd1imYdis9tXt6f+PhahUeaBRD6ZdTZDGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0NiaFijZi4dZgCRL1rwZuZj44sakz3IDNA+Zghu7tZyuVO2iXRPbL496IET8vKBbN
	 O/PgEEFjlNoMzKl4SwasBIXiAIh21cVyzDUcRle3DMkBFVPYNrm7+B3d9E1vvj0Taz
	 TdSYqCCsuriUhf2uTFg6Cpds8TnM42ttNpVdWfTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfHULad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:30:33 -0400
Received: from mail-wr1-f99.google.com ([209.85.221.99]:39765 "EHLO
        mail-wr1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfHULad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:30:33 -0400
Received: by mail-wr1-f99.google.com with SMTP id t16so1688724wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 04:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lX8OK4lw2mSaArlQhylN2j6glOuN8geLPKNWACNmoxs=;
        b=HcTwKBhzWdYGmtP/5bN2bkgaLTXicJ/7kVYivgulOldWaFUkT2nBE0B3FNFMGrFiAu
         RHBHo10lkGP4mjED9lHsBAxPAK/Pv12CBf1uKh8WQpTXUp/pFuwrW3hInakseh9wDnXc
         lZ0wn+KWE64etONdbVzetJradrkPkjWzezgqxWFA4vAYA9UaEltlhxSvuNUDGwYb6Xn3
         jCJb3kKP5CQkoP5anmkVS1zSuqgKbNkdMj5Y8Y9jCtQn/XREvRxvHKIOrL4fEO0VGl6v
         z7oMgcfkwoeijmo131WS1YTqECEI8pItZUk5kFD0VwJl1hU/JRoNKtANthzn/DpYvcRV
         GfaQ==
X-Gm-Message-State: APjAAAUGB5FSMgigiSV7WfK2ndCiDJeyh1Mfqz6XvPOxWx0iXjas9KT+
        LXaCLZ3cTG+T5HFOsBzmws3Qsd55O1Lznmrkla4dkS/PPvwZ1GtPTuI2CHEtxyT9iQ==
X-Google-Smtp-Source: APXvYqwvTyTDb6VFbY2EqaFvWbValAURyRt87hzPT4tfTUSHu4/Nzwme2MpyRbHAexRUvenclaER0MUo0iBs
X-Received: by 2002:a5d:414f:: with SMTP id c15mr11194539wrq.248.1566387030279;
        Wed, 21 Aug 2019 04:30:30 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id h15sm29024wml.50.2019.08.21.04.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 04:30:30 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0Oov-0006xA-Vq; Wed, 21 Aug 2019 11:30:30 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2F53C2742FCD; Wed, 21 Aug 2019 12:30:29 +0100 (BST)
Date:   Wed, 21 Aug 2019 12:30:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Li Yang <leoyang.li@nxp.com>, nandor.han@vaisala.com,
        Biwen Li <biwen.li@nxp.com>, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [v2] rtc: pcf85363/pcf85263: fix error that failed to run
 hwclock -w
Message-ID: <20190821113029.GE5128@sirena.co.uk>
References: <20190816024636.34738-1-biwen.li@nxp.com>
 <20190816080417.GB3545@piout.net>
 <CADRPPNRkqbWzGEvUJyi0Qff3oS6biO0v7BTrK1Jiz9AMnOYF=Q@mail.gmail.com>
 <20190816162825.GE3545@piout.net>
 <CADRPPNQwcGrVXLm8eHbXKmyecMhT6Mt9rNGnspJA1+MnV4K8oQ@mail.gmail.com>
 <20190820182224.GI4738@sirena.co.uk>
 <CADRPPNQ__XRW74e+Dq0BEjJq-onVi2dmb7qKrn2Lt_xr50VCCw@mail.gmail.com>
 <20190821112142.GD5128@sirena.co.uk>
 <20190821112413.GA27031@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
Content-Disposition: inline
In-Reply-To: <20190821112413.GA27031@piout.net>
X-Cookie: Sic transit gloria Monday!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2019 at 01:24:13PM +0200, Alexandre Belloni wrote:
> On 21/08/2019 12:21:42+0100, Mark Brown wrote:
> > On Tue, Aug 20, 2019 at 01:33:14PM -0500, Li Yang wrote:

> > > violation check of regmap rejects such access.  According to
> > > Alexcandre, the address wrapping is essential to the functionality of

> > It's *essential*?  Will innovation never cease?

> To be clear, for some RTCs, its is the only way to accurately set the
> time.

What's the mechanism here?  It's a very strange thing to require.

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1dK1QACgkQJNaLcl1U
h9Ayhgf/XhM7dhJYY6RazezOq9Nl3U6x8jy2f48DgsiJz0ayCQnPPMIhyp0YRd68
UMMq45/qttkREr04v3OjOo9FIPbCkkL/47+oz8aZ02YX93ip/cU4B0NvDojfSOx2
bI3UK2pKnbM0qWhdQFJj21sUmZoN3FRcHPJv+b44aPj/CxxkC8K/XDluim+YIUDF
fmgAtYUTZl66b2lGIUxYoyFp7tM192ZHk4wsINg1lho1PXVaDyBN9fYYXP8iPxaY
1AtnDJObrGHHOUlzYeo3zLafqSFNL3/gWYzFKj/c6rAbAiItOxzhNawqcJ7tjzyP
qLd9YlmqIWKSLQzTjbRexnU1XzhInA==
=KziT
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
