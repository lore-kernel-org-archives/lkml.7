Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1256C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA6620706
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Qswa15m5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKNOZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:25:05 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:51292 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfKNOZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5XulJnFvb1esv73zwdr7LpI1USMGcyOoEDblHyY2CFI=; b=Qswa15m5QWtVTYuj+iFcNVg3w
        DE+LPqcZl6mOF39SV6DVinb4X6L6CqEmnFM6GqtivCd/970fK3sp7OhDkl+FWUdnVa6YrlviOU1YO
        pSVcPKkB7wq0tcbW15/KBR9RwYpvOoP84F3L26gj+wniwEGFTd4CzcABhThpgQnDBEXkk=;
Received: from [2a02:790:ff:1019:7ee9:d3ff:fe1f:a246] (helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iVG3S-000398-SJ; Thu, 14 Nov 2019 15:25:03 +0100
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iVG3P-0007nx-W7; Thu, 14 Nov 2019 15:25:00 +0100
Date:   Thu, 14 Nov 2019 15:24:51 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org, phh@phh.me,
        b.galvani@gmail.com, stefan@agner.ch
Subject: Re: [PATCH] regulator: rn5t618: fix rc5t619 ldo10 enable
Message-ID: <20191114152451.1756b0c8@kemnade.info>
In-Reply-To: <20191114115430.GA4664@sirena.co.uk>
References: <20191113182643.23885-1-andreas@kemnade.info>
        <20191113183211.GB4402@sirena.co.uk>
        <20191113202633.66a91d96@aktux>
        <20191114115430.GA4664@sirena.co.uk>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6eJ2mckA0YP7LEUPCwXUNxB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6eJ2mckA0YP7LEUPCwXUNxB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Nov 2019 11:54:30 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Nov 13, 2019 at 08:26:33PM +0100, Andreas Kemnade wrote:
> > Mark Brown <broonie@kernel.org> wrote: =20
>=20
> > > This definitely looks like a bug but without a datasheet or testing i=
t's
> > > worrying guessing at the register bit to use for the enable for the
> > > second LDO... =20
>=20
> > I am hoping for a Tested-By: from the one who has submitted the patch
> > for the regulator.  =20
>=20
> Or a reviewed-by from someone with access to the datasheet.
>=20
> > Well, it is not just guessing, it is there in the url I referenced. But
> > I would of course prefer a better source. At first I wanted to spread
> > my findings. =20
>=20
> The URL you provided looked to be for a different part though?
>=20
No, they just skip the rc5t in the name. Same situation in the vendor
kernel for my device, but there is only a tarball online, so it is bad
to reference. Everything is named there ricoh619 (or 61x). And on the chip =
is
printed rc5t619.

Regards,
Andreas

--Sig_/6eJ2mckA0YP7LEUPCwXUNxB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl3NY7MACgkQl4jFM1s/
ye/g9A/9FiQdmdvYsbCkzNxZ8HFOQ3XrgGyDeKR8gdTtUgvB+bBbFTeKsNXZFf8Y
QOEyk/B++a10qDHkJrgWOS+NDqgeUVpOnud44zv3T9yUxn6Df3enXQiX0Guja97e
2XFwXhlhfN7nReaYhPeF1lEEfF6t7Tcrq2lk+waD9PtC3si2/sQvGAYQW448Y3fX
X+CWpJTGrIDbkCF3Ofd1HxR65VoJZ8RTGWlY5ZcLt1+Xdh/E2kT9S65+cKHYoGOz
61ag3uU8eMAavFcvGt7OAuJoN7SuuWyrVx8xMO43tuvi7Cbbof2fAnLW+VPxhdci
NZrcg+ud63nSJ5GqBEPjN/F5J9sHi2FX0Ta4OuqyP58mbTdhjNWTVUVaDpJz3jWm
W+xPdNnwjRVQ/8jZAZcW3LrV3mGAUr9+Yz2mbAOGIJLPALb92JqCn2P3ILE+D71I
7L1l3h7YnK+U2+2t3oH4bXlZa1FEo0OQtc63qpkdTvjWeM70U2+DhTWcCjTWaSbk
mbkUVW/1kAN+I7eSHzduZHLVs1u7A+bSUwLzMGkzGSOksJ/l6byCt9MWDqtVCW+s
lnswECMbL4z8Rb9wv+JN2XG/fqmt2MRwTj9XHf7U/2+kkUa5vDa0HbD+Rhgnxyzl
JV5rUjnXA8COMLzdQTnU5LUwOG9qG4WhwGlP6KffaOfszbd0O0A=
=Ztlb
-----END PGP SIGNATURE-----

--Sig_/6eJ2mckA0YP7LEUPCwXUNxB--
