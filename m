Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB5C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34FD2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfEPO4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:56:17 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:55107 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:56:01 -0400
Received: from localhost.localdomain (aaubervilliers-681-1-43-46.w90-88.abo.wanadoo.fr [90.88.161.46])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0BEE320001D;
        Thu, 16 May 2019 14:55:55 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v9 3/4] drm/vc4: Check for the binner bo before handling OOM interrupt
Date:   Thu, 16 May 2019 16:55:43 +0200
Message-Id: <20190516145544.29051-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516145544.29051-1-paul.kocialkowski@bootlin.com>
References: <20190516145544.29051-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the OOM interrupt directly deals with the binner bo, it doesn't
make sense to try and handle it without a binner buffer registered.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vc4/vc4_irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index ffd0a4388752..723dc86b4511 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -64,6 +64,9 @@ vc4_overflow_mem_work(struct work_struct *work)
 	struct vc4_exec_info *exec;
 	unsigned long irqflags;
 
+	if (!bo)
+		return;
+
 	bin_bo_slot = vc4_v3d_get_bin_slot(vc4);
 	if (bin_bo_slot < 0) {
 		DRM_ERROR("Couldn't allocate binner overflow mem\n");
-- 
2.21.0

