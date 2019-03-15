Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FC7C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B52B218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfCOQ0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:26:07 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34567 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbfCOQ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:26:06 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost.localdomain (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 123F7C0011;
        Fri, 15 Mar 2019 16:26:02 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 3/3] drm/vc4: Don't liberate the binner BO at runtime suspend
Date:   Fri, 15 Mar 2019 17:25:38 +0100
Message-Id: <20190315162538.4120-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190315162538.4120-1-paul.kocialkowski@bootlin.com>
References: <20190315162538.4120-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binner BO is a pre-requisite to GPU operations, so we must ensure
that it is always allocated when the GPU is in use.

Because the buffer is allocated from the same pool as other GPU buffers,
we might run into a situation where we are out of memory at runtime
resume. This causes the binner BO allocation to fail and results in all
subsequent operations to fail, resulting in a major hang in userspace.

Now that we allocate the buffer at firstopen and liberate it at
lastclose, we can just keep it alive during runtime suspend.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/vc4/vc4_v3d.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index ab15e71df001..e04a51a75f01 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -303,9 +303,6 @@ static int vc4_v3d_runtime_suspend(struct device *dev)
 
 	vc4_irq_uninstall(vc4->dev);
 
-	drm_gem_object_put_unlocked(&vc4->bin_bo->base.base);
-	vc4->bin_bo = NULL;
-
 	clk_disable_unprepare(v3d->clk);
 
 	return 0;
@@ -317,10 +314,6 @@ static int vc4_v3d_runtime_resume(struct device *dev)
 	struct vc4_dev *vc4 = v3d->vc4;
 	int ret;
 
-	ret = vc4_allocate_bin_bo(vc4->dev);
-	if (ret)
-		return ret;
-
 	ret = clk_prepare_enable(v3d->clk);
 	if (ret != 0)
 		return ret;
-- 
2.21.0

