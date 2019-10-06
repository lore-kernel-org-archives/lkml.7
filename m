Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8320AC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 11:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593D62084D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 11:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfJFLlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 07:41:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44653 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfJFLlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 07:41:32 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9F75A8047D; Sun,  6 Oct 2019 13:41:14 +0200 (CEST)
Date:   Sun, 6 Oct 2019 13:41:29 +0200
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
Message-ID: <20191006114129.GD24605@amd>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sat 2019-09-28 16:53:52, Linus Torvalds wrote:
> On Sat, Sep 28, 2019 at 3:24 PM Thomas Gleixner <tglx@linutronix.de> wrot=
e:
> >
> > Nicholas presented the idea to (ab)use speculative execution for random
> > number generation years ago at the Real-Time Linux Workshop:
>=20
> What you describe is just a particularly simple version of the jitter
> entropy. Not very reliable.
>=20
> But hey, here's a made-up patch. It basically does jitter entropy, but
> it uses a more complex load than the fibonacci LFSR folding: it calls
> "schedule()" in a loop, and it sets up a timer to fire.
>=20
> And then it mixes in the TSC in that loop.
>=20
> And to be fairly conservative, it then credits one bit of entropy for
> every timer tick. Not because the timer itself would be all that
> unpredictable, but because the interaction between the timer and the
> loop is going to be pretty damn unpredictable.
>=20
> Ok, I'm handwaving. But I do claim it really is fairly conservative to
> think that a cycle counter would give one bit of entropy when you time
> over a timer actually happening. The way that loop is written, we do
> guarantee that we'll mix in the TSC value both before and after the
> timer actually happened. We never look at the difference of TSC
> values, because the mixing makes that uninteresting, but the code does
> start out with verifying that "yes, the TSC really is changing rapidly
> enough to be meaningful".
>=20
> So if we want to do jitter entropy, I'd much rather do something like
> this that actually has a known fairly complex load with timers and
> scheduling.

> +/*
> + * If we have an actual cycle counter, see if we can
> + * generate enough entropy with timing noise
> + */
> +static void try_to_generate_entropy(void)
> +{
> +	struct {
> +		unsigned long now;
> +		struct timer_list timer;
> +	} stack;

Should we have some kind of notifier chain, so that we could utilize
better random sources (spinning rust) if we had them?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2Z0ukACgkQMOfwapXb+vKARACfcUHgIWJelJiFkcenzPoaAlp+
FcAAn3RfGOg2Pv1WVXC9GkV6ehOMxCWR
=6z3Q
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
