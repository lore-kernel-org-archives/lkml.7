Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A4EC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937FE2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbfHBFXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 01:23:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732892AbfHBFW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:22:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F863307D971;
        Fri,  2 Aug 2019 05:22:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28B655D712;
        Fri,  2 Aug 2019 05:22:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1FFF29D11; Fri,  2 Aug 2019 07:22:50 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com, thomas@shipmail.org,
        tzimmermann@suse.de, daniel@ffwll.ch, bskeggs@redhat.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 09/17] drm/ttm: set both resv and base.resv pointers
Date:   Fri,  2 Aug 2019 07:22:39 +0200
Message-Id: <20190802052247.18427-10-kraxel@redhat.com>
In-Reply-To: <20190802052247.18427-1-kraxel@redhat.com>
References: <20190802052247.18427-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 02 Aug 2019 05:22:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize both ttm_buffer_object->resv and ttm_buffer_object->base.resv
pointers.  This allows to move users from the former to the latter.  When
all users are moved we can drop ttm_buffer_object->resv.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 2ff09d2bfddb..cd3a179a7e25 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1331,9 +1331,11 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 	bo->sg = sg;
 	if (resv) {
 		bo->resv = resv;
+		bo->base.resv = resv;
 		reservation_object_assert_held(bo->resv);
 	} else {
 		bo->resv = &bo->base._resv;
+		bo->base.resv = &bo->base._resv;
 	}
 	if (!ttm_bo_uses_embedded_gem_object(bo)) {
 		/*
-- 
2.18.1

