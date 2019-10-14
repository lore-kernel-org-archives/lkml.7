Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C76C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 04:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E7720873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 04:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BDJfsvOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfJNEwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 00:52:46 -0400
Received: from ozlabs.org ([203.11.71.1]:60987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfJNEwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 00:52:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 46s5lZ6rscz9sP3; Mon, 14 Oct 2019 15:52:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1571028762;
        bh=5ic5WJLETE48dYyBLSCb1MM2F7flCGOpH3qsXLyV8n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDJfsvOKlYFniqmjeT/AI6HcNOV1ln1BxU/lRTiSl1OZR30b7aBpr9jdIkYRg/52x
         NGxFBlDbv1VXrJo3DY0hI4ChehpnlBtf+O+oxCC95ARasIgJ+WLE9nzsP/2cHusaYK
         LpKGJw6gzFvNYuSsGdCxGjR6ohdcNlzb9UyGkjfk=
Date:   Mon, 14 Oct 2019 15:52:35 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Ram Pai <linuxram@us.ibm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, aik@linux.ibm.com, paul.burton@mips.com,
        robin.murphy@arm.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, hch@lst.de, jasowang@redhat.com,
        andmike@us.ibm.com, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] virtio_ring: Use DMA API if memory is encrypted
Message-ID: <20191014045235.GO4080@umbus.fritz.box>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
 <1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
 <1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8N0TQpGUCeEQshoq"
Content-Disposition: inline
In-Reply-To: <1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8N0TQpGUCeEQshoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 06:25:19PM -0700, Ram Pai wrote:
> From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>=20
> Normally, virtio enables DMA API with VIRTIO_F_IOMMU_PLATFORM, which must
> be set by both device and guest driver. However, as a hack, when DMA API
> returns physical addresses, guest driver can use the DMA API; even though
> device does not set VIRTIO_F_IOMMU_PLATFORM and just uses physical
> addresses.
>=20
> Doing this works-around POWER secure guests for which only the bounce
> buffer is accessible to the device, but which don't set
> VIRTIO_F_IOMMU_PLATFORM due to a set of hypervisor and architectural bugs.
> To guard against platform changes, breaking any of these assumptions down
> the road, we check at probe time and fail if that's not the case.
>=20
> cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> cc: David Gibson <david@gibson.dropbear.id.au>
> cc: Michael Ellerman <mpe@ellerman.id.au>
> cc: Paul Mackerras <paulus@ozlabs.org>
> cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> cc: Alexey Kardashevskiy <aik@linux.ibm.com>
> cc: Jason Wang <jasowang@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I don't know that this is the most elegant solution possible.  But
it's simple, gets the job done and pretty unlikely to cause mysterious
breakage down the road.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8N0TQpGUCeEQshoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2j/xMACgkQbDjKyiDZ
s5KZJw/7BRxGaRXVs4GwonOJMnJpzq+0zo4Rex4IzZu98y/3bSw1XB+cNfhAwGdo
00Qpp0+AGxMNUmcXy+ilSprBokq1gDBh1hbq2ap/1yoK/fcW2L5ZuyoT5m9d1AMR
4sExuhtQpr7ZMAHHC5Q99jOi44i4BNixlNI62OwtYwOoSvGz1dar6PthN/D6zZ1N
k5ViBzqOY4CIoK/Onqlf47P0ZbgP2XP7rfri0m+PbY0ipOw7E+8zMl4NMIu+dGeU
RQm5e1v8wX/5MUS50gAL+lW/QUxsneaCs3WLCXvHqSJL+shLJnV8Bnomgw+zsBCb
lkLKb+MqdRLt+OMjmIzAtJ2Sza6CU5cpvOAWmIeTlxiwEdD5qrVzAryhFU204vwP
J4ovQSOyR4geqNF3uzTvvVhdme9dNLHkwp7h9PnFwVQEYK6/BlUXxi6WXQXbcthz
PDIj5YdYOwnHLsAv0uaEqRb8/n8ULgyLMfMI4EJOomafMlXF+VD0UPsOEC5glAJ4
TQ6Q0MMzMJ48BhOhwoAZDEYCJYPSXDaKKxEPgvr+uY+VeGTMuMUC8W8VyKFfEZr2
jKpt2P6u/9cPgZWI02Ve5xbRDHJ38cW74JxnTK21zEiF5m14JTYxU6lTTyPQZhFe
DWvkWwsvDz0JvMt8z5DU+FZZbYAnax5XWnEqIl2urw/ChF6DHOY=
=kf/I
-----END PGP SIGNATURE-----

--8N0TQpGUCeEQshoq--
