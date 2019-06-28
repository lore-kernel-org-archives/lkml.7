Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA69FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F336214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfF1SrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:47:20 -0400
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:56781 "EHLO
        7.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfF1SrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:47:20 -0400
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2019 14:47:19 EDT
Received: from player772.ha.ovh.net (unknown [10.109.146.5])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6ECB21D1D2B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 20:38:46 +0200 (CEST)
Received: from sk2.org (gw.sk2.org [88.186.243.14])
        (Authenticated sender: steve@sk2.org)
        by player772.ha.ovh.net (Postfix) with ESMTPSA id D8A3A759C830;
        Fri, 28 Jun 2019 18:38:42 +0000 (UTC)
Date:   Fri, 28 Jun 2019 20:38:41 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: format kernel-parameters -- as code
Message-ID: <20190628203841.723ccd9c@heffalump.sk2.org>
In-Reply-To: <20190628091021.457d0301@lwn.net>
References: <20190627135938.3722-1-steve@sk2.org>
        <20190628091021.457d0301@lwn.net>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/+Q2ZDCvK8guFHmIkhT+Ru1w"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 6824642289615850885
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvddtgdduvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+Q2ZDCvK8guFHmIkhT+Ru1w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Jun 2019 09:10:21 -0600, Jonathan Corbet <corbet@lwn.net> wrote:
> On Thu, 27 Jun 2019 15:59:38 +0200
> > The current ReStructuredText formatting results in "--", used to
> > indicate the end of the kernel command-line parameters, appearing as
> > an en-dash instead of two hyphens; this patch formats them as code,
> > "``--``", as done elsewhere in the documentation.
> >=20
> > Signed-off-by: Stephen Kitt <steve@sk2.org> =20
>=20
> A worthy fix, I've applied it.  This seems like the sort of annoyance that
> will bite us over and over, though.  We might want to find a more
> comprehensive way to turn this behavior off.

Right, looking further shows a large number of places where -- is handled
incorrectly. The following patch disables this =E2=80=9Csmart=E2=80=9D hand=
ling wholesale;
I=E2=80=99ll follow up (in the next few days) with patches to use real em- =
and
en-dashes where appropriate.

Regards,

Stephen

=46rom 3b10d01decfec38a124be75739b398a3dcd9d5ce Mon Sep 17 00:00:00 2001
From: Stephen Kitt <steve@sk2.org>
Date: Fri, 28 Jun 2019 20:34:31 +0200
Subject: [PATCH] Disable Sphinx SmartyPants in HTML output

The handling of dashes in particular results in confusing
documentation in a number of instances, since "--" becomes an
en-dash. This disables SmartyPants wholesale, losing smart quotes
along with smart dashes.

With Sphinx 1.6 we could fine-tune the conversion, using the new
smartquotes and smartquotes_action settings.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/conf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 7ace3f8852bd..966dbdfafcd1 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -200,7 +200,7 @@ html_context =3D {
=20
 # If true, SmartyPants will be used to convert quotes and dashes to
 # typographically correct entities.
-#html_use_smartypants =3D True
+html_use_smartypants =3D False
=20
 # Custom sidebar templates, maps document names to template names.
 #html_sidebars =3D {}
--=20
2.11.0


--Sig_/+Q2ZDCvK8guFHmIkhT+Ru1w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl0WXrEACgkQgNMC9Yht
g5zEiA//UWxO0D8Gj4guz7JvI59f1scnIIvc/bjVR5KM2wr1nDuL32FbRP4KjU0n
x5vWte2gM2GR5txA7SQAcuOmWd9+lLH25iKJVFug+0l0EcS8rtclH4B8YaPLU07H
D4dDsaN1sl4+w6aUlU7vEmD2ly+Xu3NlARutOhaIhHIyOpUVASkt2G+Rfb0bpNQs
YntKIwWPrnAUFYaFd5PXY3okqlLc4RNVT1TrKubS9pqgFMT6jPBMEYcbhbogH3ok
zta4ZdUHJfIMA7mPzVXHD0haoXFitn7CuvPqP7buOrjbke6Kw7YiR7ciidUZkxdp
1xqGzqzcF45K2j1lIyOOAr2e1Lmp8r2mNuZWZ+cJGT/zdR0tn9+VNGo0ZDUw8CGu
yNF3ho/tGaZ58cOmtfhLjoI2Ln0wOhObh9fiDy6TXKfjyBsDikc6JOcg9flwPhcU
c+GGxoNGj+Cw41drldqgM0I6Dm8Ir7osUbdz0/Pv5JjRu3aWWcrH684noM1NX28p
yazGhrtVDAHSEjePneKtya2NPjFyc8x1oAEFO62lRSuvtgILGIEionrKeRmaqfP6
KnRUa1BEUqRzV1fXnV5HTgDfq94Z6pqMdtmWZ4lAkq0xd2MvsAXiNKUTXNnUh1cI
7Cv2Z9PoehoZZRfgL9weSorwV1cFvZSCXpqHNxTeSmgqsaQWDn0=
=BYN7
-----END PGP SIGNATURE-----

--Sig_/+Q2ZDCvK8guFHmIkhT+Ru1w--
