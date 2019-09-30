Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFB1C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0A42190F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfI3IOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:14:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:59612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfI3IOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:14:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 292E2AF43;
        Mon, 30 Sep 2019 08:14:36 +0000 (UTC)
Message-ID: <7429d35ebf2115ee9020bd261f504858c3419486.camel@suse.de>
Subject: Re: [PATCH] ARM: fix __get_user_check() in case uaccess_* calls are
 not inlined
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Agner <stefan@agner.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 30 Sep 2019 10:13:57 +0200
In-Reply-To: <20190930055925.25842-1-yamada.masahiro@socionext.com>
References: <20190930055925.25842-1-yamada.masahiro@socionext.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-IeFRuNA2cBG/0U7j0WPi"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IeFRuNA2cBG/0U7j0WPi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-30 at 14:59 +0900, Masahiro Yamada wrote:
> KernelCI reports that bcm2835_defconfig is no longer booting since
> commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> forcibly"):
>=20
>   https://lkml.org/lkml/2019/9/26/825
>=20
> I also received a regression report from Nicolas Saenz Julienne:
>=20
>   https://lkml.org/lkml/2019/9/27/263
>=20
> This problem has cropped up on arch/arm/config/bcm2835_defconfig
> because it enables CONFIG_CC_OPTIMIZE_FOR_SIZE. The compiler tends
> to prefer not inlining functions with -Os. I was able to reproduce
> it with other boards and defconfig files by manually enabling
> CONFIG_CC_OPTIMIZE_FOR_SIZE.
>=20
> The __get_user_check() specifically uses r0, r1, r2 registers.
> So, uaccess_save_and_enable() and uaccess_restore() must be inlined
> in order to avoid those registers being overwritten in the callees.
>=20
> Prior to commit 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING"), the 'inline' marker was always enough for
> inlining functions, except on x86.
>=20
> Since that commit, all architectures can enable CONFIG_OPTIMIZE_INLINING.
> So, __always_inline is now the only guaranteed way of forcible inlining.
>=20
> I want to keep as much compiler's freedom as possible about the inlining
> decision. So, I changed the function call order instead of adding
> __always_inline around.
>=20
> Call uaccess_save_and_enable() before assigning the __p ("r0"), and
> uaccess_restore() after evacuating the __e ("r0").
>=20
> Fixes: 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Thanks!

Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


--=-IeFRuNA2cBG/0U7j0WPi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2RuUUACgkQlfZmHno8
x/4mGwf/TjOB2oFr8aZFVmRpUy6wdYJ/WjWJWgFRQxJCX2lTjIb8JfDUQB7dXcDl
AzNED/mYYtw7i0J6gOQPqBe/wGWY1kWndS1raRy0VuhYqKrpY9hsrzPkTXfQ6n+Z
P+YSlBElpDShLqC+b3ZNnidYo4yvhQDh1KfOD+tl4qNEVmPvDcDWpGOgNSIsFqnc
DO9kEVOzQg5kY+O0w/ds65s4Lq1TEYgMdUI5RKTP77k79lH0u3agDCXqJqzQySxx
hEbSJtcJAWRsrmUGMmbOgyab4BgMOi6hBhP3jscVCq660dwrBqBGQ2E2Sex3v+ok
SYQ0+Fu7K8JNggyWSwqswtxTkbaP4g==
=OhtC
-----END PGP SIGNATURE-----

--=-IeFRuNA2cBG/0U7j0WPi--

