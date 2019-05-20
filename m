Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1853EC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED39E20675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbfETJXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:23:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41650 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732038AbfETJXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:23:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EA8115AD;
        Mon, 20 May 2019 02:23:31 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89AF43F575;
        Mon, 20 May 2019 02:23:28 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] drm/panfrost: Use drm_gem_shmem_map_offset()
Date:   Mon, 20 May 2019 10:23:06 +0100
Message-Id: <20190520092306.27633-3-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520092306.27633-1-steven.price@arm.com>
References: <20190520092306.27633-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

panfrost_ioctl_mmap_bo() contains a reimplementation of
drm_gem_map_offset() but with a bug - it allows mapping imported objects
(without going through the exporter). Fix this by switching to use the
newly renamed drm_gem_map_offset() function instead which has the bonus
of simplifying the code.

CC: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index d11e2281dde6..8be0cd5d6c7a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -255,26 +255,14 @@ static int panfrost_ioctl_mmap_bo(struct drm_device *dev, void *data,
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
+	return drm_gem_map_offset(file_priv, dev, args->handle,
+				       &args->offset);
 }
 
 static int panfrost_ioctl_get_bo_offset(struct drm_device *dev, void *data,
-- 
2.20.1

