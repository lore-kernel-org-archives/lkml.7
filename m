Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25F9C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C2F2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q+skvyy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389007AbfHGXbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:31:55 -0400
Received: from ozlabs.org ([203.11.71.1]:36993 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387849AbfHGXbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:31:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463npJ4gNcz9sBF;
        Thu,  8 Aug 2019 09:31:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565220712;
        bh=D4954wWJFIxeNOAVCijZOojKttQJdCVp6dAMHpHJBYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q+skvyy73bh+ueDzhcKMjKlRSYzXaCCxgrX6NDyy5Tzh9ghKs7cR3BymxbZCU5U6T
         yAMsqZM92mMcarCtTU1k89qMQpoK40pguulgJmeyJN4prVl6NwY3ubv0Cald+An2yO
         4R52Xqly490gOUTSYM0wH7inL7stWfH6VQ3WDNHsOdfJrnDpzeAjpCbfm7x3YCPIN7
         rFZP0eQG5x4okmcQ7Gd/YtJzRINkvvm9BmEVQDjLNbYAnsClM0fUeiXbdoDoHkdGGe
         4vtm+CcY+nfElk+5OXXcjhqMY1ZeoMe9t+XYBn/Gq9DJAl3cuT7fFSesAu5dEjKyNc
         qajJef3XjxUdg==
Date:   Thu, 8 Aug 2019 09:31:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190808093134.1a5df132@canb.auug.org.au>
In-Reply-To: <20190807112917.GA4624@rikard>
References: <20190807180041.07f06dc0@canb.auug.org.au>
        <20190807112917.GA4624@rikard>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S1/XyKHC=Oh8eUWuEWK2PHJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S1/XyKHC=Oh8eUWuEWK2PHJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rikard,

On Wed, 7 Aug 2019 13:29:17 +0200 Rikard Falkeborn <rikard.falkeborn@gmail.=
com> wrote:
>
> Hi Stephen, Andrew
>=20
> On Wed, Aug 07, 2019 at 06:00:41PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the akpm-current tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >=20
> > In file included from include/linux/bits.h:22,
> >                  from arch/x86/include/asm/msr-index.h:5,
> >                  from arch/x86/boot/cpucheck.c:28:
> > include/linux/build_bug.h:49: warning: "BUILD_BUG_ON" redefined
> >  #define BUILD_BUG_ON(condition) \
> > =20
> > In file included from arch/x86/boot/cpucheck.c:22:
> > arch/x86/boot/boot.h:31: note: this is the location of the previous def=
inition
> >  #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)=
]))
> >=20
> > Caused by commit
> >=20
> >   d72f2a993607 ("linux/bits.h: add compile time sanity check of GENMASK=
 inputs")
> >=20
> > --=20
> > Cheers,
> > Stephen Rothwell =20
>=20
> Please drop this patch, it has additional issues that needs to be fixed
> in another revision.

I have removed it from linux-next for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/S1/XyKHC=Oh8eUWuEWK2PHJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1LX1YACgkQAVBC80lX
0Gz1vQf/Vr+jSE3tZ3mO3nFRIABShN33fdZ8ctsctp2uCkjyX5JZmgQ04MRZZKCM
V2XABQmTugkVJ5B2RK4Mgc4QYvsHDUUSO7f1sjA2c97uU7GxxbkmoNP+ZXGKe5YT
DuH/I8pOmF4J0TAUURAhXgODc9j5fZ9qYFFt3u8l+6dXnlo5TxsEO9uaV4E36z2b
v94ChOSTlHLLB6J5SxNAmSv5zFuMhBeQ5d23zub//ynN5Dp8hVUOxfi4Gww8YSPO
lrjvvun84fRGi86j/NA1gYlGjX9FohRWJ3vVYtNQKOBtvm0oVB6R2nmH9IFFPRm8
uTdWuigz1JdKRtTwKX0lnsB+TUfvRA==
=An6g
-----END PGP SIGNATURE-----

--Sig_/S1/XyKHC=Oh8eUWuEWK2PHJ--
