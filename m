Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E41C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B0F217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AX+5tIq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfC2LfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:35:20 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:57920 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfC2LfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:35:20 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x2TBWphT012559;
        Fri, 29 Mar 2019 20:32:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x2TBWphT012559
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553859173;
        bh=tEJutIG3Lh/EZkRCNYRIQ9ceoZoPdFp7/y8BL0YMjyY=;
        h=From:To:Cc:Subject:Date:From;
        b=AX+5tIq8j4ohThNs6xJDKIPJdON3aYv91vuxqpuqEiHXTPA3BK75CKGm+CP1msmDw
         yC1URWCQwcJoXdoSwfXeK4TqIRypGy4uAP5KixRISBC9qlicfRLXmAzlV6TGLKWNxH
         TYRemkI9COgy8w0X5+z30SWyOy6SZDfnvkESm1UrBSntV8ML5EzFfQrVc7ZRNdIwct
         HuyrHaW96dtuVANjcsF+Hn/JfsMnSm9XHwUiRZc4fLehrYOror9sGuJkD/S3snRYmH
         Zbz8XwQc+/+IuCr9zY7zSgxtzJUtXrOukqKR72Wd1cUh9ApYEVyAOEXTZci4R/F8GZ
         Aoo2kb2QMwYqA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sean Paul <sean@poorly.run>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Brian Starkey <brian.starkey@arm.com>,
        intel-gvt-dev@lists.freedesktop.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        freedreno@lists.freedesktop.org
Subject: [PATCH v2] drm: prefix header search paths with $(srctree)/
Date:   Fri, 29 Mar 2019 20:32:41 +0900
Message-Id: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the Kbuild core manipulates header search paths in a crazy
way [1].

To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
the search paths in the srctree. Some Makefiles are already written in
that way, but not all. The goal of this work is to make the notation
consistent, and finally get rid of the gross hacks.

Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
("kbuild: do not drop -I without parameter").

[1]: https://patchwork.kernel.org/patch/9632347/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---

I put all gpu/drm changes into a single patch because
they are trivial conversion.

If you are interested in the big picture of this work,
the full patch set is available at the following URL.

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test


Changes in v2:
  - fix up the new driver komeda
  - Add Sam's Reviewed-by

 drivers/gpu/drm/amd/amdgpu/Makefile         | 2 +-
 drivers/gpu/drm/amd/lib/Makefile            | 2 +-
 drivers/gpu/drm/arm/display/komeda/Makefile | 4 ++--
 drivers/gpu/drm/i915/gvt/Makefile           | 2 +-
 drivers/gpu/drm/msm/Makefile                | 6 +++---
 drivers/gpu/drm/nouveau/Kbuild              | 8 ++++----
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 466da59..62bf9da 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-FULL_AMD_PATH=$(src)/..
+FULL_AMD_PATH=$(srctree)/$(src)/..
 DISPLAY_FOLDER_NAME=display
 FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
 
diff --git a/drivers/gpu/drm/amd/lib/Makefile b/drivers/gpu/drm/amd/lib/Makefile
index 6902430..d534992 100644
--- a/drivers/gpu/drm/amd/lib/Makefile
+++ b/drivers/gpu/drm/amd/lib/Makefile
@@ -27,6 +27,6 @@
 # driver components or later moved to kernel/lib for sharing with
 # other drivers.
 
-ccflags-y := -I$(src)/../include
+ccflags-y := -I $(srctree)/$(src)/../include
 
 obj-$(CONFIG_CHASH) += chash.o
diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/arm/display/komeda/Makefile
index 1b875e5..a72e30c 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ccflags-y := \
-	-I$(src)/../include \
-	-I$(src)
+	-I $(srctree)/$(src)/../include \
+	-I $(srctree)/$(src)
 
 komeda-y := \
 	komeda_drv.o \
diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
index 271fb46..ea8324a 100644
--- a/drivers/gpu/drm/i915/gvt/Makefile
+++ b/drivers/gpu/drm/i915/gvt/Makefile
@@ -5,5 +5,5 @@ GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
 	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
 	fb_decoder.o dmabuf.o page_track.o
 
-ccflags-y				+= -I$(src) -I$(src)/$(GVT_DIR)
+ccflags-y				+= -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
 i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 56a70c7..b7b1ebd 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y := -Idrivers/gpu/drm/msm
-ccflags-y += -Idrivers/gpu/drm/msm/disp/dpu1
-ccflags-$(CONFIG_DRM_MSM_DSI) += -Idrivers/gpu/drm/msm/dsi
+ccflags-y := -I $(srctree)/$(src)
+ccflags-y += -I $(srctree)/$(src)/disp/dpu1
+ccflags-$(CONFIG_DRM_MSM_DSI) += -I $(srctree)/$(src)/dsi
 
 msm-y := \
 	adreno/adreno_device.o \
diff --git a/drivers/gpu/drm/nouveau/Kbuild b/drivers/gpu/drm/nouveau/Kbuild
index ea3035e..4fae728 100644
--- a/drivers/gpu/drm/nouveau/Kbuild
+++ b/drivers/gpu/drm/nouveau/Kbuild
@@ -1,7 +1,7 @@
-ccflags-y += -I$(src)/include
-ccflags-y += -I$(src)/include/nvkm
-ccflags-y += -I$(src)/nvkm
-ccflags-y += -I$(src)
+ccflags-y += -I $(srctree)/$(src)/include
+ccflags-y += -I $(srctree)/$(src)/include/nvkm
+ccflags-y += -I $(srctree)/$(src)/nvkm
+ccflags-y += -I $(srctree)/$(src)
 
 # NVKM - HW resource manager
 #- code also used by various userspace tools/tests
-- 
2.7.4

