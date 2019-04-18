Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_RHS_DOB,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83474C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B0520674
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbfDRNFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:05:33 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59257 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRNFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:05:32 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost.localdomain (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 5B2514001A;
        Thu, 18 Apr 2019 13:05:29 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v2] drm/sun4i: Use DRM_GEM_CMA_VMAP_DRIVER_OPS for GEM operations
Date:   Thu, 18 Apr 2019 15:05:09 +0200
Message-Id: <20190418130509.3569-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our driver makes a typical use of CMA, with GEM object allocated as
GEM CMA objects. Use DRM_GEM_CMA_VMAP_DRIVER_OPS to describe the ops
instead of duplicating them.

Because DRM_GEM_CMA_VMAP_DRIVER_OPS implements a gem_create_object op
which sets per-object funcs (drm_cma_gem_default_funcs), we can also
get rid of free_object_unlocked and gem_vm_ops, which are superseded
by the object funcs.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
Changes since v1:
* Made sure our dumb_create overwrites the OPS's dumb_create.

 drivers/gpu/drm/sun4i/sun4i_drv.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 3ebd9f5e2719..c8c0ab3da972 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -52,22 +52,8 @@ static struct drm_driver sun4i_drv_driver = {
 	.minor			= 0,
 
 	/* GEM Operations */
+	DRM_GEM_CMA_VMAP_DRIVER_OPS,
 	.dumb_create		= drm_sun4i_gem_dumb_create,
-	.gem_free_object_unlocked = drm_gem_cma_free_object,
-	.gem_vm_ops		= &drm_gem_cma_vm_ops,
-
-	/* PRIME Operations */
-	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
-	.gem_prime_import	= drm_gem_prime_import,
-	.gem_prime_export	= drm_gem_prime_export,
-	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
-	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
-	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
-
-	/* Frame Buffer Operations */
 };
 
 static int sun4i_drv_bind(struct device *dev)
-- 
2.21.0

