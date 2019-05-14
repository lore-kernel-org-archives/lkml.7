Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75AAC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 04:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96AF2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 04:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Vlk2o/4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfENEtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 00:49:45 -0400
Received: from ozlabs.org ([203.11.71.1]:39599 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfENEtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 00:49:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4534wl0rMRz9sBp;
        Tue, 14 May 2019 14:49:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557809383;
        bh=KuZ8WUohyWe50F13yVqwau/0S6d11//MrO0lXreM+uE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vlk2o/4oznCOtpM/rOtYXXTaiKq/cw3rNlPoa54dJvfDzzVNEJm0jDQlWJG0zTo4g
         1g4XojpEVWbg8jRdOmgqKz3AJ3X18zIvitl2aoJq4hk4YQ+nCfX/UDcv5aOEv5NHyk
         h+kK/caFUoz4fKZQvpNPhc1LjY7SxPHzIW/X91ERfRd2JTIFJFBlviH3WINcw/uwoI
         auKvYAae7yvpL6VCzCuFjnZWdcdosLQxA1AGEpM5mClDI46N2eUD7iGbvjoXAf5Mwp
         WVYIg3TLshqYnjl5nzIhB8OdgKXin23gs19V/mw7A3Fio+OeqClyA9Fr9NrGHjBaZC
         3gHV43GMuVbvA==
Date:   Tue, 14 May 2019 14:49:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ecryptfs tree
Message-ID: <20190514144942.403f0e96@canb.auug.org.au>
In-Reply-To: <CAK7LNAS-KDO0Cuq34T5MZvJjxZ-A3HaG3qnJi3v4P9xS=4fRQA@mail.gmail.com>
References: <20190514100910.6996d2f5@canb.auug.org.au>
        <CAK7LNAT_aJ4-abaNXe5VwvAYa2TOprjFL-vcUc730EDwHq80kw@mail.gmail.com>
        <20190514110334.424cf0be@canb.auug.org.au>
        <CAK7LNAS-KDO0Cuq34T5MZvJjxZ-A3HaG3qnJi3v4P9xS=4fRQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/caDE/H.1YQjykSJJ7NW76NM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/caDE/H.1YQjykSJJ7NW76NM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Tue, 14 May 2019 13:16:37 +0900 Masahiro Yamada <yamada.masahiro@socione=
xt.com> wrote:
>
> If you are talking about the rebuild of
> .tmp_versions/*.mod files,
> yes, they are cleaned up every time.
>=20
> # Create temporary dir for module support files
> # clean it up only when building all modules
> cmd_crmodverdir =3D $(Q)mkdir -p $(MODVERDIR) \
>                   $(if $(KBUILD_MODULES),; rm -f $(MODVERDIR)/*)
>=20
>=20
> I think the reason is that
> we want to make sure stale modules are not remaining
> when CONFIG_MY_DRIVER=3Dm is turned into CONFIG_MY_DRIVER=3Dn
>=20
>=20
> Rebuilding .mod files is not expensive.
>=20
> I think this behavior can be improved, but
> that is how it has been working for a long time.

when you say "not expensive", how long is that?  Because an x86_64
allmodconfig build currently produces 7313 of those files, so at .01
seconds each (for example) that would add over a minute to each of my
builds ... and I do lots of builds every day.  OK, so it may not be
that significant (so a millisecond each is obviously not a problem),
but just wondering if it can be avoided.

--=20
Cheers,
Stephen Rothwell

--Sig_/caDE/H.1YQjykSJJ7NW76NM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzaSOYACgkQAVBC80lX
0GwsKgf/SSRx5sD4e36x/UZq9x39Q5HP3h3xDj3LZ/ouhU+uPqF8jwAM2LOw1rrF
DOWE3LZ87R1CkIGxgqup5F3D8nrn7DXcIak9xYOkGceIcL1cR0ZXFEOr+ov5rq4a
ftdpKuAtl/l4rF5FrcVjQFPwWsN04MHvvlZQyF4e1snO7LikYQCIW/xH8VXwoJy1
FiM4lfkfF5GyohEbktG/hLiBlK5rLgI8p2ESjFWoXi7fXnnjO5ji4RUgisLitYXq
cLLygqiKwmjGbNVnlBZs2uLTApQE483LqQP/NnJWazSyJZqKHVobtpwqgXa+5e3F
tuSee73joKe4qGHAQcISZQHcDjdkGw==
=hgY+
-----END PGP SIGNATURE-----

--Sig_/caDE/H.1YQjykSJJ7NW76NM--
