Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C92C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735812075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfC0XMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:12:19 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:39312 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC0XMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:12:18 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4842272CC64;
        Thu, 28 Mar 2019 02:12:15 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 395DA7CC74C; Thu, 28 Mar 2019 02:12:15 +0300 (MSK)
Date:   Thu, 28 Mar 2019 02:12:15 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] x86/syscalls: Mark expected switch fall-throughs
Message-ID: <20190327231215.GA815@altlinux.org>
References: <20190228192746.GA13021@embeddedor>
 <alpine.DEB.2.21.1903231457590.1798@nanos.tec.linutronix.de>
 <20190326151244.GC16837@redhat.com>
 <20190327012606.GA16532@altlinux.org>
 <alpine.DEB.2.21.1903271527110.1789@nanos.tec.linutronix.de>
 <20190327222014.GA32540@altlinux.org>
 <alpine.DEB.2.21.1903272351110.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903272351110.1789@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2019 at 11:52:19PM +0100, Thomas Gleixner wrote:
> On Thu, 28 Mar 2019, Dmitry V. Levin wrote:
> > On Wed, Mar 27, 2019 at 03:29:16PM +0100, Thomas Gleixner wrote:
> > > On Wed, 27 Mar 2019, Dmitry V. Levin wrote:
> > > > On Tue, Mar 26, 2019 at 04:12:45PM +0100, Oleg Nesterov wrote:
> > > > > On 03/23, Thomas Gleixner wrote:
> > > > [...]
> > > > > >  2) syscall_set_arguments() has been introduced in 2008 and we =
still have
> > > > > >     no caller. Instead of polishing it, can it be removed compl=
etely or are
> > > > > >     there plans to actually use it?
> > > > >=20
> > > > > I think it can die.
> > > >=20
> > > > When PTRACE_GET_SYSCALL_INFO is finally squeezed into the kernel,
> > > > we could discuss adding PTRACE_SET_SYSCALL_INFO as well, and it
> > > > will need syscall_set_arguments().
> > >=20
> > > So if that ever happens, then adding the code back isn't rocket
> > > science. But if not, then there is no point in carrying the dead horse
> > > around another 11 years.
> >=20
> > Given that it took me roughly 4 months to get a relatively simple revert
> > of commit 5e937a9ae913 accepted into linux-next, adding the code back
> > might be time-consuming.
> >=20
> > Could we delay the removal of syscall_set_arguments() until
> > PTRACE_GET_SYSCALL_INFO is merged into the kernel?
> > I hope it won't take another 11 years.
>=20
> Hope dies last :)
>=20
> Seriously. If we keep it can we at least remove all the unused arguments
> which we have on both functions to simplify the whole mess?

In case of syscall_set_arguments() I think we can safely remove
"i" and "n" arguments assuming i =3D=3D 0 and n =3D=3D 6.

All I can say about syscall_get_arguments() is that
- all current users invoke it with i =3D=3D 0,
- all current users that invoke it with n !=3D 6 are in kernel/trace/trace_=
syscalls.c
so it may actually be invoked with n < 6.


--=20
ldv

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcnANOAAoJEAVFT+BVnCUI+asQAN0ek3uJ5dOzgkhSZjL4bdq/
0A5IiG3DL1Vmk59JHexHl1c7r9AFYM/b/7d5YYF5eYxWpXkz25jIr+qmF9Z8TYj7
Pvo76uwn+hEcE2s6OYaPMjQqfUHa7mDh81slK5/Hm/o3GSJHHmt5VeV/OvljNFQJ
yeXph+G5DCKfvp4YLA4RS++R5uDTMGyz3IPV+++CPkv/+bXgHeF6ClGJ3DShL5w9
qk8kABNN+xSJVgKhDTl5VNnGJ+i3MkRdslwUrQxDYkgIrmjDcOqXhkzdU/0S4QAC
UDbklunwFgTXBvAW9AglHvIRamXTYmUW9W2vWzddQcNcFvNoyF5l8C97xjqK1+Bv
nBsb0Zc9PxxqyVTQVTESzMA9401PVh8dHLCux23rwqlDNTvxXOAMSkuXdBQlE2RA
IKCBE1XsnwSPLjI+BeD8S45sUwFYFY/knspFm0jp01Nxu66BNZdWNXSqQPlLyYXW
HJV7ay4z/8qjQNP3EG+ac/USNP3/pKZmn+6Fu1WwsVuFNy0I7svl4/RyTqxaWNsB
TA3P16OinlK4ZxFPv8D/kiyT0YBQtqYDB5JdEBUGRJVdIqY4anbtgqjXTCq4ID5C
EjWJIFa2hyOoCuXUlr83h8FAQzfN2ekD4vxjpapBLauI4200x/NcTv+DBj3YmEHX
ep30N9s4jRfALRP65wpR
=k+yg
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
