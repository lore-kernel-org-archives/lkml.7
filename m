Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCB4C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641CE208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbfDHJ2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:28:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfDHJ2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:28:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC6B47DCC4;
        Mon,  8 Apr 2019 09:28:15 +0000 (UTC)
Received: from localhost (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10C641C938;
        Mon,  8 Apr 2019 09:28:12 +0000 (UTC)
Date:   Mon, 8 Apr 2019 10:28:11 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@gmail.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 2/4] vhost/vsock: split packets to send using
 multiple buffers
Message-ID: <20190408092811.GO15001@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-3-sgarzare@redhat.com>
 <20190405081356.GC25152@stefanha-x1.localdomain>
 <20190405093608.f2zsyxnjxcba5v6r@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Sr6hGnsCY8KeifOY"
Content-Disposition: inline
In-Reply-To: <20190405093608.f2zsyxnjxcba5v6r@steredhat>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 08 Apr 2019 09:28:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr6hGnsCY8KeifOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 11:36:08AM +0200, Stefano Garzarella wrote:
> On Fri, Apr 05, 2019 at 09:13:56AM +0100, Stefan Hajnoczi wrote:
> > On Thu, Apr 04, 2019 at 12:58:36PM +0200, Stefano Garzarella wrote:
> > > -		vhost_add_used(vq, head, sizeof(pkt->hdr) + pkt->len);
> > > +		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
> > >  		added =3D true;
> > > =20
> > > +		pkt->off +=3D payload_len;
> > > +
> > > +		/* If we didn't send all the payload we can requeue the packet
> > > +		 * to send it with the next available buffer.
> > > +		 */
> > > +		if (pkt->off < pkt->len) {
> > > +			spin_lock_bh(&vsock->send_pkt_list_lock);
> > > +			list_add(&pkt->list, &vsock->send_pkt_list);
> > > +			spin_unlock_bh(&vsock->send_pkt_list_lock);
> > > +			continue;
> >=20
> > The virtio_transport_deliver_tap_pkt() call is skipped.  Packet capture
> > should see the exact packets that are delivered.  I think this patch
> > will present one large packet instead of several smaller packets that
> > were actually delivered.
>=20
> I'll modify virtio_transport_build_skb() to take care of pkt->off
> and reading the payload size from the virtio_vsock_hdr.
> Otherwise, should I introduce another field in virtio_vsock_pkt to store
> the payload size?

I don't remember the details but I trust you'll pick a good way of doing
it.

Stefan

--Sr6hGnsCY8KeifOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcqxQrAAoJEJykq7OBq3PIRNMH/RSv7+scItA1bhLrAepGRG8C
33Z8YoFCFwvbnEzOhreX/oBgQD2uKuXWeiuQvhnx2jEondkZcmspoTqAqA3YIr1C
3ujY9MsIfEmKoM4XLYhEnZ5bf5gZeBuWzPIWhhZJTF8N7fyIOIIV2XmFeVEOnRk0
U9PEDq3gGU50Z4Z2rmHDQIp9LswnDw2knzgQptXFRDhQh6GRql7n4d0GIMlLG1YI
AyBmxasATjVa7TYish3o7+bS1m5xXzqx7kBar1DfwLwhmn3wy4zhJKvLcjJiL9Rb
V1MiVGdVwhKcY7dlEhHd9cTpkuUQ2bXbY+WNlIX+9yByy7EMbb1Fk/Iqpdut190=
=bSSE
-----END PGP SIGNATURE-----

--Sr6hGnsCY8KeifOY--
