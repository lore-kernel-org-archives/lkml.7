Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18CCC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723BD206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfDALyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:54:18 -0400
Received: from sauhun.de ([88.99.104.3]:50782 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfDALyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:54:17 -0400
Received: from localhost (p54B331B1.dip0.t-ipconnect.de [84.179.49.177])
        by pokefinder.org (Postfix) with ESMTPSA id 06A622C7BF4;
        Mon,  1 Apr 2019 13:54:14 +0200 (CEST)
Date:   Mon, 1 Apr 2019 13:54:14 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] i2c: remove use of in_atomic()
Message-ID: <20190401115414.hxrqqjujvwczdafz@ninjato>
References: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
 <20190401104756.GK11158@hirez.programming.kicks-ass.net>
 <20190401111323.ajvo4drongc6dtel@ninjato>
 <20190401112109.GB12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i6ygapewcnz2fobg"
Content-Disposition: inline
In-Reply-To: <20190401112109.GB12232@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i6ygapewcnz2fobg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > "This matches the use cases for atomic I2C transfers I have seen so far:
> > very late communication (mostly to a PMIC) to powerdown or reboot the
> > system."
>=20
> Ah, sorry, I missed that.
>=20
> > And yes, I would never recommend a HW design to use I2C for shutting
> > down/rebooting. But such HW is out there.
>=20
> Can we then make the whole thing conditional on:
>=20
>   system_state > SYSTEM_RUNNING
>=20
> Such that we're sure to never trigger this under any other conditions?

Oh, we can for sure modify the code to something else. Actually, this is
why I was calling out to you. I was never comfortable with the old
'in_atomic() || irqs_disabled()' code, but wasn't sure what would be an
adequate replacement which will not risk regressions.

The above condition makes much more sense to me and is also much more
readable. Can it simply replace irqs_disabled()? Are interrupts already
disabled for system_state > SYSTEM_RUNNING? (I got a bit lost in the
code paths when trying to figure it out)


--i6ygapewcnz2fobg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyh++IACgkQFA3kzBSg
KbZoahAAruazcsi+JSHoP4Pk52K5w1109bs+btGr6Ti6AqRIUsAQPlPuBHbmtrLW
YbfICiy7sdtvDRPImwOVVrY88/TBPWb2QcW5HUNuf9ePLKY5zeqyQ52NQYvK5CMs
TI2ywZRQ7E/ViwXI5gwFDD9jl3Ygn6ag8n3Y1elEYsqllbUYw5Zf6qUnWKY1YH12
ogrdw4u23jmFiazbX1KZ1v0WwLxKl70JO3yVuJc/tAl4sncuZ4t1Cb1QYjngfYxv
LDy80jsvp1B28JDeN/qEwrX5/Jx/9fPebKPhQzToPREUbj5+hT2fDu1loGOJkIsY
dWuhme12B3nujnRsZzDR9YPpF32YNBa6JWwl/QxBNgJzBWSAI3zET8M6vIFSKkwo
xjdeluZ5hGii+r34SG70HfM2p5zo/UgnkEHhnfgQkIOc6xlRlRdn9oDWTnCPXrjc
HxodJyPWOi4wnuVdbvtBZsPmIXbj02azZfu4/61jGKij5NHQv+JFYGQdUaptCYZg
B0QRusvI9v/gXc/ljz0h6JU5gp2QXGlWitw1wh03+dwvJvxGr6V9HbDdEM+8p17k
vup4WcfWjUNzjeLhqeVHRvqo6frJAJ+/uJAJwe0CRec2hfcly2Zf8UNkgpk6/3jA
fc8j09d5uCWf9kY2XD7i8y4ErOrYKrzKXI05Bq2uPFUXJdRSAss=
=Gz1t
-----END PGP SIGNATURE-----

--i6ygapewcnz2fobg--
