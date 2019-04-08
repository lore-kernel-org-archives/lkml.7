Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6E7C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DFE2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPMSC8JU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfDHSIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:08:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38347 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:08:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so17545180wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gc69Gdkq4uh6zRPv6o3sKCYKDf1xCH0ieyU9USOf4rw=;
        b=GPMSC8JUoCFaSjw9LhxglyJZswbwypcTtUNOSUNFTjIHTnn5esBUFHRD8EHfW/MovI
         /6rarLc+c8NAcrXHarEtRWjs+FBfYKuj0V7vUCrWwRpY6hVIn3F51qJCJzQ8JNB4XsOq
         GnMPYm4PFujsyms8VQc86FcA+Yvb86XLRTX0NU/cI7so06mLcXWyp5DJxCf8Napy5vsq
         NlGKw43P/bcW7wwa8oq9zJUhN4V18gwn6ucXAP3CSeVnSpQujzTJKFGpA2nQbQj4DaQv
         +tSpcUWMNXwaW9z+2X+odqGW8F5zIe8rKagiDSPEQqpBpxBJkxnFqFIVz07C+70fxMQX
         bY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gc69Gdkq4uh6zRPv6o3sKCYKDf1xCH0ieyU9USOf4rw=;
        b=EG6FPoxCrik0Sw5NB2+p47NrmkoR+dRZZRTejK/DPtPdFw/NyISWH+VXIX0VcBVT1p
         CL9c2uhYZoxrxCj/WrazEjdPT3x3uGktcmWkNpIx2vIdlfZg7u6PED2wJiKIrRcip71o
         sXmpevGtooYK24muYf3kcbGep1FxXdSufCkcVTAgPNuTXlKqUuG0nMyR3y6pgTJs57ob
         0vE+LziITT3fivQMEdWZlOrb9W5ccJHzoaLAVAFzNMYEavJULEVKdxjlsDzSsI0OahnG
         iwAl3eluVuBkjO96NpHArhA2k6yyoWx0UVksJruohv6aUK3+f32KiZ/QPeqYQFa8O0BY
         Nfrw==
X-Gm-Message-State: APjAAAWA2XD4gLtCkgrWhjOvvdZ2P3JOxOQ87q0QeIolqO6u5WfvE4Uj
        6R/IjPZE7O9AW0o7v4AV8Ak=
X-Google-Smtp-Source: APXvYqxcb6uVGlaxLVfInfRL1bKf4AmJ8RrS4DvpELIPrUIB9wPnQl7xnIQILolD8T5FxrJpKnl2lg==
X-Received: by 2002:adf:d081:: with SMTP id y1mr20355190wrh.283.1554746890902;
        Mon, 08 Apr 2019 11:08:10 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x14sm13776872wmj.3.2019.04.08.11.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 11:08:10 -0700 (PDT)
Date:   Mon, 8 Apr 2019 20:08:09 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: This program cannot be run in DOS mode.$
Message-ID: <20190408180809.myjp5zaviuibj5uf@pali>
References: <20190401102434.9805-1-pali.rohar@gmail.com>
 <20190408180422.GA5103@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="so27llpdtyfbe25c"
Content-Disposition: inline
In-Reply-To: <20190408180422.GA5103@amd>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--so27llpdtyfbe25c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 08 April 2019 20:04:22 Pavel Machek wrote:
> On Mon 2019-04-01 12:24:34, Pali Roh=C3=A1r wrote:
> > Every EFI binary is in PE format. And we know that PE format needs to h=
ave
> > MZ MS-DOS header as there is written offset to PE header.
> >=20
> > Therefore generated bzImage binary with CONFIG_EFI_STUB option is MS-DOS
> > executable binary.
> >=20
> > We already know the "requirement" that Windows PE executable started in
> > MS-DOS must print legendary and famous message to computer screen:
> > "This program cannot be run in DOS mode."
> >=20
> > But trying to run that bzImage of Linux kernel with MZ header just cause
> > freezing whole MS-DOS instead of writing "the correct message" to user.
> > This is not the compliant behavior of PE executables!
> >=20
> > This patch fixes this problem. When Linux kernel compiled with
> > CONFIG_EFI_STUB is started in MS-DOS then it prints message:
> >=20
> >   This program cannot be run in DOS mode.
> >   To load Linux kernel from DOS mode use LOADLIN.EXE.
> >=20
> > So it also helps MS-DOS users how to "correctly" start this bzImage bin=
ary
> > by mentioning LOADLIN.EXE. Note that MS-DOS strings are not null-termin=
ated
> > but rather dollar-terminated.
> >=20
> > To have error message unified bugger_off_msg for BIOS boot block code w=
as
> > changed to:
> >=20
> >   This program cannot be run in BIOS mode.
> >=20
> > So if you copy generated bzImage directly to boot sector and try to boo=
t it
> > by BIOS you get this new updated message.
> >=20
> > Due to fixed offset of setup header (0x1f1), PE header was moved after
> > entrytext section. bstext and bsdata sections where is full MZ header a=
nd
> > MS-DOS code is now bigger.
>=20
> Hehe, I guess the patch may have been dropped due to april's fools?

Yea, it was mean as first April patch :-) I tested it with MS-DOS 7.0
and DOSBox and it worked.

> You may want to retransmit?

Do you really think it can be useful? :-)

> 								Pavel
>=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > ---
> >  arch/x86/boot/header.S | 55 ++++++++++++++++++++++++++++++++++++++++++=
+-------
> >  arch/x86/boot/setup.ld |  1 +
> >  2 files changed, 49 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> > index 850b8762e889..58fcab7d00c8 100644
> > --- a/arch/x86/boot/header.S
> > +++ b/arch/x86/boot/header.S
> > @@ -45,6 +45,46 @@ bootsect_start:
> >  	# "MZ", MS-DOS header
> >  	.byte 0x4d
> >  	.byte 0x5a
> > +
> > +	# Explicitly enter this as bytes, or the assembler
> > +	# tries to generate a 3-byte jump here, which causes
> > +	# everything else to push off to the wrong offset.
> > +	.byte	0xeb    # short (2-byte) jump
> > +	.byte	bios_start-1f
> > +1:
> > +
> > +	.org	0x04
> > +	.short	3       # e_cp - Pages in file
> > +	.short	0       # e_crlc - Relocations
> > +	.short	4       # e_cparhdr - Size of header in paragraphs
> > +	.short	0       # e_minalloc - Minimum extra paragraphs needed
> > +	.short	0xffff  # e_maxalloc - Maximum extra paragraphs needed
> > +	.short	0       # e_ss - Initial (relative) SS value
> > +	.short	0       # e_sp - Initial SP value
> > +	.short	0       # e_csum - Checksum
> > +	.short	0       # e_ip - Initial IP value
> > +	.short	-4      # e_cs - Initial (relative) CS value
> > +	.short	0x40    # e_lfarlc - File address of relocation table
> > +
> > +	.org	0x3c
> > +	.long	pe_header  # Offset to the PE header
> > +
> > +	#
> > +	# MS-DOS start code
> > +	#
> > +	push	%cs
> > +	pop	%ds
> > +
> > +	# Write msdos_msg string
> > +	mov	$msdos_msg, %dx
> > +	mov	$0x09, %ah
> > +	int	$0x21
> > +
> > +	# Terminate program
> > +	mov	$0x4c01, %ax
> > +	int	$0x21
> > +
> > +bios_start:
> >  #endif
> > =20
> >  	# Normalize the start address
> > @@ -80,22 +120,23 @@ bs_die:
> >  	# invoke the BIOS reset code...
> >  	ljmp	$0xf000,$0xfff0
> > =20
> > +	.section ".bsdata", "a"
> >  #ifdef CONFIG_EFI_STUB
> > -	.org	0x3c
> > -	#
> > -	# Offset to the PE header.
> > -	#
> > -	.long	pe_header
> > +msdos_msg:
> > +	.ascii	"This program cannot be run in DOS mode.\r\n"
> > +	.ascii	"To load Linux kernel from DOS mode use LOADLIN.EXE.\r\r\n"
> > +	.ascii	"$"
> >  #endif /* CONFIG_EFI_STUB */
> > =20
> > -	.section ".bsdata", "a"
> >  bugger_off_msg:
> > -	.ascii	"Use a boot loader.\r\n"
> > +	.ascii	"This program cannot be run in BIOS mode.\r\n"
> > +	.ascii	"To load Linux kernel from BIOS mode use a boot loader.\r\n"
> >  	.ascii	"\n"
> >  	.ascii	"Remove disk and press any key to reboot...\r\n"
> >  	.byte	0
> > =20
> >  #ifdef CONFIG_EFI_STUB
> > +	.section ".pedata", "a"
> >  pe_header:
> >  	.ascii	"PE"
> >  	.word 	0
> > diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
> > index 0149e41d42c2..c0ec2fe09d2d 100644
> > --- a/arch/x86/boot/setup.ld
> > +++ b/arch/x86/boot/setup.ld
> > @@ -16,6 +16,7 @@ SECTIONS
> >  	. =3D 495;
> >  	.header		: { *(.header) }
> >  	.entrytext	: { *(.entrytext) }
> > +	.pedata		: { *(.pedata) }
> >  	.inittext	: { *(.inittext) }
> >  	.initdata	: { *(.initdata) }
> >  	__end_init =3D .;
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--so27llpdtyfbe25c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXKuOBwAKCRCL8Mk9A+RD
UhZjAKC6GaB94mn/OuVS8I5KQg3qab01DQCfXA3BbHekchMyPZAkOd8WIRGuIIE=
=MMwD
-----END PGP SIGNATURE-----

--so27llpdtyfbe25c--
