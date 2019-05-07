Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC5EC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3109A205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfEGPLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:11:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51859 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfEGPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:11:08 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1ABAA8023E; Tue,  7 May 2019 17:10:56 +0200 (CEST)
Date:   Tue, 7 May 2019 17:11:08 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Pavel Machek <pavel@denx.de>, alexander.shishkin@linux.intel.com,
        security@kernel.org, sasha.levin@oracle.com,
        gregkh@linuxfoundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, trivial@kernel.org
Subject: Re: stm class: Prevent user-controllable allocations
Message-ID: <20190507151108.GA16767@amd>
References: <20190507124113.GA659@amd>
 <20190507125027.GV2239@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20190507125027.GV2239@kadam>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-05-07 15:50:27, Dan Carpenter wrote:
> On Tue, May 07, 2019 at 02:41:13PM +0200, Pavel Machek wrote:
> >=20
> > It seems to me that we still allow overflow if count =3D=3D ~0. We'll t=
hen
> > allocate 0 bytes but copy ~0 bytes. That does not sound healthy.
> >=20
> > Fixes: f08b18266c7116e2ec6885dd53a928f580060a71
> >=20
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> >=20
> > diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> > index c7ba8ac..8846fca 100644
> > --- a/drivers/hwtracing/stm/core.c
> > +++ b/drivers/hwtracing/stm/core.c
> > @@ -631,7 +631,7 @@ static ssize_t stm_char_write(struct file *file, co=
nst char __user *buf,
> >  	char *kbuf;
> >  	int err;
> > =20
> > -	if (count + 1 > PAGE_SIZE)
> > +	if (count > PAGE_SIZE - 1)
> >  		count =3D PAGE_SIZE - 1;
>=20
> The "count" variable should all be checked in vfs_write().  count + off
> is checked in rw_verify_area() and count is capped at MAX_RW_COUNT.
>=20
> #define MAX_RW_COUNT (INT_MAX & PAGE_MASK)

Ok, so overflow is checked elsewhere. I'd still like patch to be
applied as it makes code more obvious.

Thanks,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzRoAwACgkQMOfwapXb+vLiBwCfW3/qUSRW/fU++mgIHK6ru0O2
GLQAn2G3OLDGFL9c06AtGq3JNfh2sSYI
=kTox
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
