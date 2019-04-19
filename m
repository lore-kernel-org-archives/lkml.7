Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963A3C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C25A217FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfDSAKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:10:21 -0400
Received: from anholt.net ([50.246.234.109]:41332 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfDSAKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:10:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5C92D10A3377;
        Thu, 18 Apr 2019 17:10:19 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 8vcSX3UXRkpk; Thu, 18 Apr 2019 17:10:18 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id EB21010A339C;
        Thu, 18 Apr 2019 17:10:15 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id DD41D2FE3AA4; Thu, 18 Apr 2019 17:10:14 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/4] drm/v3d: Fix debugfs reads of MMU regs.
Date:   Thu, 18 Apr 2019 17:10:11 -0700
Message-Id: <20190419001014.23579-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They're in the hub, not the individual cores.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_debugfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index a2dc4262955e..356a8acfa72d 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -26,6 +26,10 @@ static const struct v3d_reg_def v3d_hub_reg_defs[] = {
 	REGDEF(V3D_HUB_IDENT3),
 	REGDEF(V3D_HUB_INT_STS),
 	REGDEF(V3D_HUB_INT_MSK_STS),
+
+	REGDEF(V3D_MMU_CTL),
+	REGDEF(V3D_MMU_VIO_ADDR),
+	REGDEF(V3D_MMU_VIO_ID),
 };
 
 static const struct v3d_reg_def v3d_gca_reg_defs[] = {
@@ -50,9 +54,6 @@ static const struct v3d_reg_def v3d_core_reg_defs[] = {
 	REGDEF(V3D_PTB_BPCA),
 	REGDEF(V3D_PTB_BPCS),
 
-	REGDEF(V3D_MMU_CTL),
-	REGDEF(V3D_MMU_VIO_ADDR),
-
 	REGDEF(V3D_GMP_STATUS),
 	REGDEF(V3D_GMP_CFG),
 	REGDEF(V3D_GMP_VIO_ADDR),
-- 
2.20.1

