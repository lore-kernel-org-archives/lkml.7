Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC0FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0066721774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574946826;
	bh=dnXNcXyuTtgDqMpz4APOynqOyZPJg8LLyEfHI27hVP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=maBtLe6QNllmStjcaYzPn/rRKV22FTJZUuO3uDB66oqaQdq50jPfkUhQf8fFl4I9l
	 HOL/BcduXGtnAaH6212ASOV7zKo1TGlSugUO+I1HMCpHFXf4Q+zIOQ2oa5sJKnP4is
	 9Xa/CTrBPqs86+SWkfqrX2ft7YLpkEGpL6XfsSXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfK1NNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:13:44 -0500
Received: from foss.arm.com ([217.140.110.172]:35126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfK1NNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:13:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F23EF30E;
        Thu, 28 Nov 2019 05:13:43 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FCA03F52E;
        Thu, 28 Nov 2019 05:13:43 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:13:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCHv2 6/6] ASoC: da7213: Add default clock handling
Message-ID: <20191128131341.GD4210@sirena.org.uk>
References: <20191126170841.GC4205@sirena.org.uk>
 <AM5PR1001MB09949D557742E8817545637F80450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191126175040.GD4205@sirena.org.uk>
 <AM5PR1001MB09940CF764711F1F13A6B37E80440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191127123317.GA4879@sirena.org.uk>
 <AM5PR1001MB0994D842A2D7051F81A7765B80440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191127154030.GD4879@sirena.org.uk>
 <AM5PR1001MB099467ACADA4F7B6DDA5087480440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191127164116.GE4879@sirena.org.uk>
 <AM5PR1001MB099446A50351CC49478893D780440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB099446A50351CC49478893D780440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2019 at 06:10:00PM +0000, Adam Thomson wrote:
> On 27 November 2019 16:41, Mark Brown wrote:

> > The PLL configuration specifies both input and output clock rates (as
> > well as an input clock source) so if it's got to configure the MCLK I'd
> > expect the driver to figure that out without needing the caller to
> > separately set the MCLK rate.

> Yes it does but the name of the function implies it's setting the codec's PLL,
> not the system clock, whereas the other function implies setting the system
> clock and not the PLL. Also generally you're only setting the sysclk once
> whereas you may want to configure and enable/disable the PLL more dynamically,
> at least for devices which do have a built-in PLL. Of course that could still be
> handled through the single PLL function call.

I wouldn't be so sure about only setting the SYSCLK once - if you've got
an input clock you can configure then you might for example want to
switch between 44.1kHz and 48kHz bases, and disable it or run it at very
low frequency when idle.  In some systems it's as dynamic as a PLL is.

> Just as an informational, what's the future for these two functions if
> essentially one is only really required and the other deemed redundant? I would
> just like to be clear so I'm not falling over things like this in the future,
> and wasting your time as well. Seems that the PLL call isn't part of simple
> generic card code so would the be deemed surplus to requirements some point down
> the line?

Things like simple-card are good for 90% of systems but I'm fairly sure
we'll never be able to handle more complex setups entirely
automatically.  What we *should* be doing over time is transitioning all
this clock stuff into the actual clock framework but that's a big, long
term thing which nobody is currently actually working on.

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3fyAUACgkQJNaLcl1U
h9BbLwf/ZISsJtwJ0CU1vhbk43SAwt2M4uHor1sY0rCDrh6SnqvRGe6TMWOHvjHz
9huuR+na9acBHQ5yOOiQn6fA9JGClPZNKN2HjgUOfZ28J1Qur+pNddbtTuy70xi4
oOayq16CdAMqXwa7IPIjo3lL+LIJfBJun2XGUQlKByrLpON/y+9LRT+r8twRpFhu
Ko0M4akmUEXodGJfWRPsoHXVDXRV9LMvKB8m5v9MwVSH4XHfzZCuf4XtlUIigztX
MnlSv4fnVyoHpRUbjShEsq0TIvOOIgf01NIGNqhsBLUd4OUlRMX64/FHDOSuObEn
n05/fdBhdXaCJRclImqdOUtFGdqHLA==
=Y+sk
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
