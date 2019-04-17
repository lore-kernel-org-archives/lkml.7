Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACC6C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886AF2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SHQjvF3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbfDQXCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:02:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729079AbfDQXCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:02:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44kyST62XCz9s3l;
        Thu, 18 Apr 2019 09:02:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555542170;
        bh=pfeTRac5DKfXQf/+P9YGeK1DA09dfTybqbB3bbsYobs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SHQjvF3yikA2pTNmFF13Z5WhxanK4NPWkhBE68WZIl+gJq4fMwB0kv4bkZ3IgIeHD
         sxc/0NTauMO4yXHH7nRxoAJ7TVtBeSmOHxr7uDNfueB93YVlzot8GvnjJ8jSlTq4tn
         sP1m+Cji1Jov20BMLFd6DONr5biPvm1NBV41AXN25ncn03PRPPNZzCqcFogy8bFnCt
         PAoz1hnMCpd4CnpSLg8tNBZCNhnImLX7Kcb84s5eLLbr8rTVS4yQLyMxXm1veRMdOc
         RVWoWZQUx5tL+3v93HJdfky/DALtSCwSWDi7/YNBgf4Nojdk6Pq/xm7LAea57skeTY
         rOjC7vDgMiShg==
Date:   Thu, 18 Apr 2019 09:02:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190418090247.2982dafd@canb.auug.org.au>
In-Reply-To: <CAGXu5j+9_f=5aT7x=K=Hg9LS3eQ9-dhVF18LCBfZcx+EmTO3PA@mail.gmail.com>
References: <20190417165321.61cd6380@canb.auug.org.au>
        <CAGXu5jKYxLe9-umda7C3iWfYFe-Thv=dL4bJQC9nU4GMGK5Wwg@mail.gmail.com>
        <CAGXu5j+9_f=5aT7x=K=Hg9LS3eQ9-dhVF18LCBfZcx+EmTO3PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/13rMavU0T_TyHpnv8t5sT_i"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/13rMavU0T_TyHpnv8t5sT_i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Wed, 17 Apr 2019 17:28:39 -0500 Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 17, 2019 at 5:22 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Apr 17, 2019 at 1:53 AM Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote: =20
> > >
> > > Hi Andrew,
> > >
> > > After merging the akpm-current tree, today's linux-next build (arm
> > > multi_v7_defconfig) failed like this:
> > >
> > > fs/binfmt_elf.c: In function 'load_elf_binary':
> > > fs/binfmt_elf.c:1140:7: error: 'elf_interpreter' undeclared (first us=
e in this function); did you mean 'interpreter'?
> > >   if (!elf_interpreter)
> > >        ^~~~~~~~~~~~~~~
> > >        interpreter =20
> >
> > static int load_elf_binary(struct linux_binprm *bprm)
> > {
> > ...
> >         char * elf_interpreter =3D NULL;
> >
> > This is _absolutely_ a valid variable. =20

It was. However commit a34f642bccf1 from Andrew's tree changes its scope.

So there is nothing wrong with commit 3ebf0dd657ce, it is the incorrect
rebase of it on top of a34f642bccf1 that causes the build problem.

> > > Caused by commit
> > >
> > >   3ebf0dd657ce ("fs/binfmt_elf.c: move brk out of mmap when doing dir=
ect loader exec")
> > >
> > > interacting with commit
> > >
> > >   a34f642bccf1 ("fs/binfmt_elf.c: free PT_INTERP filename ASAP")
> > >
> > > I have applied the following patch for today.
> > >
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Wed, 17 Apr 2019 16:48:29 +1000
> > > Subject: [PATCH] fix "fs/binfmt_elf.c: move brk out of mmap when doin=
g direct loader exec"
> > >
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > >  fs/binfmt_elf.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > > index b3bbe6bca499..fe5668a1bbaa 100644
> > > --- a/fs/binfmt_elf.c
> > > +++ b/fs/binfmt_elf.c
> > > @@ -1137,7 +1137,7 @@ static int load_elf_binary(struct linux_binprm =
*bprm)
> > >          * collide early with the stack growing down), and into the u=
nused
> > >          * ELF_ET_DYN_BASE region.
> > >          */
> > > -       if (!elf_interpreter)
> > > +       if (!interpreter) =20
> >
> > No, this is very wrong and will, I think, cause all PIE binaries to fai=
l to run. =20
>=20
> I may be wrong: I think this will cause all static binaries to see
> their brk moved very unexpectedly. All static PIE binaries will fail?

Are you sure that elf_interpreter =3D=3D NULL is not equivalent to
interpreter =3D=3D NULL by this point in the code?  Earlier if
elf_intpreter is not NULL, we have set interpreter (using open_exec)
and errored out if that fails.
--=20
Cheers,
Stephen Rothwell

--Sig_/13rMavU0T_TyHpnv8t5sT_i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly3sJcACgkQAVBC80lX
0Gy8qQgAnbt0cxYETgUrMpPGHkvUSluXfu3gIA3zlwYpzkZKmK/uRVYH0kMjKuvy
RhDFBSlhAXuMlBr+kNR+3GTB4gneNnu4kpeNdbJzzyUv7gXCBmTvPiHiwOKuMSxF
lMgEEhDdZFpbVYCPgDlWZzRIrQMAaLudt+H0yqmm7O0dkZ1EHHEyPjpZTJZgEQWU
wPITT3IaUgq0nKBM7Sr/NTGgYjbqK9xP0jiPStjvezNNSTjgUjKIGaGtnOvVfKgv
xI8EOYZB6hqeuZ3wNt8CZyok78w77o5WEUmCGxtMEDvFX5FMx/iEIUkD+JPqduGt
uPsrCEN+PnF48qWfB3KtgpBHC9cecw==
=Zg77
-----END PGP SIGNATURE-----

--Sig_/13rMavU0T_TyHpnv8t5sT_i--
