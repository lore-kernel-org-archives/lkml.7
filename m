Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4B5C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E209207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfFFIrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:47:09 -0400
Received: from 96-92-233-220-static.hfc.comcastbusiness.net ([96.92.233.220]:55749
        "EHLO dcr0.decred.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfFFIrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:47:09 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jun 2019 04:47:08 EDT
Received: from marcos-macbook.home (a95-94-160-35.cpe.netcabo.pt [95.94.160.35])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dcr0.decred.org (Postfix) with ESMTPSA id 459FB18B407F;
        Thu,  6 Jun 2019 08:37:14 +0000 (UTC)
From:   Marco Peereboom <marco@decred.org>
Message-Id: <8630ED8D-03D4-4BDB-A4A4-6C33325BFA88@decred.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_45A4FB4B-0652-4B92-B0EB-03726583BE22";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] RISC-V: Break load reservations during switch_to
Date:   Thu, 6 Jun 2019 09:37:13 +0100
In-Reply-To: <20190605231735.26581-1-palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, me@carlosedp.com,
        joel@sing.id.au, linux-kernel@vger.kernel.org
To:     Palmer Dabbelt <palmer@sifive.com>
References: <20190605231735.26581-1-palmer@sifive.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_45A4FB4B-0652-4B92-B0EB-03726583BE22
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Ah that=E2=80=99s sneaky!!

> On Jun 6, 2019, at 12:17 AM, Palmer Dabbelt <palmer@sifive.com> wrote:
>=20
> The comment describes why in detail.  This was found because QEMU =
never
> gives up load reservations, the issue is unlikely to manifest on real
> hardware.
>=20
> Thanks to Carlos Eduardo for finding the bug!
>=20
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
> arch/riscv/kernel/entry.S | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>=20
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 1c1ecc238cfa..e9fc3480e6b4 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -330,6 +330,24 @@ ENTRY(__switch_to)
> 	add   a3, a0, a4
> 	add   a4, a1, a4
> 	REG_S ra,  TASK_THREAD_RA_RA(a3)
> +	/*
> +	 * The Linux ABI allows programs to depend on load reservations =
being
> +	 * broken on context switches, but the ISA doesn't require that =
the
> +	 * hardware ever breaks a load reservation.  The only way to =
break a
> +	 * load reservation is with a store conditional, so we emit one =
here.
> +	 * Since nothing ever takes a load reservation on =
TASK_THREAD_RA_RA we
> +	 * know this will always fail, but just to be on the safe side =
this
> +	 * writes the same value that was unconditionally written by the
> +	 * previous instruction.
> +	 */
> +#if (TASK_THREAD_RA_RA !=3D 0)
> +# error "The offset between ra and ra is non-zero"
> +#endif
> +#if (__riscv_xlen =3D=3D 64)
> +	sc.d  x0, ra, 0(a3)
> +#else
> +	sc.w  x0, ra, 0(a3)
> +#endif
> 	REG_S sp,  TASK_THREAD_SP_RA(a3)
> 	REG_S s0,  TASK_THREAD_S0_RA(a3)
> 	REG_S s1,  TASK_THREAD_S1_RA(a3)
> --
> 2.21.0
>=20


--Apple-Mail=_45A4FB4B-0652-4B92-B0EB-03726583BE22
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8htVBWYODFIPzwuljM0W459K7ykFAlz40LkACgkQjM0W459K
7ykrsw//XiqwGdn/KPK7L2tSCRVBqNVpY4M2p2FYzHr6CK4Hy9C9WdWVazpkG/8D
YaBuFzw9J2UIMeaf7os4bHrMtOErjN7R/Zs6i/PpJVKjK/zuxtKs+mrF/nNhFose
JRSBpeGNFu2rR0+RgEj0h9whdg+Re0rASnS8bKnnYj/x+irZ+VZiN/7+W9aHnP7O
mv9sjl/EZWGcw5PuTze/QjfU/BDeZFXvQjehItOy/r+1MyrSgi+vkYuGw0D+XZ/4
yTXk9GOn18YNOUv4CBCYWKuS3SFsrq/PyR3ziIUnlvN9kcY6enjQMoO1q3lGDdN/
sWjxHnA+9htiSfLr/cBfCAa/hebVr3H3F1Vep4ubX5s9bbPf7gF6CA5dhZBpfH7v
qw0bs/TQlM39BZebbl0qDfvRI8P9zunrKDO/RgfJjy2XjbBpeAw9IQ74kb/U2ymR
yK6CLEbsXkEpCAOh+iMrWyDB/7RTGgDBqkWOnh3f3ZgqBh4FDjp7es1+qU0iNuwi
JwSGFzrWoUsgQFWwud1H9mqRLFzLtqn8id6oRGwHhoekmWnFhx8dr4Hr3s3/rfq7
5GTEbblV7Vb8dw9M4mOPepxPtg3iB4liuzIADywHhFlY3n5SxgzJCKU5l1DiDjuz
/VM18jQ2V8UdrThNr37d72n1Z75IoUHIWBXSChdUf3aPN6uwxOs=
=v92O
-----END PGP SIGNATURE-----

--Apple-Mail=_45A4FB4B-0652-4B92-B0EB-03726583BE22--
