Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93716C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F018216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbfGaROd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:14:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44604 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfGaROc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:14:32 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 16C3F80315; Wed, 31 Jul 2019 19:14:18 +0200 (CEST)
Date:   Wed, 31 Jul 2019 19:14:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
Message-ID: <20190731171429.GA24222@amd>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-07-30 22:35:18, Joe Perches wrote:
> Reserve the pseudo keyword 'fallthrough' for the ability to convert the
> various case block /* fallthrough */ style comments to appear to be an
> actual reserved word with the same gcc case block missing fallthrough
> warning capability.

Acked-by: Pavel Machek <pavel@ucw.cz>

> +/*
> + * Add the pseudo keyword 'fallthrough' so case statement blocks
> + * must end with any of these keywords:
> + *   break;
> + *   fallthrough;
> + *   goto <label>;
> + *   return [expression];
> + *
> + *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#St=
atement-Attributes
> + */
> +#if __has_attribute(__fallthrough__)
> +# define fallthrough                    __attribute__((__fallthrough__))
> +#else
> +# define fallthrough                    do {} while (0)  /* fallthrough =
*/
> +#endif
> +

Will various checkers (and gcc) recognize, that comment in a macro,
and disable the warning accordingly?

Explanation that the comment is "magic" might not be a bad idea.

Thanks,

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1BzHUACgkQMOfwapXb+vLJRgCgt63UaF4OMDYnlc7IYkKsBcQB
ldoAnR44SU7EuihEaNtjc+QR8V2rr+fX
=O4oi
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
