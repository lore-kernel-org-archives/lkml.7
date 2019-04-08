Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABD2C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CD621473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfDHPpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:45:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHPpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:45:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49C3781255;
        Mon,  8 Apr 2019 15:45:13 +0000 (UTC)
Received: from localhost (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F4715C1B4;
        Mon,  8 Apr 2019 15:45:06 +0000 (UTC)
Date:   Mon, 8 Apr 2019 16:45:05 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@gmail.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 3/4] vsock/virtio: change the maximum packet size
 allowed
Message-ID: <20190408154505.GA1333@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-4-sgarzare@redhat.com>
 <20190405082447.GD25152@stefanha-x1.localdomain>
 <20190405100747.dbwi3sjaudp3d2wa@steredhat>
 <20190408093723.GP15001@stefanha-x1.localdomain>
 <20190408145531.yreyawkn5vjqj7sl@steredhat>
 <20190408105619-mutt-send-email-mst@kernel.org>
 <20190408151735.itsfswajk5ww3ejv@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20190408151735.itsfswajk5ww3ejv@steredhat>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 08 Apr 2019 15:45:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 05:17:35PM +0200, Stefano Garzarella wrote:
> On Mon, Apr 08, 2019 at 10:57:44AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Apr 08, 2019 at 04:55:31PM +0200, Stefano Garzarella wrote:
> > > > Anyway, any change to this behavior requires compatibility so new g=
uest
> > > > drivers work with old vhost_vsock.ko.  Therefore we should probably=
 just
> > > > leave the limit for now.
> > >=20
> > > I understood your point of view and I completely agree with you.
> > > But, until we don't have a way to expose features/versions between gu=
est
> > > and host,
> >=20
> > Why not use the standard virtio feature negotiation mechanism for this?
> >=20
>=20
> Yes, I have this in my mind :), but I want to understand better if we can
> use virtio-net also for this mechanism.
> For now, I don't think limiting the packets to 64 KiB is a big issue.
>=20
> What do you think if I postpone this when I have more clear if we can
> use virtio-net or not? (in order to avoid duplicated work)

Yes, I agree.  VIRTIO has feature negotiation and we can use it to
change this behavior cleanly.

However, this will require a spec change and this patch series delivers
significant performance improvements that can be merged sooner than
VIRTIO spec changes.

Let's defer the max packet size change via VIRTIO feature bits.  It can
be done separately if we decide to stick to the virtio-vsock device
design and not virtio-net.

Stefan

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcq2yBAAoJEJykq7OBq3PIdLwIAJ53dUbUcSZ6WgyRyiz+7o7U
fmFk32nGiRNXGrXxnisvG+Zv0azKfxYNSFi0uP4tHqxCSjNlQDs0XayhrAjeywri
ZuycR6NdulGIqUpSf74hi7beBmcj1wAzotC9aiDCNoQnQ3IqYNzkz/8FWhOQO5T6
CpfPf5EKbPOw3FBAbFNL7m6TZR3SoEb7vkMK6tnGQ+SruDFdXBr4H5XvNcoOyUbX
BK03izf4SDpjMio8782ASOF4v8OeVkDJfbP/RGWFTtLOS9fHmGDOBRNp8iQayXWt
TjAgwkEmDDinRcRXifRz7i9lHhPdfBnmJmWpyW+tHcIAy4HMC2C6WXoMb5AvRvg=
=18t+
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
