Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD02EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A145D206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DbMWvxV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfDZCSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:18:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42473 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfDZCSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:18:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44qyPv3JfGz9s70;
        Fri, 26 Apr 2019 12:17:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556245076;
        bh=Qqgp1DAA42BKNh/pC10z5JxEM/PAd80YG6YdJcPqr14=;
        h=Date:From:To:Cc:Subject:From;
        b=DbMWvxV7pB7y/Ahxx5cLJ/5hs4Moo0Fk4ua4v4Xil/gah1YoPQ22I4VEMUMq0Qj83
         5f9QZod6X5Kwu9tKC7adpCDaZ8wdFlwxAcMaOa5nj+25kusk+HsLkoYAXQHZKPRENR
         59IEeG+RO0oe2Gme5A7A0zYUsOphR/cumUT4jQETPDshmab/SzCsAXC+PSJdcrG8xV
         4cjwSJBN5CHjIWsiq3iEx29XAuFQmsfGShh0bWpFUBt7GMeMYdkZhOzuuEr3VJbz7W
         CWSv09tEs2YtESf7ytsJDAm+RMtGw59TRXyly1BcWpND8cD9YW0UZz0A5/l0oxIBVW
         y6qHiNnJnibIQ==
Date:   Fri, 26 Apr 2019 12:17:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
        Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf@tronnes.org>
Subject: linux-next: build failure after merge of the drm tree
Message-ID: <20190426121735.54ff8785@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CxWqRw_sHO9W/Gm/1zGUIvr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CxWqRw_sHO9W/Gm/1zGUIvr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/gpu/drm/virtio/virtgpu_prime.c:43:18: error: redefinition of 'virtg=
pu_gem_prime_get_sg_table'
 struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/virtio/virtgpu_prime.c:31:18: note: previous definition of =
'virtgpu_gem_prime_get_sg_table' was here
 struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by a bad automaic merge between commit

  a0cecc23cfcb ("Revert "drm/virtio: drop prime import/export callbacks"")

from Linus' tree and commit

  98f41dc3b3ee ("drm/virtio: implement prime export")

from the drm tree.

I dropped the version of this function from the drm-fixes tree:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 26 Apr 2019 12:13:26 +1000
Subject: [PATCH] drm/virtio: fix up bad merge of virtgpu_gem_prime_get_sg_t=
able

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/virtio/virtgpu_prime.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virti=
o/virtgpu_prime.c
index 0f670fc6c954..8fbf71bd0c5e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -40,11 +40,6 @@ struct sg_table *virtgpu_gem_prime_get_sg_table(struct d=
rm_gem_object *obj)
 				     bo->tbo.ttm->num_pages);
 }
=20
-struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
-{
-	return ERR_PTR(-ENODEV);
-}
-
 struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
 	struct drm_device *dev, struct dma_buf_attachment *attach,
 	struct sg_table *table)
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/CxWqRw_sHO9W/Gm/1zGUIvr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzCaj8ACgkQAVBC80lX
0GxFpwf/TFuH0ZkexQDGAbpdNoL3tS0ByjHqfnk94wixNeEwLSb3GxiNzPUJJBmb
HAzl4RVWa4aS6S1QyJPUa8lFA3op/k83vPWtavYVB4CWk/USsKY1ZzFBcz6g8ulW
3E2bm3ZnAci+2VyreJnkAqlEKF1m5VjfiWcLmi4Co7dzye01JyQ0rnDd8ZYuGgRO
3iOnLmJba58Hk0fMRMt6xNC/cyuMXPs/h+1MD6YyJTWz6VxXBEEBwXoY6w1zQCBd
RH5y7lxfTdLyHY4/0+vy1wQIriCL2EzA3yXbDiN47ESUbCexsm+djVUGzSyEU1zG
95iFa/9WsoSo+fW8ffex+HI0FUAHnQ==
=0kOG
-----END PGP SIGNATURE-----

--Sig_/CxWqRw_sHO9W/Gm/1zGUIvr--
