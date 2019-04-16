Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EA2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B29921773
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbfDPW7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:59:13 -0400
Received: from anholt.net ([50.246.234.109]:54090 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730844AbfDPW7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:59:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5DF5E10A3385;
        Tue, 16 Apr 2019 15:59:11 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Fj9Bxh6tIVvm; Tue, 16 Apr 2019 15:59:09 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9A04110A3388;
        Tue, 16 Apr 2019 15:58:58 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id CEF442FE4633; Tue, 16 Apr 2019 15:58:56 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 4/5] drm/v3d: Drop reservation of a shared slot in the dma-buf reservations.
Date:   Tue, 16 Apr 2019 15:58:55 -0700
Message-Id: <20190416225856.20264-5-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416225856.20264-1-eric@anholt.net>
References: <20190416225856.20264-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only set the excl (possible-writing) fence pointer and never add a
shared (read-only) fence.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 8bd6fa69f566..6873b14a0d38 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -253,18 +253,6 @@ v3d_lock_bo_reservations(struct drm_gem_object **bos,
 	if (ret)
 		return ret;
 
-	/* Reserve space for our shared (read-only) fence references,
-	 * before we commit the CL to the hardware.
-	 */
-	for (i = 0; i < bo_count; i++) {
-		ret = reservation_object_reserve_shared(bos[i]->resv, 1);
-		if (ret) {
-			drm_gem_unlock_reservations(bos, bo_count,
-						    acquire_ctx);
-			return ret;
-		}
-	}
-
 	return 0;
 }
 
-- 
2.20.1

