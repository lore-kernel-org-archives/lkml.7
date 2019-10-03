Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312CFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0EE20865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405544AbfJCQxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:53:25 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:42194 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405232AbfJCQxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:53:19 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id E55FEA33D1;
        Thu,  3 Oct 2019 18:53:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id 2oKS5ApijqDi; Thu,  3 Oct 2019 18:53:11 +0200 (CEST)
Date:   Fri, 4 Oct 2019 02:53:01 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        Christian Brauner <christian@brauner.io>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Guillaume Dore <corwin@poussif.eu>, linux-doc@vger.kernel.org,
        linux-abi@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH] Documentation: update about adding syscalls
Message-ID: <20191003165301.ihrlrgcldgun7dld@yavin.dot.cyphar.com>
References: <20191002151437.5367-1-christian.brauner@ubuntu.com>
 <20191003103931.52683cb6@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ecmiy52y44gvxiaw"
Content-Disposition: inline
In-Reply-To: <20191003103931.52683cb6@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ecmiy52y44gvxiaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-03, Jonathan Corbet <corbet@lwn.net> wrote:
> [Expanding CC a bit; this is the sort of change I'm reluctant to take
> without being sure it reflects what the community thinks.]
>=20
> On Wed,  2 Oct 2019 17:14:37 +0200
> Christian Brauner <christian.brauner@ubuntu.com> wrote:
>=20
> > Add additional information on how to ensure that syscalls with structure
> > arguments are extensible and add a section about naming conventions to
> > follow when adding revised versions of already existing syscalls.
> >=20
> > Co-Developed-by: Aleksa Sarai <cyphar@cyphar.com>
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  Documentation/process/adding-syscalls.rst | 82 +++++++++++++++++++----
> >  1 file changed, 70 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/=
process/adding-syscalls.rst
> > index 1c3a840d06b9..93e0221fbb9a 100644
> > --- a/Documentation/process/adding-syscalls.rst
> > +++ b/Documentation/process/adding-syscalls.rst
> > @@ -79,7 +79,7 @@ flags, and reject the system call (with ``EINVAL``) i=
f it does::
> >  For more sophisticated system calls that involve a larger number of ar=
guments,
> >  it's preferred to encapsulate the majority of the arguments into a str=
ucture
> >  that is passed in by pointer.  Such a structure can cope with future e=
xtension
> > -by including a size argument in the structure::
> > +by either including a size argument in the structure::
> > =20
> >      struct xyzzy_params {
> >          u32 size; /* userspace sets p->size =3D sizeof(struct xyzzy_pa=
rams) */
> > @@ -87,20 +87,56 @@ by including a size argument in the structure::
> >          u64 param_2;
> >          u64 param_3;
> >      };
> > +    int sys_xyzzy(struct xyzzy_params __user *uarg);
> > +    /* in case of -E2BIG, p->size is set to the in-kernel size and thu=
s all
> > +       extensions after that offset are unsupported. */
>=20
> That comment kind of threw me for a loop - this is the first mention of
> E2BIG and readers may not just know what's being talked about.  Especially
> since the comment suggests *not* actually returning an error.

I probably could've worded this better -- this comment describes what
userspace sees when they use the API (sched_setattr(2) is an example of
this style of API).

In the case where the kernel doesn't support a requested extension
(usize > ksize, and there are non-zero bytes past ksize) then the kernel
returns -E2BIG *but also* sets p->size to ksize so that userspace knows
what extensions the kernel supports.

Maybe I should've replicated more of the details from the kernel-doc for
copy_struct_from_user().

> > -As long as any subsequently added field, say ``param_4``, is designed =
so that a
> > -zero value gives the previous behaviour, then this allows both directi=
ons of
> > -version mismatch:
> > +or by including a separate argument that specifies the size::
> > =20
> > - - To cope with a later userspace program calling an older kernel, the=
 kernel
> > -   code should check that any memory beyond the size of the structure =
that it
> > -   expects is zero (effectively checking that ``param_4 =3D=3D 0``).
> > - - To cope with an older userspace program calling a newer kernel, the=
 kernel
> > -   code can zero-extend a smaller instance of the structure (effective=
ly
> > -   setting ``param_4 =3D 0``).
> > +    struct xyzzy_params {
> > +        u32 param_1;
> > +        u64 param_2;
> > +        u64 param_3;
> > +    };
> > +    /* userspace sets @usize =3D sizeof(struct xyzzy_params) */
> > +    int sys_xyzzy(struct xyzzy_params __user *uarg, size_t usize);
> > +    /* in case of -E2BIG, userspace has to attempt smaller @usize valu=
es
> > +       to figure out which extensions are unsupported. */
>=20
> Here too.  But what I'm really wondering about now is: you're describing
> different behavior for what are essentially two cases of the same thing.
> Why should the kernel simply accept the smaller size if the size is
> embedded in the structure itself, but return an error and force user space
> to retry if it's a separate argument?
>=20
> I guess maybe because in the latter case the kernel can't easily return
> the size it's actually using?  I think that should be explicit if so.

As above, the -E2BIG only happens if userspace is trying to use an
extension that the kernel doesn't support (usize > ksize, non-zero bytes
after ksize). The main difference between the two API styles is whether
or not userspace gets told what ksize is explicitly in the case of an
-E2BIG.

Maybe it would be less confusing to only mention one of ways of doing
it, but then we have to pick one (and while the newer syscalls [clone3
and openat2] use a separate argument, there are more syscalls which
embed it in the struct).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ecmiy52y44gvxiaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXZYnaQAKCRCdlLljIbnQ
EhlVAQCqbspnt/NT+1gkI4JVdUZFAWs0Fw/uNiDdbdMPIaf3JAEA/PeY3tJKd9bc
O9UhoWmz9VranrMXxxyR6e0LVw7J3wo=
=BOSH
-----END PGP SIGNATURE-----

--ecmiy52y44gvxiaw--
