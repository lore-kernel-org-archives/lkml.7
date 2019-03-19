Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64136C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F692077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCSWc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:32:56 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:47046 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCSWc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:32:56 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1BDF872CCAC;
        Wed, 20 Mar 2019 01:32:53 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 0E1F27CC74C; Wed, 20 Mar 2019 01:32:53 +0300 (MSK)
Date:   Wed, 20 Mar 2019 01:32:53 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RESEND PATCH] ptrace: take into account saved_sigmask in
 PTRACE_{GET,SET}SIGMASK
Message-ID: <20190319223252.GA19424@altlinux.org>
References: <20190319191957.27156-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20190319191957.27156-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 12:19:57PM -0700, Andrei Vagin wrote:
> There are a few system calls (pselect, ppoll, etc) which replace a task
> sigmask while they are running in a kernel-space
>=20
> When a task calls one of these syscalls, the kernel saves a current
> sigmask in task->saved_sigmask and sets a syscall sigmask.
>=20
> On syscall-exit-stop, ptrace traps a task before restoring the
> saved_sigmask, so PTRACE_GETSIGMASK returns the syscall sigmask and
> PTRACE_SETSIGMASK does nothing, because its sigmask is replaced by
> saved_sigmask, when the task returns to user-space.
>=20
> This patch fixes this problem.  PTRACE_GET_SIGMASK returns saved_sigmask
> is it's set.  PTRACE_SETSIGMASK drops the TIF_RESTORE_SIGMASK flag.

If it's not too late, could somebody tweak the commit message so that
PTRACE_GET_SIGMASK becomes PTRACE_GETSIGMASK and "is it's set" is changed
to "if it's set", please?


--=20
ldv

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJckW4UAAoJEAVFT+BVnCUItfsP/R6/j0iRF6lVA67Vlb3yafBM
w5nk7j1eV0Pm/gKALaGVrB6rwJC7ghD05S64uqca9vX8oKJLSTayP6e3Xy1WqP1c
EymLkosU9869M95+3EN/zfKyRUzrVOdvSdMNgl1WGMRSs3txCub3PuWJ8QHq6EBi
bCzLbK5V15tJs3yOn/yqR3AXKLvt+/ZVWhHUHkbf/DcMMYs3Ycjt6BSM27pExvg9
rDxPoxtEC63bzgDSSY3fbaFbRScGS1X2Pl+PNiCaTCuyP+oULXLDPPXExZDHZTP2
hsS7ID5FIXhYAzLfvrN9tRQmqHC+fQdDMIDf15zUKl8XaoCwnf43gyNZPWIxTe+H
k7/UIoOBHYPD50HX9+al7S1QfGX2E7fyinmBl0mT+X9eMORxNoWFMbI3WmmJZkDE
ZR/weOis2GpeDtev+aBOTS9k0csY6/hhVFtC8/OULHExr01EdImA37NKlkQbwXEq
HKW7b60sPqSVeYAoF5o00UjfzTL/eAHxSJWI/2/6XfHhbde6XzDfuPEwuBU6bC+O
XIRLV1EShd64cgfaskThMMivjB3gnJpaukC01MfzUJi+xZWAzdnJme56kJ5xS12j
OtgL3Zv9V18Nq/SIOlE2bIIQKYFMZopM/b4Y70tKA4R2swNFSzmcxRli7YgxY09i
umENVJldGMUEyoVrGYTV
=29F8
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
