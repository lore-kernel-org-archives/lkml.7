Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F39C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FED82067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfHEMnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:43:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbfHEMnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:43:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8460D3697F;
        Mon,  5 Aug 2019 12:43:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D7F060E1C;
        Mon,  5 Aug 2019 12:43:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4B6879D22; Mon,  5 Aug 2019 14:43:15 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, thomas@shipmail.org,
        tzimmermann@suse.de, ckoenig.leichtzumerken@gmail.com,
        bskeggs@redhat.com, daniel@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 18/18] drm/ttm: drop ttm_buffer_object->resv
Date:   Mon,  5 Aug 2019 14:43:10 +0200
Message-Id: <20190805124310.3275-19-kraxel@redhat.com>
In-Reply-To: <20190805124310.3275-1-kraxel@redhat.com>
References: <20190805124310.3275-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 05 Aug 2019 12:43:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users moved to ttm_buffer_object->base.resv

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 include/drm/ttm/ttm_bo_api.h | 1 -
 drivers/gpu/drm/ttm/ttm_bo.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 7ffc50a3303d..65ef5376de59 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -230,7 +230,6 @@ struct ttm_buffer_object {
 
 	struct sg_table *sg;
 
-	struct reservation_object *resv;
 	struct mutex wu_mutex;
 };
 
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 73d407494586..b2a3103fa0db 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1332,11 +1332,9 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 	bo->acc_size = acc_size;
 	bo->sg = sg;
 	if (resv) {
-		bo->resv = resv;
 		bo->base.resv = resv;
 		reservation_object_assert_held(bo->base.resv);
 	} else {
-		bo->resv = &bo->base._resv;
 		bo->base.resv = &bo->base._resv;
 	}
 	if (!ttm_bo_uses_embedded_gem_object(bo)) {
-- 
2.18.1

