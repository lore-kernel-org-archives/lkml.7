Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A97C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730E021872
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733272AbfJAJDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:03:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:49114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726568AbfJAJDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:03:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53471AFF4;
        Tue,  1 Oct 2019 09:03:44 +0000 (UTC)
Message-ID: <196a63271591fbe0bc1fdd5a1a01a25caf5178d0.camel@suse.de>
Subject: Re: [PATCH v2] ARM: add __always_inline to functions called from
 __get_user_check()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Enrico Weigelt <info@metux.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Agner <stefan@agner.ch>, linux-kernel@vger.kernel.org,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 01 Oct 2019 11:03:40 +0200
In-Reply-To: <20191001083701.27207-1-yamada.masahiro@socionext.com>
References: <20191001083701.27207-1-yamada.masahiro@socionext.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1pzhYzFOaS2Q7mcGcHoY"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1pzhYzFOaS2Q7mcGcHoY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-01 at 17:37 +0900, Masahiro Yamada wrote:
> KernelCI reports that bcm2835_defconfig is no longer booting since
> commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> forcibly") (https://lkml.org/lkml/2019/9/26/825).
>=20
> I also received a regression report from Nicolas Saenz Julienne
> (https://lkml.org/lkml/2019/9/27/263).
>=20
> This problem has cropped up on bcm2835_defconfig because it enables
> CONFIG_CC_OPTIMIZE_FOR_SIZE. The compiler tends to prefer not inlining
> functions with -Os. I was able to reproduce it with other boards and
> defconfig files by manually enabling CONFIG_CC_OPTIMIZE_FOR_SIZE.
>=20
> The __get_user_check() specifically uses r0, r1, r2 registers.
> So, uaccess_save_and_enable() and uaccess_restore() must be inlined.
> Otherwise, those register assignments would be entirely dropped,
> according to my analysis of the disassembly.
>=20
> Prior to commit 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING"), the 'inline' marker was always enough for
> inlining functions, except on x86.
>=20
> Since that commit, all architectures can enable CONFIG_OPTIMIZE_INLINING.
> So, __always_inline is now the only guaranteed way of forcible inlining.
>=20
> I also added __always_inline to 4 functions in the call-graph from the
> __get_user_check() macro.
>=20
> Fixes: 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


--=-1pzhYzFOaS2Q7mcGcHoY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2TFmwACgkQlfZmHno8
x/6gYwf/bt9SGaahlMy9jzh92vkL0lR++WMTDA9czeLR9wbO/ccn+pzclxkdt2oV
zHhrTCh5umkugXPLNKJAwZHfyBCnZ/r4Qe4RUrf4VLaQxHWNtNAhfSroI0213SXW
xcpmbYWmgFuEkiCBC0WOUESteF78q5e6OXe8jExrj1BQIe4aOqaKHNSMJdkdrbyl
Im1V51p0JSvVgJPDTZJax4gHko+Tq4/PTPXwCsxeRCu7ftC2eLk+TFFfxufsVAOw
gTr0yr8wR+ekaeDayR1fp87Uz51u83A3/K0bhfTtcHHMykQwTUFijaYRHeAGd//G
wV5Zsn+SQl3vKzQsrCieTubb54urkw==
=6Yel
-----END PGP SIGNATURE-----

--=-1pzhYzFOaS2Q7mcGcHoY--

