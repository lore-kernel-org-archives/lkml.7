Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43632ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE9420835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfJGWSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 18:18:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45632 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGWSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:18:21 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5045980555; Tue,  8 Oct 2019 00:18:03 +0200 (CEST)
Date:   Tue, 8 Oct 2019 00:18:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <20191007221817.GA4027@amd>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <20191006114129.GD24605@amd>
 <CAHk-=wjvhovO6V4-zT=xEMFnRonYteZvsPo-S0_n_DetSTUk5A@mail.gmail.com>
 <20191006173501.GA31243@amd>
 <CAHk-=whgfz2+OgBTVrHLoHK57emYb4gN6TtJ_s-607U=jBQ+ig@mail.gmail.com>
 <20191006182103.GA2394@amd>
 <20191007114734.GA6104@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20191007114734.GA6104@mit.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-10-07 07:47:34, Theodore Y. Ts'o wrote:
> On Sun, Oct 06, 2019 at 08:21:03PM +0200, Pavel Machek wrote:
> > Even without cycle counter... if we _know_ we are trying to generate
> > entropy and have MMC available, we don't care about power and
> > performance.
> >=20
> > So we can just...
> >=20
> >    issue read request on MMC
> >    while (!interrupt_done)
> >    	 i++
> > 	=20
> > ...and then use i++ as poor man's version of cycle counter.
>=20
> I suggest that you try that and see how much uncertainty you really
> have before you assume that this is actually going to work.  Again, on
> "System on a Chip" systems, there is very likely a single master
> oscillator, and the eMMC is going to be on the the same silicon die as
> the CPU.  At least for spinning rust platters it's on a physically

I have many systems including SoC here, but technology needed for NAND
flash is different from technology for CPU, so these parts do _not_
share a silicon die. They do not even share same package. (Also RTC
tends to be on separate chip, connected using i2c).

Would you have an example of Linux-capable system where eMMC is on
same chip as CPU?

> P.S.  Note that this Don Davis's paper[1] claims that they were able
> to extract 100 independent unpredictable bits per _minute_.  Given
> that modern init scripts want us to be able to boot in under a few

Well, for now I'm arguing that it is possible to gather entropy, not
neccessarily that it is going to be fast. Still waiting minute and a
half during boot is better than generating non-random keys.

Linux already credits interrupts with some entropy, so all I really
need to do is generate some interrupts. And "find /" generates lots of
those on embedded systems. (Even with nfsroot as long as network card
is not being polled...)

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2buakACgkQMOfwapXb+vIMKACfTYD726DRhIKO8U/fIqbhpkhb
6X0AnjicfyhZGiQk6WZBcx++vPb4LCtJ
=U6l+
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
