Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF8AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D9921019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfCMXwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:52:15 -0400
Received: from anholt.net ([50.246.234.109]:53744 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfCMXwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:52:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 54AE610A2E6C;
        Wed, 13 Mar 2019 16:52:14 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 0sUvoLsdQavc; Wed, 13 Mar 2019 16:52:12 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9A37E10A2CC1;
        Wed, 13 Mar 2019 16:52:12 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 7E3C82FE4653; Wed, 13 Mar 2019 16:52:11 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/4] drm/v3d: Add a note about OOM vs FRDONE, which may be racing on v3.3.
Date:   Wed, 13 Mar 2019 16:52:08 -0700
Message-Id: <20190313235211.28995-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We deref v3d->bin_job in the work handler, but v3d->bin_job doesn't
actually hold a ref on the job.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index b4d6ae81186d..a09442ec7297 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -87,7 +87,8 @@ v3d_irq(int irq, void *arg)
 	if (intsts & V3D_INT_OUTOMEM) {
 		/* Note that the OOM status is edge signaled, so the
 		 * interrupt won't happen again until the we actually
-		 * add more memory.
+		 * add more memory.  Also, as of V3D 4.1, FRDONE won't
+		 * be reported until any OOM state has been cleared.
 		 */
 		schedule_work(&v3d->overflow_mem_work);
 		status = IRQ_HANDLED;
-- 
2.20.1

