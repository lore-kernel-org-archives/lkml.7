Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB6CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7533320830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfDCHXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:23:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfDCHXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:23:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C317A30833A4;
        Wed,  3 Apr 2019 07:23:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B59A562674;
        Wed,  3 Apr 2019 07:23:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0BD211750B; Wed,  3 Apr 2019 09:23:18 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list),
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE)
Subject: [PATCH] drm/cirrus: rewrite and modernize driver.
Date:   Wed,  3 Apr 2019 09:23:17 +0200
Message-Id: <20190403072318.31507-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 03 Apr 2019 07:23:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Time to kill some bad sample code people are copying from ;)

This is a complete rewrite of the cirrus driver.  The cirrus_mode_set()
function is pretty much the only function which is carried over largely
unmodified.  Everything else is upside down.

It is a single monster patch.  But given that it does some pretty
fundamental changes to the drivers workflow and also reduces the code
size by roughly 70% I think it'll still be alot easier to review than a
longish baby-step patch series.

Changes summary:
 - Given the small amout of video memory (4 MB) the cirrus device has
   the rewritten driver doesn't try to manage buffers there.  Instead
   it will blit (memcpy) the active framebuffer to video memory.
 - All gem objects are stored in main memory and are manged using the
   new shmem helpers.  ttm is out.
 - Only DRM_FORMAT_RGB565 (depth 16) is supported.  The old driver does
   that too by default.  There was a module parameter which enables 24/32
   bpp support and disables higher resolutions (due to cirrus hardware
   constrains).  That parameter wasn't reimplemented.
 - The simple display pipeline is used.
 - The generic fbdev emulation is used.
 - It's a atomic driver now.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus_drv.h   | 251 -----------
 drivers/gpu/drm/cirrus/cirrus.c       | 602 +++++++++++++++++++++++++
 drivers/gpu/drm/cirrus/cirrus_drv.c   | 161 -------
 drivers/gpu/drm/cirrus/cirrus_fbdev.c | 309 -------------
 drivers/gpu/drm/cirrus/cirrus_main.c  | 328 --------------
 drivers/gpu/drm/cirrus/cirrus_mode.c  | 617 --------------------------
 drivers/gpu/drm/cirrus/cirrus_ttm.c   | 343 --------------
 drivers/gpu/drm/cirrus/Kconfig        |   2 +-
 drivers/gpu/drm/cirrus/Makefile       |   3 -
 9 files changed, 603 insertions(+), 2013 deletions(-)
 delete mode 100644 drivers/gpu/drm/cirrus/cirrus_drv.h
 create mode 100644 drivers/gpu/drm/cirrus/cirrus.c
 delete mode 100644 drivers/gpu/drm/cirrus/cirrus_drv.c
 delete mode 100644 drivers/gpu/drm/cirrus/cirrus_fbdev.c
 delete mode 100644 drivers/gpu/drm/cirrus/cirrus_main.c
 delete mode 100644 drivers/gpu/drm/cirrus/cirrus_mode.c
 delete mode 100644 drivers/gpu/drm/cirrus/cirrus_ttm.c

diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.h b/drivers/gpu/drm/cirrus/cirrus_drv.h
deleted file mode 100644
index 828b150cdb20..000000000000
--- a/drivers/gpu/drm/cirrus/cirrus_drv.h
+++ /dev/null
@@ -1,251 +0,0 @@
-/*
- * Copyright 2012 Red Hat
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License version 2. See the file COPYING in the main
- * directory of this archive for more details.
- *
- * Authors: Matthew Garrett
- *          Dave Airlie
- */
-#ifndef __CIRRUS_DRV_H__
-#define __CIRRUS_DRV_H__
-
-#include <video/vga.h>
-
-#include <drm/drm_encoder.h>
-#include <drm/drm_fb_helper.h>
-
-#include <drm/ttm/ttm_bo_api.h>
-#include <drm/ttm/ttm_bo_driver.h>
-#include <drm/ttm/ttm_placement.h>
-#include <drm/ttm/ttm_memory.h>
-#include <drm/ttm/ttm_module.h>
-
-#include <drm/drm_gem.h>
-
-#define DRIVER_AUTHOR		"Matthew Garrett"
-
-#define DRIVER_NAME		"cirrus"
-#define DRIVER_DESC		"qemu Cirrus emulation"
-#define DRIVER_DATE		"20110418"
-
-#define DRIVER_MAJOR		1
-#define DRIVER_MINOR		0
-#define DRIVER_PATCHLEVEL	0
-
-#define CIRRUSFB_CONN_LIMIT 1
-
-#define RREG8(reg) ioread8(((void __iomem *)cdev->rmmio) + (reg))
-#define WREG8(reg, v) iowrite8(v, ((void __iomem *)cdev->rmmio) + (reg))
-#define RREG32(reg) ioread32(((void __iomem *)cdev->rmmio) + (reg))
-#define WREG32(reg, v) iowrite32(v, ((void __iomem *)cdev->rmmio) + (reg))
-
-#define SEQ_INDEX 4
-#define SEQ_DATA 5
-
-#define WREG_SEQ(reg, v)					\
-	do {							\
-		WREG8(SEQ_INDEX, reg);				\
-		WREG8(SEQ_DATA, v);				\
-	} while (0)						\
-
-#define CRT_INDEX 0x14
-#define CRT_DATA 0x15
-
-#define WREG_CRT(reg, v)					\
-	do {							\
-		WREG8(CRT_INDEX, reg);				\
-		WREG8(CRT_DATA, v);				\
-	} while (0)						\
-
-#define GFX_INDEX 0xe
-#define GFX_DATA 0xf
-
-#define WREG_GFX(reg, v)					\
-	do {							\
-		WREG8(GFX_INDEX, reg);				\
-		WREG8(GFX_DATA, v);				\
-	} while (0)						\
-
-/*
- * Cirrus has a "hidden" DAC register that can be accessed by writing to
- * the pixel mask register to reset the state, then reading from the register
- * four times. The next write will then pass to the DAC
- */
-#define VGA_DAC_MASK 0x6
-
-#define WREG_HDR(v)						\
-	do {							\
-		RREG8(VGA_DAC_MASK);					\
-		RREG8(VGA_DAC_MASK);					\
-		RREG8(VGA_DAC_MASK);					\
-		RREG8(VGA_DAC_MASK);					\
-		WREG8(VGA_DAC_MASK, v);					\
-	} while (0)						\
-
-
-#define CIRRUS_MAX_FB_HEIGHT 4096
-#define CIRRUS_MAX_FB_WIDTH 4096
-
-#define CIRRUS_DPMS_CLEARED (-1)
-
-#define to_cirrus_crtc(x) container_of(x, struct cirrus_crtc, base)
-#define to_cirrus_encoder(x) container_of(x, struct cirrus_encoder, base)
-
-struct cirrus_crtc {
-	struct drm_crtc			base;
-	int				last_dpms;
-	bool				enabled;
-};
-
-struct cirrus_fbdev;
-struct cirrus_mode_info {
-	struct cirrus_crtc		*crtc;
-	/* pointer to fbdev info structure */
-	struct cirrus_fbdev		*gfbdev;
-};
-
-struct cirrus_encoder {
-	struct drm_encoder		base;
-	int				last_dpms;
-};
-
-struct cirrus_connector {
-	struct drm_connector		base;
-};
-
-struct cirrus_mc {
-	resource_size_t			vram_size;
-	resource_size_t			vram_base;
-};
-
-struct cirrus_device {
-	struct drm_device		*dev;
-	unsigned long			flags;
-
-	resource_size_t			rmmio_base;
-	resource_size_t			rmmio_size;
-	void __iomem			*rmmio;
-
-	struct cirrus_mc			mc;
-	struct cirrus_mode_info		mode_info;
-
-	int				num_crtc;
-	int fb_mtrr;
-
-	struct {
-		struct ttm_bo_device bdev;
-	} ttm;
-	bool mm_inited;
-};
-
-
-struct cirrus_fbdev {
-	struct drm_fb_helper helper; /* must be first */
-	struct drm_framebuffer *gfb;
-	void *sysram;
-	int size;
-	int x1, y1, x2, y2; /* dirty rect */
-	spinlock_t dirty_lock;
-};
-
-struct cirrus_bo {
-	struct ttm_buffer_object bo;
-	struct ttm_placement placement;
-	struct ttm_bo_kmap_obj kmap;
-	struct drm_gem_object gem;
-	struct ttm_place placements[3];
-	int pin_count;
-};
-#define gem_to_cirrus_bo(gobj) container_of((gobj), struct cirrus_bo, gem)
-
-static inline struct cirrus_bo *
-cirrus_bo(struct ttm_buffer_object *bo)
-{
-	return container_of(bo, struct cirrus_bo, bo);
-}
-
-
-#define to_cirrus_obj(x) container_of(x, struct cirrus_gem_object, base)
-#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
-
-				/* cirrus_main.c */
-int cirrus_device_init(struct cirrus_device *cdev,
-		      struct drm_device *ddev,
-		      struct pci_dev *pdev,
-		      uint32_t flags);
-void cirrus_device_fini(struct cirrus_device *cdev);
-void cirrus_gem_free_object(struct drm_gem_object *obj);
-int cirrus_dumb_mmap_offset(struct drm_file *file,
-			    struct drm_device *dev,
-			    uint32_t handle,
-			    uint64_t *offset);
-int cirrus_gem_create(struct drm_device *dev,
-		   u32 size, bool iskernel,
-		      struct drm_gem_object **obj);
-int cirrus_dumb_create(struct drm_file *file,
-		    struct drm_device *dev,
-		       struct drm_mode_create_dumb *args);
-
-int cirrus_framebuffer_init(struct drm_device *dev,
-			    struct drm_framebuffer *gfb,
-			    const struct drm_mode_fb_cmd2 *mode_cmd,
-			    struct drm_gem_object *obj);
-
-bool cirrus_check_framebuffer(struct cirrus_device *cdev, int width, int height,
-			      int bpp, int pitch);
-
-				/* cirrus_display.c */
-int cirrus_modeset_init(struct cirrus_device *cdev);
-void cirrus_modeset_fini(struct cirrus_device *cdev);
-
-				/* cirrus_fbdev.c */
-int cirrus_fbdev_init(struct cirrus_device *cdev);
-void cirrus_fbdev_fini(struct cirrus_device *cdev);
-
-
-
-				/* cirrus_irq.c */
-void cirrus_driver_irq_preinstall(struct drm_device *dev);
-int cirrus_driver_irq_postinstall(struct drm_device *dev);
-void cirrus_driver_irq_uninstall(struct drm_device *dev);
-irqreturn_t cirrus_driver_irq_handler(int irq, void *arg);
-
-				/* cirrus_kms.c */
-int cirrus_driver_load(struct drm_device *dev, unsigned long flags);
-void cirrus_driver_unload(struct drm_device *dev);
-extern struct drm_ioctl_desc cirrus_ioctls[];
-extern int cirrus_max_ioctl;
-
-int cirrus_mm_init(struct cirrus_device *cirrus);
-void cirrus_mm_fini(struct cirrus_device *cirrus);
-void cirrus_ttm_placement(struct cirrus_bo *bo, int domain);
-int cirrus_bo_create(struct drm_device *dev, int size, int align,
-		     uint32_t flags, struct cirrus_bo **pcirrusbo);
-int cirrus_mmap(struct file *filp, struct vm_area_struct *vma);
-
-static inline int cirrus_bo_reserve(struct cirrus_bo *bo, bool no_wait)
-{
-	int ret;
-
-	ret = ttm_bo_reserve(&bo->bo, true, no_wait, NULL);
-	if (ret) {
-		if (ret != -ERESTARTSYS && ret != -EBUSY)
-			DRM_ERROR("reserve failed %p\n", bo);
-		return ret;
-	}
-	return 0;
-}
-
-static inline void cirrus_bo_unreserve(struct cirrus_bo *bo)
-{
-	ttm_bo_unreserve(&bo->bo);
-}
-
-int cirrus_bo_push_sysram(struct cirrus_bo *bo);
-int cirrus_bo_pin(struct cirrus_bo *bo, u32 pl_flag, u64 *gpu_addr);
-
-extern int cirrus_bpp;
-
-#endif				/* __CIRRUS_DRV_H__ */
diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
new file mode 100644
index 000000000000..e27bb13fc777
--- /dev/null
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -0,0 +1,602 @@
+/*
+ * Copyright 2012-2019 Red Hat
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License version 2. See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * Authors: Matthew Garrett
+ *	    Dave Airlie
+ *	    Gerd Hoffmann
+ *
+ * Portions of this code derived from cirrusfb.c:
+ * drivers/video/cirrusfb.c - driver for Cirrus Logic chipsets
+ *
+ * Copyright 1999-2001 Jeff Garzik <jgarzik@pobox.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/console.h>
+
+#include <video/vga.h>
+#include <video/cirrus.h>
+
+#include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+#include <drm/drm_ioctl.h>
+#include <drm/drm_vblank.h>
+#include <drm/drm_connector.h>
+
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_helper.h>
+
+#define DRIVER_NAME "cirrus"
+#define DRIVER_DESC "qemu cirrus vga"
+#define DRIVER_DATE "2019"
+#define DRIVER_MAJOR 2
+#define DRIVER_MINOR 0
+
+struct cirrus_device {
+	struct drm_device	       *dev;
+	struct drm_simple_display_pipe pipe;
+	struct drm_connector	       conn;
+	unsigned int		       bpp;
+	unsigned int		       pitch;
+	void __iomem		       *vram;
+	void __iomem		       *mmio;
+};
+
+/* ------------------------------------------------------------------ */
+/*
+ * The meat of this driver. The core passes us a mode and we have to program
+ * it. The modesetting here is the bare minimum required to satisfy the qemu
+ * emulation of this hardware, and running this against a real device is
+ * likely to result in an inadequately programmed mode. We've already had
+ * the opportunity to modify the mode, so whatever we receive here should
+ * be something that can be correctly programmed and displayed
+ */
+
+#define RREG8(reg) ioread8(((void __iomem *)cirrus->mmio) + (reg))
+#define WREG8(reg, v) iowrite8(v, ((void __iomem *)cirrus->mmio) + (reg))
+#define RREG32(reg) ioread32(((void __iomem *)cirrus->mmio) + (reg))
+#define WREG32(reg, v) iowrite32(v, ((void __iomem *)cirrus->mmio) + (reg))
+
+#define SEQ_INDEX 4
+#define SEQ_DATA 5
+
+#define WREG_SEQ(reg, v)					\
+	do {							\
+		WREG8(SEQ_INDEX, reg);				\
+		WREG8(SEQ_DATA, v);				\
+	} while (0)						\
+
+#define CRT_INDEX 0x14
+#define CRT_DATA 0x15
+
+#define WREG_CRT(reg, v)					\
+	do {							\
+		WREG8(CRT_INDEX, reg);				\
+		WREG8(CRT_DATA, v);				\
+	} while (0)						\
+
+#define GFX_INDEX 0xe
+#define GFX_DATA 0xf
+
+#define WREG_GFX(reg, v)					\
+	do {							\
+		WREG8(GFX_INDEX, reg);				\
+		WREG8(GFX_DATA, v);				\
+	} while (0)						\
+
+#define VGA_DAC_MASK 0x6
+
+#define WREG_HDR(v)						\
+	do {							\
+		RREG8(VGA_DAC_MASK);				\
+		RREG8(VGA_DAC_MASK);				\
+		RREG8(VGA_DAC_MASK);				\
+		RREG8(VGA_DAC_MASK);				\
+		WREG8(VGA_DAC_MASK, v);				\
+	} while (0)						\
+
+
+static int cirrus_mode_set(struct cirrus_device *cirrus,
+			   struct drm_crtc_state *crtc_state)
+{
+	struct drm_display_mode *mode = &crtc_state->mode;
+	int hsyncstart, hsyncend, htotal, hdispend;
+	int vtotal, vdispend;
+	int tmp;
+	int sr07 = 0, hdr = 0;
+
+	htotal = mode->htotal / 8;
+	hsyncend = mode->hsync_end / 8;
+	hsyncstart = mode->hsync_start / 8;
+	hdispend = mode->hdisplay / 8;
+
+	vtotal = mode->vtotal;
+	vdispend = mode->vdisplay;
+
+	vdispend -= 1;
+	vtotal -= 2;
+
+	htotal -= 5;
+	hdispend -= 1;
+	hsyncstart += 1;
+	hsyncend += 1;
+
+	WREG_CRT(VGA_CRTC_V_SYNC_END, 0x20);
+	WREG_CRT(VGA_CRTC_H_TOTAL, htotal);
+	WREG_CRT(VGA_CRTC_H_DISP, hdispend);
+	WREG_CRT(VGA_CRTC_H_SYNC_START, hsyncstart);
+	WREG_CRT(VGA_CRTC_H_SYNC_END, hsyncend);
+	WREG_CRT(VGA_CRTC_V_TOTAL, vtotal & 0xff);
+	WREG_CRT(VGA_CRTC_V_DISP_END, vdispend & 0xff);
+
+	tmp = 0x40;
+	if ((vdispend + 1) & 512)
+		tmp |= 0x20;
+	WREG_CRT(VGA_CRTC_MAX_SCAN, tmp);
+
+	/*
+	 * Overflow bits for values that don't fit in the standard registers
+	 */
+	tmp = 16;
+	if (vtotal & 256)
+		tmp |= 1;
+	if (vdispend & 256)
+		tmp |= 2;
+	if ((vdispend + 1) & 256)
+		tmp |= 8;
+	if (vtotal & 512)
+		tmp |= 32;
+	if (vdispend & 512)
+		tmp |= 64;
+	WREG_CRT(VGA_CRTC_OVERFLOW, tmp);
+
+	tmp = 0;
+
+	/* More overflow bits */
+
+	if ((htotal + 5) & 64)
+		tmp |= 16;
+	if ((htotal + 5) & 128)
+		tmp |= 32;
+	if (vtotal & 256)
+		tmp |= 64;
+	if (vtotal & 512)
+		tmp |= 128;
+
+	WREG_CRT(CL_CRT1A, tmp);
+
+	/* Disable Hercules/CGA compatibility */
+	WREG_CRT(VGA_CRTC_MODE, 0x03);
+
+	WREG8(SEQ_INDEX, 0x7);
+	sr07 = RREG8(SEQ_DATA);
+	sr07 &= 0xe0;
+	hdr = 0;
+
+	cirrus->bpp = cirrus->dev->mode_config.preferred_depth;
+	switch (cirrus->bpp) {
+	case 8:
+		sr07 |= 0x11;
+		break;
+	case 16:
+		sr07 |= 0x17;
+		hdr = 0xc1;
+		break;
+	case 24:
+		sr07 |= 0x15;
+		hdr = 0xc5;
+		break;
+	case 32:
+		sr07 |= 0x19;
+		hdr = 0xc5;
+		break;
+	default:
+		return -1;
+	}
+
+	WREG_SEQ(0x7, sr07);
+
+	/* Program the pitch */
+	cirrus->pitch = mode->hdisplay * cirrus->bpp / 8;
+	tmp = cirrus->pitch / 8;
+	WREG_CRT(VGA_CRTC_OFFSET, tmp);
+
+	/* Enable extended blanking and pitch bits, and enable full memory */
+	tmp = 0x22;
+	tmp |= (cirrus->pitch >> 7) & 0x10;
+	tmp |= (cirrus->pitch >> 6) & 0x40;
+	WREG_CRT(0x1b, tmp);
+
+	/* Enable high-colour modes */
+	WREG_GFX(VGA_GFX_MODE, 0x40);
+
+	/* And set graphics mode */
+	WREG_GFX(VGA_GFX_MISC, 0x01);
+
+	WREG_HDR(hdr);
+	/* cirrus_crtc_do_set_base(crtc, old_fb, x, y, 0); */
+
+	/* Unblank (needed on S3 resume, vgabios doesn't do it then) */
+	outb(0x20, 0x3c0);
+	return 0;
+}
+
+static int cirrus_fb_blit_clips(struct drm_framebuffer *fb,
+				struct drm_clip_rect *clips,
+				unsigned int num_clips)
+{
+	struct cirrus_device *cirrus = fb->dev->dev_private;
+	unsigned i, y, xoff, xlen, src, dst;
+	void *vmap;
+
+	vmap = drm_gem_shmem_vmap(fb->obj[0]);
+	if (!vmap)
+		return -ENOMEM;
+
+	for (i = 0; i < num_clips; i++) {
+		xoff = clips[i].x1 * cirrus->bpp / 8;
+		xlen = (clips[i].x2 - clips[i].x1) * cirrus->bpp / 8;
+		for (y = clips[i].y1; y < clips[i].y2; y++) {
+			src = xoff + y * fb->pitches[0];
+			dst = xoff + y * cirrus->pitch;
+			memcpy_toio(cirrus->vram + dst, vmap + src, xlen);
+		}
+	}
+
+	drm_gem_shmem_vunmap(fb->obj[0], vmap);
+	return 0;
+}
+
+static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
+			       struct drm_rect *rect)
+{
+	struct drm_clip_rect clip_rect = {
+		.x1 = rect->x1,
+		.x2 = rect->x2,
+		.y1 = rect->y1,
+		.y2 = rect->y2,
+	};
+	return cirrus_fb_blit_clips(fb, &clip_rect, 1);
+}
+
+static int cirrus_fb_blit_fullscreen(struct drm_framebuffer *fb)
+{
+	struct drm_clip_rect fullscreen = {
+		.x1 = 0,
+		.x2 = fb->width,
+		.y1 = 0,
+		.y2 = fb->height,
+	};
+	return cirrus_fb_blit_clips(fb, &fullscreen, 1);
+}
+
+static int cirrus_check_size(int width, int height)
+{
+	static const int max_pitch = 0x1FF << 3; /* (4096 - 1) & ~111b bytes */
+	static const int max_size = 4 * 1024 * 1024; /* 4 MB */
+	int bytes_pp = 2; /* depth 16 */
+
+	if (width * bytes_pp > max_pitch)
+		return -EINVAL;
+	if (width * height * bytes_pp > max_size)
+		return -EINVAL;
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* cirrus connector						      */
+
+static int cirrus_conn_get_modes(struct drm_connector *conn)
+{
+	int count;
+
+	count = drm_add_modes_noedid(conn,
+				     conn->dev->mode_config.max_width,
+				     conn->dev->mode_config.max_height);
+	drm_set_preferred_mode(conn, 1024, 768);
+	return count;
+}
+
+static const struct drm_connector_helper_funcs cirrus_conn_helper_funcs = {
+	.get_modes = cirrus_conn_get_modes,
+};
+
+static const struct drm_connector_funcs cirrus_conn_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int cirrus_conn_init(struct cirrus_device *cirrus)
+{
+	drm_connector_helper_add(&cirrus->conn, &cirrus_conn_helper_funcs);
+	return drm_connector_init(cirrus->dev, &cirrus->conn,
+				  &cirrus_conn_funcs, DRM_MODE_CONNECTOR_VGA);
+
+}
+
+/* ------------------------------------------------------------------ */
+/* cirrus (simple) display pipe					      */
+
+enum drm_mode_status cirrus_pipe_mode_valid(struct drm_crtc *crtc,
+					    const struct drm_display_mode *mode)
+{
+	if (cirrus_check_size(mode->hdisplay, mode->vdisplay) < 0)
+		return MODE_BAD;
+	return MODE_OK;
+}
+
+int cirrus_pipe_check(struct drm_simple_display_pipe *pipe,
+		      struct drm_plane_state *plane_state,
+		      struct drm_crtc_state *crtc_state)
+{
+	struct drm_framebuffer *fb = plane_state->fb;
+
+	if (!fb)
+		return 0;
+	return cirrus_check_size(fb->width, fb->height);
+}
+
+void cirrus_pipe_enable(struct drm_simple_display_pipe *pipe,
+			struct drm_crtc_state *crtc_state,
+			struct drm_plane_state *plane_state)
+{
+	struct cirrus_device *cirrus = pipe->crtc.dev->dev_private;
+
+	cirrus_mode_set(cirrus, crtc_state);
+	cirrus_fb_blit_fullscreen(plane_state->fb);
+}
+
+void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
+			struct drm_plane_state *old_state)
+{
+	struct drm_plane_state *state = pipe->plane.state;
+	struct drm_crtc *crtc = &pipe->crtc;
+	struct drm_rect rect;
+
+	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
+		cirrus_fb_blit_rect(pipe->plane.state->fb, &rect);
+
+	if (crtc->state->event) {
+		spin_lock_irq(&crtc->dev->event_lock);
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		spin_unlock_irq(&crtc->dev->event_lock);
+		crtc->state->event = NULL;
+	}
+}
+
+static const struct drm_simple_display_pipe_funcs cirrus_pipe_funcs = {
+	.mode_valid = cirrus_pipe_mode_valid,
+	.check	    = cirrus_pipe_check,
+	.enable	    = cirrus_pipe_enable,
+	.update	    = cirrus_pipe_update,
+};
+
+static const uint32_t cirrus_formats[] = {
+	DRM_FORMAT_RGB565,
+};
+
+static int cirrus_pipe_init(struct cirrus_device *cirrus)
+{
+	return drm_simple_display_pipe_init(cirrus->dev,
+					    &cirrus->pipe,
+					    &cirrus_pipe_funcs,
+					    cirrus_formats,
+					    ARRAY_SIZE(cirrus_formats),
+					    NULL,
+					    &cirrus->conn);
+}
+
+/* ------------------------------------------------------------------ */
+/* cirrus framebuffers & mode config				      */
+
+static int cirrus_fb_dirty(struct drm_framebuffer *fb,
+			   struct drm_file *file_priv,
+			   unsigned int flags, unsigned int color,
+			   struct drm_clip_rect *clips,
+			   unsigned int num_clips)
+{
+	struct cirrus_device *cirrus = fb->dev->dev_private;
+
+	if (cirrus->pipe.plane.state->fb != fb)
+		return 0;
+
+	if (num_clips)
+		cirrus_fb_blit_clips(fb, clips, num_clips);
+	else
+		cirrus_fb_blit_fullscreen(fb);
+	return 0;
+}
+
+static const struct drm_framebuffer_funcs cirrus_fb_funcs = {
+	.destroy = drm_gem_fb_destroy,
+	.create_handle = drm_gem_fb_create_handle,
+	.dirty = cirrus_fb_dirty,
+};
+
+static struct drm_framebuffer*
+cirrus_fb_create(struct drm_device *dev, struct drm_file *file_priv,
+		 const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	if (mode_cmd->pixel_format != DRM_FORMAT_RGB565)
+		return ERR_PTR(-EINVAL);
+	if (cirrus_check_size(mode_cmd->width, mode_cmd->height) < 0)
+		return ERR_PTR(-EINVAL);
+	return drm_gem_fb_create_with_funcs(dev, file_priv, mode_cmd,
+					    &cirrus_fb_funcs);
+}
+
+static const struct drm_mode_config_funcs cirrus_mode_config_funcs = {
+	.fb_create = cirrus_fb_create,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static void cirrus_mode_config_init(struct cirrus_device *cirrus)
+{
+	struct drm_device *dev = cirrus->dev;
+
+	drm_mode_config_init(dev);
+	dev->mode_config.min_width = 0;
+	dev->mode_config.min_height = 0;
+	dev->mode_config.max_width = 1600;
+	dev->mode_config.max_height = 1024;
+	dev->mode_config.preferred_depth = 16;
+	dev->mode_config.prefer_shadow = 0;
+	dev->mode_config.funcs = &cirrus_mode_config_funcs;
+}
+
+/* ------------------------------------------------------------------ */
+
+DEFINE_DRM_GEM_SHMEM_FOPS(cirrus_fops);
+
+static struct drm_driver cirrus_driver = {
+	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC | DRIVER_PRIME,
+
+	.name		 = DRIVER_NAME,
+	.desc		 = DRIVER_DESC,
+	.date		 = DRIVER_DATE,
+	.major		 = DRIVER_MAJOR,
+	.minor		 = DRIVER_MINOR,
+
+	.fops		 = &cirrus_fops,
+	DRM_GEM_SHMEM_DRIVER_OPS,
+};
+
+static int cirrus_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *ent)
+{
+	struct drm_device *dev;
+	struct cirrus_device *cirrus;
+	int ret;
+
+	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "cirrusdrmfb");
+	if (ret)
+		return ret;
+
+	dev = drm_dev_alloc(&cirrus_driver, &pdev->dev);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		goto err_free_dev;
+
+	ret = pci_request_regions(pdev, DRIVER_NAME);
+	if (ret)
+		goto err_free_dev;
+
+	ret = -ENOMEM;
+	cirrus = kzalloc(sizeof(*cirrus), GFP_KERNEL);
+	if (cirrus == NULL)
+		goto err_pci_release;
+	dev->dev_private = cirrus;
+	cirrus->dev = dev;
+
+	cirrus->vram = ioremap(pci_resource_start(pdev, 0),
+			       pci_resource_len(pdev, 0));
+	if (cirrus->vram == NULL)
+		goto err_free_cirrus;
+
+	cirrus->mmio = ioremap(pci_resource_start(pdev, 1),
+			       pci_resource_len(pdev, 1));
+	if (cirrus->mmio == NULL)
+		goto err_unmap_vram;
+
+	cirrus_mode_config_init(cirrus);
+
+	ret = cirrus_conn_init(cirrus);
+	if (ret < 0)
+		goto err_cleanup;
+
+	ret = cirrus_pipe_init(cirrus);
+	if (ret < 0)
+		goto err_cleanup;
+
+	drm_mode_config_reset(dev);
+
+	dev->pdev = pdev;
+	pci_set_drvdata(pdev, dev);
+	ret = drm_dev_register(dev, 0);
+	if (ret)
+		goto err_cleanup;
+
+	drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
+	return 0;
+
+err_cleanup:
+	drm_mode_config_cleanup(dev);
+	iounmap(cirrus->mmio);
+err_unmap_vram:
+	iounmap(cirrus->vram);
+err_free_cirrus:
+	kfree(cirrus);
+err_pci_release:
+	pci_release_regions(pdev);
+err_free_dev:
+	drm_dev_put(dev);
+	return ret;
+}
+
+static void cirrus_pci_remove(struct pci_dev *pdev)
+{
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct cirrus_device *cirrus = dev->dev_private;
+
+	drm_dev_unregister(dev);
+	drm_mode_config_cleanup(dev);
+	iounmap(cirrus->mmio);
+	iounmap(cirrus->vram);
+	kfree(cirrus);
+	pci_release_regions(pdev);
+	drm_dev_put(dev);
+}
+
+/* only bind to the cirrus chip in qemu */
+static const struct pci_device_id pciidlist[] = {
+	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_5446,
+	  PCI_SUBVENDOR_ID_REDHAT_QUMRANET, PCI_SUBDEVICE_ID_QEMU,
+	  0, 0, 0 },
+	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_5446,
+	  PCI_VENDOR_ID_XEN, 0x0001,
+	  0, 0, 0 },
+	{ /* end if list */}
+};
+static struct pci_driver cirrus_pci_driver = {
+	.name = DRIVER_NAME,
+	.id_table = pciidlist,
+	.probe = cirrus_pci_probe,
+	.remove = cirrus_pci_remove,
+};
+
+static int __init cirrus_init(void)
+{
+	if (vgacon_text_force())
+		return -EINVAL;
+	return pci_register_driver(&cirrus_pci_driver);
+}
+
+static void __exit cirrus_exit(void)
+{
+	pci_unregister_driver(&cirrus_pci_driver);
+}
+
+module_init(cirrus_init);
+module_exit(cirrus_exit);
+
+MODULE_DEVICE_TABLE(pci, pciidlist);
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.c b/drivers/gpu/drm/cirrus/cirrus_drv.c
deleted file mode 100644
index 8ec880f3a322..000000000000
--- a/drivers/gpu/drm/cirrus/cirrus_drv.c
+++ /dev/null
@@ -1,161 +0,0 @@
-/*
- * Copyright 2012 Red Hat <mjg@redhat.com>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License version 2. See the file COPYING in the main
- * directory of this archive for more details.
- *
- * Authors: Matthew Garrett
- *          Dave Airlie
- */
-#include <linux/module.h>
-#include <linux/console.h>
-#include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
-#include <drm/drm_probe_helper.h>
-
-#include "cirrus_drv.h"
-
-int cirrus_modeset = -1;
-int cirrus_bpp = 16;
-
-MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
-module_param_named(modeset, cirrus_modeset, int, 0400);
-MODULE_PARM_DESC(bpp, "Max bits-per-pixel (default:16)");
-module_param_named(bpp, cirrus_bpp, int, 0400);
-
-/*
- * This is the generic driver code. This binds the driver to the drm core,
- * which then performs further device association and calls our graphics init
- * functions
- */
-
-static struct drm_driver driver;
-
-/* only bind to the cirrus chip in qemu */
-static const struct pci_device_id pciidlist[] = {
-	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_5446,
-	  PCI_SUBVENDOR_ID_REDHAT_QUMRANET, PCI_SUBDEVICE_ID_QEMU,
-	  0, 0, 0 },
-	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_5446, PCI_VENDOR_ID_XEN,
-	  0x0001, 0, 0, 0 },
-	{0,}
-};
-
-
-static int cirrus_pci_probe(struct pci_dev *pdev,
-			    const struct pci_device_id *ent)
-{
-	int ret;
-
-	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "cirrusdrmfb");
-	if (ret)
-		return ret;
-
-	return drm_get_pci_dev(pdev, ent, &driver);
-}
-
-static void cirrus_pci_remove(struct pci_dev *pdev)
-{
-	struct drm_device *dev = pci_get_drvdata(pdev);
-
-	drm_put_dev(dev);
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int cirrus_pm_suspend(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct cirrus_device *cdev = drm_dev->dev_private;
-
-	drm_kms_helper_poll_disable(drm_dev);
-
-	if (cdev->mode_info.gfbdev) {
-		console_lock();
-		drm_fb_helper_set_suspend(&cdev->mode_info.gfbdev->helper, 1);
-		console_unlock();
-	}
-
-	return 0;
-}
-
-static int cirrus_pm_resume(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct cirrus_device *cdev = drm_dev->dev_private;
-
-	drm_helper_resume_force_mode(drm_dev);
-
-	if (cdev->mode_info.gfbdev) {
-		console_lock();
-		drm_fb_helper_set_suspend(&cdev->mode_info.gfbdev->helper, 0);
-		console_unlock();
-	}
-
-	drm_kms_helper_poll_enable(drm_dev);
-	return 0;
-}
-#endif
-
-static const struct file_operations cirrus_driver_fops = {
-	.owner = THIS_MODULE,
-	.open = drm_open,
-	.release = drm_release,
-	.unlocked_ioctl = drm_ioctl,
-	.mmap = cirrus_mmap,
-	.poll = drm_poll,
-	.compat_ioctl = drm_compat_ioctl,
-};
-static struct drm_driver driver = {
-	.driver_features = DRIVER_MODESET | DRIVER_GEM,
-	.load = cirrus_driver_load,
-	.unload = cirrus_driver_unload,
-	.fops = &cirrus_driver_fops,
-	.name = DRIVER_NAME,
-	.desc = DRIVER_DESC,
-	.date = DRIVER_DATE,
-	.major = DRIVER_MAJOR,
-	.minor = DRIVER_MINOR,
-	.patchlevel = DRIVER_PATCHLEVEL,
-	.gem_free_object_unlocked = cirrus_gem_free_object,
-	.dumb_create = cirrus_dumb_create,
-	.dumb_map_offset = cirrus_dumb_mmap_offset,
-};
-
-static const struct dev_pm_ops cirrus_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(cirrus_pm_suspend,
-				cirrus_pm_resume)
-};
-
-static struct pci_driver cirrus_pci_driver = {
-	.name = DRIVER_NAME,
-	.id_table = pciidlist,
-	.probe = cirrus_pci_probe,
-	.remove = cirrus_pci_remove,
-	.driver.pm = &cirrus_pm_ops,
-};
-
-static int __init cirrus_init(void)
-{
-	if (vgacon_text_force() && cirrus_modeset == -1)
-		return -EINVAL;
-
-	if (cirrus_modeset == 0)
-		return -EINVAL;
-	return pci_register_driver(&cirrus_pci_driver);
-}
-
-static void __exit cirrus_exit(void)
-{
-	pci_unregister_driver(&cirrus_pci_driver);
-}
-
-module_init(cirrus_init);
-module_exit(cirrus_exit);
-
-MODULE_DEVICE_TABLE(pci, pciidlist);
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
deleted file mode 100644
index 2e6128069fc3..000000000000
--- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
+++ /dev/null
@@ -1,309 +0,0 @@
-/*
- * Copyright 2012 Red Hat
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License version 2. See the file COPYING in the main
- * directory of this archive for more details.
- *
- * Authors: Matthew Garrett
- *          Dave Airlie
- */
-#include <linux/module.h>
-#include <drm/drmP.h>
-#include <drm/drm_util.h>
-#include <drm/drm_fb_helper.h>
-#include <drm/drm_crtc_helper.h>
-
-#include "cirrus_drv.h"
-
-static void cirrus_dirty_update(struct cirrus_fbdev *afbdev,
-			     int x, int y, int width, int height)
-{
-	int i;
-	struct drm_gem_object *obj;
-	struct cirrus_bo *bo;
-	int src_offset, dst_offset;
-	int bpp = afbdev->gfb->format->cpp[0];
-	int ret = -EBUSY;
-	bool unmap = false;
-	bool store_for_later = false;
-	int x2, y2;
-	unsigned long flags;
-
-	obj = afbdev->gfb->obj[0];
-	bo = gem_to_cirrus_bo(obj);
-
-	/*
-	 * try and reserve the BO, if we fail with busy
-	 * then the BO is being moved and we should
-	 * store up the damage until later.
-	 */
-	if (drm_can_sleep())
-		ret = cirrus_bo_reserve(bo, true);
-	if (ret) {
-		if (ret != -EBUSY)
-			return;
-		store_for_later = true;
-	}
-
-	x2 = x + width - 1;
-	y2 = y + height - 1;
-	spin_lock_irqsave(&afbdev->dirty_lock, flags);
-
-	if (afbdev->y1 < y)
-		y = afbdev->y1;
-	if (afbdev->y2 > y2)
-		y2 = afbdev->y2;
-	if (afbdev->x1 < x)
-		x = afbdev->x1;
-	if (afbdev->x2 > x2)
-		x2 = afbdev->x2;
-
-	if (store_for_later) {
-		afbdev->x1 = x;
-		afbdev->x2 = x2;
-		afbdev->y1 = y;
-		afbdev->y2 = y2;
-		spin_unlock_irqrestore(&afbdev->dirty_lock, flags);
-		return;
-	}
-
-	afbdev->x1 = afbdev->y1 = INT_MAX;
-	afbdev->x2 = afbdev->y2 = 0;
-	spin_unlock_irqrestore(&afbdev->dirty_lock, flags);
-
-	if (!bo->kmap.virtual) {
-		ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages, &bo->kmap);
-		if (ret) {
-			DRM_ERROR("failed to kmap fb updates\n");
-			cirrus_bo_unreserve(bo);
-			return;
-		}
-		unmap = true;
-	}
-	for (i = y; i < y + height; i++) {
-		/* assume equal stride for now */
-		src_offset = dst_offset = i * afbdev->gfb->pitches[0] + (x * bpp);
-		memcpy_toio(bo->kmap.virtual + src_offset, afbdev->sysram + src_offset, width * bpp);
-
-	}
-	if (unmap)
-		ttm_bo_kunmap(&bo->kmap);
-
-	cirrus_bo_unreserve(bo);
-}
-
-static void cirrus_fillrect(struct fb_info *info,
-			 const struct fb_fillrect *rect)
-{
-	struct cirrus_fbdev *afbdev = info->par;
-	drm_fb_helper_sys_fillrect(info, rect);
-	cirrus_dirty_update(afbdev, rect->dx, rect->dy, rect->width,
-			 rect->height);
-}
-
-static void cirrus_copyarea(struct fb_info *info,
-			 const struct fb_copyarea *area)
-{
-	struct cirrus_fbdev *afbdev = info->par;
-	drm_fb_helper_sys_copyarea(info, area);
-	cirrus_dirty_update(afbdev, area->dx, area->dy, area->width,
-			 area->height);
-}
-
-static void cirrus_imageblit(struct fb_info *info,
-			  const struct fb_image *image)
-{
-	struct cirrus_fbdev *afbdev = info->par;
-	drm_fb_helper_sys_imageblit(info, image);
-	cirrus_dirty_update(afbdev, image->dx, image->dy, image->width,
-			 image->height);
-}
-
-
-static struct fb_ops cirrusfb_ops = {
-	.owner = THIS_MODULE,
-	.fb_check_var = drm_fb_helper_check_var,
-	.fb_set_par = drm_fb_helper_set_par,
-	.fb_fillrect = cirrus_fillrect,
-	.fb_copyarea = cirrus_copyarea,
-	.fb_imageblit = cirrus_imageblit,
-	.fb_pan_display = drm_fb_helper_pan_display,
-	.fb_blank = drm_fb_helper_blank,
-	.fb_setcmap = drm_fb_helper_setcmap,
-};
-
-static int cirrusfb_create_object(struct cirrus_fbdev *afbdev,
-			       const struct drm_mode_fb_cmd2 *mode_cmd,
-			       struct drm_gem_object **gobj_p)
-{
-	struct drm_device *dev = afbdev->helper.dev;
-	struct cirrus_device *cdev = dev->dev_private;
-	u32 bpp;
-	u32 size;
-	struct drm_gem_object *gobj;
-	int ret = 0;
-
-	bpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0) * 8;
-
-	if (!cirrus_check_framebuffer(cdev, mode_cmd->width, mode_cmd->height,
-				      bpp, mode_cmd->pitches[0]))
-		return -EINVAL;
-
-	size = mode_cmd->pitches[0] * mode_cmd->height;
-	ret = cirrus_gem_create(dev, size, true, &gobj);
-	if (ret)
-		return ret;
-
-	*gobj_p = gobj;
-	return ret;
-}
-
-static int cirrusfb_create(struct drm_fb_helper *helper,
-			   struct drm_fb_helper_surface_size *sizes)
-{
-	struct cirrus_fbdev *gfbdev =
-		container_of(helper, struct cirrus_fbdev, helper);
-	struct cirrus_device *cdev = gfbdev->helper.dev->dev_private;
-	struct fb_info *info;
-	struct drm_framebuffer *fb;
-	struct drm_mode_fb_cmd2 mode_cmd;
-	void *sysram;
-	struct drm_gem_object *gobj = NULL;
-	int size, ret;
-
-	mode_cmd.width = sizes->surface_width;
-	mode_cmd.height = sizes->surface_height;
-	mode_cmd.pitches[0] = mode_cmd.width * ((sizes->surface_bpp + 7) / 8);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
-							  sizes->surface_depth);
-	size = mode_cmd.pitches[0] * mode_cmd.height;
-
-	ret = cirrusfb_create_object(gfbdev, &mode_cmd, &gobj);
-	if (ret) {
-		DRM_ERROR("failed to create fbcon backing object %d\n", ret);
-		return ret;
-	}
-
-	sysram = vmalloc(size);
-	if (!sysram)
-		return -ENOMEM;
-
-	info = drm_fb_helper_alloc_fbi(helper);
-	if (IS_ERR(info)) {
-		ret = PTR_ERR(info);
-		goto err_vfree;
-	}
-
-	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
-	if (!fb) {
-		ret = -ENOMEM;
-		goto err_drm_gem_object_put_unlocked;
-	}
-
-	ret = cirrus_framebuffer_init(cdev->dev, fb, &mode_cmd, gobj);
-	if (ret)
-		goto err_kfree;
-
-	gfbdev->sysram = sysram;
-	gfbdev->size = size;
-	gfbdev->gfb = fb;
-
-	/* setup helper */
-	gfbdev->helper.fb = fb;
-
-	info->fbops = &cirrusfb_ops;
-
-	drm_fb_helper_fill_info(info, &gfbdev->helper, sizes);
-
-	/* setup aperture base/size for vesafb takeover */
-	info->apertures->ranges[0].base = cdev->dev->mode_config.fb_base;
-	info->apertures->ranges[0].size = cdev->mc.vram_size;
-
-	info->fix.smem_start = cdev->dev->mode_config.fb_base;
-	info->fix.smem_len = cdev->mc.vram_size;
-
-	info->screen_base = sysram;
-	info->screen_size = size;
-
-	info->fix.mmio_start = 0;
-	info->fix.mmio_len = 0;
-
-	DRM_INFO("fb mappable at 0x%lX\n", info->fix.smem_start);
-	DRM_INFO("vram aper at 0x%lX\n", (unsigned long)info->fix.smem_start);
-	DRM_INFO("size %lu\n", (unsigned long)info->fix.smem_len);
-	DRM_INFO("fb depth is %d\n", fb->format->depth);
-	DRM_INFO("   pitch is %d\n", fb->pitches[0]);
-
-	return 0;
-
-err_kfree:
-	kfree(fb);
-err_drm_gem_object_put_unlocked:
-	drm_gem_object_put_unlocked(gobj);
-err_vfree:
-	vfree(sysram);
-	return ret;
-}
-
-static int cirrus_fbdev_destroy(struct drm_device *dev,
-				struct cirrus_fbdev *gfbdev)
-{
-	struct drm_framebuffer *gfb = gfbdev->gfb;
-
-	drm_helper_force_disable_all(dev);
-
-	drm_fb_helper_unregister_fbi(&gfbdev->helper);
-
-	vfree(gfbdev->sysram);
-	drm_fb_helper_fini(&gfbdev->helper);
-	if (gfb)
-		drm_framebuffer_put(gfb);
-
-	return 0;
-}
-
-static const struct drm_fb_helper_funcs cirrus_fb_helper_funcs = {
-	.fb_probe = cirrusfb_create,
-};
-
-int cirrus_fbdev_init(struct cirrus_device *cdev)
-{
-	struct cirrus_fbdev *gfbdev;
-	int ret;
-
-	/*bpp_sel = 8;*/
-	gfbdev = kzalloc(sizeof(struct cirrus_fbdev), GFP_KERNEL);
-	if (!gfbdev)
-		return -ENOMEM;
-
-	cdev->mode_info.gfbdev = gfbdev;
-	spin_lock_init(&gfbdev->dirty_lock);
-
-	drm_fb_helper_prepare(cdev->dev, &gfbdev->helper,
-			      &cirrus_fb_helper_funcs);
-
-	ret = drm_fb_helper_init(cdev->dev, &gfbdev->helper,
-				 CIRRUSFB_CONN_LIMIT);
-	if (ret)
-		return ret;
-
-	ret = drm_fb_helper_single_add_all_connectors(&gfbdev->helper);
-	if (ret)
-		return ret;
-
-	/* disable all the possible outputs/crtcs before entering KMS mode */
-	drm_helper_disable_unused_functions(cdev->dev);
-
-	return drm_fb_helper_initial_config(&gfbdev->helper, cirrus_bpp);
-}
-
-void cirrus_fbdev_fini(struct cirrus_device *cdev)
-{
-	if (!cdev->mode_info.gfbdev)
-		return;
-
-	cirrus_fbdev_destroy(cdev->dev, cdev->mode_info.gfbdev);
-	kfree(cdev->mode_info.gfbdev);
-	cdev->mode_info.gfbdev = NULL;
-}
diff --git a/drivers/gpu/drm/cirrus/cirrus_main.c b/drivers/gpu/drm/cirrus/cirrus_main.c
deleted file mode 100644
index 57f8fe6d020b..000000000000
--- a/drivers/gpu/drm/cirrus/cirrus_main.c
+++ /dev/null
@@ -1,328 +0,0 @@
-/*
- * Copyright 2012 Red Hat
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License version 2. See the file COPYING in the main
- * directory of this archive for more details.
- *
- * Authors: Matthew Garrett
- *          Dave Airlie
- */
-#include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
-#include <drm/drm_gem_framebuffer_helper.h>
-
-#include "cirrus_drv.h"
-
-static const struct drm_framebuffer_funcs cirrus_fb_funcs = {
-	.create_handle = drm_gem_fb_create_handle,
-	.destroy = drm_gem_fb_destroy,
-};
-
-int cirrus_framebuffer_init(struct drm_device *dev,
-			    struct drm_framebuffer *gfb,
-			    const struct drm_mode_fb_cmd2 *mode_cmd,
-			    struct drm_gem_object *obj)
-{
-	int ret;
-
-	drm_helper_mode_fill_fb_struct(dev, gfb, mode_cmd);
-	gfb->obj[0] = obj;
-	ret = drm_framebuffer_init(dev, gfb, &cirrus_fb_funcs);
-	if (ret) {
-		DRM_ERROR("drm_framebuffer_init failed: %d\n", ret);
-		return ret;
-	}
-	return 0;
-}
-
-static struct drm_framebuffer *
-cirrus_user_framebuffer_create(struct drm_device *dev,
-			       struct drm_file *filp,
-			       const struct drm_mode_fb_cmd2 *mode_cmd)
-{
-	struct cirrus_device *cdev = dev->dev_private;
-	struct drm_gem_object *obj;
-	struct drm_framebuffer *fb;
-	u32 bpp;
-	int ret;
-
-	bpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0) * 8;
-
-	if (!cirrus_check_framebuffer(cdev, mode_cmd->width, mode_cmd->height,
-				      bpp, mode_cmd->pitches[0]))
-		return ERR_PTR(-EINVAL);
-
-	obj = drm_gem_object_lookup(filp, mode_cmd->handles[0]);
-	if (obj == NULL)
-		return ERR_PTR(-ENOENT);
-
-	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
-	if (!fb) {
-		drm_gem_object_put_unlocked(obj);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	ret = cirrus_framebuffer_init(dev, fb, mode_cmd, obj);
-	if (ret) {
-		drm_gem_object_put_unlocked(obj);
-		kfree(fb);
-		return ERR_PTR(ret);
-	}
-	return fb;
-}
-
-static const struct drm_mode_config_funcs cirrus_mode_funcs = {
-	.fb_create = cirrus_user_framebuffer_create,
-};
-
-/* Unmap the framebuffer from the core and release the memory */
-static void cirrus_vram_fini(struct cirrus_device *cdev)
-{
-	iounmap(cdev->rmmio);
-	cdev->rmmio = NULL;
-	if (cdev->mc.vram_base)
-		release_mem_region(cdev->mc.vram_base, cdev->mc.vram_size);
-}
-
-/* Map the framebuffer from the card and configure the core */
-static int cirrus_vram_init(struct cirrus_device *cdev)
-{
-	/* BAR 0 is VRAM */
-	cdev->mc.vram_base = pci_resource_start(cdev->dev->pdev, 0);
-	cdev->mc.vram_size = pci_resource_len(cdev->dev->pdev, 0);
-
-	if (!request_mem_region(cdev->mc.vram_base, cdev->mc.vram_size,
-				"cirrusdrmfb_vram")) {
-		DRM_ERROR("can't reserve VRAM\n");
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
-/*
- * Our emulated hardware has two sets of memory. One is video RAM and can
- * simply be used as a linear framebuffer - the other provides mmio access
- * to the display registers. The latter can also be accessed via IO port
- * access, but we map the range and use mmio to program them instead
- */
-
-int cirrus_device_init(struct cirrus_device *cdev,
-		       struct drm_device *ddev,
-		       struct pci_dev *pdev, uint32_t flags)
-{
-	int ret;
-
-	cdev->dev = ddev;
-	cdev->flags = flags;
-
-	/* Hardcode the number of CRTCs to 1 */
-	cdev->num_crtc = 1;
-
-	/* BAR 0 is the framebuffer, BAR 1 contains registers */
-	cdev->rmmio_base = pci_resource_start(cdev->dev->pdev, 1);
-	cdev->rmmio_size = pci_resource_len(cdev->dev->pdev, 1);
-
-	if (!request_mem_region(cdev->rmmio_base, cdev->rmmio_size,
-				"cirrusdrmfb_mmio")) {
-		DRM_ERROR("can't reserve mmio registers\n");
-		return -ENOMEM;
-	}
-
-	cdev->rmmio = ioremap(cdev->rmmio_base, cdev->rmmio_size);
-
-	if (cdev->rmmio == NULL)
-		return -ENOMEM;
-
-	ret = cirrus_vram_init(cdev);
-	if (ret) {
-		release_mem_region(cdev->rmmio_base, cdev->rmmio_size);
-		return ret;
-	}
-
-	return 0;
-}
-
-void cirrus_device_fini(struct cirrus_device *cdev)
-{
-	release_mem_region(cdev->rmmio_base, cdev->rmmio_size);
-	cirrus_vram_fini(cdev);
-}
-
-/*
- * Functions here will be called by the core once it's bound the driver to
- * a PCI device
- */
-
-int cirrus_driver_load(struct drm_device *dev, unsigned long flags)
-{
-	struct cirrus_device *cdev;
-	int r;
-
-	cdev = kzalloc(sizeof(struct cirrus_device), GFP_KERNEL);
-	if (cdev == NULL)
-		return -ENOMEM;
-	dev->dev_private = (void *)cdev;
-
-	r = cirrus_device_init(cdev, dev, dev->pdev, flags);
-	if (r) {
-		dev_err(&dev->pdev->dev, "Fatal error during GPU init: %d\n", r);
-		goto out;
-	}
-
-	r = cirrus_mm_init(cdev);
-	if (r) {
-		dev_err(&dev->pdev->dev, "fatal err on mm init\n");
-		goto out;
-	}
-
-	/*
-	 * cirrus_modeset_init() is initializing/registering the emulated fbdev
-	 * and DRM internals can access/test some of the fields in
-	 * mode_config->funcs as part of the fbdev registration process.
-	 * Make sure dev->mode_config.funcs is properly set to avoid
-	 * dereferencing a NULL pointer.
-	 * FIXME: mode_config.funcs assignment should probably be done in
-	 * cirrus_modeset_init() (that's a common pattern seen in other DRM
-	 * drivers).
-	 */
-	dev->mode_config.funcs = &cirrus_mode_funcs;
-	r = cirrus_modeset_init(cdev);
-	if (r) {
-		dev_err(&dev->pdev->dev, "Fatal error during modeset init: %d\n", r);
-		goto out;
-	}
-
-	return 0;
-out:
-	cirrus_driver_unload(dev);
-	return r;
-}
-
-void cirrus_driver_unload(struct drm_device *dev)
-{
-	struct cirrus_device *cdev = dev->dev_private;
-
-	if (cdev == NULL)
-		return;
-	cirrus_modeset_fini(cdev);
-	cirrus_mm_fini(cdev);
-	cirrus_device_fini(cdev);
-	kfree(cdev);
-	dev->dev_private = NULL;
-}
-
-int cirrus_gem_create(struct drm_device *dev,
-		   u32 size, bool iskernel,
-		   struct drm_gem_object **obj)
-{
-	struct cirrus_bo *cirrusbo;
-	int ret;
-
-	*obj = NULL;
-
-	size = roundup(size, PAGE_SIZE);
-	if (size == 0)
-		return -EINVAL;
-
-	ret = cirrus_bo_create(dev, size, 0, 0, &cirrusbo);
-	if (ret) {
-		if (ret != -ERESTARTSYS)
-			DRM_ERROR("failed to allocate GEM object\n");
-		return ret;
-	}
-	*obj = &cirrusbo->gem;
-	return 0;
-}
-
-int cirrus_dumb_create(struct drm_file *file,
-		    struct drm_device *dev,
-		    struct drm_mode_create_dumb *args)
-{
-	int ret;
-	struct drm_gem_object *gobj;
-	u32 handle;
-
-	args->pitch = args->width * ((args->bpp + 7) / 8);
-	args->size = args->pitch * args->height;
-
-	ret = cirrus_gem_create(dev, args->size, false,
-			     &gobj);
-	if (ret)
-		return ret;
-
-	ret = drm_gem_handle_create(file, gobj, &handle);
-	drm_gem_object_put_unlocked(gobj);
-	if (ret)
-		return ret;
-
-	args->handle = handle;
-	return 0;
-}
-
-static void cirrus_bo_unref(struct cirrus_bo **bo)
-{
-	struct ttm_buffer_object *tbo;
-
-	if ((*bo) == NULL)
-		return;
-
-	tbo = &((*bo)->bo);
-	ttm_bo_put(tbo);
-	*bo = NULL;
-}
-
-void cirrus_gem_free_object(struct drm_gem_object *obj)
-{
-	struct cirrus_bo *cirrus_bo = gem_to_cirrus_bo(obj);
-
-	cirrus_bo_unref(&cirrus_bo);
-}
-
-
-static inline u64 cirrus_bo_mmap_offset(struct cirrus_bo *bo)
-{
-	return drm_vma_node_offset_addr(&bo->bo.vma_node);
-}
-
-int
-cirrus_dumb_mmap_offset(struct drm_file *file,
-		     struct drm_device *dev,
-		     uint32_t handle,
-		     uint64_t *offset)
-{
-	struct drm_gem_object *obj;
-	struct cirrus_bo *bo;
-
-	obj = drm_gem_object_lookup(file, handle);
-	if (obj == NULL)
-		return -ENOENT;
-
-	bo = gem_to_cirrus_bo(obj);
-	*offset = cirrus_bo_mmap_offset(bo);
-
-	drm_gem_object_put_unlocked(obj);
-
-	return 0;
-}
-
-bool cirrus_check_framebuffer(struct cirrus_device *cdev, int width, int height,
-			      int bpp, int pitch)
-{
-	const int max_pitch = 0x1FF << 3; /* (4096 - 1) & ~111b bytes */
-	const int max_size = cdev->mc.vram_size;
-
-	if (bpp > cirrus_bpp)
-		return false;
-	if (bpp > 32)
-		return false;
-
-	if (pitch > max_pitch)
-		return false;
-
-	if (pitch * height > max_size)
-		return false;
-
-	return true;
-}
diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
deleted file mode 100644
index b109cd71426f..000000000000
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ /dev/null
@@ -1,617 +0,0 @@
-
-/*
- * Copyright 2012 Red Hat
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License version 2. See the file COPYING in the main
- * directory of this archive for more details.
- *
- * Authors: Matthew Garrett
- *          Dave Airlie
- *
- * Portions of this code derived from cirrusfb.c:
- * drivers/video/cirrusfb.c - driver for Cirrus Logic chipsets
- *
- * Copyright 1999-2001 Jeff Garzik <jgarzik@pobox.com>
- */
-#include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
-#include <drm/drm_plane_helper.h>
-#include <drm/drm_probe_helper.h>
-
-#include <video/cirrus.h>
-
-#include "cirrus_drv.h"
-
-#define CIRRUS_LUT_SIZE 256
-
-#define PALETTE_INDEX 0x8
-#define PALETTE_DATA 0x9
-
-/*
- * This file contains setup code for the CRTC.
- */
-
-/*
- * The DRM core requires DPMS functions, but they make little sense in our
- * case and so are just stubs
- */
-
-static void cirrus_crtc_dpms(struct drm_crtc *crtc, int mode)
-{
-	struct drm_device *dev = crtc->dev;
-	struct cirrus_device *cdev = dev->dev_private;
-	u8 sr01, gr0e;
-
-	switch (mode) {
-	case DRM_MODE_DPMS_ON:
-		sr01 = 0x00;
-		gr0e = 0x00;
-		break;
-	case DRM_MODE_DPMS_STANDBY:
-		sr01 = 0x20;
-		gr0e = 0x02;
-		break;
-	case DRM_MODE_DPMS_SUSPEND:
-		sr01 = 0x20;
-		gr0e = 0x04;
-		break;
-	case DRM_MODE_DPMS_OFF:
-		sr01 = 0x20;
-		gr0e = 0x06;
-		break;
-	default:
-		return;
-	}
-
-	WREG8(SEQ_INDEX, 0x1);
-	sr01 |= RREG8(SEQ_DATA) & ~0x20;
-	WREG_SEQ(0x1, sr01);
-
-	WREG8(GFX_INDEX, 0xe);
-	gr0e |= RREG8(GFX_DATA) & ~0x06;
-	WREG_GFX(0xe, gr0e);
-}
-
-static void cirrus_set_start_address(struct drm_crtc *crtc, unsigned offset)
-{
-	struct cirrus_device *cdev = crtc->dev->dev_private;
-	u32 addr;
-	u8 tmp;
-
-	addr = offset >> 2;
-	WREG_CRT(0x0c, (u8)((addr >> 8) & 0xff));
-	WREG_CRT(0x0d, (u8)(addr & 0xff));
-
-	WREG8(CRT_INDEX, 0x1b);
-	tmp = RREG8(CRT_DATA);
-	tmp &= 0xf2;
-	tmp |= (addr >> 16) & 0x01;
-	tmp |= (addr >> 15) & 0x0c;
-	WREG_CRT(0x1b, tmp);
-	WREG8(CRT_INDEX, 0x1d);
-	tmp = RREG8(CRT_DATA);
-	tmp &= 0x7f;
-	tmp |= (addr >> 12) & 0x80;
-	WREG_CRT(0x1d, tmp);
-}
-
-/* cirrus is different - we will force move buffers out of VRAM */
-static int cirrus_crtc_do_set_base(struct drm_crtc *crtc,
-				struct drm_framebuffer *fb,
-				int x, int y, int atomic)
-{
-	struct cirrus_device *cdev = crtc->dev->dev_private;
-	struct cirrus_bo *bo;
-	int ret;
-	u64 gpu_addr;
-
-	/* push the previous fb to system ram */
-	if (!atomic && fb) {
-		bo = gem_to_cirrus_bo(fb->obj[0]);
-		ret = cirrus_bo_reserve(bo, false);
-		if (ret)
-			return ret;
-		cirrus_bo_push_sysram(bo);
-		cirrus_bo_unreserve(bo);
-	}
-
-	bo = gem_to_cirrus_bo(crtc->primary->fb->obj[0]);
-
-	ret = cirrus_bo_reserve(bo, false);
-	if (ret)
-		return ret;
-
-	ret = cirrus_bo_pin(bo, TTM_PL_FLAG_VRAM, &gpu_addr);
-	if (ret) {
-		cirrus_bo_unreserve(bo);
-		return ret;
-	}
-
-	if (cdev->mode_info.gfbdev->gfb == crtc->primary->fb) {
-		/* if pushing console in kmap it */
-		ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages, &bo->kmap);
-		if (ret)
-			DRM_ERROR("failed to kmap fbcon\n");
-	}
-	cirrus_bo_unreserve(bo);
-
-	cirrus_set_start_address(crtc, (u32)gpu_addr);
-	return 0;
-}
-
-static int cirrus_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
-			     struct drm_framebuffer *old_fb)
-{
-	return cirrus_crtc_do_set_base(crtc, old_fb, x, y, 0);
-}
-
-/*
- * The meat of this driver. The core passes us a mode and we have to program
- * it. The modesetting here is the bare minimum required to satisfy the qemu
- * emulation of this hardware, and running this against a real device is
- * likely to result in an inadequately programmed mode. We've already had
- * the opportunity to modify the mode, so whatever we receive here should
- * be something that can be correctly programmed and displayed
- */
-static int cirrus_crtc_mode_set(struct drm_crtc *crtc,
-				struct drm_display_mode *mode,
-				struct drm_display_mode *adjusted_mode,
-				int x, int y, struct drm_framebuffer *old_fb)
-{
-	struct drm_device *dev = crtc->dev;
-	struct cirrus_device *cdev = dev->dev_private;
-	const struct drm_framebuffer *fb = crtc->primary->fb;
-	int hsyncstart, hsyncend, htotal, hdispend;
-	int vtotal, vdispend;
-	int tmp;
-	int sr07 = 0, hdr = 0;
-
-	htotal = mode->htotal / 8;
-	hsyncend = mode->hsync_end / 8;
-	hsyncstart = mode->hsync_start / 8;
-	hdispend = mode->hdisplay / 8;
-
-	vtotal = mode->vtotal;
-	vdispend = mode->vdisplay;
-
-	vdispend -= 1;
-	vtotal -= 2;
-
-	htotal -= 5;
-	hdispend -= 1;
-	hsyncstart += 1;
-	hsyncend += 1;
-
-	WREG_CRT(VGA_CRTC_V_SYNC_END, 0x20);
-	WREG_CRT(VGA_CRTC_H_TOTAL, htotal);
-	WREG_CRT(VGA_CRTC_H_DISP, hdispend);
-	WREG_CRT(VGA_CRTC_H_SYNC_START, hsyncstart);
-	WREG_CRT(VGA_CRTC_H_SYNC_END, hsyncend);
-	WREG_CRT(VGA_CRTC_V_TOTAL, vtotal & 0xff);
-	WREG_CRT(VGA_CRTC_V_DISP_END, vdispend & 0xff);
-
-	tmp = 0x40;
-	if ((vdispend + 1) & 512)
-		tmp |= 0x20;
-	WREG_CRT(VGA_CRTC_MAX_SCAN, tmp);
-
-	/*
-	 * Overflow bits for values that don't fit in the standard registers
-	 */
-	tmp = 16;
-	if (vtotal & 256)
-		tmp |= 1;
-	if (vdispend & 256)
-		tmp |= 2;
-	if ((vdispend + 1) & 256)
-		tmp |= 8;
-	if (vtotal & 512)
-		tmp |= 32;
-	if (vdispend & 512)
-		tmp |= 64;
-	WREG_CRT(VGA_CRTC_OVERFLOW, tmp);
-
-	tmp = 0;
-
-	/* More overflow bits */
-
-	if ((htotal + 5) & 64)
-		tmp |= 16;
-	if ((htotal + 5) & 128)
-		tmp |= 32;
-	if (vtotal & 256)
-		tmp |= 64;
-	if (vtotal & 512)
-		tmp |= 128;
-
-	WREG_CRT(CL_CRT1A, tmp);
-
-	/* Disable Hercules/CGA compatibility */
-	WREG_CRT(VGA_CRTC_MODE, 0x03);
-
-	WREG8(SEQ_INDEX, 0x7);
-	sr07 = RREG8(SEQ_DATA);
-	sr07 &= 0xe0;
-	hdr = 0;
-	switch (fb->format->cpp[0] * 8) {
-	case 8:
-		sr07 |= 0x11;
-		break;
-	case 16:
-		sr07 |= 0x17;
-		hdr = 0xc1;
-		break;
-	case 24:
-		sr07 |= 0x15;
-		hdr = 0xc5;
-		break;
-	case 32:
-		sr07 |= 0x19;
-		hdr = 0xc5;
-		break;
-	default:
-		return -1;
-	}
-
-	WREG_SEQ(0x7, sr07);
-
-	/* Program the pitch */
-	tmp = fb->pitches[0] / 8;
-	WREG_CRT(VGA_CRTC_OFFSET, tmp);
-
-	/* Enable extended blanking and pitch bits, and enable full memory */
-	tmp = 0x22;
-	tmp |= (fb->pitches[0] >> 7) & 0x10;
-	tmp |= (fb->pitches[0] >> 6) & 0x40;
-	WREG_CRT(0x1b, tmp);
-
-	/* Enable high-colour modes */
-	WREG_GFX(VGA_GFX_MODE, 0x40);
-
-	/* And set graphics mode */
-	WREG_GFX(VGA_GFX_MISC, 0x01);
-
-	WREG_HDR(hdr);
-	cirrus_crtc_do_set_base(crtc, old_fb, x, y, 0);
-
-	/* Unblank (needed on S3 resume, vgabios doesn't do it then) */
-	outb(0x20, 0x3c0);
-	return 0;
-}
-
-/*
- * This is called before a mode is programmed. A typical use might be to
- * enable DPMS during the programming to avoid seeing intermediate stages,
- * but that's not relevant to us
- */
-static void cirrus_crtc_prepare(struct drm_crtc *crtc)
-{
-}
-
-static void cirrus_crtc_load_lut(struct drm_crtc *crtc)
-{
-	struct drm_device *dev = crtc->dev;
-	struct cirrus_device *cdev = dev->dev_private;
-	u16 *r, *g, *b;
-	int i;
-
-	if (!crtc->enabled)
-		return;
-
-	r = crtc->gamma_store;
-	g = r + crtc->gamma_size;
-	b = g + crtc->gamma_size;
-
-	for (i = 0; i < CIRRUS_LUT_SIZE; i++) {
-		/* VGA registers */
-		WREG8(PALETTE_INDEX, i);
-		WREG8(PALETTE_DATA, *r++ >> 8);
-		WREG8(PALETTE_DATA, *g++ >> 8);
-		WREG8(PALETTE_DATA, *b++ >> 8);
-	}
-}
-
-/*
- * This is called after a mode is programmed. It should reverse anything done
- * by the prepare function
- */
-static void cirrus_crtc_commit(struct drm_crtc *crtc)
-{
-	cirrus_crtc_load_lut(crtc);
-}
-
-/*
- * The core can pass us a set of gamma values to program. We actually only
- * use this for 8-bit mode so can't perform smooth fades on deeper modes,
- * but it's a requirement that we provide the function
- */
-static int cirrus_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
-				 u16 *blue, uint32_t size,
-				 struct drm_modeset_acquire_ctx *ctx)
-{
-	cirrus_crtc_load_lut(crtc);
-
-	return 0;
-}
-
-/* Simple cleanup function */
-static void cirrus_crtc_destroy(struct drm_crtc *crtc)
-{
-	struct cirrus_crtc *cirrus_crtc = to_cirrus_crtc(crtc);
-
-	drm_crtc_cleanup(crtc);
-	kfree(cirrus_crtc);
-}
-
-/* These provide the minimum set of functions required to handle a CRTC */
-static const struct drm_crtc_funcs cirrus_crtc_funcs = {
-	.gamma_set = cirrus_crtc_gamma_set,
-	.set_config = drm_crtc_helper_set_config,
-	.destroy = cirrus_crtc_destroy,
-};
-
-static const struct drm_crtc_helper_funcs cirrus_helper_funcs = {
-	.dpms = cirrus_crtc_dpms,
-	.mode_set = cirrus_crtc_mode_set,
-	.mode_set_base = cirrus_crtc_mode_set_base,
-	.prepare = cirrus_crtc_prepare,
-	.commit = cirrus_crtc_commit,
-};
-
-/* CRTC setup */
-static const uint32_t cirrus_formats_16[] = {
-	DRM_FORMAT_RGB565,
-};
-
-static const uint32_t cirrus_formats_24[] = {
-	DRM_FORMAT_RGB888,
-	DRM_FORMAT_RGB565,
-};
-
-static const uint32_t cirrus_formats_32[] = {
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_RGB888,
-	DRM_FORMAT_RGB565,
-};
-
-static struct drm_plane *cirrus_primary_plane(struct drm_device *dev)
-{
-	const uint32_t *formats;
-	uint32_t nformats;
-	struct drm_plane *primary;
-	int ret;
-
-	switch (cirrus_bpp) {
-	case 16:
-		formats = cirrus_formats_16;
-		nformats = ARRAY_SIZE(cirrus_formats_16);
-		break;
-	case 24:
-		formats = cirrus_formats_24;
-		nformats = ARRAY_SIZE(cirrus_formats_24);
-		break;
-	case 32:
-		formats = cirrus_formats_32;
-		nformats = ARRAY_SIZE(cirrus_formats_32);
-		break;
-	default:
-		return NULL;
-	}
-
-	primary = kzalloc(sizeof(*primary), GFP_KERNEL);
-	if (primary == NULL) {
-		DRM_DEBUG_KMS("Failed to allocate primary plane\n");
-		return NULL;
-	}
-
-	ret = drm_universal_plane_init(dev, primary, 0,
-				       &drm_primary_helper_funcs,
-				       formats, nformats,
-				       NULL,
-				       DRM_PLANE_TYPE_PRIMARY, NULL);
-	if (ret) {
-		kfree(primary);
-		primary = NULL;
-	}
-
-	return primary;
-}
-
-static void cirrus_crtc_init(struct drm_device *dev)
-{
-	struct cirrus_device *cdev = dev->dev_private;
-	struct cirrus_crtc *cirrus_crtc;
-	struct drm_plane *primary;
-
-	cirrus_crtc = kzalloc(sizeof(struct cirrus_crtc) +
-			      (CIRRUSFB_CONN_LIMIT * sizeof(struct drm_connector *)),
-			      GFP_KERNEL);
-
-	if (cirrus_crtc == NULL)
-		return;
-
-	primary = cirrus_primary_plane(dev);
-	if (primary == NULL) {
-		kfree(cirrus_crtc);
-		return;
-	}
-
-	drm_crtc_init_with_planes(dev, &cirrus_crtc->base,
-				  primary, NULL,
-				  &cirrus_crtc_funcs, NULL);
-
-	drm_mode_crtc_set_gamma_size(&cirrus_crtc->base, CIRRUS_LUT_SIZE);
-	cdev->mode_info.crtc = cirrus_crtc;
-
-	drm_crtc_helper_add(&cirrus_crtc->base, &cirrus_helper_funcs);
-}
-
-static void cirrus_encoder_mode_set(struct drm_encoder *encoder,
-				struct drm_display_mode *mode,
-				struct drm_display_mode *adjusted_mode)
-{
-}
-
-static void cirrus_encoder_dpms(struct drm_encoder *encoder, int state)
-{
-	return;
-}
-
-static void cirrus_encoder_prepare(struct drm_encoder *encoder)
-{
-}
-
-static void cirrus_encoder_commit(struct drm_encoder *encoder)
-{
-}
-
-static void cirrus_encoder_destroy(struct drm_encoder *encoder)
-{
-	struct cirrus_encoder *cirrus_encoder = to_cirrus_encoder(encoder);
-	drm_encoder_cleanup(encoder);
-	kfree(cirrus_encoder);
-}
-
-static const struct drm_encoder_helper_funcs cirrus_encoder_helper_funcs = {
-	.dpms = cirrus_encoder_dpms,
-	.mode_set = cirrus_encoder_mode_set,
-	.prepare = cirrus_encoder_prepare,
-	.commit = cirrus_encoder_commit,
-};
-
-static const struct drm_encoder_funcs cirrus_encoder_encoder_funcs = {
-	.destroy = cirrus_encoder_destroy,
-};
-
-static struct drm_encoder *cirrus_encoder_init(struct drm_device *dev)
-{
-	struct drm_encoder *encoder;
-	struct cirrus_encoder *cirrus_encoder;
-
-	cirrus_encoder = kzalloc(sizeof(struct cirrus_encoder), GFP_KERNEL);
-	if (!cirrus_encoder)
-		return NULL;
-
-	encoder = &cirrus_encoder->base;
-	encoder->possible_crtcs = 0x1;
-
-	drm_encoder_init(dev, encoder, &cirrus_encoder_encoder_funcs,
-			 DRM_MODE_ENCODER_DAC, NULL);
-	drm_encoder_helper_add(encoder, &cirrus_encoder_helper_funcs);
-
-	return encoder;
-}
-
-
-static int cirrus_vga_get_modes(struct drm_connector *connector)
-{
-	int count;
-
-	/* Just add a static list of modes */
-	if (cirrus_bpp <= 24) {
-		count = drm_add_modes_noedid(connector, 1280, 1024);
-		drm_set_preferred_mode(connector, 1024, 768);
-	} else {
-		count = drm_add_modes_noedid(connector, 800, 600);
-		drm_set_preferred_mode(connector, 800, 600);
-	}
-	return count;
-}
-
-static struct drm_encoder *cirrus_connector_best_encoder(struct drm_connector
-						  *connector)
-{
-	int enc_id = connector->encoder_ids[0];
-	/* pick the encoder ids */
-	if (enc_id)
-		return drm_encoder_find(connector->dev, NULL, enc_id);
-	return NULL;
-}
-
-static void cirrus_connector_destroy(struct drm_connector *connector)
-{
-	drm_connector_cleanup(connector);
-	kfree(connector);
-}
-
-static const struct drm_connector_helper_funcs cirrus_vga_connector_helper_funcs = {
-	.get_modes = cirrus_vga_get_modes,
-	.best_encoder = cirrus_connector_best_encoder,
-};
-
-static const struct drm_connector_funcs cirrus_vga_connector_funcs = {
-	.dpms = drm_helper_connector_dpms,
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = cirrus_connector_destroy,
-};
-
-static struct drm_connector *cirrus_vga_init(struct drm_device *dev)
-{
-	struct drm_connector *connector;
-	struct cirrus_connector *cirrus_connector;
-
-	cirrus_connector = kzalloc(sizeof(struct cirrus_connector), GFP_KERNEL);
-	if (!cirrus_connector)
-		return NULL;
-
-	connector = &cirrus_connector->base;
-
-	drm_connector_init(dev, connector,
-			   &cirrus_vga_connector_funcs, DRM_MODE_CONNECTOR_VGA);
-
-	drm_connector_helper_add(connector, &cirrus_vga_connector_helper_funcs);
-
-	drm_connector_register(connector);
-	return connector;
-}
-
-
-int cirrus_modeset_init(struct cirrus_device *cdev)
-{
-	struct drm_encoder *encoder;
-	struct drm_connector *connector;
-	int ret;
-
-	drm_mode_config_init(cdev->dev);
-
-	cdev->dev->mode_config.max_width = CIRRUS_MAX_FB_WIDTH;
-	cdev->dev->mode_config.max_height = CIRRUS_MAX_FB_HEIGHT;
-
-	cdev->dev->mode_config.fb_base = cdev->mc.vram_base;
-	cdev->dev->mode_config.preferred_depth = cirrus_bpp;
-	/* don't prefer a shadow on virt GPU */
-	cdev->dev->mode_config.prefer_shadow = 0;
-
-	cirrus_crtc_init(cdev->dev);
-
-	encoder = cirrus_encoder_init(cdev->dev);
-	if (!encoder) {
-		DRM_ERROR("cirrus_encoder_init failed\n");
-		return -1;
-	}
-
-	connector = cirrus_vga_init(cdev->dev);
-	if (!connector) {
-		DRM_ERROR("cirrus_vga_init failed\n");
-		return -1;
-	}
-
-	drm_connector_attach_encoder(connector, encoder);
-
-	ret = cirrus_fbdev_init(cdev);
-	if (ret) {
-		DRM_ERROR("cirrus_fbdev_init failed\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-void cirrus_modeset_fini(struct cirrus_device *cdev)
-{
-	cirrus_fbdev_fini(cdev);
-	drm_helper_force_disable_all(cdev->dev);
-	drm_mode_config_cleanup(cdev->dev);
-}
diff --git a/drivers/gpu/drm/cirrus/cirrus_ttm.c b/drivers/gpu/drm/cirrus/cirrus_ttm.c
deleted file mode 100644
index e075810b4bd4..000000000000
--- a/drivers/gpu/drm/cirrus/cirrus_ttm.c
+++ /dev/null
@@ -1,343 +0,0 @@
-/*
- * Copyright 2012 Red Hat Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the
- * "Software"), to deal in the Software without restriction, including
- * without limitation the rights to use, copy, modify, merge, publish,
- * distribute, sub license, and/or sell copies of the Software, and to
- * permit persons to whom the Software is furnished to do so, subject to
- * the following conditions:
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
- * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
- * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
- * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
- * USE OR OTHER DEALINGS IN THE SOFTWARE.
- *
- * The above copyright notice and this permission notice (including the
- * next paragraph) shall be included in all copies or substantial portions
- * of the Software.
- *
- */
-/*
- * Authors: Dave Airlie <airlied@redhat.com>
- */
-#include <drm/drmP.h>
-#include <drm/ttm/ttm_page_alloc.h>
-
-#include "cirrus_drv.h"
-
-static inline struct cirrus_device *
-cirrus_bdev(struct ttm_bo_device *bd)
-{
-	return container_of(bd, struct cirrus_device, ttm.bdev);
-}
-
-static void cirrus_bo_ttm_destroy(struct ttm_buffer_object *tbo)
-{
-	struct cirrus_bo *bo;
-
-	bo = container_of(tbo, struct cirrus_bo, bo);
-
-	drm_gem_object_release(&bo->gem);
-	kfree(bo);
-}
-
-static bool cirrus_ttm_bo_is_cirrus_bo(struct ttm_buffer_object *bo)
-{
-	if (bo->destroy == &cirrus_bo_ttm_destroy)
-		return true;
-	return false;
-}
-
-static int
-cirrus_bo_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
-		     struct ttm_mem_type_manager *man)
-{
-	switch (type) {
-	case TTM_PL_SYSTEM:
-		man->flags = TTM_MEMTYPE_FLAG_MAPPABLE;
-		man->available_caching = TTM_PL_MASK_CACHING;
-		man->default_caching = TTM_PL_FLAG_CACHED;
-		break;
-	case TTM_PL_VRAM:
-		man->func = &ttm_bo_manager_func;
-		man->flags = TTM_MEMTYPE_FLAG_FIXED |
-			TTM_MEMTYPE_FLAG_MAPPABLE;
-		man->available_caching = TTM_PL_FLAG_UNCACHED |
-			TTM_PL_FLAG_WC;
-		man->default_caching = TTM_PL_FLAG_WC;
-		break;
-	default:
-		DRM_ERROR("Unsupported memory type %u\n", (unsigned)type);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-static void
-cirrus_bo_evict_flags(struct ttm_buffer_object *bo, struct ttm_placement *pl)
-{
-	struct cirrus_bo *cirrusbo = cirrus_bo(bo);
-
-	if (!cirrus_ttm_bo_is_cirrus_bo(bo))
-		return;
-
-	cirrus_ttm_placement(cirrusbo, TTM_PL_FLAG_SYSTEM);
-	*pl = cirrusbo->placement;
-}
-
-static int cirrus_bo_verify_access(struct ttm_buffer_object *bo, struct file *filp)
-{
-	struct cirrus_bo *cirrusbo = cirrus_bo(bo);
-
-	return drm_vma_node_verify_access(&cirrusbo->gem.vma_node,
-					  filp->private_data);
-}
-
-static int cirrus_ttm_io_mem_reserve(struct ttm_bo_device *bdev,
-				  struct ttm_mem_reg *mem)
-{
-	struct ttm_mem_type_manager *man = &bdev->man[mem->mem_type];
-	struct cirrus_device *cirrus = cirrus_bdev(bdev);
-
-	mem->bus.addr = NULL;
-	mem->bus.offset = 0;
-	mem->bus.size = mem->num_pages << PAGE_SHIFT;
-	mem->bus.base = 0;
-	mem->bus.is_iomem = false;
-	if (!(man->flags & TTM_MEMTYPE_FLAG_MAPPABLE))
-		return -EINVAL;
-	switch (mem->mem_type) {
-	case TTM_PL_SYSTEM:
-		/* system memory */
-		return 0;
-	case TTM_PL_VRAM:
-		mem->bus.offset = mem->start << PAGE_SHIFT;
-		mem->bus.base = pci_resource_start(cirrus->dev->pdev, 0);
-		mem->bus.is_iomem = true;
-		break;
-	default:
-		return -EINVAL;
-		break;
-	}
-	return 0;
-}
-
-static void cirrus_ttm_io_mem_free(struct ttm_bo_device *bdev, struct ttm_mem_reg *mem)
-{
-}
-
-static void cirrus_ttm_backend_destroy(struct ttm_tt *tt)
-{
-	ttm_tt_fini(tt);
-	kfree(tt);
-}
-
-static struct ttm_backend_func cirrus_tt_backend_func = {
-	.destroy = &cirrus_ttm_backend_destroy,
-};
-
-
-static struct ttm_tt *cirrus_ttm_tt_create(struct ttm_buffer_object *bo,
-					   uint32_t page_flags)
-{
-	struct ttm_tt *tt;
-
-	tt = kzalloc(sizeof(struct ttm_tt), GFP_KERNEL);
-	if (tt == NULL)
-		return NULL;
-	tt->func = &cirrus_tt_backend_func;
-	if (ttm_tt_init(tt, bo, page_flags)) {
-		kfree(tt);
-		return NULL;
-	}
-	return tt;
-}
-
-struct ttm_bo_driver cirrus_bo_driver = {
-	.ttm_tt_create = cirrus_ttm_tt_create,
-	.init_mem_type = cirrus_bo_init_mem_type,
-	.eviction_valuable = ttm_bo_eviction_valuable,
-	.evict_flags = cirrus_bo_evict_flags,
-	.move = NULL,
-	.verify_access = cirrus_bo_verify_access,
-	.io_mem_reserve = &cirrus_ttm_io_mem_reserve,
-	.io_mem_free = &cirrus_ttm_io_mem_free,
-};
-
-int cirrus_mm_init(struct cirrus_device *cirrus)
-{
-	int ret;
-	struct drm_device *dev = cirrus->dev;
-	struct ttm_bo_device *bdev = &cirrus->ttm.bdev;
-
-	ret = ttm_bo_device_init(&cirrus->ttm.bdev,
-				 &cirrus_bo_driver,
-				 dev->anon_inode->i_mapping,
-				 DRM_FILE_PAGE_OFFSET,
-				 true);
-	if (ret) {
-		DRM_ERROR("Error initialising bo driver; %d\n", ret);
-		return ret;
-	}
-
-	ret = ttm_bo_init_mm(bdev, TTM_PL_VRAM,
-			     cirrus->mc.vram_size >> PAGE_SHIFT);
-	if (ret) {
-		DRM_ERROR("Failed ttm VRAM init: %d\n", ret);
-		return ret;
-	}
-
-	arch_io_reserve_memtype_wc(pci_resource_start(dev->pdev, 0),
-				   pci_resource_len(dev->pdev, 0));
-
-	cirrus->fb_mtrr = arch_phys_wc_add(pci_resource_start(dev->pdev, 0),
-					   pci_resource_len(dev->pdev, 0));
-
-	cirrus->mm_inited = true;
-	return 0;
-}
-
-void cirrus_mm_fini(struct cirrus_device *cirrus)
-{
-	struct drm_device *dev = cirrus->dev;
-
-	if (!cirrus->mm_inited)
-		return;
-
-	ttm_bo_device_release(&cirrus->ttm.bdev);
-
-	arch_phys_wc_del(cirrus->fb_mtrr);
-	cirrus->fb_mtrr = 0;
-	arch_io_free_memtype_wc(pci_resource_start(dev->pdev, 0),
-				pci_resource_len(dev->pdev, 0));
-}
-
-void cirrus_ttm_placement(struct cirrus_bo *bo, int domain)
-{
-	u32 c = 0;
-	unsigned i;
-	bo->placement.placement = bo->placements;
-	bo->placement.busy_placement = bo->placements;
-	if (domain & TTM_PL_FLAG_VRAM)
-		bo->placements[c++].flags = TTM_PL_FLAG_WC | TTM_PL_FLAG_UNCACHED | TTM_PL_FLAG_VRAM;
-	if (domain & TTM_PL_FLAG_SYSTEM)
-		bo->placements[c++].flags = TTM_PL_MASK_CACHING | TTM_PL_FLAG_SYSTEM;
-	if (!c)
-		bo->placements[c++].flags = TTM_PL_MASK_CACHING | TTM_PL_FLAG_SYSTEM;
-	bo->placement.num_placement = c;
-	bo->placement.num_busy_placement = c;
-	for (i = 0; i < c; ++i) {
-		bo->placements[i].fpfn = 0;
-		bo->placements[i].lpfn = 0;
-	}
-}
-
-int cirrus_bo_create(struct drm_device *dev, int size, int align,
-		  uint32_t flags, struct cirrus_bo **pcirrusbo)
-{
-	struct cirrus_device *cirrus = dev->dev_private;
-	struct cirrus_bo *cirrusbo;
-	size_t acc_size;
-	int ret;
-
-	cirrusbo = kzalloc(sizeof(struct cirrus_bo), GFP_KERNEL);
-	if (!cirrusbo)
-		return -ENOMEM;
-
-	ret = drm_gem_object_init(dev, &cirrusbo->gem, size);
-	if (ret) {
-		kfree(cirrusbo);
-		return ret;
-	}
-
-	cirrusbo->bo.bdev = &cirrus->ttm.bdev;
-
-	cirrus_ttm_placement(cirrusbo, TTM_PL_FLAG_VRAM | TTM_PL_FLAG_SYSTEM);
-
-	acc_size = ttm_bo_dma_acc_size(&cirrus->ttm.bdev, size,
-				       sizeof(struct cirrus_bo));
-
-	ret = ttm_bo_init(&cirrus->ttm.bdev, &cirrusbo->bo, size,
-			  ttm_bo_type_device, &cirrusbo->placement,
-			  align >> PAGE_SHIFT, false, acc_size,
-			  NULL, NULL, cirrus_bo_ttm_destroy);
-	if (ret)
-		return ret;
-
-	*pcirrusbo = cirrusbo;
-	return 0;
-}
-
-static inline u64 cirrus_bo_gpu_offset(struct cirrus_bo *bo)
-{
-	return bo->bo.offset;
-}
-
-int cirrus_bo_pin(struct cirrus_bo *bo, u32 pl_flag, u64 *gpu_addr)
-{
-	struct ttm_operation_ctx ctx = { false, false };
-	int i, ret;
-
-	if (bo->pin_count) {
-		bo->pin_count++;
-		if (gpu_addr)
-			*gpu_addr = cirrus_bo_gpu_offset(bo);
-	}
-
-	cirrus_ttm_placement(bo, pl_flag);
-	for (i = 0; i < bo->placement.num_placement; i++)
-		bo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
-	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
-	if (ret)
-		return ret;
-
-	bo->pin_count = 1;
-	if (gpu_addr)
-		*gpu_addr = cirrus_bo_gpu_offset(bo);
-	return 0;
-}
-
-int cirrus_bo_push_sysram(struct cirrus_bo *bo)
-{
-	struct ttm_operation_ctx ctx = { false, false };
-	int i, ret;
-	if (!bo->pin_count) {
-		DRM_ERROR("unpin bad %p\n", bo);
-		return 0;
-	}
-	bo->pin_count--;
-	if (bo->pin_count)
-		return 0;
-
-	if (bo->kmap.virtual)
-		ttm_bo_kunmap(&bo->kmap);
-
-	cirrus_ttm_placement(bo, TTM_PL_FLAG_SYSTEM);
-	for (i = 0; i < bo->placement.num_placement ; i++)
-		bo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
-
-	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
-	if (ret) {
-		DRM_ERROR("pushing to VRAM failed\n");
-		return ret;
-	}
-	return 0;
-}
-
-int cirrus_mmap(struct file *filp, struct vm_area_struct *vma)
-{
-	struct drm_file *file_priv;
-	struct cirrus_device *cirrus;
-
-	if (unlikely(vma->vm_pgoff < DRM_FILE_PAGE_OFFSET))
-		return -EINVAL;
-
-	file_priv = filp->private_data;
-	cirrus = file_priv->minor->dev->dev_private;
-	return ttm_bo_mmap(filp, vma, &cirrus->ttm.bdev);
-}
diff --git a/drivers/gpu/drm/cirrus/Kconfig b/drivers/gpu/drm/cirrus/Kconfig
index fc78c90ee931..dd4f52a0bc1c 100644
--- a/drivers/gpu/drm/cirrus/Kconfig
+++ b/drivers/gpu/drm/cirrus/Kconfig
@@ -2,7 +2,7 @@ config DRM_CIRRUS_QEMU
 	tristate "Cirrus driver for QEMU emulated device"
 	depends on DRM && PCI && MMU
 	select DRM_KMS_HELPER
-	select DRM_TTM
+	select DRM_GEM_SHMEM_HELPER
 	help
 	 This is a KMS driver for emulated cirrus device in qemu.
 	 It is *NOT* intended for real cirrus devices. This requires
diff --git a/drivers/gpu/drm/cirrus/Makefile b/drivers/gpu/drm/cirrus/Makefile
index 919c0a336c97..acf8971d37a1 100644
--- a/drivers/gpu/drm/cirrus/Makefile
+++ b/drivers/gpu/drm/cirrus/Makefile
@@ -1,4 +1 @@
-cirrus-y  := cirrus_main.o cirrus_mode.o \
-	cirrus_drv.o cirrus_fbdev.o cirrus_ttm.o
-
 obj-$(CONFIG_DRM_CIRRUS_QEMU) += cirrus.o
-- 
2.18.1

