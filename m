Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11B9C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A332184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDEEqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 00:46:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDEEqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 00:46:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD85CC04D943;
        Fri,  5 Apr 2019 04:46:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F57460C05;
        Fri,  5 Apr 2019 04:46:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id AB9A316E2C; Fri,  5 Apr 2019 06:46:02 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     jcmvbkbc@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: move drm_connector_update_edid_property() call
Date:   Fri,  5 Apr 2019 06:46:02 +0200
Message-Id: <20190405044602.2334-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 05 Apr 2019 04:46:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_connector_update_edid_property can sleep, we must not
call it while holding a spinlock.  Move the callsize.

Reported-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index e62fe24b1a2e..5bb0f0a084e9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -619,11 +619,11 @@ static void virtio_gpu_cmd_get_edid_cb(struct virtio_gpu_device *vgdev,
 	output = vgdev->outputs + scanout;
 
 	new_edid = drm_do_get_edid(&output->conn, virtio_get_edid_block, resp);
+	drm_connector_update_edid_property(&output->conn, new_edid);
 
 	spin_lock(&vgdev->display_info_lock);
 	old_edid = output->edid;
 	output->edid = new_edid;
-	drm_connector_update_edid_property(&output->conn, output->edid);
 	spin_unlock(&vgdev->display_info_lock);
 
 	kfree(old_edid);
-- 
2.18.1

