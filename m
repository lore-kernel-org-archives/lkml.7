Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D5CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45AB206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im6isl7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbfDDTPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:15:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54715 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730103AbfDDTPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:15:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so4289634wml.4;
        Thu, 04 Apr 2019 12:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BqpfFvICUg1IPmvDH1zD8aD1L9qHqmlYKJ8+16JkwxA=;
        b=Im6isl7rDhepK7w97jdSjBFF8PkuilsscG5Ekmtqhq+/HKNo9nZzq5I+7oQwxv5N3h
         bzPf6bi2DWtl4vkumiMX+5xh5pLnFjo4eyGdX3TF8Xqlcnc8Ky+HDJ6VOgXcazsgujOF
         2KZunFHIKND3x7eXsH97QRMm3mqWiXjyx6PHk8xQloLcTdeOFKyIev6gr1rWs1Gm/ZmV
         QZDGphHIi4QY6ZqO5OEPlv6CP7GoiHQxQLAGY71nXsO+y8rkvmwu7mvqSfynJrFPsSuZ
         bVVqRbMyFm3fS4ziK/g8bHGN1zqCvp7xM+W0XdIH8YsZ0sykV1Jffj9XaODTssLyPiim
         YNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BqpfFvICUg1IPmvDH1zD8aD1L9qHqmlYKJ8+16JkwxA=;
        b=iXuLnrLVBtjdiUR4rksSlwa1yaAu/fFy2YmDPETl1UChPsbutYyHBETz0yssfWqrfN
         7k/Y2V0efn65A82KidxNmLBx3/GqWiCsvtGpnCDbBdzpX9LERd4H0syfNI4gfvVOwPNK
         bSnrVqhhU6q2+69k/ZT0nCoOBNtTVqEVjcPgeb6E1MS8HzC21GGZ9Iwotg7Ds8CcL4yM
         v9p/bVIbE9IAz+k4oUW0wic4ZleKdDzfDPBaEavG0ovwJArut4Lr5sR/G/SndHVGu0dm
         tHEMdCAJ9OR+PF5cF/z44ArNha9OKOd0MB40W06QxgLQczzjheXBaReINl/qA+l0XLE6
         hRUg==
X-Gm-Message-State: APjAAAW+EBKXsSxolAs8rY/eMckpl9QB9v9ZUNXyvbdyVy9ytkXnIyjJ
        0TeU1dFsdQPetzvv2kbD+Bg=
X-Google-Smtp-Source: APXvYqxxVdybZfOQLYMwWeB9TcY3YVIv07Agg9kO/95Luxoy9mU3RHqijz5IvSvxcvg1OBwHVx7whw==
X-Received: by 2002:a1c:1b45:: with SMTP id b66mr5335460wmb.77.1554405341290;
        Thu, 04 Apr 2019 12:15:41 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id z8sm18068861wrh.80.2019.04.04.12.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 12:15:40 -0700 (PDT)
Date:   Thu, 4 Apr 2019 20:15:39 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 1/4] vsock/virtio: reduce credit update messages
Message-ID: <20190404191539.GB25152@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-2-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <20190404105838.101559-2-sgarzare@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 12:58:35PM +0200, Stefano Garzarella wrote:
> @@ -256,6 +257,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock =
*vsk,
>  	struct virtio_vsock_sock *vvs =3D vsk->trans;
>  	struct virtio_vsock_pkt *pkt;
>  	size_t bytes, total =3D 0;
> +	s64 free_space;

Why s64?  buf_alloc, fwd_cnt, and last_fwd_cnt are all u32.  fwd_cnt -
last_fwd_cnt <=3D buf_alloc is always true.

>  	int err =3D -EFAULT;
> =20
>  	spin_lock_bh(&vvs->rx_lock);
> @@ -288,9 +290,15 @@ virtio_transport_stream_do_dequeue(struct vsock_sock=
 *vsk,
>  	}
>  	spin_unlock_bh(&vvs->rx_lock);
> =20
> -	/* Send a credit pkt to peer */
> -	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
> -					    NULL);
> +	/* We send a credit update only when the space available seen
> +	 * by the transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
> +	 */
> +	free_space =3D vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);

Locking?  These fields should be accessed under tx_lock.

> +	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
> +		virtio_transport_send_credit_update(vsk,
> +						    VIRTIO_VSOCK_TYPE_STREAM,
> +						    NULL);
> +	}

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcplfbAAoJEJykq7OBq3PI2uYIALQfLRpQHKb7GaCRjoDssVSe
XlSjQ47uP6LdmnzrkmFy2QtA0UCQS8fZdFbvu4wReh9dcDk+jQAno2Xzuwv6sTzu
cJ+uknZzmMmZarWh3m4w5ooIM4p7GO8HFWbCr9Sq6nS9aAw1N1YpGjB6JvtAZJuE
vIOHRa3rZ/aQ/Xil907cKLWyXwYMWEfeAnD+ujUr5zkyQyuUrYlck7YW9gPas3c+
ClvvF+uYnvq9tf1exel6NwPvnjmtG+1aTDtIuqrv0Af/QqryUuD64UDkybOHGRlZ
4rIsRIsRZHTsyleB/oJPANE/L0bNzDfCpxvyfSBps6b5bIR4rJ8AqvRrDE+82uI=
=9/y/
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
