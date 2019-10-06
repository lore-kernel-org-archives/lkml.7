Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8725FC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD462077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfJFSVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 14:21:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55119 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfJFSVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 14:21:06 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0C5C6804BD; Sun,  6 Oct 2019 20:20:48 +0200 (CEST)
Date:   Sun, 6 Oct 2019 20:21:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <20191006182103.GA2394@amd>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <20191006114129.GD24605@amd>
 <CAHk-=wjvhovO6V4-zT=xEMFnRonYteZvsPo-S0_n_DetSTUk5A@mail.gmail.com>
 <20191006173501.GA31243@amd>
 <CAHk-=whgfz2+OgBTVrHLoHK57emYb4gN6TtJ_s-607U=jBQ+ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <CAHk-=whgfz2+OgBTVrHLoHK57emYb4gN6TtJ_s-607U=jBQ+ig@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-10-06 11:06:38, Linus Torvalds wrote:
> On Sun, Oct 6, 2019 at 10:35 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > It will not: boot is now halted because systemd wants some
> > entropy. Everything is idle and very little interrupts are
> > happening. We have spinning rust, but it is idle, and thus not
> > generating any interrupts.
>=20
> Yes, but we have that problem now solved.
>=20
> Except on embedded platforms that have garbage CPU's without even a
> cycle counter.
>=20
> But those won't have spinning rust anyway.
>=20
> Yes, bad SSD's and MMC disks (that they do have) will generate timing
> noise too, but in the absense of a cycle counter, that noise won't be
> much use.

Even without cycle counter... if we _know_ we are trying to generate
entropy and have MMC available, we don't care about power and
performance.

So we can just...

   issue read request on MMC
   while (!interrupt_done)
   	 i++
	=20
=2E..and then use i++ as poor man's version of cycle counter.

[We would not want to do that in normal operation, for obvious
reasons, just when userland is blocked and waiting for entropy.]

Hmm?

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2aMI8ACgkQMOfwapXb+vJTywCgnfuEma9x9CxZe2Emi8/q3o88
fAAAn1UB+rc9fkjq94ygwBLuGjAtgcFo
=qr1z
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
