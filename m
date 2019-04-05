Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC4DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF49217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+wqOj5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfDEIYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:24:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35683 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:24:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so6933801wrp.2;
        Fri, 05 Apr 2019 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vcAGVwffkChWM3GNFoyXAhcxCqnVacQuIbvdyotZLKw=;
        b=D+wqOj5H9LMk8ePCJOpYioa0Rw7DTfNr134f0UMxZiN6itl3HfgnDONtTWOEVPFEDe
         jjyehrvnr2abkKv6oB5lIplC8M81SQYjpOkJEcssFESGL14zFnS+2o3Y/XRi0MavlBen
         lJY6/frQncqiu14cZ/AlB2xECf96arwccJGT/PQej7P5QoZzICWpkXOrgHTmIdXFRc1l
         HWy6gcPMXfb6hulFuPwN8pwcXqquH71Fxso/mDNwGfEtsWv+Q7jcJ2EnGq60j2cPDucP
         AJgoTU2EJDXZmOJ8lI0bKg5/3RForJDH7uylOTm2VnErGt4h+dQ6I8la8zQRyR2q/UlK
         GMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vcAGVwffkChWM3GNFoyXAhcxCqnVacQuIbvdyotZLKw=;
        b=ICgGecQt1AahT/CSw/mK8N9mshCscziNxd49oBp7B/c2a82As7WrN9szdHjfRp3kI5
         shfd4Vb3Kzs80wV8YqVC+A8Q1lQ+RKyCcvu1RoBbtnKVEVYbTGsSBdx/z405bmDQN7sM
         6CdJR0TBp4DaqG4AbxAIHpKGf3SfyG7t+KEsVNUvEDI9ORY6xBeHFMWUYEWB2ofEOQvM
         LdJf/ROUbk1svYEgeFA+DZ7V95H0jVSNpS0G3bj1vN7qpCQnNddJCmy0iY7V7wZV3taZ
         qk/x1kDXCykqWoRFoAat/Of2c4cE46jXEkYZlsqP47M1cl+1haadOe+RG8jCaRZERbre
         s7Ag==
X-Gm-Message-State: APjAAAXYZKyKmG5hlXxariJ8TxIsCiO1ro8zbzXm4Qe1GJLkZOM8i6r8
        tzxUEq6PBAbDPfTA6XatEWQ=
X-Google-Smtp-Source: APXvYqzttcSB9L8/xHbgT9hliJXljIF7JaZ8SPAcN/UvUB9ScDaXc7l+aMjrsrFfsk/udvI4sja8cg==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr7535881wrq.200.1554452689218;
        Fri, 05 Apr 2019 01:24:49 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id w14sm15943843wrr.16.2019.04.05.01.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 01:24:48 -0700 (PDT)
Date:   Fri, 5 Apr 2019 09:24:47 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 3/4] vsock/virtio: change the maximum packet size
 allowed
Message-ID: <20190405082447.GD25152@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-4-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <20190404105838.101559-4-sgarzare@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 12:58:37PM +0200, Stefano Garzarella wrote:
> Since now we are able to split packets, we can avoid limiting
> their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
> Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
> packet size.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index f32301d823f5..822e5d07a4ec 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -167,8 +167,8 @@ static int virtio_transport_send_pkt_info(struct vsoc=
k_sock *vsk,
>  	vvs =3D vsk->trans;
> =20
>  	/* we can send less than pkt_len bytes */
> -	if (pkt_len > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE)
> -		pkt_len =3D VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> +	if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> +		pkt_len =3D VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;

The next line limits pkt_len based on available credits:

  /* virtio_transport_get_credit might return less than pkt_len credit */
  pkt_len =3D virtio_transport_get_credit(vvs, pkt_len);

I think drivers/vhost/vsock.c:vhost_transport_do_send_pkt() now works
correctly even with pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.

The other ->send_pkt() callback is
net/vmw_vsock/virtio_transport.c:virtio_transport_send_pkt_work() and it
can already send any size packet.

Do you remember why VIRTIO_VSOCK_MAX_PKT_BUF_SIZE still needs to be the
limit?  I'm wondering if we can get rid of it now and just limit packets
to the available credits.

Stefan

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpxDPAAoJEJykq7OBq3PIkwEIAKUcFcpFXgBx1Gbs5mSd4ypd
Yi7a6mc4wSbq/FLNhVo0xVjJA+7hSNxiUvsqbwr1ajpudAHbMoV9LEuVZqtRLBmM
pj9GmjHssqWgFr83oW1zlti/BNcArOoYl0csKoqfWXMA8sBb4o0ENdjlXwPvy+rm
aQE78BhRi0vHSpFlOs+Zc/KHaaeQuH0fufyjLSi4vFhWnOC4jpoXuPhCT2NAVCJA
MEdGNJZ2ZxtPBD8cUJH/ZTziNOArXsnOc6a9YIW72JnUOywqokVvgvsBtimaKN95
lbBsBCmPxd0rY4n3OTAssfnHbUVVNwYaVoysD39pWBwwd1ZL0J3kqpP2zPh/O7g=
=xs/A
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
