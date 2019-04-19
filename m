Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C990C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD85121736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfDSAKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:10:19 -0400
Received: from anholt.net ([50.246.234.109]:41320 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfDSAKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:10:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 39C4B10A15DE;
        Thu, 18 Apr 2019 17:10:18 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id gkWqYgldLcFn; Thu, 18 Apr 2019 17:10:16 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D798610A3377;
        Thu, 18 Apr 2019 17:10:15 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id E72142FE3AA9; Thu, 18 Apr 2019 17:10:14 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/4] drm/v3d: Dump V3D error debug registers in debugfs, and one at reset.
Date:   Thu, 18 Apr 2019 17:10:13 -0700
Message-Id: <20190419001014.23579-3-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419001014.23579-1-eric@anholt.net>
References: <20190419001014.23579-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at a hang recently, I noticed these registers that might tell
me if something obvious was wrong.  They didn't help in this case, but
keep it around for the future.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_debugfs.c |  5 ++++
 drivers/gpu/drm/v3d/v3d_gem.c     |  4 +++-
 drivers/gpu/drm/v3d/v3d_regs.h    | 38 +++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index ab652a034959..78a78938e81f 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -58,6 +58,11 @@ static const struct v3d_reg_def v3d_core_reg_defs[] = {
 	REGDEF(V3D_GMP_STATUS),
 	REGDEF(V3D_GMP_CFG),
 	REGDEF(V3D_GMP_VIO_ADDR),
+
+	REGDEF(V3D_ERR_FDBGO),
+	REGDEF(V3D_ERR_FDBGB),
+	REGDEF(V3D_ERR_FDBGS),
+	REGDEF(V3D_ERR_STAT),
 };
 
 static const struct v3d_reg_def v3d_csd_reg_defs[] = {
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index f736e021467a..27e0f87075d9 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -109,7 +109,9 @@ v3d_reset(struct v3d_dev *v3d)
 {
 	struct drm_device *dev = &v3d->drm;
 
-	DRM_ERROR("Resetting GPU.\n");
+	DRM_DEV_ERROR(dev->dev, "Resetting GPU for hang.\n");
+	DRM_DEV_ERROR(dev->dev, "V3D_ERR_STAT: 0x%08x\n",
+		      V3D_CORE_READ(0, V3D_ERR_STAT));
 	trace_v3d_reset_begin(dev);
 
 	/* XXX: only needed for safe powerdown, not reset. */
diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
index 54c8c4320da0..eda1e289976f 100644
--- a/drivers/gpu/drm/v3d/v3d_regs.h
+++ b/drivers/gpu/drm/v3d/v3d_regs.h
@@ -455,4 +455,42 @@
 # define V3D_CSD_CURRENT_ID0_WG_Y_MASK                 V3D_MASK(15, 0)
 # define V3D_CSD_CURRENT_ID0_WG_Y_SHIFT                0
 
+#define V3D_ERR_FDBGO                                  0x00f04
+#define V3D_ERR_FDBGB                                  0x00f08
+#define V3D_ERR_FDBGR                                  0x00f0c
+
+#define V3D_ERR_FDBGS                                  0x00f10
+# define V3D_ERR_FDBGS_INTERPZ_IP_STALL                BIT(17)
+# define V3D_ERR_FDBGS_DEPTHO_FIFO_IP_STALL            BIT(16)
+# define V3D_ERR_FDBGS_XYNRM_IP_STALL                  BIT(14)
+# define V3D_ERR_FDBGS_EZREQ_FIFO_OP_VALID             BIT(13)
+# define V3D_ERR_FDBGS_QXYF_FIFO_OP_VALID              BIT(12)
+# define V3D_ERR_FDBGS_QXYF_FIFO_OP_LAST               BIT(11)
+# define V3D_ERR_FDBGS_EZTEST_ANYQVALID                BIT(7)
+# define V3D_ERR_FDBGS_EZTEST_PASS                     BIT(6)
+# define V3D_ERR_FDBGS_EZTEST_QREADY                   BIT(5)
+# define V3D_ERR_FDBGS_EZTEST_VLF_OKNOVALID            BIT(4)
+# define V3D_ERR_FDBGS_EZTEST_QSTALL                   BIT(3)
+# define V3D_ERR_FDBGS_EZTEST_IP_VLFSTALL              BIT(2)
+# define V3D_ERR_FDBGS_EZTEST_IP_PRSTALL               BIT(1)
+# define V3D_ERR_FDBGS_EZTEST_IP_QSTALL                BIT(0)
+
+#define V3D_ERR_STAT                                   0x00f20
+# define V3D_ERR_L2CARE                                BIT(15)
+# define V3D_ERR_VCMBE                                 BIT(14)
+# define V3D_ERR_VCMRE                                 BIT(13)
+# define V3D_ERR_VCDI                                  BIT(12)
+# define V3D_ERR_VCDE                                  BIT(11)
+# define V3D_ERR_VDWE                                  BIT(10)
+# define V3D_ERR_VPMEAS                                BIT(9)
+# define V3D_ERR_VPMEFNA                               BIT(8)
+# define V3D_ERR_VPMEWNA                               BIT(7)
+# define V3D_ERR_VPMERNA                               BIT(6)
+# define V3D_ERR_VPMERR                                BIT(5)
+# define V3D_ERR_VPMEWR                                BIT(4)
+# define V3D_ERR_VPAERRGL                              BIT(3)
+# define V3D_ERR_VPAEBRGL                              BIT(2)
+# define V3D_ERR_VPAERGS                               BIT(1)
+# define V3D_ERR_VPAEABB                               BIT(0)
+
 #endif /* V3D_REGS_H */
-- 
2.20.1

