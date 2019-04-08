Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2BBC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65892206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfDHSE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:04:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42344 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHSE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:04:26 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0B6BE803C7; Mon,  8 Apr 2019 20:04:14 +0200 (CEST)
Date:   Mon, 8 Apr 2019 20:04:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: This program cannot be run in DOS mode.$
Message-ID: <20190408180422.GA5103@amd>
References: <20190401102434.9805-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20190401102434.9805-1-pali.rohar@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-01 12:24:34, Pali Roh=E1r wrote:
> Every EFI binary is in PE format. And we know that PE format needs to have
> MZ MS-DOS header as there is written offset to PE header.
>=20
> Therefore generated bzImage binary with CONFIG_EFI_STUB option is MS-DOS
> executable binary.
>=20
> We already know the "requirement" that Windows PE executable started in
> MS-DOS must print legendary and famous message to computer screen:
> "This program cannot be run in DOS mode."
>=20
> But trying to run that bzImage of Linux kernel with MZ header just cause
> freezing whole MS-DOS instead of writing "the correct message" to user.
> This is not the compliant behavior of PE executables!
>=20
> This patch fixes this problem. When Linux kernel compiled with
> CONFIG_EFI_STUB is started in MS-DOS then it prints message:
>=20
>   This program cannot be run in DOS mode.
>   To load Linux kernel from DOS mode use LOADLIN.EXE.
>=20
> So it also helps MS-DOS users how to "correctly" start this bzImage binary
> by mentioning LOADLIN.EXE. Note that MS-DOS strings are not null-terminat=
ed
> but rather dollar-terminated.
>=20
> To have error message unified bugger_off_msg for BIOS boot block code was
> changed to:
>=20
>   This program cannot be run in BIOS mode.
>=20
> So if you copy generated bzImage directly to boot sector and try to boot =
it
> by BIOS you get this new updated message.
>=20
> Due to fixed offset of setup header (0x1f1), PE header was moved after
> entrytext section. bstext and bsdata sections where is full MZ header and
> MS-DOS code is now bigger.

Hehe, I guess the patch may have been dropped due to april's fools?

You may want to retransmit?
								Pavel

> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> ---
>  arch/x86/boot/header.S | 55 +++++++++++++++++++++++++++++++++++++++++++-=
------
>  arch/x86/boot/setup.ld |  1 +
>  2 files changed, 49 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 850b8762e889..58fcab7d00c8 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -45,6 +45,46 @@ bootsect_start:
>  	# "MZ", MS-DOS header
>  	.byte 0x4d
>  	.byte 0x5a
> +
> +	# Explicitly enter this as bytes, or the assembler
> +	# tries to generate a 3-byte jump here, which causes
> +	# everything else to push off to the wrong offset.
> +	.byte	0xeb    # short (2-byte) jump
> +	.byte	bios_start-1f
> +1:
> +
> +	.org	0x04
> +	.short	3       # e_cp - Pages in file
> +	.short	0       # e_crlc - Relocations
> +	.short	4       # e_cparhdr - Size of header in paragraphs
> +	.short	0       # e_minalloc - Minimum extra paragraphs needed
> +	.short	0xffff  # e_maxalloc - Maximum extra paragraphs needed
> +	.short	0       # e_ss - Initial (relative) SS value
> +	.short	0       # e_sp - Initial SP value
> +	.short	0       # e_csum - Checksum
> +	.short	0       # e_ip - Initial IP value
> +	.short	-4      # e_cs - Initial (relative) CS value
> +	.short	0x40    # e_lfarlc - File address of relocation table
> +
> +	.org	0x3c
> +	.long	pe_header  # Offset to the PE header
> +
> +	#
> +	# MS-DOS start code
> +	#
> +	push	%cs
> +	pop	%ds
> +
> +	# Write msdos_msg string
> +	mov	$msdos_msg, %dx
> +	mov	$0x09, %ah
> +	int	$0x21
> +
> +	# Terminate program
> +	mov	$0x4c01, %ax
> +	int	$0x21
> +
> +bios_start:
>  #endif
> =20
>  	# Normalize the start address
> @@ -80,22 +120,23 @@ bs_die:
>  	# invoke the BIOS reset code...
>  	ljmp	$0xf000,$0xfff0
> =20
> +	.section ".bsdata", "a"
>  #ifdef CONFIG_EFI_STUB
> -	.org	0x3c
> -	#
> -	# Offset to the PE header.
> -	#
> -	.long	pe_header
> +msdos_msg:
> +	.ascii	"This program cannot be run in DOS mode.\r\n"
> +	.ascii	"To load Linux kernel from DOS mode use LOADLIN.EXE.\r\r\n"
> +	.ascii	"$"
>  #endif /* CONFIG_EFI_STUB */
> =20
> -	.section ".bsdata", "a"
>  bugger_off_msg:
> -	.ascii	"Use a boot loader.\r\n"
> +	.ascii	"This program cannot be run in BIOS mode.\r\n"
> +	.ascii	"To load Linux kernel from BIOS mode use a boot loader.\r\n"
>  	.ascii	"\n"
>  	.ascii	"Remove disk and press any key to reboot...\r\n"
>  	.byte	0
> =20
>  #ifdef CONFIG_EFI_STUB
> +	.section ".pedata", "a"
>  pe_header:
>  	.ascii	"PE"
>  	.word 	0
> diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
> index 0149e41d42c2..c0ec2fe09d2d 100644
> --- a/arch/x86/boot/setup.ld
> +++ b/arch/x86/boot/setup.ld
> @@ -16,6 +16,7 @@ SECTIONS
>  	. =3D 495;
>  	.header		: { *(.header) }
>  	.entrytext	: { *(.entrytext) }
> +	.pedata		: { *(.pedata) }
>  	.inittext	: { *(.inittext) }
>  	.initdata	: { *(.initdata) }
>  	__end_init =3D .;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrjSYACgkQMOfwapXb+vIbDACePGhHTNYQNtgbgeSttrJvUCKu
UiwAoIn/nkk64OVdM6PmI6hcNohDoBdI
=ej5Y
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
