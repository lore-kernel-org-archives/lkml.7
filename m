Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAC4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BCA20657
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfCHQRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:17:38 -0500
Received: from anholt.net ([50.246.234.109]:52542 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbfCHQRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:17:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 278B510A2E2B;
        Fri,  8 Mar 2019 08:17:23 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 3MJO0dbiJEtt; Fri,  8 Mar 2019 08:17:21 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 691BF10A2E2C;
        Fri,  8 Mar 2019 08:17:17 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 2B3F82FE4656; Fri,  8 Mar 2019 08:17:16 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/4] drm/v3d: Remove some dead members of struct v3d_bo.
Date:   Fri,  8 Mar 2019 08:17:15 -0800
Message-Id: <20190308161716.2466-4-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308161716.2466-1-eric@anholt.net>
References: <20190308161716.2466-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmas was from the previous model of page table management (one per
fd), and vaddr was left over from vc4.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_bo.c  | 1 -
 drivers/gpu/drm/v3d/v3d_drv.h | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 5c83b392b20a..dff38bf36c50 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -117,7 +117,6 @@ static struct v3d_bo *v3d_bo_create_struct(struct drm_device *dev,
 		return ERR_PTR(-ENOMEM);
 	obj = &bo->base;
 
-	INIT_LIST_HEAD(&bo->vmas);
 	INIT_LIST_HEAD(&bo->unref_head);
 	mutex_init(&bo->lock);
 
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index d856159bd007..f5ed915a0f15 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -108,12 +108,6 @@ struct v3d_file_priv {
 	struct drm_sched_entity sched_entity[V3D_MAX_QUEUES];
 };
 
-/* Tracks a mapping of a BO into a per-fd address space */
-struct v3d_vma {
-	struct v3d_page_table *pt;
-	struct list_head list; /* entry in v3d_bo.vmas */
-};
-
 struct v3d_bo {
 	struct drm_gem_object base;
 
@@ -124,9 +118,6 @@ struct v3d_bo {
 	u32 pages_refcount;
 	struct page **pages;
 	struct sg_table *sgt;
-	void *vaddr;
-
-	struct list_head vmas;    /* list of v3d_vma */
 
 	/* List entry for the BO's position in
 	 * v3d_exec_info->unref_list
-- 
2.20.1

