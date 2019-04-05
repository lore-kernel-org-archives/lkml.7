Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2686FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8267217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfDEKY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:24:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730546AbfDEKY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:24:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F212C02500A;
        Fri,  5 Apr 2019 10:24:27 +0000 (UTC)
Received: from localhost (ovpn-117-172.ams2.redhat.com [10.36.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F40A56091F;
        Fri,  5 Apr 2019 10:24:22 +0000 (UTC)
Date:   Fri, 5 Apr 2019 11:24:18 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc:     linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost/vsock: initialize vhost_vsock->hash
Message-ID: <20190405102418.GF25152@stefanha-x1.localdomain>
References: <CAGF4SLiZxXcWskZXmGbwO11MnwyMAK_Bpbn0ugZzK6jSMHdiog@mail.gmail.com>
 <1553793057-24002-1-git-send-email-v.mayatskih@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kR3zbvD4cgoYnS/6"
Content-Disposition: inline
In-Reply-To: <1553793057-24002-1-git-send-email-v.mayatskih@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 05 Apr 2019 10:24:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kR3zbvD4cgoYnS/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2019 at 01:10:57PM -0400, Vitaly Mayatskikh wrote:
> There's no current valid use case when uninitialized hash can be read
> before being written, however let's keep every vhost_vsock field
> initialized just for clarity.
>=20
> Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
> ---
>  drivers/vhost/vsock.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index bb5fc0e..f43f4ed 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -537,6 +537,7 @@ static int vhost_vsock_dev_open(struct inode *inode, =
struct file *file)
>  	spin_lock_init(&vsock->send_pkt_list_lock);
>  	INIT_LIST_HEAD(&vsock->send_pkt_list);
>  	vhost_work_init(&vsock->send_pkt_work, vhost_transport_send_pkt_work);
> +	INIT_HLIST_NODE(&vsock->hash);
>  	return 0;
> =20
>  out:
> --=20
> 1.8.3.1

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kR3zbvD4cgoYnS/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpyzSAAoJEJykq7OBq3PIXQoH/1x/QiN7WueqBBia1ZM1z4ju
zY9I9PgH9nksM48rspSG+Ko/L8kESslYCzVSsns05e1o4FNonfoo+QNjvciZ1AXs
Xvuc8qf7BoW+F/VtDRfhFTE1wD9iTvDMY5d3rWSWP8zCzOvz4Ej0Dw1mrekl/TA3
rANt1yH+JYSbOYd9SePbnqGsM7ygdTIQPHVpYgwdkcFZ1PewhJpNl0n8K/ikfEPV
qgdnLUdmAHgqAlQgKA8RkXMZ30pZI7jXS9otPGpzEYkmomlclA88mObygICJrTug
julhk8XUJ17IEglftKs/0NXVEkatMJBX1tADFXAAcnIFEjvZYRElAL5bfmjbKtY=
=wo/m
-----END PGP SIGNATURE-----

--kR3zbvD4cgoYnS/6--
