Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1020CC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA8A2082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfDAW0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:26:51 -0400
Received: from anholt.net ([50.246.234.109]:48360 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbfDAW0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:26:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9456410A278C;
        Mon,  1 Apr 2019 15:26:49 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id q-bYYG6cI22h; Mon,  1 Apr 2019 15:26:47 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id DCA0D10A2A55;
        Mon,  1 Apr 2019 15:26:36 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id C0A2E2FE34D1; Mon,  1 Apr 2019 15:26:35 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Rob Herring <robh@kernel.org>,
        Qiang Yu <yuq825@gmail.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 4/7] drm/v3d: Drop reservation of a shared slot in the dma-buf reservations.
Date:   Mon,  1 Apr 2019 15:26:32 -0700
Message-Id: <20190401222635.25013-5-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401222635.25013-1-eric@anholt.net>
References: <20190401222635.25013-1-eric@anholt.net>
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
index b78ffc526885..ba3188b0d613 100644
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

