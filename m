Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2774C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF1120859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfE0L2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:28:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:36310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbfE0L2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:28:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3A54ACFA;
        Mon, 27 May 2019 11:28:50 +0000 (UTC)
Message-ID: <e2dd83c5dbba1bb9bd300285285ab07135dc6166.camel@suse.de>
Subject: Re: [PATCH] xhci: clear port_remote_wakeup after resume failure
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     oneukum@suse.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 May 2019 13:28:48 +0200
In-Reply-To: <eb5d9252-1283-be73-96d6-c24a0fdf1eab@linux.intel.com>
References: <20190524145231.6605-1-nsaenzjulienne@suse.de>
         <eb5d9252-1283-be73-96d6-c24a0fdf1eab@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-f7bqoOZL4zNS+o7sGeVu"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f7bqoOZL4zNS+o7sGeVu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthias,
thanks for the review.

On Mon, 2019-05-27 at 14:16 +0300, Mathias Nyman wrote:
> On 24.5.2019 17.52, Nicolas Saenz Julienne wrote:
> > This was seen on a Dell Precision 5520 using it's WD15 dock. The dock's
> > Ethernet device interfaces with the laptop through one of it's USB3
> > ports. While idle, the Ethernet device and HCD are suspended by runtime
> > PM, being the only device connected on the bus. Then, both are resumed =
on
> > behalf of the Ethernet device, which has remote wake-up capabilities.
> >=20
> > The Ethernet device was observed to randomly disconnect from the USB
> > port shortly after submitting it's remote wake-up request. Probably a
> > weird timing issue yet to be investigated. This causes runtime PM to
> > busyloop causing some tangible CPU load. The reason is the port gets
> > stuck in the middle of a remote wake-up operation, waiting for the
> > device to switch to U0. This never happens, leaving "port_remote_wakeup=
"
> > enabled, and automatically triggering a failure on any further suspend
> > operation.
> >=20
> > This patch clears "port_remote_wakeup" upon detecting a device with a
> > wrong resuming port state (see Table 4-9 in 4.15.2.3). Making sure the
> > above mentioned situation doesn't trigger a PM busyloop.
> >=20
>=20
> There was a similar case where the USB3 link had transitioned to a
> lower power U1 or U2 state after resume, before driver read the state,
> leaving port_remote_wakeup flag uncleared.
>=20
> This was fixed in 5.1 kernel by commit:
>=20
> 6cbcf59 xhci: Fix port resume done detection for SS ports with LPM enable
>=20
> Can you check if you have it?
> It should be in recent stable releases as well.

I was aware of that patch, unfortunately it doesn't address the same issue.=
 In
my case I never get a second port status event (so no PLC =3D=3D 1 or any s=
tate
change seen in PLS). The device simply disconnects from the bus.

I did test both the issue and fix on top of last week's master branch.

Regards,
Nicolas


--=-f7bqoOZL4zNS+o7sGeVu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlzryfAACgkQlfZmHno8
x/7FdQf/U6VLTEYpri+b7l4Jk/VsmleJAOXb709TIDyiCJPapRA7jo0DVWUtwIm9
dPfI8mJlVXCnIvL04p/tzfv8zxH6TDa6rV7//+71CqiRpg3KsYHoZWxS2X9X/W5i
Vuj6hJAa7ziaZI1M5UEhjWXAX+8WF9bABcy2Wyrk2U5V+neadU70Fod5ap3fkZRT
qELPOLsHRTorYIl9/Kj5M7vHEpJehaBJ8DZTjfGCunvDdeSNfA2nROBMZ3s1k/gq
be8/lAoh3xX7Iv3KInny9QihssiHsMBHNjCb1aPnkw3oMM5CxNJLoCGGIO5pkExV
UfACpCWZb0bIrZjUbsaYpIDDerlbHg==
=d8YU
-----END PGP SIGNATURE-----

--=-f7bqoOZL4zNS+o7sGeVu--

