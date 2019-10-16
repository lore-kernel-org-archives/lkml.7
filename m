Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69448FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F2121A49
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VW4V+/aZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436618AbfJPSxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:53:02 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46604 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbfJPSxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:53:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GIqfgo083570;
        Wed, 16 Oct 2019 13:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571251961;
        bh=vUHHm6TQrzUaqF3WoeACMdoEVSPvSP0FUJ+Io/gdxSQ=;
        h=From:To:CC:Subject:Date;
        b=VW4V+/aZg20RkpZf9MraYhWlL5qZKFA7AkTCmXqpdrkBW9KjrD4toiuNnGTspLQ79
         UYG7axKc2ttmfLszbY1LuCOPKm3uISbwZdy3ay49JBzkkFeKuIKZSHzdadMYFzJWWN
         WqjjS2pAofIqHhrRTEKcK3+mQEzTRLZKEA9L4EqQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GIqffr082253
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 13:52:41 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 13:52:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 13:52:41 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GIqfNF081989;
        Wed, 16 Oct 2019 13:52:41 -0500
Received: from localhost ([10.250.79.55])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x9GIqdZ11777;
        Wed, 16 Oct 2019 13:52:39 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH] drm: Move radeon and amdgpu Kconfig options into their directories
Date:   Wed, 16 Oct 2019 14:52:30 -0400
Message-ID: <20191016185230.27824-1-afd@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most Kconfig options to enable a driver are in the Kconfig file
inside the relevant directory, move these two to the same.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/gpu/drm/Kconfig            | 34 ------------------------------
 drivers/gpu/drm/amd/amdgpu/Kconfig | 18 ++++++++++++++++
 drivers/gpu/drm/radeon/Kconfig     | 18 ++++++++++++++++
 3 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index e67c194c2aca..bc5329b697ad 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -203,42 +203,8 @@ source "drivers/gpu/drm/i2c/Kconfig"
 
 source "drivers/gpu/drm/arm/Kconfig"
 
-config DRM_RADEON
-	tristate "ATI Radeon"
-	depends on DRM && PCI && MMU
-	select FW_LOADER
-        select DRM_KMS_HELPER
-        select DRM_TTM
-	select POWER_SUPPLY
-	select HWMON
-	select BACKLIGHT_CLASS_DEVICE
-	select INTERVAL_TREE
-	help
-	  Choose this option if you have an ATI Radeon graphics card.  There
-	  are both PCI and AGP versions.  You don't need to choose this to
-	  run the Radeon in plain VGA mode.
-
-	  If M is selected, the module will be called radeon.
-
 source "drivers/gpu/drm/radeon/Kconfig"
 
-config DRM_AMDGPU
-	tristate "AMD GPU"
-	depends on DRM && PCI && MMU
-	select FW_LOADER
-        select DRM_KMS_HELPER
-	select DRM_SCHED
-        select DRM_TTM
-	select POWER_SUPPLY
-	select HWMON
-	select BACKLIGHT_CLASS_DEVICE
-	select INTERVAL_TREE
-	select CHASH
-	help
-	  Choose this option if you have a recent AMD Radeon graphics card.
-
-	  If M is selected, the module will be called amdgpu.
-
 source "drivers/gpu/drm/amd/amdgpu/Kconfig"
 
 source "drivers/gpu/drm/nouveau/Kconfig"
diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 2e98c016cb47..a53554557cc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -1,4 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config DRM_AMDGPU
+	tristate "AMD GPU"
+	depends on DRM && PCI && MMU
+	select FW_LOADER
+	select DRM_KMS_HELPER
+	select DRM_SCHED
+	select DRM_TTM
+	select POWER_SUPPLY
+	select HWMON
+	select BACKLIGHT_CLASS_DEVICE
+	select INTERVAL_TREE
+	select CHASH
+	help
+	  Choose this option if you have a recent AMD Radeon graphics card.
+
+	  If M is selected, the module will be called amdgpu.
+
 config DRM_AMDGPU_SI
 	bool "Enable amdgpu support for SI parts"
 	depends on DRM_AMDGPU
diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kconfig
index 6f60f4840cc5..ba67b879d31d 100644
--- a/drivers/gpu/drm/radeon/Kconfig
+++ b/drivers/gpu/drm/radeon/Kconfig
@@ -1,4 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config DRM_RADEON
+	tristate "ATI Radeon"
+	depends on DRM && PCI && MMU
+	select FW_LOADER
+	select DRM_KMS_HELPER
+	select DRM_TTM
+	select POWER_SUPPLY
+	select HWMON
+	select BACKLIGHT_CLASS_DEVICE
+	select INTERVAL_TREE
+	help
+	  Choose this option if you have an ATI Radeon graphics card.  There
+	  are both PCI and AGP versions.  You don't need to choose this to
+	  run the Radeon in plain VGA mode.
+
+	  If M is selected, the module will be called radeon.
+
 config DRM_RADEON_USERPTR
 	bool "Always enable userptr support"
 	depends on DRM_RADEON
-- 
2.17.1

