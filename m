Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF329C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF052147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbfFTGP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfFTGPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:15:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2185F81F1B;
        Thu, 20 Jun 2019 06:15:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78C8C1001B3D;
        Thu, 20 Jun 2019 06:15:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 81A6D1750C; Thu, 20 Jun 2019 08:15:47 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm: add mmap() to drm_gem_object_funcs
Date:   Thu, 20 Jun 2019 08:15:45 +0200
Message-Id: <20190620061547.8664-2-kraxel@redhat.com>
In-Reply-To: <20190620061547.8664-1-kraxel@redhat.com>
References: <20190620061547.8664-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 20 Jun 2019 06:15:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_gem_object_funcs->vm_ops alone can't handle
everything mmap() needs.  Add a new callback for it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem.h     | 9 +++++++++
 drivers/gpu/drm/drm_gem.c | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index a9121fe66ea2..2e680a065470 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -144,6 +144,15 @@ struct drm_gem_object_funcs {
 	 */
 	void (*vunmap)(struct drm_gem_object *obj, void *vaddr);
 
+	/**
+	 * @mmap:
+	 *
+	 * Called by drm_gem_mmap() for additional checks/setup.
+	 *
+	 * This callback is optional.
+	 */
+	int (*mmap)(struct drm_gem_object *obj, struct vm_area_struct *vma);
+
 	/**
 	 * @vm_ops:
 	 *
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index a8c4468f03d9..1deae1b70f39 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1192,6 +1192,10 @@ int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 	ret = drm_gem_mmap_obj(obj, drm_vma_node_size(node) << PAGE_SHIFT,
 			       vma);
 
+	if (ret == 0)
+		if (obj->funcs->mmap)
+			ret = obj->funcs->mmap(obj, vma);
+
 	drm_gem_object_put_unlocked(obj);
 
 	return ret;
-- 
2.18.1

