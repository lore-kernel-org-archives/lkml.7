Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985FDC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69880208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfEMOdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:33:09 -0400
Received: from foss.arm.com ([217.140.101.70]:57580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfEMOdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:33:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A11A341;
        Mon, 13 May 2019 07:33:08 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E0153F71E;
        Mon, 13 May 2019 07:33:06 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH] drm/panfrost: Use drm_gem_dump_map_offset()
Date:   Mon, 13 May 2019 15:32:44 +0100
Message-Id: <20190513143244.16478-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

panfrost_ioctl_mmap_bo() contains a reimplementation of
drm_gem_dump_map_offset() but with a bug - it allows mapping imported
objects (without going through the exporter). Fix this by switching to
use the generic drm_gem_dump_map_offset() function instead which has the
bonus of simplifying the code.

CC: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 94b0819ad50b..d048250ad8ab 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -254,26 +254,14 @@ static int panfrost_ioctl_mmap_bo(struct drm_device *dev, void *data,
 		      struct drm_file *file_priv)
 {
 	struct drm_panfrost_mmap_bo *args = data;
-	struct drm_gem_object *gem_obj;
-	int ret;
 
 	if (args->flags != 0) {
 		DRM_INFO("unknown mmap_bo flags: %d\n", args->flags);
 		return -EINVAL;
 	}
 
-	gem_obj = drm_gem_object_lookup(file_priv, args->handle);
-	if (!gem_obj) {
-		DRM_DEBUG("Failed to look up GEM BO %d\n", args->handle);
-		return -ENOENT;
-	}
-
-	ret = drm_gem_create_mmap_offset(gem_obj);
-	if (ret == 0)
-		args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
-	drm_gem_object_put_unlocked(gem_obj);
-
-	return ret;
+	return drm_gem_dumb_map_offset(file_priv, dev, args->handle,
+				       &args->offset);
 }
 
 static int panfrost_ioctl_get_bo_offset(struct drm_device *dev, void *data,
-- 
2.20.1

