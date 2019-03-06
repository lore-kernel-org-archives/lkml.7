Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B39AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AA320684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfCFXJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:09:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57438 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFXJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:09:47 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 51C8480457; Thu,  7 Mar 2019 00:09:38 +0100 (CET)
Date:   Thu, 7 Mar 2019 00:09:44 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     hpa@zytor.com, Daniel Colascione <dancol@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
Message-ID: <20190306230944.GB7915@amd>
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com>
 <20190119162754.GC231277@google.com>
 <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
 <20190119232503.GA149403@google.com>
 <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
 <20190120155838.GA23827@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <20190120155838.GA23827@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > >Ok, I'll look into LZMA. Thanks for checking the compression sizes.
> > >
> > >- Joel
> >=20
> > Don't use lzma, use xz if you are going to do something.
>=20
> Ok, sounds good.
>=20
> > However, it seems unlikely to me that someone not willing to spend the =
space in the filesystem will spend unswappable kernel memory.
> >=20
> > It would seem that a far saner way to do this is to use inittmpfs or pe=
rhaps an auxiliary "ktmpfs" so it can at least be swapped out if you have s=
wap.
>=20
> But this is already possible with the proposed solution, you would load t=
he
> module, extract it into a tmpfs, and unload the module. TMPFS pages can
> already be swapped.

So your licensing requirements prevent you from having headers in the
filesystem, but allow module with the headers hidden inside on the
filesystem?

Looks like you should just tar xvzf
this-is-a-kernel-module-I-promise.ko /usr/src/linux/include :-).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyAUzgACgkQMOfwapXb+vJQHQCdE/XXkghlja4N42Pg3cnPr7S7
iKsAoJZ4ULf9mtuzWpfcFy+DYm/5G5fJ
=dKWB
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
