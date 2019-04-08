Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C8FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2735520880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDHJh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:37:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfDHJh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:37:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FA3531028F1;
        Mon,  8 Apr 2019 09:37:27 +0000 (UTC)
Received: from localhost (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94C9960851;
        Mon,  8 Apr 2019 09:37:24 +0000 (UTC)
Date:   Mon, 8 Apr 2019 10:37:23 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@gmail.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 3/4] vsock/virtio: change the maximum packet size
 allowed
Message-ID: <20190408093723.GP15001@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-4-sgarzare@redhat.com>
 <20190405082447.GD25152@stefanha-x1.localdomain>
 <20190405100747.dbwi3sjaudp3d2wa@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R3SAtXwgGp429mN7"
Content-Disposition: inline
In-Reply-To: <20190405100747.dbwi3sjaudp3d2wa@steredhat>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 08 Apr 2019 09:37:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R3SAtXwgGp429mN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 12:07:47PM +0200, Stefano Garzarella wrote:
> On Fri, Apr 05, 2019 at 09:24:47AM +0100, Stefan Hajnoczi wrote:
> > On Thu, Apr 04, 2019 at 12:58:37PM +0200, Stefano Garzarella wrote:
> > > Since now we are able to split packets, we can avoid limiting
> > > their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
> > > Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
> > > packet size.
> > >=20
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/=
virtio_transport_common.c
> > > index f32301d823f5..822e5d07a4ec 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -167,8 +167,8 @@ static int virtio_transport_send_pkt_info(struct =
vsock_sock *vsk,
> > >  	vvs =3D vsk->trans;
> > > =20
> > >  	/* we can send less than pkt_len bytes */
> > > -	if (pkt_len > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE)
> > > -		pkt_len =3D VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> > > +	if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> > > +		pkt_len =3D VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
> >=20
> > The next line limits pkt_len based on available credits:
> >=20
> >   /* virtio_transport_get_credit might return less than pkt_len credit =
*/
> >   pkt_len =3D virtio_transport_get_credit(vvs, pkt_len);
> >=20
> > I think drivers/vhost/vsock.c:vhost_transport_do_send_pkt() now works
> > correctly even with pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
>=20
> Correct.
>=20
> >=20
> > The other ->send_pkt() callback is
> > net/vmw_vsock/virtio_transport.c:virtio_transport_send_pkt_work() and it
> > can already send any size packet.
> >=20
> > Do you remember why VIRTIO_VSOCK_MAX_PKT_BUF_SIZE still needs to be the
> > limit?  I'm wondering if we can get rid of it now and just limit packets
> > to the available credits.
>=20
> There are 2 reasons why I left this limit:
> 1. When the host receives a packets, it must be <=3D
>    VIRTIO_VSOCK_MAX_PKT_BUF_SIZE [drivers/vhost/vsock.c:vhost_vsock_alloc=
_pkt()]
>    So in this way we can limit the packets sent from the guest.

The general intent is to prevent the guest from sending huge buffers.
This is good.

However, the guest must already obey the credit limit advertized by the
host.  Therefore I think we should be checking against that instead of
an arbitrary constant limit.

So I think the limit should be the receive buffer size, not
VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.  But at this point the code doesn't know
which connection the packet is associated with and cannot check the
receive buffer size. :(

Anyway, any change to this behavior requires compatibility so new guest
drivers work with old vhost_vsock.ko.  Therefore we should probably just
leave the limit for now.

> 2. When the host send packets, it help us to increase the parallelism
>    (especially if the guest has 64 KB RX buffers) because the user thread
>    will split packets, calling multiple times transport->stream_enqueue()
>    in net/vmw_vsock/af_vsock.c:vsock_stream_sendmsg() while the
>    vhost_transport_send_pkt_work() send them to the guest.

Sorry, I don't understand the reasoning.  Overall this creates more
work.  Are you saying the benefit is that
vhost_transport_send_pkt_work() can run "early" and notify the guest of
partial rx data before all of it has been enqueued?

Stefan

--R3SAtXwgGp429mN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcqxZTAAoJEJykq7OBq3PIjDMH/0mW2RMt9MmR8x9kN886jFZQ
PP5AEzRl/JPaqRtzo2ckvFJrgIbbRx5f8Behl2zOX5UlqNFz0HKW8LH3x/Ex+bpB
rPnvD6T4zkZ9GRunB2Pew99Kg3p0fb8WzIQlnoDobepystkcxTHKxC0QMSosOPXT
o9RMU2KwAD38E9l74FrnrODMKnYyrnjpMzSRECg7yvF2jN7yu1QNjlBDX4c5SanL
NivUhHTx7o16bs6Zt+ClLw+zel3GkM6jlgsjiX7tchDct3Q6TCW+L2NYRXxPrnuz
vi0fY9CRvMA3lUui4bIE4i/5BgBJc1YxVbR3DNNnJUU39NKG66flMf7YDPRPzyE=
=E+n0
-----END PGP SIGNATURE-----

--R3SAtXwgGp429mN7--
