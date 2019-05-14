Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44ADC04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858E621019
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L55k7Xpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfENA4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 20:56:54 -0400
Received: from ozlabs.org ([203.11.71.1]:41959 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfENA4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 20:56:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 452zm21TCvz9s5c;
        Tue, 14 May 2019 10:56:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557795411;
        bh=TxTcMKVqXgh7M+k63ZhUKgh1N6mWCEbKVbjlNxSZxxQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L55k7XpytwSSD1dtS2oPdIP7U3wNYg3AWkB2LnGA0twqCO3igIMU8erT6RZjhAa9y
         RoM/9XKlRI6XB8ZdUU0kinDUTSLoHZQP6Lqv3W2IvIlWz92+9SYzkCeEXcEe3NwQX/
         n+7rIeMIcMlbRr2D7sp9HE9F0LWXXFLfrVy9LX5dzAGwosbvjg6npXpgAJt7gaYbuY
         yQCyF8YFZkhMi7jgklFHnG/GF33pAjYe6CleQ67oa7bisbtZZWOaJ6kDqM+lV/prnL
         8Flj3rovoCnJVqQyQYtU6ucLoIkZ412E7yBkIM73p4BAAGqnzZSI1cMR1sQn4FvaVY
         8oJtwbQvAH3bA==
Date:   Tue, 14 May 2019 10:56:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Tyler Hicks <tyhicks@canonical.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: linux-next: build failure after merge of the ecryptfs tree
Message-ID: <20190514105649.512267cd@canb.auug.org.au>
In-Reply-To: <CAK7LNAT_aJ4-abaNXe5VwvAYa2TOprjFL-vcUc730EDwHq80kw@mail.gmail.com>
References: <20190514100910.6996d2f5@canb.auug.org.au>
        <CAK7LNAT_aJ4-abaNXe5VwvAYa2TOprjFL-vcUc730EDwHq80kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GAZU4z.04i=a5k9ZE+2ngzi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GAZU4z.04i=a5k9ZE+2ngzi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[excessive quoting for new CC's]

On Tue, 14 May 2019 09:40:53 +0900 Masahiro Yamada <yamada.masahiro@socione=
xt.com> wrote:
>
> On Tue, May 14, 2019 at 9:16 AM Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> >
> > I don't know why this suddenly appeared after mergeing the ecryptfs tree
> > since nothin has changed in that tree for some time (and nothing in that
> > tree seems relevant).
> >
> > After merging the ecryptfs tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > scripts/Makefile.modpost:112: target '.tmp_versions/asix.mod' doesn't m=
atch the target pattern
> > scripts/Makefile.modpost:113: warning: overriding recipe for target '.t=
mp_versions/asix.mod'
> > scripts/Makefile.modpost:100: warning: ignoring old recipe for target '=
.tmp_versions/asix.mod'
> > scripts/Makefile.modpost:127: target '.tmp_versions/asix.mod' doesn't m=
atch the target pattern
> > scripts/Makefile.modpost:128: warning: overriding recipe for target '.t=
mp_versions/asix.mod'
> > scripts/Makefile.modpost:113: warning: ignoring old recipe for target '=
.tmp_versions/asix.mod'
> > make[2]: Circular .tmp_versions/asix.mod <- __modpost dependency droppe=
d.
> > Binary file .tmp_versions/asix.mod matches: No such file or directory
> > make[2]: *** [scripts/Makefile.modpost:91: __modpost] Error 1
> > make[1]: *** [Makefile:1290: modules] Error 2
> >
> > The only clue I can see is that asix.o gets built in two separate
> > directories (drivers/net/{phy,usb}). =20
>=20
> Module name should be unique.
>=20
> If both are compiled as a module,
> they have the same module names:
>=20
> drivers/net/phy/asix.ko
> drivers/net/usb/asix.ko
>=20
> If you see .tmp_version directory,
> you will see asix.mod
>=20
> Perhaps, one overwrote the other,
> or it already got broken somehow.

So, the latter of these drivers (drivers/net/phy/asix.c) was added in
v4.18-rc1 by commit

  31dd83b96641 ("net-next: phy: new Asix Electronics PHY driver")

If we can't have 2 modules with the same base name, is it too late to
change its name?

I am sort of suprised that noone else has hit this in the past year.

> > I have the following files in the object directory:
> >
> > ./.tmp_versions/asix.mod
> > ./drivers/net/usb/asix.ko
> > ./drivers/net/usb/asix.mod.o
> > ./drivers/net/usb/asix.o
> > ./drivers/net/usb/asix_common.o
> > ./drivers/net/usb/asix_devices.o
> > ./drivers/net/usb/.asix.ko.cmd
> > ./drivers/net/usb/.asix.mod.o.cmd
> > ./drivers/net/usb/.asix.o.cmd
> > ./drivers/net/usb/asix.mod.c
> > ./drivers/net/usb/.asix_common.o.cmd
> > ./drivers/net/usb/.asix_devices.o.cmd
> > ./drivers/net/phy/asix.ko
> > ./drivers/net/phy/asix.o
> > ./drivers/net/phy/.asix.ko.cmd
> > ./drivers/net/phy/.asix.mod.o.cmd
> > ./drivers/net/phy/asix.mod.o
> > ./drivers/net/phy/asix.mod.c
> > ./drivers/net/phy/.asix.o.cmd
> >
> > ./.tmp_versions/asix.mod
> >
> > Looks like this:
> >
> > ------------------------------------------
> > drivers/net/phy/asix.ko
> > drivers/net/phy/asix.o
> >
> >
> > ------------------------------------------
> >
> > What you can't see above are the 256 NUL bytes at the end of the file
> > (followed by a NL).
> >
> > This is from a -j 80 build.  Surely there is a race condition here if t=
he
> > file in .tmp_versions is only named for the base name of the module and
> > we have 2 modules with the same base name.
> >
> > I removed that file and redid the build and it succeeded.
> >
> > Mind you, I have no itdea why this file was begin rebuilt, the merge
> > only touched these files:
> >
> > fs/ecryptfs/crypto.c
> > fs/ecryptfs/keystore.c
> >
> > Puzzled ... :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/GAZU4z.04i=a5k9ZE+2ngzi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzaElEACgkQAVBC80lX
0Gyjdgf/VOXl+vcYN5/Ns9TE9My0Xo/JNrguSjSJhQx3ADvaV+/jtei0jM7gRdLu
Zjl0UU0Ru2sOJjhUnIgm7nAk7c9btHOG46lMDnYuFWvYATJNpPR5yepJywPvpbTy
BMtnQEcSWBUIYW8GLDZiVtsrH1bgmahjDfJ/kShawh6OiF2p5+ai/zx2bOMPV5vR
1nC41I+l76jUF8triGtXtcbHtuTKKJI5MMUhnn/xEO/uIukCNAv5FjcrC0SPHXPX
97bj/UFKpGuZEPDlGVJBUOaBaif2xOuq2d5cbGktps99xg2f2Ti9NrD9z02RW/RA
2/SyK8qUp3+tSlyC77Ns41H08A4MXQ==
=zQyT
-----END PGP SIGNATURE-----

--Sig_/GAZU4z.04i=a5k9ZE+2ngzi--
