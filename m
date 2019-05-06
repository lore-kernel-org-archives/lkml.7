Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC1DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE7B2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfEFP7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:59:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:60760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726413AbfEFP7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:59:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4DCC3ADDC;
        Mon,  6 May 2019 15:59:07 +0000 (UTC)
Message-ID: <686a4d50696a87b9cbe2a5908737ce91faec5313.camel@suse.de>
Subject: Re: [PATCH v2 2/3] staging: vchiq: revert "switch to
 wait_for_completion_killable"
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, phil@raspberrypi.org,
        stefan.wahren@i2se.com, Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Date:   Mon, 06 May 2019 17:59:04 +0200
In-Reply-To: <20190506152039.GT2239@kadam>
References: <20190506144030.29056-1-nsaenzjulienne@suse.de>
         <20190506144030.29056-3-nsaenzjulienne@suse.de>
         <20190506152039.GT2239@kadam>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HWk7wVSA1bmO90ELmSsB"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HWk7wVSA1bmO90ELmSsB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan, thanks for reviewing.

On Mon, 2019-05-06 at 18:20 +0300, Dan Carpenter wrote:
> On Mon, May 06, 2019 at 04:40:29PM +0200, Nicolas Saenz Julienne wrote:
> > @@ -1740,7 +1740,8 @@ parse_rx_slots(struct vchiq_state *state)
> >  					&service->bulk_rx : &service->bulk_tx;
> > =20
> >  				DEBUG_TRACE(PARSE_LINE);
> > -				if (mutex_lock_killable(&service->bulk_mutex)) {
> > +				if (mutex_lock_killable(
> > +					&service->bulk_mutex) !=3D 0) {
>=20
> This series does't add !=3D 0 consistently...  Personally, I would prefer
> we just leave it out.  I use !=3D 0 for two things.  1)  When I'm talking
> about the number zero.
>=20
> 	if (len =3D=3D 0) {
>=20
> Or with strcmp():
>=20
> 	if (strcmp(a, b) =3D=3D 0) { // a equals b
> 	if (strcmp(a, b) < 0) {  // a less than b.
>=20
> But here zero means no errors, so I would just leave it out...

I agree, I'll fix it.

Regards,
Nicolas


--=-HWk7wVSA1bmO90ELmSsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlzQWcgACgkQlfZmHno8
x/5C3Qf+L5Sma8zaKvvi3d9DSw4lZXBIQpyTCI5G81wW2l+4ax2oZnUNZlLpu7lj
sRJy5o+hSJExXkx/3b3oBUEojchKWCZPC7ZI76aq7uhRK93Q7Yf4jem9wUJvsOwf
kvsdFhSIO7F/gxfNfZUDn2whfAN5FPBvSTBqq3e++k/1+RTqe/y65rAbJIeIkmrL
s9qVV+DWownkHzfGwsVJ1paJmvrLuwYOlfsPXIlQk3y8g+GSClXRsCWvPJxeS4vi
2Qzs/+AB6kDiVzDdxj7YDF1puf1d4xliFfvMJnUR7iEdzOG0IQZAp+qMktTvOKX8
n//mOh1eQcHx4P/2ajTxj8/5P5Wieg==
=QGu9
-----END PGP SIGNATURE-----

--=-HWk7wVSA1bmO90ELmSsB--

