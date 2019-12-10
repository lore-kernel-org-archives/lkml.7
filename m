Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DAAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2121820652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aezCjhcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfLJOGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:06:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25706 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727131AbfLJOGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575986764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9cYSQHCTDQkKzmRIgQpyk3DnPt+k/A4ckdhU2f8Or6g=;
        b=aezCjhcsuEiduFAdc2wCO4KzHE3M4abW/uEsH5HsjXtSuy6FEqIWYh3Pf+Es31LRm+pv/q
        YHSbh1oOxAs3iQFQ7P3W6gwoFy94IO6Lp6MT6DLcskqtS82l2juVYq+lq1/xigsCaX1UG8
        18WGMfbaf+xKp/XTw6M9U0KXdNRrLpQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-kTqMgunjNiCBRCaUM7nNTg-1; Tue, 10 Dec 2019 09:06:03 -0500
Received: by mail-wm1-f70.google.com with SMTP id b131so1031294wmd.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 06:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CI3qbc7xp4DF6AaDOfblCvC5kTkzEe7UO4aRTK6V7jk=;
        b=K8203WRW2DV0SHMxxmzKT2hyFc8Jb6QWMninu0yh3D8gjnMVlhRQ1tgqbuyUopwQru
         aiNBdpfqVcQFOz+HRRYtonRrVr78OOf69TXBroGCudGBoj+sfB43OtUsQ4otznWaP7Xx
         yIh6DHzXyiO2Cn6Qcl/xnSvB1g5QPcfd9Z0ZNNIog3drYr/8ZxWAGe6dYZtKIFO/pVtK
         KFuaIwpH/sF9/0PjUbQKG1PTSGkqbe13VvpOHtsWe+fcfYZbEEGuuDRL5H8NhR0NSuO9
         ovxWiY88kGwvipmbAIh17gvpvdy/juTULSs8jCuOBj+WcnNy5SGcgxHnNzv+J8VtTYi/
         m+8Q==
X-Gm-Message-State: APjAAAV2F1Z3n2yGd6reDsKvjDNXD7NfHicDaRWfA3vKSG/7KpKj3EyC
        L59EoAIXFbtW/o1sJgLM/lnE/Iese5bMGuWf7mKz31/fTZwIFEh+titGKr1IXeuvgOkgtb0bEyS
        toVhpxQhuJdK3tzaRtuWmV9/I
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr5415228wmm.70.1575986762124;
        Tue, 10 Dec 2019 06:06:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqzt2DwRGDx/tfuLDX74AYEnOhZaQrk2tBhSVe7oGiWrvR5kBtkcogM60airAVN4tsBt+f/Tiw==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr5415198wmm.70.1575986761941;
        Tue, 10 Dec 2019 06:06:01 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id a5sm3131833wmb.37.2019.12.10.06.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:06:01 -0800 (PST)
Date:   Tue, 10 Dec 2019 09:05:58 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: accept only packets with the right dst_cid
Message-ID: <20191210090505-mutt-send-email-mst@kernel.org>
References: <20191206143912.153583-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191206143912.153583-1-sgarzare@redhat.com>
X-MC-Unique: kTqMgunjNiCBRCaUM7nNTg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 03:39:12PM +0100, Stefano Garzarella wrote:
> When we receive a new packet from the guest, we check if the
> src_cid is correct, but we forgot to check the dst_cid.
>=20
> The host should accept only packets where dst_cid is
> equal to the host CID.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

what's the implication of processing incorrect dst cid?
I think mostly it's malformed guests, right?
Everyone else just passes the known host cid ...

> ---
>  drivers/vhost/vsock.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 50de0642dea6..c2d7d57e98cf 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -480,7 +480,9 @@ static void vhost_vsock_handle_tx_kick(struct vhost_w=
ork *work)
>  =09=09virtio_transport_deliver_tap_pkt(pkt);
> =20
>  =09=09/* Only accept correctly addressed packets */
> -=09=09if (le64_to_cpu(pkt->hdr.src_cid) =3D=3D vsock->guest_cid)
> +=09=09if (le64_to_cpu(pkt->hdr.src_cid) =3D=3D vsock->guest_cid &&
> +=09=09    le64_to_cpu(pkt->hdr.dst_cid) =3D=3D
> +=09=09    vhost_transport_get_local_cid())
>  =09=09=09virtio_transport_recv_pkt(&vhost_transport, pkt);
>  =09=09else
>  =09=09=09virtio_transport_free_pkt(pkt);
> --=20
> 2.23.0

