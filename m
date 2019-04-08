Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBADCC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9364920883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDHJZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:25:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfDHJZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:25:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9754B308FC5E;
        Mon,  8 Apr 2019 09:25:43 +0000 (UTC)
Received: from localhost (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 004775D9C9;
        Mon,  8 Apr 2019 09:25:40 +0000 (UTC)
Date:   Mon, 8 Apr 2019 10:25:39 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@gmail.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 1/4] vsock/virtio: reduce credit update messages
Message-ID: <20190408092539.GN15001@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-2-sgarzare@redhat.com>
 <20190404191539.GB25152@stefanha-x1.localdomain>
 <20190405081648.2zflr7gxknk4q3a2@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="K4LMwn8CgX2KMboP"
Content-Disposition: inline
In-Reply-To: <20190405081648.2zflr7gxknk4q3a2@steredhat>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 08 Apr 2019 09:25:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K4LMwn8CgX2KMboP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 10:16:48AM +0200, Stefano Garzarella wrote:
> On Thu, Apr 04, 2019 at 08:15:39PM +0100, Stefan Hajnoczi wrote:
> > On Thu, Apr 04, 2019 at 12:58:35PM +0200, Stefano Garzarella wrote:
> > >  	int err =3D -EFAULT;
> > > =20
> > >  	spin_lock_bh(&vvs->rx_lock);
> > > @@ -288,9 +290,15 @@ virtio_transport_stream_do_dequeue(struct vsock_=
sock *vsk,
> > >  	}
> > >  	spin_unlock_bh(&vvs->rx_lock);
> > > =20
> > > -	/* Send a credit pkt to peer */
> > > -	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
> > > -					    NULL);
> > > +	/* We send a credit update only when the space available seen
> > > +	 * by the transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
> > > +	 */
> > > +	free_space =3D vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
> >=20
> > Locking?  These fields should be accessed under tx_lock.
> >=20
>=20
> Yes, we need a lock, but looking in the code, vvs->fwd_cnd is written
> taking rx_lock (virtio_transport_dec_rx_pkt) and it is read with the
> tx_lock (virtio_transport_inc_tx_pkt).
>=20
> Maybe we should use another spin_lock shared between RX and TX for those
> fields or use atomic variables.
>=20
> What do you suggest?

Or make vvs->fwd_cnt atomic if it's the only field that needs to be
accessed in this manner.

Stefan

--K4LMwn8CgX2KMboP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcqxOTAAoJEJykq7OBq3PIZMYH/1TEHAKZjxIg1G2ajVhnFTbZ
OFodA0ipnYIhsKDvhulux8zPhKa/dHkxBcWAKyBmMHdQ7CuwGAGSmXl8+wvQJt91
AGkSXajUCMjW7ZBL0BLGtapphp/Rjam/9udW9YjTPHiOfOgc55h7oAHmNatTSDFF
o9vRzFlJnqvAOA+06XB4ss3hALFebZjF50+c+yk/2d6UiMLADwjjqDANmJ9e8Vbl
W4nTbFwpdLRkMn+VU8MtdJqFk+rvgvPPBRARV9wHVWS8CET8wJseU3zgDfTlajK9
/22u/jzh++RQiHJ4nExEj9o93xWEatPblEPOmhvgR633SOjouPAeAwkDQFi9gRA=
=hXkx
-----END PGP SIGNATURE-----

--K4LMwn8CgX2KMboP--
