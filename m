Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D9EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C132175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfCSOyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:54:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:59950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727796AbfCSOyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:54:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84106AEDB;
        Tue, 19 Mar 2019 14:54:23 +0000 (UTC)
Message-ID: <82718bec37e4e16e0a08b3b7a00452f99adc707b.camel@suse.de>
Subject: Re: [RFC] xhci: clear port_remote_wakeup on device disconnection
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Oliver Neukum <oneukum@suse.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Tue, 19 Mar 2019 15:54:21 +0100
In-Reply-To: <1552993288.14757.23.camel@suse.com>
References: <20190318170038.23914-1-nsaenzjulienne@suse.de>
         <1552993288.14757.23.camel@suse.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hrJ5oEi+27biUjjbRyRr"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hrJ5oEi+27biUjjbRyRr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver, thanks for the review!

On Tue, 2019-03-19 at 12:01 +0100, Oliver Neukum wrote:
> On Mo, 2019-03-18 at 18:00 +0100, Nicolas Saenz Julienne wrote:
> > This patch clears "port_remote_wakeup" upon detecting a device
> > disconnection. Making sure the above mentioned situation doesn't trigge=
r
> > a PM busyloop.
>=20
> Hi,
>=20
> that is an interesting race condition.
>=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/usb/host/xhci-hub.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> > index e2eece693655..bea853f45aec 100644
> > --- a/drivers/usb/host/xhci-hub.c
> > +++ b/drivers/usb/host/xhci-hub.c
> > @@ -942,6 +942,9 @@ static void xhci_get_usb3_port_status(struct xhci_p=
ort
> > *port, u32 *status,
> >  			bus_state->suspended_ports &=3D ~(1 << portnum);
> >  	}
> > =20
> > +	if (!(portsc & PORT_CONNECT))
> > +		bus_state->port_remote_wakeup &=3D ~(1 << portnum);
> > +
> >  	xhci_hub_report_usb3_link_state(xhci, status, portsc);
> >  	xhci_del_comp_mod_timer(xhci, portsc, portnum);
> >  }
>=20
> Why are you putting that logic into xhci_get_usb3_port_status()?
> It looks to me like there is already something related in the caller
>=20
>         /* USB2 and USB3 specific bits, including Port Link State */
>         if (hcd->speed >=3D HCD_USB3)
>                 xhci_get_usb3_port_status(port, &status, raw_port_status)=
;
>         else
>                 xhci_get_usb2_port_status(port, &status, raw_port_status,
>                                           flags);
>         /*
>          * Clear stale usb2 resume signalling variables in case port chan=
ged
>          * state during resume signalling. For example on error
>          */
>         if ((bus_state->resume_done[wIndex] ||
>              test_bit(wIndex, &bus_state->resuming_ports)) &&
>             (raw_port_status & PORT_PLS_MASK) !=3D XDEV_U3 &&
>             (raw_port_status & PORT_PLS_MASK) !=3D XDEV_RESUME) {
>                 bus_state->resume_done[wIndex] =3D 0;
>                 clear_bit(wIndex, &bus_state->resuming_ports);
>                 usb_hcd_end_port_resume(&hcd->self, wIndex);
>         }

You're right, xhci_get_usb3_port_status() is not the ideal spot I'll move t=
he
code there.

>=20
> Otherwise very good catch!
>=20
> 	Regards
> 		Oliver
>=20


--=-hrJ5oEi+27biUjjbRyRr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlyRAp0ACgkQlfZmHno8
x/5xKggAh60f8vcSfHomWuQMyLMvdjD+RBq4q+xHkxE0qeBPSCqVVQjfsfW8E0C0
xXxB1rBzD0sSo1loitt0AK/O+FB984UQwogfyOjcOEktxCl0MFbg+v6/ZEEq0fT1
luH3WuJs5Y21oYKsjxTlIU8ufqEWaBMn0JELrbaX0CbhhWeazWDApnHKqsXVtGGL
MMcGTXb9H7fXxikt9OvodqTSkIApmyvVIaDbzg0t1MuLVYT0pwNJuww9HWnqFvGT
la6ii4QpJAOoRd/2i0TR1otExn15o3TvkVQsPzd9aorvHIozvYRjvAekS2gciqIJ
kv7i+CAnyzVeuk2J2DvA3KQM9k8/OQ==
=SSCt
-----END PGP SIGNATURE-----

--=-hrJ5oEi+27biUjjbRyRr--

