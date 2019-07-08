Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E895C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D1A2084A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gRIZIvpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfGHGuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 02:50:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50487 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfGHGuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:50:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hx1273ZFz9s8m;
        Mon,  8 Jul 2019 16:50:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562568647;
        bh=HAG8N3eVIJQIBBm0rDZ5loK5+K7qbQIbei3kLEglX3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gRIZIvpGOhjC+9oIYEd5xhoj+lMX+uN4P4RcVNPDjZOkQSuI91eqyt8ILMLqKufxD
         u/tN8WfuM+IFSew7wky2WjbEnAP8Hjn/iwcWdn9uwW9Z9HOEkaEDJI0+g7iyrDi/Va
         Yurqz7u6cZOUkBkXJhkD7WKWDOokU16lwx/2ULvpABJPI342Rb/rp89qqw/65qToNe
         VGm1dS9xvKOPIgnMwcKbcoXTOiJqaQsfb4MWNw14q58TNBXQyrEiTIFx6Wjkg+LalY
         unROvkSTV87Kuqh+klNhqSqq0rPZ/mCxahZnvv0zeQsZQPsMkk3qYKmh1zUzAfJNBx
         6zbygnlcL+XxQ==
Date:   Mon, 8 Jul 2019 16:50:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20190708165046.16d2912d@canb.auug.org.au>
In-Reply-To: <20190702102832.GP20977@suse.cz>
References: <20190702153302.28e7948d@canb.auug.org.au>
        <20190702102832.GP20977@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=51/kRi1X.SKH7VyK0k1qaz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=51/kRi1X.SKH7VyK0k1qaz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 2 Jul 2019 12:28:32 +0200 David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Jul 02, 2019 at 03:33:02PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the tip tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >=20
> > fs/btrfs/ctree.c: In function '__tree_mod_log_insert':
> > fs/btrfs/ctree.c:388:2: error: implicit declaration of function 'lockde=
p_assert_held_exclusive'; did you mean 'lockdep_assert_held_once'? [-Werror=
=3Dimplicit-function-declaration]
> >   lockdep_assert_held_exclusive(&fs_info->tree_mod_log_lock);
> >   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   lockdep_assert_held_once
> >=20
> > Caused by commit
> >=20
> >   9ffbe8ac05db ("locking/lockdep: Rename lockdep_assert_held_exclusive(=
) -> lockdep_assert_held_write()")
> >=20
> > interacting with commits
> >=20
> >   84cd7723de7c ("btrfs: assert tree mod log lock in __tree_mod_log_inse=
rt")
> >   283d2e443505 ("btrfs: assert extent map tree lock in add_extent_mappi=
ng") =20
>=20
> I can move the patches out of the for-5.3 branch and send them
> separately after the rename gets merged, they're merely adding the
> assertion and otherwise do not affect the rest of the code.
>=20
> Fixing that in another way would probably need more synchronization
> between the branches but I don't think it's necessary in this case. The
> next for-next snapshot branch will fix the compilation issue.

I see that you removed those commits.  The conflict is no more.

--=20
Cheers,
Stephen Rothwell

--Sig_/=51/kRi1X.SKH7VyK0k1qaz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0i58YACgkQAVBC80lX
0GwwBwgApAIOv9IiBrb2huEuk9Ji2QUhgMUMp6OcNTWMj8J4YB/oRCHw8qF+kfEO
cEKmDkcfTITyMBwy7EQf3lDsakhNo8znyTVWFWC/58pXsF0X+eKS1gabR2aXNVFK
TbVvd/eyRe3los0+1PvwILIrlnu5+7mwxBaaFu+cFKWtRUpk/huCCjrxK4AcBx8F
rEowTDq1B+xPxuQPvOU5MnJrBf+oJKyDakzbZU4YWpZacX0pexdcbstnBguTqOJo
CYITpeXZ106khP97+q8F5gcWpq6Bs/GDg4cIvHD0rmiAou8r2fyWVrOFnU4cLmmz
x8Dg189iR4SC1eiALYtUajZI8KDJyw==
=3edz
-----END PGP SIGNATURE-----

--Sig_/=51/kRi1X.SKH7VyK0k1qaz--
