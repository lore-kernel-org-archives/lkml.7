Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5678C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9782086C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5/SKrj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfHQHl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 03:41:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46793 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfHQHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 03:41:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id m3so3463584pgv.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Rwq01trDayAP0H8fPQiQ3OK+pDaf4XqEAWP3N7Fklg=;
        b=F5/SKrj19TvAFxsRdmKEA3E1BeZi1BZY3gYsu2P/j3rhQrzutx2eFjVCNP2UcPIhA+
         FSQXkiNrcM+pugWNRaQeKEmMzquzIb3SSU3E5Tajw+Pmc+pM/rQAJdVqnIMZ/QW0vxrK
         PVJOObQjz0+XWKS1fqZFURZ1eNv+OLkuBEMVt3f6pFrhjDDHJ0j/zxg4x7ldFkaEZdG+
         dEmeepUCNWBN789PWS9FjS51yz2tegXK5Nt7OGfS0UdDe5QC3xL1E9kv20gUx/I1QGNH
         mVsEfnydgzmj437xSoPVNj1zKcRxcFoP5pYCpakLtjlQPHC7Yj0fmRfiuFB0dDYvQ/3Z
         vvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Rwq01trDayAP0H8fPQiQ3OK+pDaf4XqEAWP3N7Fklg=;
        b=gM17542ZxPrZ7D0pxYFGxEHysMs0vU4VFlvwsdqLM0cBkZLgO4hw46XJ/MxOwRhvkg
         H+hp1eGcWc45z/J6kWmI4KrgnzWAA3c8wIri9VH4jBZou4NSu5+rsIrXtJQJQUIGWSB+
         rYndmtq2aYOc7lLFXZ0Yo48x3Es/y+FgfHvUVQUfJVO8GY/VYF+klHvMGWGZPRLX3bKU
         dkufT3ra1ibAoExs1lOpPyYJd3JlmXS8PFLyL3nJ0um5bcmjVzRxulC3RuBh6Z7sTxe0
         zUBu1Njw1sqw7bz78KjAxLwnB/LPVNGe6BGpPZu9X0BCZL35vHglhebCDcBMMsXj0vdk
         l3Cw==
X-Gm-Message-State: APjAAAWubDP70xdIpd68CSjQtoYh9VLtUq96o78Ayq88Nkw+1pxhigsi
        VDkBE4FkivEILEhwQLRDdnM=
X-Google-Smtp-Source: APXvYqyLmWb3dQ7qXtS549lXT8H1MYxaTwCa5Dld/jmB2LxOOgdTHnndm9HVYHD4rwkqLpCVKQRotA==
X-Received: by 2002:a17:90a:b946:: with SMTP id f6mr10986185pjw.86.1566027686217;
        Sat, 17 Aug 2019 00:41:26 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id 5sm7285317pgh.93.2019.08.17.00.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 00:41:25 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Sidong Yang <realwakka@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/arm: drop use of drmP.h
Date:   Sat, 17 Aug 2019 08:41:15 +0100
Message-Id: <20190817074115.19116-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop use of deprecated drmP.h header file.
Remove drmP.h includes and add some include headers for function or
struct that used in code.
---
 drivers/gpu/drm/arm/hdlcd_crtc.c    | 2 +-
 drivers/gpu/drm/arm/hdlcd_drv.c     | 6 +++++-
 drivers/gpu/drm/arm/malidp_crtc.c   | 4 +++-
 drivers/gpu/drm/arm/malidp_drv.c    | 4 +++-
 drivers/gpu/drm/arm/malidp_drv.h    | 1 -
 drivers/gpu/drm/arm/malidp_hw.c     | 7 ++++++-
 drivers/gpu/drm/arm/malidp_mw.c     | 2 +-
 drivers/gpu/drm/arm/malidp_planes.c | 4 +++-
 8 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index a3efa28436ea..8285ff3e9991 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -9,7 +9,6 @@
  *  Implementation of a CRTC class for the HDLCD driver.
  */
 
-#include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
@@ -19,6 +18,7 @@
 #include <drm/drm_of.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
 #include <linux/clk.h>
 #include <linux/of_graph.h>
 #include <linux/platform_data/simplefb.h>
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 27c46a2838c5..c2a59712cf46 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -9,6 +9,7 @@
  *  ARM HDLCD Driver
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/clk.h>
@@ -17,18 +18,21 @@
 #include <linux/list.h>
 #include <linux/of_graph.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
-#include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_irq.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
 
 #include "hdlcd_drv.h"
 #include "hdlcd_regs.h"
diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
index db4451260fff..3735554f61bf 100644
--- a/drivers/gpu/drm/arm/malidp_crtc.c
+++ b/drivers/gpu/drm/arm/malidp_crtc.c
@@ -6,11 +6,13 @@
  * ARM Mali DP500/DP550/DP650 driver (crtc operations)
  */
 
-#include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
+
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <video/videomode.h>
diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index c27ff456eddc..2a13490e5dbb 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -15,17 +15,19 @@
 #include <linux/pm_runtime.h>
 #include <linux/debugfs.h>
 
-#include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_of.h>
+#include <drm/drm_vblank.h>
 
 #include "malidp_drv.h"
 #include "malidp_mw.h"
diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_drv.h
index 0a639af8337e..a57edff55f2c 100644
--- a/drivers/gpu/drm/arm/malidp_drv.h
+++ b/drivers/gpu/drm/arm/malidp_drv.h
@@ -14,7 +14,6 @@
 #include <linux/mutex.h>
 #include <linux/wait.h>
 #include <linux/spinlock.h>
-#include <drm/drmP.h>
 #include "malidp_hw.h"
 
 #define MALIDP_CONFIG_VALID_INIT	0
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 380be66d4c6e..f66d6b4bdaab 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -9,9 +9,14 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/io.h>
-#include <drm/drmP.h>
+
+#include <drm/drm_fourcc.h>
+#include <drm/drm_print.h>
+#include <drm/drm_vblank.h>
+
 #include <video/videomode.h>
 #include <video/display_timing.h>
 
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index 2e812525025d..c2f5ba52c8aa 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -10,8 +10,8 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
-#include <drm/drmP.h>
 #include <drm/drm_writeback.h>
 
 #include "malidp_drv.h"
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 488375bd133d..3c70a53813bf 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -7,11 +7,13 @@
  */
 
 #include <linux/iommu.h>
+#include <linux/platform_device.h>
 
-#include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_plane_helper.h>
-- 
2.20.1

