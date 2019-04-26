Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2387FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1F82077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfDZWrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:47:12 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41663 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfDZWrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:47:12 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44rTh96Twyz1r8jx;
        Sat, 27 Apr 2019 00:47:05 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44rTh95mjlz1rYnv;
        Sat, 27 Apr 2019 00:47:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id uOsB_hESmOF0; Sat, 27 Apr 2019 00:47:03 +0200 (CEST)
X-Auth-Info: NojtBbQNt0lRWepNZb6UcE2SrgHSeBnh4mtHX2U0P3A=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 27 Apr 2019 00:47:03 +0200 (CEST)
Date:   Sat, 27 Apr 2019 00:46:53 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joseph Myers <joseph@codesourcery.com>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Stepan Golosunov <stepan@golosunov.pp.ru>
Subject: Re: [PATCH 1/2] y2038: make CONFIG_64BIT_TIME unconditional
Message-ID: <20190427004653.3cecd1cb@jawa>
In-Reply-To: <20190426142531.1378357-1-arnd@arndb.de>
References: <20190426142531.1378357-1-arnd@arndb.de>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_6NaI2Iq9rN8j+AFUvQm+Gq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_6NaI2Iq9rN8j+AFUvQm+Gq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

> As Stepan Golosunov points out, we made a small mistake in the
> get_timespec64() function in the kernel. It was originally added under
> the assumption that CONFIG_64BIT_TIME would get enabled on all 32-bit
> and 64-bit architectures, but when I did the conversion, I only turned
> it on for 32-bit ones.
>=20
> The effect is that the get_timespec64() function never clears the
> upper half of the tv_nsec field for 32-bit tasks in compat mode.
> Clearing this is required for POSIX compliant behavior of functions
> that pass a 'timespec' structure with a 64-bit tv_sec and a 32-bit
> tv_nsec, plus uninitialized padding.

On my 32 bit ARM setup (with CONFIG_COMPAT_32BIT_TIME=3Dy) for
Y2038 test:

- I do use clock_settime64 [1] to set 64 bit tv_sec
  with 32 bit tv_nsec and 32 bit unnamed padding.

- I also may use clock_settime32 as a fallback (but it will not work
  beyond Y2038) if the 64 bit version is not available for any reason.

In the get_timespec64() the in_compat_syscall() returns 0 [2], so the
padding bits are not cleared.

This imposes the in glibc requirement to zero the padding before passing
it to the Linux kernel.

At least for my setup (32bit ARM with 64 bit time support) this patch is
not fixing anything.


Moreover, the described above problem doesn't matter on native 64 bit
systems as there both fields are 64 bit (no padding required).


Note:
[1] -
https://elixir.bootlin.com/linux/v5.1-rc6/source/arch/arm/tools/syscall.tbl=
#L421

[2] - include/linux/compat.h -> CONFIG_COMPAT is not defined - as a
result in_compat_syscall() returns 0.

>=20
> The easiest fix for linux-5.1 is to just make the Kconfig symbol
> unconditional, as it was originally intended. As a follow-up,
> we should remove any #ifdef CONFIG_64BIT_TIME completely.
>=20
> Link:
> https://lore.kernel.org/lkml/20190422090710.bmxdhhankurhafxq@sghpc.golosu=
nov.pp.ru/
> Cc: Lukasz Majewski <lukma@denx.de> Cc: Stepan Golosunov
> <stepan@golosunov.pp.ru> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Please apply this one as a bugfix for 5.1
> ---
>  arch/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 33687dddd86a..9092e0ffe4d3 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -764,7 +764,7 @@ config COMPAT_OLD_SIGACTION
>  	bool
> =20
>  config 64BIT_TIME
> -	def_bool ARCH_HAS_64BIT_TIME
> +	def_bool y
>  	help
>  	  This should be selected by all architectures that need to
> support new system calls with a 64-bit time_t. This is relevant on
> all 32-bit




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/_6NaI2Iq9rN8j+AFUvQm+Gq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlzDil0ACgkQAR8vZIA0
zr0zBggAg6PBgVsYGM8MNUE2NtAly+92AXI4PUHZmZkpydU8cwWInSugT47ndqM1
+oxXrRq6rUevuiO5lAAYHvxOOoXDiRE5R9JfK0EeJKZINy7wIzDw+CBcgiw9TQW7
QBJcQlI76H6TyUoOrgahXc6feZknkb7ZKSY0LGfimcr0pbvYL++uBCUA+HLuQgJc
/OjMwj4IONkI+TiVGrDmFbPKCAzplff9516/KbZL0HFWIFE+4BEPgsEGC5cIYTss
P50CXNlehPxEjKOheGEkpCVy83ToExpd/AnvCl02AMeFqdDN4WZgBmW6a1Y5bwts
b6rnlJsgbohRnroLc06XFCIuRyq5Cw==
=2yaG
-----END PGP SIGNATURE-----

--Sig_/_6NaI2Iq9rN8j+AFUvQm+Gq--
