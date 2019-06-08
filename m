Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D905C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 13:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E8D21537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 13:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfFHNdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 09:33:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:58748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726861AbfFHNdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 09:33:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5B91AF8C;
        Sat,  8 Jun 2019 13:33:35 +0000 (UTC)
Message-ID: <be9d7f2d3ede283cb6931c6edbb13c3fffa53b83.camel@suse.de>
Subject: Re: [PATCH] xhci: clear port_remote_wakeup after resume failure
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     oneukum@suse.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 08 Jun 2019 15:33:34 +0200
In-Reply-To: <9286ec05-d2a2-bd23-3397-b6a3623cad8f@linux.intel.com>
References: <20190524145231.6605-1-nsaenzjulienne@suse.de>
         <eb5d9252-1283-be73-96d6-c24a0fdf1eab@linux.intel.com>
         <e2dd83c5dbba1bb9bd300285285ab07135dc6166.camel@suse.de>
         <9286ec05-d2a2-bd23-3397-b6a3623cad8f@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-cRqm/SKreSIW7OXm1moF"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cRqm/SKreSIW7OXm1moF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-06-04 at 16:53 +0300, Mathias Nyman wrote:
> On 27.5.2019 14.28, Nicolas Saenz Julienne wrote:
> > Hi Matthias,
> > thanks for the review.
> >=20
> > On Mon, 2019-05-27 at 14:16 +0300, Mathias Nyman wrote:
> > > On 24.5.2019 17.52, Nicolas Saenz Julienne wrote:
> > > > This was seen on a Dell Precision 5520 using it's WD15 dock. The do=
ck's
> > > > Ethernet device interfaces with the laptop through one of it's USB3
> > > > ports. While idle, the Ethernet device and HCD are suspended by run=
time
> > > > PM, being the only device connected on the bus. Then, both are resu=
med
> > > > on
> > > > behalf of the Ethernet device, which has remote wake-up capabilitie=
s.
> > > >=20
> > > > The Ethernet device was observed to randomly disconnect from the US=
B
> > > > port shortly after submitting it's remote wake-up request. Probably=
 a
> > > > weird timing issue yet to be investigated. This causes runtime PM t=
o
> > > > busyloop causing some tangible CPU load. The reason is the port get=
s
> > > > stuck in the middle of a remote wake-up operation, waiting for the
> > > > device to switch to U0. This never happens, leaving "port_remote_wa=
keup"
> > > > enabled, and automatically triggering a failure on any further susp=
end
> > > > operation.
> > > >=20
> > > > This patch clears "port_remote_wakeup" upon detecting a device with=
 a
> > > > wrong resuming port state (see Table 4-9 in 4.15.2.3). Making sure =
the
> > > > above mentioned situation doesn't trigger a PM busyloop.
> > > >=20
> > >=20
> > > There was a similar case where the USB3 link had transitioned to a
> > > lower power U1 or U2 state after resume, before driver read the state=
,
> > > leaving port_remote_wakeup flag uncleared.
> > >=20
> > > This was fixed in 5.1 kernel by commit:
> > >=20
> > > 6cbcf59 xhci: Fix port resume done detection for SS ports with LPM en=
able
> > >=20
> > > Can you check if you have it?
> > > It should be in recent stable releases as well.
> >=20
> > I was aware of that patch, unfortunately it doesn't address the same is=
sue.
> > In
> > my case I never get a second port status event (so no PLC =3D=3D 1 or a=
ny state
> > change seen in PLS). The device simply disconnects from the bus.
> >=20
>=20
> I see, ok, then we need to clear the flag in the hub thread.
>=20
> But to me it looks like this patch could cause a small race risk in the
> successful
> device initiated resume cases.
>=20
> If the hub thread, i.e. the get_port_status() function, notices the U0 st=
ate
> before
> the interrupt handler, i.e. handle_port_status() function, then
> port_remote_wakeup
> flag is cleared in the hub thread and the wakeup notification is never ca=
lled
> from
> handle_port_status().
>=20
> Would it be enough to just check for (port_remote_wakeup flag &&
> !PORT_CONNECT) in the hub thread?
> USB3 PORT_CONNECT bit is lost in most error cases.

I get your concerns, there is a race indeed. On top of that, checking
PORT_CONNECT works fine for me.

So if I undertood your suggestion right, would this be fine?=20

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 3abe70ff1b1e..253957dc62de 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1057,6 +1057,9 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
                bus_state->resume_done[wIndex] =3D 0;
                clear_bit(wIndex, &bus_state->resuming_ports);
                usb_hcd_end_port_resume(&hcd->self, wIndex);
+       } else if (bus_state->port_remote_wakeup & (1 << port->hcd_portnum)=
 &&
+                  !(raw_port_status & PORT_CONNECT)) {
+               bus_state->port_remote_wakeup &=3D ~(1 << port->hcd_portnum=
);
        }
=20
        if (bus_state->port_c_suspend & (1 << wIndex))

Regards,
Nicolas


--=-cRqm/SKreSIW7OXm1moF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlz7uS4ACgkQlfZmHno8
x/4lVAf/TyAT8eaZIbbe6LfM3lKlrEaNIF+nzVTML9dn3//0w0NMFBBKbJ51EO6b
Y2PI4j33UKaaWtf+fXUh3hVFuRTWXjjH5gJ+QDBav4UgZxUQ4mKsooYqO+ciNKZb
1qevu+Z4XHCYou3UUukmbKiXhfsuvtr98vwwwQBBdpHJXVEQBSoiNgBmoHZDWvNL
26ov+w/+ZECF0Ofa8n5vUIGy66Pqg3ldWNF6R2YNwkea/iZRG/8sk1ZGXtVni7B7
gU3ARNIbn1HeHvuZvePUJhaSroUNzI3IqiD2DY9I2VK1PQG3mbiDBz9yRyM+enSX
beoGBT9DMOu2aS3u2Zwj2Hdl2Gt+7A==
=TuC8
-----END PGP SIGNATURE-----

--=-cRqm/SKreSIW7OXm1moF--

