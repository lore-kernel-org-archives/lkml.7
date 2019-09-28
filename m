Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFB3C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 12:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B632081B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 12:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfI1Mdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 08:33:35 -0400
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:43511 "EHLO
        2.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfI1Mdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 08:33:35 -0400
Received: from player731.ha.ovh.net (unknown [10.109.159.132])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 0E0AF1E240D
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 10:55:34 +0200 (CEST)
Received: from sk2.org (gw.sk2.org [88.186.243.14])
        (Authenticated sender: steve@sk2.org)
        by player731.ha.ovh.net (Postfix) with ESMTPSA id 6DB3AA260E0B;
        Sat, 28 Sep 2019 08:55:23 +0000 (UTC)
Date:   Sat, 28 Sep 2019 10:55:57 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-can@vger.kernel.org, linux-afs@lists.infradead.org,
        kvm@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] docs: use flexible array members, not zero-length
Message-ID: <20190928105557.221fb119@heffalump.sk2.org>
In-Reply-To: <20190928011639.7c983e77@lwn.net>
References: <20190927142927.27968-1-steve@sk2.org>
        <20190928011639.7c983e77@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/6lwZ.M0KIAOHFlu0tCvHt6N"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 2307531860306840965
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeekgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6lwZ.M0KIAOHFlu0tCvHt6N
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Sep 2019 01:16:39 -0600, Jonathan Corbet <corbet@lwn.net> wrote:
> On Fri, 27 Sep 2019 16:29:27 +0200
> Stephen Kitt <steve@sk2.org> wrote:
> > diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> > index 4d565d202ce3..24ce50fc1fc1 100644
> > --- a/Documentation/bpf/btf.rst
> > +++ b/Documentation/bpf/btf.rst
> > @@ -670,7 +670,7 @@ func_info for each specific ELF section.::
> >          __u32   sec_name_off; /* offset to section name */
> >          __u32   num_info;
> >          /* Followed by num_info * record_size number of bytes */
> > -        __u8    data[0];
> > +        __u8    data[];
> >       }; =20
>=20
> I only checked this one, but found what I had expected: the actual
> definition of this structure (found in tools/lib/bpf/libbpf_internal.h)
> says "data[0]".  We can't really make the documentation read the way we
> *wish* the source would be, we need to document reality.
>=20
> I'm pretty sure that most of the other examples will be the same.

Aargh, yes, of course, thanks for checking! I was locked in a =E2=80=9Cpres=
criptive=E2=80=9D
documentation mode, but this type of documentation has to be descriptive
since it=E2=80=99s documenting shared structures, not structures which deve=
lopers
have to write.

> If you really want to fix these, the right solution is to fix the offendi=
ng
> structures =E2=80=94 one patch per structure =E2=80=94 in the source, the=
n update the
> documentation to match the new reality.

Yes. I have a Coccinelle script which takes care of the code, but it doesn=
=E2=80=99t
work for docs ;-).

Wouldn=E2=80=99t it be better to update the docs simultaneously in each pat=
ch which
fixes a structure? Or is that unworkable with current development practices?

Regards,

Stephen

--Sig_/6lwZ.M0KIAOHFlu0tCvHt6N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl2PIB4ACgkQgNMC9Yht
g5zsMRAAlq0QqSRyK8SmkZrHHi9ZrsTUhy9uZ0IHYFiFaDl5/P9JHqCOMgWCqjLI
vjR/pTj6+Gc1h/87XgrOoWt72eqGmkP5TfqRFfrMmgTKyabiqnXjrhEEy/JpEegp
wI1qjOrs/y2gWacnVssUmbrprK7dZWQ9DxSA5glafzxWyZgLgT5dEGCQKdHQX+1v
QdYG7wZChDSuVUFxVryqIJM0zKGrOhbSlj3xHSGLDZa6+k6pvM+Sv+i7de0EJHkZ
qssPQCsxIXBvS0Md1f1NqHS5K+7y4inCoh3U88A/YfEw2zPH7CwGXo+NrD8ihKkp
aSAPICVP+ei48uuj8zGZcoCrCql7BiKSNgiTgguu3VZQ9+lIkzGuuidw84RcI4BU
OHo3sKz1HE9+QeMowg0QcEpE5RJflJDMb/9PFciMkpSjFTOAZHQvvA8zZkLjVm2Y
kSVmIoYAtGKb7PxqwBmZYyWGaHS090pie8PrdGAfo/KJPSHzPlK8ZnEwZJqGb2Ko
GUyw/xNFefziyA35xSptguK4K4sSsIeD+Z5+Vt6xvyATEf5PS+9pQsKL3uxczUEV
2WDYg6SXW2CU2nEpkGndHIQPcQSKZE2hASRwL7dtl89nM5tgviYAfOWdo1eBje0Q
HkXRsGAUe6tlnlUDBjYa4VYLJMZS5vYTjY551oHzlfMmGQErvQM=
=rxn4
-----END PGP SIGNATURE-----

--Sig_/6lwZ.M0KIAOHFlu0tCvHt6N--
