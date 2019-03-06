Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE48C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75E320661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfCFRCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:02:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfCFRCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:02:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DF5988305;
        Wed,  6 Mar 2019 17:02:18 +0000 (UTC)
Received: from localhost (ovpn-117-87.ams2.redhat.com [10.36.117.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F35855C647;
        Wed,  6 Mar 2019 17:02:17 +0000 (UTC)
Date:   Wed, 6 Mar 2019 17:02:16 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc:     Stefan Hajnoczi <stefanha@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: fix kernel panic from
 virtio_transport_reset_no_sock
Message-ID: <20190306170216.GC29057@stefanha-x1.localdomain>
References: <20190305180145.27161-1-alazar@bitdefender.com>
 <20190306084104.GA22159@stefanha-x1.localdomain>
 <1551863441.5559.19509.@c1753101230bd75c4bdbfe8f0947046bcaf69c6c>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <1551863441.5559.19509.@c1753101230bd75c4bdbfe8f0947046bcaf69c6c>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 06 Mar 2019 17:02:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 11:10:41AM +0200, Adalbert Laz=C4=83r wrote:
> On Wed, 6 Mar 2019 08:41:04 +0000, Stefan Hajnoczi <stefanha@gmail.com> w=
rote:
> > On Tue, Mar 05, 2019 at 08:01:45PM +0200, Adalbert Laz=C4=83r wrote:
> > The pkt argument is the received packet that we must reply to.
> > The reply packet is allocated just before line 680 and must be free
> > explicitly for return -ENOTCONN.
> >=20
> > You can avoid the leak and make the code easier to read like this:
> >=20
> >   struct virtio_vsock_pkt *reply;
> >=20
> >   ...
> >=20
> >      ------ avoid reusing 'pkt'
> >     v
> >   reply =3D virtio_transport_alloc_pkt(&info, 0, ...);
> >   if (!reply)
> >       return -ENOMEM;
> >=20
> >   t =3D virtio_transport_get_ops();
> >   if (!t) {
> >       virtio_transport_free_pkt(reply); <-- prevent memory leak
> >       return -ENOTCONN;
> >   }
> >   return t->send_pkt(reply);
>=20
> What do you think about Stefano's suggestion, to move the check above
> the line were the reply is allocated?

That's fine too.

However a follow up patch to eliminate the confusing way that 'pkt' is
reused is still warranted.  If you are busy I'd be happy to send that
cleanup.

Stefan

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcf/0YAAoJEJykq7OBq3PIs3AH/1reh3MukS2CTzKwSmGQGqBN
Ps+VDdzKgn+h+Rmr9t6vj3wrJI7T8omxUwcZzXjz45cJyY4UnqynrwvayMzZSLxi
V817uV3GAMrlRJzTQdnl5M5UEW7h6gdkOexKl92eUU5cl+H0SUhb8oeOhL+9SY7X
nuEaEQVfRiDeBGC62oUTfwwIVAQlkKyoLhE649PKl2lpP1UA+JwSaBFVQ/7RzLBo
fPK33EceZifQh95nd4vr6TZhBbu3F4wC44illc46C9i9yYLvHz7RmXoHOteXuNVP
TNLgyoLUMwiz7RCGn016JJ9MFCQBL7rA/JNuS4fo5DE2+ihx8kp8i58VnMEvPrs=
=nvm3
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
