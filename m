Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842D8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58993218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfCUTmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:42:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfCUTmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:42:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C7D0308338F;
        Thu, 21 Mar 2019 19:42:24 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2404819C59;
        Thu, 21 Mar 2019 19:42:23 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] gpu/nouveau: empty chunk do not have a buffer object associated with them.
Date:   Thu, 21 Mar 2019 15:42:18 -0400
Message-Id: <20190321194218.2716-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 21 Mar 2019 19:42:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Empty chunk do not have a bo associated with them so no need to pin/unpin
on suspend/resume.

This fix suspend/resume on 5.1rc1 when NOUVEAU_SVM is enabled.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Tested-by: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index aa9fec80492d..a510dbe9a9cb 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -456,11 +456,6 @@ nouveau_dmem_resume(struct nouveau_drm *drm)
 		/* FIXME handle pin failure */
 		WARN_ON(ret);
 	}
-	list_for_each_entry (chunk, &drm->dmem->chunk_empty, list) {
-		ret = nouveau_bo_pin(chunk->bo, TTM_PL_FLAG_VRAM, false);
-		/* FIXME handle pin failure */
-		WARN_ON(ret);
-	}
 	mutex_unlock(&drm->dmem->mutex);
 }
 
@@ -479,9 +474,6 @@ nouveau_dmem_suspend(struct nouveau_drm *drm)
 	list_for_each_entry (chunk, &drm->dmem->chunk_full, list) {
 		nouveau_bo_unpin(chunk->bo);
 	}
-	list_for_each_entry (chunk, &drm->dmem->chunk_empty, list) {
-		nouveau_bo_unpin(chunk->bo);
-	}
 	mutex_unlock(&drm->dmem->mutex);
 }
 
-- 
2.17.1

