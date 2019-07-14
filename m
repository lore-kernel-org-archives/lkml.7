Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD38C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 16:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63BC205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 16:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfGNQOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 12:14:52 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:44804 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbfGNQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 12:14:52 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E166C72CA65;
        Sun, 14 Jul 2019 19:14:49 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id CFA887CCE3A; Sun, 14 Jul 2019 19:14:49 +0300 (MSK)
Date:   Sun, 14 Jul 2019 19:14:49 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Anatoly Pugachev <matorola@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clone: fix CLONE_PIDFD support
Message-ID: <20190714161449.GA10389@altlinux.org>
References: <20190714120206.GC6773@altlinux.org>
 <20190714121724.mwg2t3di6goha7yq@brauner.io>
 <20190714141007.GA9131@altlinux.org>
 <20190714142304.3uihy4vepmxgdqha@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20190714142304.3uihy4vepmxgdqha@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2019 at 04:23:05PM +0200, Christian Brauner wrote:
> On Sun, Jul 14, 2019 at 05:10:08PM +0300, Dmitry V. Levin wrote:
> > On Sun, Jul 14, 2019 at 02:17:25PM +0200, Christian Brauner wrote:
> > > On Sun, Jul 14, 2019 at 03:02:06PM +0300, Dmitry V. Levin wrote:
> > > > The introduction of clone3 syscall accidentally broke CLONE_PIDFD
> > > > support in traditional clone syscall on compat x86 and those
> > > > architectures that use do_fork to implement clone syscall.
> > > >=20
> > > > This bug was found by strace test suite.
> > > >=20
> > > > Link: https://strace.io/logs/strace/2019-07-12
> > > > Fixes: 7f192e3cd316 ("fork: add clone3")
> > > > Bisected-and-tested-by: Anatoly Pugachev <matorola@gmail.com>
> > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > >=20
> > > Good catch! Thank you Dmitry.
> > >=20
> > > One change request below.
> > >=20
> > > > ---
> > > >  arch/x86/ia32/sys_ia32.c | 1 +
> > > >  kernel/fork.c            | 1 +
> > > >  2 files changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
> > > > index 64a6c952091e..98754baf411a 100644
> > > > --- a/arch/x86/ia32/sys_ia32.c
> > > > +++ b/arch/x86/ia32/sys_ia32.c
> > > > @@ -239,6 +239,7 @@ COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long=
, clone_flags,
> > > >  {
> > > >  	struct kernel_clone_args args =3D {
> > > >  		.flags		=3D (clone_flags & ~CSIGNAL),
> > > > +		.pidfd		=3D parent_tidptr,
> > > >  		.child_tid	=3D child_tidptr,
> > > >  		.parent_tid	=3D parent_tidptr,
> > > >  		.exit_signal	=3D (clone_flags & CSIGNAL),
> > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > index 8f3e2d97d771..2c3cbad807b6 100644
> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -2417,6 +2417,7 @@ long do_fork(unsigned long clone_flags,
> > > >  {
> > > >  	struct kernel_clone_args args =3D {
> > > >  		.flags		=3D (clone_flags & ~CSIGNAL),
> > > > +		.pidfd		=3D parent_tidptr,
> > > >  		.child_tid	=3D child_tidptr,
> > > >  		.parent_tid	=3D parent_tidptr,
> > > >  		.exit_signal	=3D (clone_flags & CSIGNAL),
> > > > --=20
> > >=20
> > > Both of these legacy clone helpers need to make CLONE_PIDFD and
> > > CLONE_PARENT_SETTID incompatible, i.e. could you please add a helper =
to
> > > kernel/fork.c:
> > >=20
> > > bool legacy_clone_args_valid(const struct kernel_clone_args *kargs)
> > > {
> > > 	/* clone(CLONE_PIDFD) uses parent_tidptr to return a pidfd */
> > > 	if ((kargs->flags & CLONE_PIDFD) && (kargs->flags & CLONE_PARENT_SET=
TID))
> > > 		return false;
> > > }
> > >=20
> > > and export it and use it in ia32 too?
> >=20
> > copy_process already performs the check, isn't this enough?
>=20
> No it doesn't anymore. clone3() allows CLONE_PIDFD + CLONE_PARENT_SETTID
> since struct clone_args has a dedicated pidfd return argument.

Indeed, I must've missed it, thanks.

OK, I'll send a new fix with legacy_clone_args_valid.


--=20
ldv

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJdK1T5AAoJEAVFT+BVnCUIQwsP/Rs4APu+XjpUaIOrgJ3dnqGA
9XxwSZSGaPiZk/QCuyIwJ7SITNYbFklGDXDLP7jqBObpEObIKwCqnN6bzi7+MbRq
TlRRFrY/PBrpTnnDXcFTAyv1Fno0m/S8giPA5QyeP/fEiIak5SRKyjb+Hg3x+7Lm
ohm2GGkazv7Ul3PyPsasm1WQJIYgQWRI9SizzJ3ivwcdafsg/aNKUMhg3XHL1CXA
vfwRBjU5k3Ho2WpUQyh9HieysCl/BBDWKBGkif0lEr+zN7UG6QYFkaymztAtdrOA
xxBNjULIoRK88aTFKGh7oM+BIZpopNaiXmVDQSZLf5IKMmQEu3mmmO6X//YeKmHF
toEL0QToOA+VHiFcq3LiIG3U145rbfyhNdF6O0tuUQAiYbkzwQAZcymHlkbY8fcw
BRxkAnNH3imZVH1jWVsY1G5iDIOA/88RAb25/ipknSaqdfBtTDBwbWsraI4PZjwC
ZxgxtP2bqoOx49xncqjILnHR/Z8EbZdj3c8i0KBkxJxQeEEyJK/YC77LpRYSA32h
1BIdYUj6bMB5KVKGV8WO0p6mPXFm572jVG5oYsdUJxMWFhm+gHYdB0AVUczo+Poa
891Wg3akxjKNlARO8oT+ZqljRP5Ri2PS9tACMXLfEAyNl+9cjE5wGn0bwMRqYbm9
yOd0/155Ym+Xx8YjzNIm
=oTW/
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
