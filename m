Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43C9C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8675120700
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfJFRfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:35:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53906 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbfJFRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:35:05 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 88382804A9; Sun,  6 Oct 2019 19:34:47 +0200 (CEST)
Date:   Sun, 6 Oct 2019 19:35:02 +0200
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
Message-ID: <20191006173501.GA31243@amd>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <20191006114129.GD24605@amd>
 <CAHk-=wjvhovO6V4-zT=xEMFnRonYteZvsPo-S0_n_DetSTUk5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjvhovO6V4-zT=xEMFnRonYteZvsPo-S0_n_DetSTUk5A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-10-06 10:26:18, Linus Torvalds wrote:
> On Sun, Oct 6, 2019 at 4:41 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Should we have some kind of notifier chain, so that we could utilize
> > better random sources (spinning rust) if we had them?
>=20
> The spinning rust will get entropy on its own just thanks to the
> regular interrupt stuff. And the kernel tryin gto do IO is a bad
> idea.

It will not: boot is now halted because systemd wants some
entropy. Everything is idle and very little interrupts are
happening. We have spinning rust, but it is idle, and thus not
generating any interrupts.

> Plus I think it's kind of pointless to do anythign at all for things
> like spinning rust in this day and age. It's no longer relevant, and
> never really was in the area where this was a problem.
>=20
> Also, I don't really like the notion of random (sic) notifiers that
> different drivers or things could attach to this thing. People will
> disagree about how much entropy it has anyway, and I'd rather have
> _one_ clear implementation that people can look at and comment on and
> try to actually write an academic paper on and suggest improvements
> to, than some generic "entropy notifier interface" that then gets
> whatever input somebody decides is appropriate.
>=20
> We already have interfaces for "I think I have interesting data":
> add_interrupt_randomness(), add_device_randomness(),
> add_hwgenerator_randomness() are all for different sources of
> entropy.

I'm not suggesting the notifier would invent some entropy... I agree
that kernel doing IO is strange, but I'm suggesting just that: if
userspace is blocked waiting for entropy, do some I/O, and let
interrupt randomness do its job.

It will work great on spinning rust. It will also work somehow on SSDs
and SD cards etc, because they have separate CPUs these days. They'll
certainly generate some interrupts, and we already assign some
randomness to that... It will let the machine boot, and entropy
calculation rules do not need to change.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2aJcUACgkQMOfwapXb+vJoQwCfVYSJea7N8MJtkKLYFp8F2PgP
PG0AnRqDVeQLLkeq8toHSyfHc5+0kESP
=QjAp
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
