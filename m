Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE43C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CAE20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfDHJX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:23:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfDHJXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:23:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BC733082B21;
        Mon,  8 Apr 2019 09:23:25 +0000 (UTC)
Received: from localhost (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C15315D9C9;
        Mon,  8 Apr 2019 09:23:19 +0000 (UTC)
Date:   Mon, 8 Apr 2019 10:23:18 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
 throughput
Message-ID: <20190408092318.GM15001@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404114643-mutt-send-email-mst@kernel.org>
 <20190404164715.sycigtccwq2rziuz@steredhat>
 <20190404140345-mutt-send-email-mst@kernel.org>
 <20190405074917.ooftpalmploq6x3b@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yaap9KN+GmBP785v"
Content-Disposition: inline
In-Reply-To: <20190405074917.ooftpalmploq6x3b@steredhat>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 08 Apr 2019 09:23:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yaap9KN+GmBP785v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 09:49:17AM +0200, Stefano Garzarella wrote:
> On Thu, Apr 04, 2019 at 02:04:10PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Apr 04, 2019 at 06:47:15PM +0200, Stefano Garzarella wrote:
> > > On Thu, Apr 04, 2019 at 11:52:46AM -0400, Michael S. Tsirkin wrote:
> > > > I simply love it that you have analysed the individual impact of
> > > > each patch! Great job!
> > >=20
> > > Thanks! I followed Stefan's suggestions!
> > >=20
> > > >=20
> > > > For comparison's sake, it could be IMHO benefitial to add a column
> > > > with virtio-net+vhost-net performance.
> > > >=20
> > > > This will both give us an idea about whether the vsock layer introd=
uces
> > > > inefficiencies, and whether the virtio-net idea has merit.
> > > >=20
> > >=20
> > > Sure, I already did TCP tests on virtio-net + vhost, starting qemu in
> > > this way:
> > >   $ qemu-system-x86_64 ... \
> > >       -netdev tap,id=3Dnet0,vhost=3Don,ifname=3Dtap0,script=3Dno,down=
script=3Dno \
> > >       -device virtio-net-pci,netdev=3Dnet0
> > >=20
> > > I did also a test using TCP_NODELAY, just to be fair, because VSOCK
> > > doesn't implement something like this.
> >=20
> > Why not?
> >=20
>=20
> I think because originally VSOCK was designed to be simple and
> low-latency, but of course we can introduce something like that.
>=20
> Current implementation directly copy the buffer from the user-space in a
> virtio_vsock_pkt and enqueue it to be transmitted.
>=20
> Maybe we can introduce a buffer per socket where accumulate bytes and
> send it when it is full or when a timer is fired . We can also introduce
> a VSOCK_NODELAY (maybe using the same value of TCP_NODELAY for
> compatibility) to send the buffer immediately for low-latency use cases.
>=20
> What do you think?

Today virtio-vsock implements a 1:1 sendmsg():packet relationship
because it's simple.  But there's no need for the guest to enqueue
multiple VIRTIO_VSOCK_OP_RW packets when a single large packet could
combine all payloads for a connection.  This is not the same as
TCP_NODELAY but related.

I think it's worth exploring TCP_NODELAY and send_pkt_list merging.
Hopefully it won't make the code much more complicated.

Stefan

--yaap9KN+GmBP785v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcqxMGAAoJEJykq7OBq3PITjwH/jr71No5QfyjmjTtKanTvBNm
ETbLBSbD/NXtjcvBfF3HVkiPyv2dNjB/cpAc8/dAVlvnMskaQHdeKIxeTZ9k//jC
dxUbXR6TYhYbQhwMQN8ra8GaxhlweNsjgjARXFw0Tl8ROSICLL881UhGJ7VseSkz
FR43QCE+HTQgZmBhmNg9wODD4mXZGyAKSDCkDsAk6SrJALV5RTXOI8lhRwi7Ro+e
ASS7b3XQXfbgn2gw37OIyehAY/vxo/PBQSFYAOOBIdNhQK4a+G/i2T0wOTN9yrxD
09/8JSvXIj97UPAO786QIFaUMYFvYsZJ5usFzBvIGntSvZMPLkyeDlUAw/Y1CUA=
=oVMF
-----END PGP SIGNATURE-----

--yaap9KN+GmBP785v--
