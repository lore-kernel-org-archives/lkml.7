Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A5FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6672238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Fv54TOX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfGYNVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:21:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42606 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYNVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:21:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so858626wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7EMLPA/uXshrhX8tUHlB7rWmq/Bv+vAhoVTbSln7+0=;
        b=Fv54TOX6FNJ//eMWDstY7AgTcgwfVv92yemrD2sdaPfTVJkl9bvR8YctNNHR7vFO8c
         4nlTgnbMX0MR5gO1wxfGjqPeFdLyUBpSZeAb19UdpJXpZDdvR0kPEKDVLjPkhOC5HnAg
         Tm5O5c8BqOIN68y9LBPn9fjxRpgLMXTVhTPA63MHvZdPIRml+TG0FnhiF+JtXpSjBhaF
         NmjFUf5xfeDe/0CqyrXSV7nLW8WgeJPH8OGpA/YGRm4/IDHcZc/WUfLm2EAKO4bwL+K6
         agWZrcuVeaztexlkKJQPKIuFrYKn0Z1+qF5UptZxyjWTe2Ng2S5K0UZwydjUxABAcpY2
         OWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7EMLPA/uXshrhX8tUHlB7rWmq/Bv+vAhoVTbSln7+0=;
        b=ReVlK9ooDgFAFkp/nn5cB0SIf/yaHfS5aZzbRCo+lUZxZ8hXbrTSXUwDVC7aAFHJTA
         FE74HdA4ywvbH9Kur79EtYSc2ylDymFzl24f2GVg4IhP+G4dP/RL2Rx6GIaILYEuVyi9
         YB4KFR+oU4FcaL/VanPYF7i70cZjm6CVXJ5HrcSqgKt2B2Nx8PsnAuzVHX/RN2xPT4aq
         H+T1hqDUjJmDEEa628kb/fwAfbam/WUp4adO07ML/LlGfBisycPvgGHNAKKUmRCMK/2j
         bUx7gxogfOhGeP+wy7bbsJ2BvskIHO0b2dm3ob9PSq+Zrq2p2AHjyD2C6FkGNiEzm5Tr
         pIQg==
X-Gm-Message-State: APjAAAVGfcyGntkSP9hseVf1AB5VK5P4xMridY1FbHehIpeF/QTNu3xb
        tgnfiCAPAWT2kUjjROW15N/wLjQL
X-Google-Smtp-Source: APXvYqwhue3g07/6fWFKzYTLHvyOYNdW84QPVWg4Kj7bJgNFcVQJynkcYGxefKduUaJtACggHVm8Xg==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr19767933wrn.11.1564060383337;
        Thu, 25 Jul 2019 06:13:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id z7sm47119735wrh.67.2019.07.25.06.13.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 06:13:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/5] staging: media/davinci_vpfe: fix pinmux setup compilation
Date:   Thu, 25 Jul 2019 15:12:53 +0200
Message-Id: <20190725131257.6142-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725131257.6142-1-brgl@bgdev.pl>
References: <20190725131257.6142-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This fixes the following build error in davinci_vpfe.

/git/arm-soc/drivers/staging/media/davinci_vpfe/dm365_isif.c: In function 'vpfe_isif_init':
/git/arm-soc/drivers/staging/media/davinci_vpfe/dm365_isif.c:2031:2: error: implicit declaration of function 'davinci_cfg_reg'; did you mean 'omap_cfg_reg'? [-Werror=implicit-function-declaration]
  davinci_cfg_reg(DM365_VIN_CAM_WEN);
  ^~~~~~~~~~~~~~~
  omap_cfg_reg
/git/arm-soc/drivers/staging/media/davinci_vpfe/dm365_isif.c:2031:18: error: 'DM365_VIN_CAM_WEN' undeclared (first use in this function); did you mean 'DM365_ISIF_MAX_CLDC'?
  davinci_cfg_reg(DM365_VIN_CAM_WEN);
                  ^~~~~~~~~~~~~~~~~

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/staging/media/davinci_vpfe/Makefile     | 5 -----
 drivers/staging/media/davinci_vpfe/dm365_isif.c | 8 +++-----
 drivers/staging/media/davinci_vpfe/dm365_isif.h | 2 --
 drivers/staging/media/davinci_vpfe/vpfe.h       | 2 ++
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/davinci_vpfe/Makefile b/drivers/staging/media/davinci_vpfe/Makefile
index 0ae8c5014f74..3b93e0583940 100644
--- a/drivers/staging/media/davinci_vpfe/Makefile
+++ b/drivers/staging/media/davinci_vpfe/Makefile
@@ -4,8 +4,3 @@ obj-$(CONFIG_VIDEO_DM365_VPFE) += davinci-vfpe.o
 davinci-vfpe-objs := \
 	dm365_isif.o dm365_ipipe_hw.o dm365_ipipe.o \
 	dm365_resizer.o dm365_ipipeif.o vpfe_mc_capture.o vpfe_video.o
-
-# Allow building it with COMPILE_TEST on other archs
-ifndef CONFIG_ARCH_DAVINCI
-ccflags-y += -I $(srctree)/arch/arm/mach-davinci/include/
-endif
diff --git a/drivers/staging/media/davinci_vpfe/dm365_isif.c b/drivers/staging/media/davinci_vpfe/dm365_isif.c
index 05a997f7aa5d..5cfd52ea3ba7 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_isif.c
+++ b/drivers/staging/media/davinci_vpfe/dm365_isif.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/delay.h>
+#include "vpfe.h"
 #include "dm365_isif.h"
 #include "vpfe_mc_capture.h"
 
@@ -1983,6 +1984,7 @@ int vpfe_isif_init(struct vpfe_isif_device *isif, struct platform_device *pdev)
 	struct v4l2_subdev *sd = &isif->subdev;
 	struct media_pad *pads = &isif->pads[0];
 	struct media_entity *me = &sd->entity;
+	struct vpfe_config *cfg = pdev->dev.platform_data;
 	static resource_size_t res_len;
 	struct resource *res;
 	void __iomem *addr;
@@ -2023,11 +2025,7 @@ int vpfe_isif_init(struct vpfe_isif_device *isif, struct platform_device *pdev)
 		}
 		i++;
 	}
-	davinci_cfg_reg(DM365_VIN_CAM_WEN);
-	davinci_cfg_reg(DM365_VIN_CAM_VD);
-	davinci_cfg_reg(DM365_VIN_CAM_HD);
-	davinci_cfg_reg(DM365_VIN_YIN4_7_EN);
-	davinci_cfg_reg(DM365_VIN_YIN0_3_EN);
+	cfg->isif_setup_pinmux();
 
 	/* queue ops */
 	isif->video_out.ops = &isif_video_ops;
diff --git a/drivers/staging/media/davinci_vpfe/dm365_isif.h b/drivers/staging/media/davinci_vpfe/dm365_isif.h
index 0e1fe472fb2b..82eeba9c24c2 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_isif.h
+++ b/drivers/staging/media/davinci_vpfe/dm365_isif.h
@@ -21,8 +21,6 @@
 
 #include <linux/platform_device.h>
 
-#include <mach/mux.h>
-
 #include <media/davinci/vpfe_types.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
diff --git a/drivers/staging/media/davinci_vpfe/vpfe.h b/drivers/staging/media/davinci_vpfe/vpfe.h
index 1f8e011fc162..54ef6720ceeb 100644
--- a/drivers/staging/media/davinci_vpfe/vpfe.h
+++ b/drivers/staging/media/davinci_vpfe/vpfe.h
@@ -74,6 +74,8 @@ struct vpfe_config {
 	char *card_name;
 	/* setup function for the input path */
 	int (*setup_input)(enum vpfe_subdev_id id);
+	/* point to dm365_isif_setup_pinmux() */
+	void (*isif_setup_pinmux)(void);
 	/* number of clocks */
 	int num_clocks;
 	/* clocks used for vpfe capture */
-- 
2.21.0

