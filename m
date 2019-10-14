Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35933C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 05:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C0D2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 05:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfJNFx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 01:53:29 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:44392 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfJNFx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 01:53:28 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 9F1ED7F34CE; Mon, 14 Oct 2019 07:53:26 +0200 (CEST)
Date:   Mon, 14 Oct 2019 07:51:14 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 1/1] printf: add support for printing symbolic error
 names
Message-ID: <20191014055114.GA5045@taurus.defre.kleine-koenig.org>
References: <20190917065959.5560-1-linux@rasmusvillemoes.dk>
 <20191011133617.9963-1-linux@rasmusvillemoes.dk>
 <20191011133617.9963-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20191011133617.9963-2-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 03:36:17PM +0200, Rasmus Villemoes wrote:
> It has been suggested several times to extend vsnprintf() to be able
> to convert the numeric value of ENOSPC to print "ENOSPC". This
> implements that as a %p extension: With %pe, one can do
>=20
>   if (IS_ERR(foo)) {
>     pr_err("Sorry, can't do that: %pe\n", foo);
>     return PTR_ERR(foo);
>   }
>=20
> instead of what is seen in quite a few places in the kernel:
>=20
>   if (IS_ERR(foo)) {
>     pr_err("Sorry, can't do that: %ld\n", PTR_ERR(foo));
>     return PTR_ERR(foo);
>   }
>=20
> If the value passed to %pe is an ERR_PTR, but the library function
> errname() added here doesn't know about the value, the value is simply
> printed in decimal. If the value passed to %pe is not an ERR_PTR, we
> treat it as an ordinary %p and thus print the hashed value (passing
> non-ERR_PTR values to %pe indicates a bug in the caller, but we can't
> do much about that).
>=20
> With my embedded hat on, and because it's not very invasive to do,
> I've made it possible to remove this. The errname() function and
> associated lookup tables take up about 3K. For most, that's probably
> quite acceptable and a price worth paying for more readable
> dmesg (once this starts getting used), while for those that disable
> printk() it's of very little use - I don't see a
> procfs/sysfs/seq_printf() file reasonably making use of this - and
> they clearly want to squeeze vmlinux as much as possible. Hence the
> default y if PRINTK.
>=20
> The symbols to include have been found by massaging the output of
>=20
>   find arch include -iname 'errno*.h' | xargs grep -E 'define\s*E'
>=20
> In the cases where some common aliasing exists
> (e.g. EAGAIN=3DEWOULDBLOCK on all platforms, EDEADLOCK=3DEDEADLK on most),
> I've moved the more popular one (in terms of 'git grep -w Efoo | wc)
> to the bottom so that one takes precedence.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

I like having an explicit code even better than relying on a plain %p to
emit the code. So please readd my

Acked-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>

Best regards
Uwe

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl2kDM4ACgkQwfwUeK3K
7Amktgf/ZUKMyhXs+ND6w+xxA4HnQO3sndsdhdsqO1EBhXFTKJAGMi43qs++FP7z
62e30zX9uKg0AnFrKS2E67GpoM7ye9er0Q/NNnOQ7zLe2hDyN/9qsPsQz165hxvj
3c8ySawCsJSjCBNYbqTEa4YncIvjKMmHijDQQCchp5FR6S9eoK744oKH/Dy7Qofl
CkGoFFB6+FMUTBJTTO3PI4rW4R2PAePi5KedmtS/yc53wcJx2eRSyOkbZH7TEIw1
a51F8u9W/wR65Kn/v+0fAM/Ka33QfEaxZYMlh05uHVCb7aGod/TqzysFMsBbgUKz
wmOX3SlTzJFw7Vgp2Ytol4drCNfXVg==
=k9wZ
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
