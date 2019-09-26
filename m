Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545BAC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E67E20872
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfIZJGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:06:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:32988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729018AbfIZJGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:06:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BE23AB7D;
        Thu, 26 Sep 2019 09:06:33 +0000 (UTC)
Message-ID: <fcdf6f6325d8afbd6c0b91c782b8ef89ba3dc1d0.camel@suse.de>
Subject: Re: [RFC PATCH] xen/gntdev: Stop abusing DT of_dma_configure API
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Date:   Thu, 26 Sep 2019 11:06:31 +0200
In-Reply-To: <20190925215006.12056-1-robh@kernel.org>
References: <20190925215006.12056-1-robh@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-VZLu1lyfilRACxdtIeDn"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VZLu1lyfilRACxdtIeDn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-09-25 at 16:50 -0500, Rob Herring wrote:
> As the comment says, this isn't a DT based device. of_dma_configure()
> is going to stop allowing a NULL DT node, so this needs to be fixed.
>=20
> Not sure exactly what setup besides arch_setup_dma_ops is needed...
>=20
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Julien Grall <julien.grall@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Just so it isn't forgotten, the same applies here:

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c
b/drivers/gpu/drm/xen/xen_drm_front.c
index ba1828acd8c9..de316a891f39 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -11,7 +11,6 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
=20
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
@@ -718,19 +717,7 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
        struct device *dev =3D &xb_dev->dev;
        int ret;
=20
-       /*
-        * The device is not spawn from a device tree, so arch_setup_dma_op=
s
-        * is not called, thus leaving the device with dummy DMA ops.
-        * This makes the device return error on PRIME buffer import, which
-        * is not correct: to fix this call of_dma_configure() with a NULL
-        * node to set default DMA ops.
-        */
        dev->coherent_dma_mask =3D DMA_BIT_MASK(32);
-       ret =3D of_dma_configure(dev, NULL, true);
-       if (ret < 0) {
-               DRM_ERROR("Cannot setup DMA ops, ret %d", ret);
-               return ret;
-       }
=20
        front_info =3D devm_kzalloc(&xb_dev->dev,
                                  sizeof(*front_info), GFP_KERNEL);


--=-VZLu1lyfilRACxdtIeDn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2Mf5cACgkQlfZmHno8
x/4SfAf+NsGqU0loPiWDCjo41LSGYYLj1TAtCnYEFJhWysp82mV30XSwqhdPMdEd
ydFDB1TmNDhAazi+do8Sh47UzN+UQ2e4U3a5zZ949lNlPNG5bOueY+SQ+S39PFfy
G+NP0lHrXfisWnLmslIn9y6Eqi5Ik4Bjb2DqNZLiAoyzYDlwvDMoAI66J54GT84H
c7TGaeDzTpP4mHxW1BbJxk66gtEIvvURo62SOZuaohC4SICm6f26g+iz6CG8Bjdw
+jRf9eff00d4MOwD28lJPMrHcDS80W1nZHcdTEijMB3bK0QWBkSr1g9Mki2jzukA
5DGyncDkT9wSqIzxCXx77+RPs3rLuA==
=7yuB
-----END PGP SIGNATURE-----

--=-VZLu1lyfilRACxdtIeDn--

