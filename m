Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B285C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6941020855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MToP0eK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfDEIOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:14:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40074 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:14:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so6864143wre.7;
        Fri, 05 Apr 2019 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0VcpK5Q6ngN+ePl+877sP/2Ba6h9t5x0sJntr0IIDPg=;
        b=MToP0eK3sVUiSYrGQwzXXeZLm+xgPwG8JG6Y+cYiLPKKAdfyQgqVhZriQcdZj07vOo
         wa2wMuttmchdxdqrZFlQXqSKQEiZjfRHcNBz0EPu1t8AVjqIlevWE+WuPySKJlSLx5WL
         Xj3ZluRStorqs4Szdd0BSRdqJlTc8jJxJvCUn44gPIGFQoKCzC2nHH3ILbRXIjiXegal
         mU91jdvQzMW5cJrm/SHXkbcUsyiBo85Qaql3vaDnogr1yRVPfxY+DxrQA08RoRvkiaSL
         Piqxop4XZlpTRiKpPZhfR84EAFp1lPIqhfLZ1+Lx+8gpIwXtWnUmW+BbvxwVyz+UbHrx
         cmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0VcpK5Q6ngN+ePl+877sP/2Ba6h9t5x0sJntr0IIDPg=;
        b=JqR/fq1MJBHXIXQvcPiKl6u3SmLkW4IhCEaLEKGAbESygiUxSgoNDz17kPEthB8YNJ
         4clnUm7tyRO+omCybL4SS7yMh+msesxyPy1kc8rwbr9NKbRRbOVOCRUz8GT8qK1Nu/MY
         XYksqnzeT8DZSo8qUUC1YsvYIyuihremObMViv/p367W4Qcr5QwYAtPqofeXzaXuzXvM
         Kj47d+qAHsuWynH7+qAIzicZ530/YYpWJwI4aC59xC3pshjgh6Gh5PKSUoKmI4dBvtg1
         3/54HSsLuS9JaxhSGdfDDblTSP/KChFW1ct7b88vFl3Rc/FWl1vTWbtrUgzsCoCH0qW1
         nWbA==
X-Gm-Message-State: APjAAAXht9HJjKkr9ITX8QKYwKMyOOp39W9P/TYisvqQbfhg/5O8KXtU
        shf4vJRXL3qSm3tylbV0xD0=
X-Google-Smtp-Source: APXvYqyl+TEf8iEjReoNv9xSjIpvgd/nEH1X30+h5CcSNtQ8bN/ziXbY6zYeta9+dG44Y3RZqz91UQ==
X-Received: by 2002:adf:fd86:: with SMTP id d6mr7033436wrr.15.1554452038189;
        Fri, 05 Apr 2019 01:13:58 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id e9sm33922310wrp.35.2019.04.05.01.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 01:13:56 -0700 (PDT)
Date:   Fri, 5 Apr 2019 09:13:56 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 2/4] vhost/vsock: split packets to send using
 multiple buffers
Message-ID: <20190405081356.GC25152@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-3-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <20190404105838.101559-3-sgarzare@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 12:58:36PM +0200, Stefano Garzarella wrote:
> @@ -139,8 +139,18 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsoc=
k,
>  			break;
>  		}
> =20
> -		len =3D iov_length(&vq->iov[out], in);
> -		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, len);
> +		payload_len =3D pkt->len - pkt->off;
> +		iov_len =3D iov_length(&vq->iov[out], in);
> +		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, iov_len);
> +
> +		/* If the packet is greater than the space available in the
> +		 * buffer, we split it using multiple buffers.
> +		 */
> +		if (payload_len > iov_len - sizeof(pkt->hdr))

Integer underflow.  iov_len is controlled by the guest and therefore
untrusted.  Please validate iov_len before assuming it's larger than
sizeof(pkt->hdr).

> -		vhost_add_used(vq, head, sizeof(pkt->hdr) + pkt->len);
> +		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
>  		added =3D true;
> =20
> +		pkt->off +=3D payload_len;
> +
> +		/* If we didn't send all the payload we can requeue the packet
> +		 * to send it with the next available buffer.
> +		 */
> +		if (pkt->off < pkt->len) {
> +			spin_lock_bh(&vsock->send_pkt_list_lock);
> +			list_add(&pkt->list, &vsock->send_pkt_list);
> +			spin_unlock_bh(&vsock->send_pkt_list_lock);
> +			continue;

The virtio_transport_deliver_tap_pkt() call is skipped.  Packet capture
should see the exact packets that are delivered.  I think this patch
will present one large packet instead of several smaller packets that
were actually delivered.

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpw5DAAoJEJykq7OBq3PIJgcIALZ1RYiVNTOBUmwCwEEblxaw
fJC/J3itodETbLSey5X8x6dJhkwH+34HkZvYoGAh/mx31OLS/Z4+BCNuUVokPHST
yd7Wa0XAzQTd6N0b826X3iwJDavCbiSJLTmTK5LNOaRX1tDY8BYKjhWHhJS4y3CG
RJfHKM9Uo0e9viKDXuCzLbR+/CX4C0nPV4/f0N7x9nfAuqIsojiLKCZqaZylKO66
4UWWnr6PuhoCqtnjzOG5OM/QRO05I7yCW3/hAN8kU3e58yPVlke4d4vGrZzBvLfS
D0z2dW6xwhG33B0p4qNkPhg1KUxd6OaR4i36OA7Qd+36sLPNCxV8Z0yGbvi++CI=
=sM71
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
