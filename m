Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70D6C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AFF2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uF2ol3aI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfG2W0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:26:25 -0400
Received: from ozlabs.org ([203.11.71.1]:57563 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfG2W0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:26:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45yDmr4ytPz9sBZ;
        Tue, 30 Jul 2019 08:26:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564439182;
        bh=iCgND0Vug34KrKrT3B1sSvny/JOeVtmB130k4FViN/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uF2ol3aIldsyI+/paWOsSDejg1wfdazTCOdn50Wn92Tcxj1O9T9EPXozUbE1D3wTu
         TyR8khBV8chWI4dBrhYGmnoLgOASpIYPLmdbA1AwZCoabKebQSrgeTBfWsEpS0ukwL
         Z1SYxJ1bye3Jvyg6Nh0y18Jk5HwU73GCk2lu8lNTRSethtZj91Byp0l3GWIN+/oduN
         czsp3wiB36R3IWFq+/MYoSv95Yset4exWtAl4+2TMtb3LGxV1Xn33SQIXx2o3UsWGo
         kRGgwCyk4xMIfpuK8scPg6eSzkpgw34EaC8hunoJO0+pgLlgPN8zCyBVhimSllpPTG
         qPrC3mSJFry0g==
Date:   Tue, 30 Jul 2019 08:26:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Denis Efremov <efremov@linux.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] modpost: check for static EXPORT_SYMBOL* functions
Message-ID: <20190730082618.5bb5edf3@canb.auug.org.au>
In-Reply-To: <20190729141801.31333-1-efremov@linux.com>
References: <20190714152817.24693-1-efremov@linux.com>
        <20190729141801.31333-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W1FvA._R0XXtjhBVU9lsVnR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W1FvA._R0XXtjhBVU9lsVnR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, 29 Jul 2019 17:18:01 +0300 Denis Efremov <efremov@linux.com> wrote:
>
> This patch adds a check to warn about static EXPORT_SYMBOL* functions
> during the modpost. In most of the cases, a static symbol marked for
> exporting is an odd combination that should be fixed either by deleting
> the exporting mark or by removing the static attribute and adding the
> appropriate declaration to headers.

OK, this is now in linux-next and I am getting what look like false
positives :-(

My powerpc builds produce these:

WARNING: "ahci_em_messages" [vmlinux] is the static EXPORT_SYMBOL_GPL
WARNING: "ftrace_set_clr_event" [vmlinux] is the static EXPORT_SYMBOL_GPL
WARNING: "empty_zero_page" [vmlinux] is the static EXPORT_SYMBOL
WARNING: "jiffies" [vmlinux] is the static EXPORT_SYMBOL

empty_zero_page (at least) is not static.  It is defined in assembler ...

jiffies is defined in arch/powerpc/kernel/vmlinux.lds.S as an alias for
(part of) jiffies_64 which is not static (defined in kernel/time/timer.c).

The other 2 were OK.
--=20
Cheers,
Stephen Rothwell

--Sig_/W1FvA._R0XXtjhBVU9lsVnR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0/cosACgkQAVBC80lX
0GzaKwf/eMecLr6q+Z8Lqr2neg+RXHvOu+Ph+Q3hgYr0RbcLyGZYcBtE33vMZgGR
Ue3bKhTvx+0YJBg7z8uO3tP+n5BVvw/wo9Kn4s/ckWZA8eK2c3FJ2SMuT4dKir9X
bdHg+T3OVJeHT/NkHGO6TrRb/7lL/xcEwifhbG6LNc0Fdc7UQ2LIZZFeVURIWSkv
P/Q+OhS4pT1r8T7jfhVM2REMDKcl3j0/gmNjyXe4mTjaoh2rGSmfuKKnWCV0YlmT
vwBYB7zI71zH7ndRoXYoBCRWiIi0Nphgjk0idKBI/5A3UU9YZOIr5/VKfWBM7zec
SgcnFWXp+ixj6ZO2DJoWOaCq2E4b1g==
=JP8H
-----END PGP SIGNATURE-----

--Sig_/W1FvA._R0XXtjhBVU9lsVnR--
