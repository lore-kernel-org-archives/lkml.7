Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46702C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D30921721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfGAPWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:22:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfGAPWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:22:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C19483082A9A;
        Mon,  1 Jul 2019 15:21:54 +0000 (UTC)
Received: from localhost (unknown [10.36.118.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 268386F947;
        Mon,  1 Jul 2019 15:21:49 +0000 (UTC)
Date:   Mon, 1 Jul 2019 16:21:48 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: virtio_scsi: Use struct_size() helper
Message-ID: <20190701152148.GG11900@stefanha-x1.localdomain>
References: <20190619192833.GA825@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline
In-Reply-To: <20190619192833.GA825@embeddedor>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 01 Jul 2019 15:22:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2019 at 02:28:33PM -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>=20
> struct virtio_scsi {
> 	...
>         struct virtio_scsi_vq req_vqs[];
> };
>=20
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
>=20
> So, replace the following form:
>=20
> sizeof(*vscsi) + sizeof(vscsi->req_vqs[0]) * num_queues
>=20
> with:
>=20
> struct_size(vscsi, req_vqs, num_queues)
>=20
> This code was detected with the help of Coccinelle.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/scsi/virtio_scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0aJQwACgkQnKSrs4Gr
c8hU0wf/SEM8YCmD62jJAJNbhuuxbgPPdSmJV/Oh3RzqiM/ujaeDjX1Msi+8fFbR
NlE7Cr9xEkGuEacjWbl+MNio761nAUo5Ibln9uws3BTpnHClVohmaat2RfuRyoB5
0O1FC55L1Gj8+/RaRoZAO3gld6TM5+KFuptuYN4kOl9/DJDSbjoGX11dFtyL6Jut
mSdjs07Koh+Uxt+2/gIEoflBy6tr8nbOIpIb0qI9Y+4iYXUFPvRqDhqnZ1TezcWE
T4lWINqg4FuT+MMmCAyk8KLhj9FVKLMG7mCRT/R+emhi2yTwyMwvKLYeMW0uikUQ
2NfsNT8OZBYFNEdUzjeCiw4Mg8f99A==
=FseJ
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
