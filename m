Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37706C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1497C23400
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfIDFrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 01:47:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbfIDFrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:47:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 052E030842A8;
        Wed,  4 Sep 2019 05:47:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-72.ams2.redhat.com [10.36.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8A9019C4F;
        Wed,  4 Sep 2019 05:47:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 060F131EEC; Wed,  4 Sep 2019 07:47:42 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU)
Subject: [PATCH v3 7/7] drm/vram: fix Kconfig
Date:   Wed,  4 Sep 2019 07:47:40 +0200
Message-Id: <20190904054740.20817-8-kraxel@redhat.com>
In-Reply-To: <20190904054740.20817-1-kraxel@redhat.com>
References: <20190904054740.20817-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 04 Sep 2019 05:47:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select isn't recursive, so we can't turn on DRM_TTM + DRM_TTM_HELPER
in config DRM_VRAM_HELPER, we have to select them on the vram users
instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/Kconfig                 | 2 --
 drivers/gpu/drm/ast/Kconfig             | 2 ++
 drivers/gpu/drm/bochs/Kconfig           | 2 ++
 drivers/gpu/drm/hisilicon/hibmc/Kconfig | 3 ++-
 drivers/gpu/drm/mgag200/Kconfig         | 2 ++
 drivers/gpu/drm/vboxvideo/Kconfig       | 2 ++
 6 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 1be8ad30d8fe..cd11a3bde19c 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -168,8 +168,6 @@ config DRM_TTM
 config DRM_VRAM_HELPER
 	tristate
 	depends on DRM
-	select DRM_TTM
-	select DRM_TTM_HELPER
 	help
 	  Helpers for VRAM memory management
 
diff --git a/drivers/gpu/drm/ast/Kconfig b/drivers/gpu/drm/ast/Kconfig
index 829620d5326c..fbcf2f45cef5 100644
--- a/drivers/gpu/drm/ast/Kconfig
+++ b/drivers/gpu/drm/ast/Kconfig
@@ -4,6 +4,8 @@ config DRM_AST
 	depends on DRM && PCI && MMU
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
+	select DRM_TTM
+	select DRM_TTM_HELPER
 	help
 	 Say yes for experimental AST GPU driver. Do not enable
 	 this driver without having a working -modesetting,
diff --git a/drivers/gpu/drm/bochs/Kconfig b/drivers/gpu/drm/bochs/Kconfig
index 32b043abb668..7bcdf294fed8 100644
--- a/drivers/gpu/drm/bochs/Kconfig
+++ b/drivers/gpu/drm/bochs/Kconfig
@@ -4,6 +4,8 @@ config DRM_BOCHS
 	depends on DRM && PCI && MMU
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
+	select DRM_TTM
+	select DRM_TTM_HELPER
 	help
 	  Choose this option for qemu.
 	  If M is selected the module will be called bochs-drm.
diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
index f20eedf0073a..8ad9a5b12e40 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
+++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
@@ -4,7 +4,8 @@ config DRM_HISI_HIBMC
 	depends on DRM && PCI && MMU
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
-
+	select DRM_TTM
+	select DRM_TTM_HELPER
 	help
 	  Choose this option if you have a Hisilicon Hibmc soc chipset.
 	  If M is selected the module will be called hibmc-drm.
diff --git a/drivers/gpu/drm/mgag200/Kconfig b/drivers/gpu/drm/mgag200/Kconfig
index 76fee0fbdcae..aed11f4f4c55 100644
--- a/drivers/gpu/drm/mgag200/Kconfig
+++ b/drivers/gpu/drm/mgag200/Kconfig
@@ -4,6 +4,8 @@ config DRM_MGAG200
 	depends on DRM && PCI && MMU
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
+	select DRM_TTM
+	select DRM_TTM_HELPER
 	help
 	 This is a KMS driver for the MGA G200 server chips, it
          does not support the original MGA G200 or any of the desktop
diff --git a/drivers/gpu/drm/vboxvideo/Kconfig b/drivers/gpu/drm/vboxvideo/Kconfig
index 56ba510f21a2..45fe135d6e43 100644
--- a/drivers/gpu/drm/vboxvideo/Kconfig
+++ b/drivers/gpu/drm/vboxvideo/Kconfig
@@ -4,6 +4,8 @@ config DRM_VBOXVIDEO
 	depends on DRM && X86 && PCI
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
+	select DRM_TTM
+	select DRM_TTM_HELPER
 	select GENERIC_ALLOCATOR
 	help
 	  This is a KMS driver for the virtual Graphics Card used in
-- 
2.18.1

