Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C27FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BA0206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLBGpLwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfDEIoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:44:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41517 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEIoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:44:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so6962318wrq.8;
        Fri, 05 Apr 2019 01:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xIS2CQxQf9TcEXWFdWdbRhxYcwgstEigJMkG4x8kPB0=;
        b=ZLBGpLwy3hcuYfns8pVP8c4L71bgX312Z8lNKOxy4sryxcm8RhwIlthx9RygZIgq3g
         3t1doEKW31OfQt7En/ScVEIhV8oIgos9baWjg0lmynOWjnriEUUmSI08fFuy/FEKlHGX
         j1Td/gjAKU1TIHzj4cu4v37c3HzBekF4dPa4kk9ZpyzZuUUGIP4Gj4NwKsrx2lpmIfel
         BJ2sKhz3hsb3gZd1lM1FbHDiTUqVuwqHYJERGci6rJ4oNV/Ik/DU5fWmEzjw/j6QebJ0
         LfPW3iZ8hXGzI+x8qf84s1njROIAMdXrGjHYPzNkNF2kXzElxuGa6WTnPoVGuIzKeZr+
         v0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xIS2CQxQf9TcEXWFdWdbRhxYcwgstEigJMkG4x8kPB0=;
        b=kVugPbh2ctpIk44jeFV78Xk8FrHQXNRmCjFGSfj7V8C5S7uecpteFQRUoqBJ8bedK4
         S+MLgwIR7diKtebgA114mqAfa1iaiVM1vLV0zZtt0fjvPIlAntv+/cTS8QDw14USx1uJ
         V2GwvYcBwO5UvkMBZBmtocONN42fGQPhHWm7GOrJheuvArH5/ZGf2jG8zzLUkUEyZbBb
         IPjyB1+AUixItF4eNeES0twqBe3eVQsW+KwfSRwDx4Gqzh9Qn33cExKJKXlLLWjKCebt
         g2glNrtnEhwmXZir4d8pbqKNZJ37r0VGh718d/Abv6WAMvVmdNbL5W5pYY8ljpspN64Z
         4xMA==
X-Gm-Message-State: APjAAAUBoCvaFY2gViQ0VC/gb7lViGRzAOrcwv4iylIK9FtKB0eJ6SdI
        ytGzGWraeYXpSaxyQsef7OUXHsdt
X-Google-Smtp-Source: APXvYqwJL+EjllmmolpZVxpbHAGIRD2uX1T2ZJjtBYMYp9Nf6tWhuKGB2UjQ0OpDlXLQVAhGAJU/fg==
X-Received: by 2002:a05:6000:1250:: with SMTP id j16mr7374631wrx.135.1554453856542;
        Fri, 05 Apr 2019 01:44:16 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id p6sm14425275wrs.6.2019.04.05.01.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 01:44:15 -0700 (PDT)
Date:   Fri, 5 Apr 2019 09:44:14 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC 4/4] vsock/virtio: increase RX buffer size to 64 KiB
Message-ID: <20190405084414.GE25152@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-5-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline
In-Reply-To: <20190404105838.101559-5-sgarzare@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 12:58:38PM +0200, Stefano Garzarella wrote:
> In order to increase host -> guest throughput with large packets,
> we can use 64 KiB RX buffers.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/virtio_vsock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index 6d7a22cc20bf..43cce304408e 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -10,7 +10,7 @@
>  #define VIRTIO_VSOCK_DEFAULT_MIN_BUF_SIZE	128
>  #define VIRTIO_VSOCK_DEFAULT_BUF_SIZE		(1024 * 256)
>  #define VIRTIO_VSOCK_DEFAULT_MAX_BUF_SIZE	(1024 * 256)
> -#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
> +#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 64)

This patch raises rx ring memory consumption from 128 * 4KB =3D 512KB to
128 * 64KB =3D 8MB.

Michael, Jason: Any advice regarding rx/tx ring sizes and buffer sizes?

Depending on rx ring size and the workload's packet size, different
values might be preferred.

This could become a tunable in the future.  It determines the size of
the guest driver's rx buffers.

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpxVeAAoJEJykq7OBq3PIhtsIAIxorF0RmP5eAJziHtgy2yLQ
MlHya7rpnvkF6xSqnCmYAATiZRsnWrPr2hCF/EvYsISlH2Tb+1obPERpSkfdgs0D
LX1QekHhiGKo3fHeWRsKWFVXaFTCyVEQxgngBf0tiYAbYIxFuj54cyUm3tI0OwAi
7JHueqlDJ9HyFVHT2Sdob3NhRyb67aHw/hNKH/ocAduD0NmTx/5V8/0gIxy91ojS
sho3R/CPRJm1mNFUTgiwQWJH3TFrSa5KGu5t2fO8NcXDjAd/5hwgSMtgU3ypSYas
bCTyFBsO7srrP1wzz5YLVLcc5VFQBGrakOLKtmL4GeoyMTl4VZCCWbtN2VQpwWE=
=pBj5
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
