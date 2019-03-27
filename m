Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71780C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EB32075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfC0QtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:49:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfC0QtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:49:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E857C307D987;
        Wed, 27 Mar 2019 16:49:15 +0000 (UTC)
Received: from localhost (ovpn-116-213.ams2.redhat.com [10.36.116.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 788E11715C;
        Wed, 27 Mar 2019 16:49:15 +0000 (UTC)
Date:   Wed, 27 Mar 2019 16:49:14 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: zero vhost_vsock memory on allocation
Message-ID: <20190327164914.GE27283@stefanha-x1.localdomain>
References: <1553648174-24913-1-git-send-email-v.mayatskih@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
In-Reply-To: <1553648174-24913-1-git-send-email-v.mayatskih@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 27 Mar 2019 16:49:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 08:56:14PM -0400, Vitaly Mayatskikh wrote:
> This fixes OOPS when using under-initialized vhost_vsock object.
>=20
> The code had a combo of kzalloc plus vmalloc as a fallback
> initially, but it has been replaced by plain kvmalloc in
> commit 6c5ab6511f71 ("mm: support __GFP_REPEAT in kvmalloc_node for >32kB=
")
>=20
> OOPS is easy to reproduce with open/ioctl after trashing the RAM.

Which field was accessed before initialization?

I ask because the situation is now unclear since code remains that
assumes vsock is *not* zero-initialized:

  vsock->guest_cid =3D 0; /* no CID assigned yet */

  atomic_set(&vsock->queued_replies, 0);

If we're going to zalloc, let's get rid of explicit zero
initializations.  Or let's use kvmalloc() and fix the uninitialized
access.  Mixing both is confusing.

> Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
> ---
>  drivers/vhost/vsock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index bb5fc0e..9e7cb13 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -512,7 +512,7 @@ static int vhost_vsock_dev_open(struct inode *inode, =
struct file *file)
>  	/* This struct is large and allocation could fail, fall back to vmalloc
>  	 * if there is no other way.
>  	 */
> -	vsock =3D kvmalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> +	vsock =3D kvzalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
>  	if (!vsock)
>  		return -ENOMEM;
> =20
> --=20
> 1.8.3.1
>=20

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcm6mKAAoJEJykq7OBq3PIfCIH/1ZudXBDTe+lVpYHGgiheqDK
TxlZYvjeRdWRIPv02vngsUXSAfpS1Wb9BopaE2m47TTQBzIYJ51bvQPXRim2cGmf
Y2O5DuRl3KggOCcelmzQjsJLnjY6fOgeSJrCBltVNGPLOhk1CXBywX99mvk1YHYS
1hKjZQMANQZcSv8gWypVxUEzC1XZVHL1+tSVMhumTEmCeMcouGMMWhC8XZuN05A+
+wxiPCFNeH1EWSokvBVKjUPJnvaauENO4Qk4/YSzk7TERsYTv3pH0b1UbWJ/K4Sm
FUodfBPJWkQknZpenbwduaA+/RQ+HxCrEGeor+87l8QFtzFHiaZ+EKuxgFyTWiw=
=a8tB
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--
