Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C362C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09692084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="X7+/TkIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDCNZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:25:56 -0400
Received: from de-deferred1.bosch-org.com ([139.15.180.216]:42114 "EHLO
        de-deferred1.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbfDCNZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:25:53 -0400
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by si0vms0224.rbdmz01.com (Postfix) with ESMTPS id 44Z65f3nqDz29q;
        Wed,  3 Apr 2019 15:15:50 +0200 (CEST)
Received: from si0vm1947.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 44Z65c625Fz1XLG6v;
        Wed,  3 Apr 2019 15:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=in.bosch.com;
        s=2015-01-21; t=1554297348;
        bh=5JmXTCA8402bhLcSZ4Bm03a+Df0e1eFcN7hmyjl8vSI=; l=10;
        h=From:From:Reply-To:Sender;
        b=X7+/TkICb4Vcmx8SPBnNJJSLxMI2dW/tRjpHz0GUXEfmaxWlpCAHypxtZZraii2YP
         NIGkCHxmoMJlaK/mg5hAFev2pzQxIKhX1OF2Q7meaJsgypj588Zb6QqGDLoaQIYI23
         GdvyggSq850lcoVAR7IBWMf90rMmxqNaaiqxnFlo=
Received: from fe0vm02900.rbesz01.com (unknown [10.58.172.176])
        by si0vm1947.rbesz01.com (Postfix) with ESMTPS id 44Z65c5XlXz6CjQSS;
        Wed,  3 Apr 2019 15:15:48 +0200 (CEST)
X-AuditID: 0a3aad0c-d01ff700000039d6-3b-5ca4b20455d2
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm02900.rbesz01.com (SMG Outbound) with SMTP id 70.BF.14806.402B4AC5; Wed,  3 Apr 2019 15:15:48 +0200 (CEST)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 44Z65c08p9z6CjZqr;
        Wed,  3 Apr 2019 15:15:48 +0200 (CEST)
Received: from localhost.localdomain (10.47.103.88) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 3 Apr 2019
 15:15:45 +0200
From:   <VenkataRajesh.Kalakodima@in.bosch.com>
To:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
        Tsutomu Muroya <muroya@ksk.co.jp>,
        Steve Longerbeam <steve_longerbeam@mentor.com>
Subject: [PATCH 1/8] drm: Add DU CMM support functions
Date:   Wed, 3 Apr 2019 18:44:37 +0530
Message-ID: <1554297284-14009-2-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.103.88]
X-Brightmail-Tracker: H4sIAAAAAAAAA22Sf0wbZRjHed+7647KkeNg8FA2nBf1D8lmmW5WWcw0/tGZTJclM5npsh1y
        tM0okLvSwBIMsjAzIE4Stwjr2qGNA2IdxcyxgXTrUMuPwcQtU1mKmWjKMn4X12Uq3lFY+4f/
        Pc/zfT7vN+83D01wA+t0tLXULkqlQgmv0ZLaV7wbN5NdHpP+Vneywd0/QhluLs1qDFGnHxvm
        G0OU4afLTo3hwtQMNly7fYUwnPN+RuykjR2eKGGcaPgBG3uWapHxr+Em0rjYlbuHele7o0gs
        sTpE6flXD2ktoeFasrx/EVfWOXNr0OhXuB4l08C+CP7eM+vqkZbm2GYMt329VKzxI4gMzeFY
        cx/Bud+GSRXRsJvB7/OtIBlsO4KGmYsrWwQ7iCAwOK00NJ3ObocTXkEtSfZp6H60S2UZdh+0
        LLSgmHUu/DJynFDrZPYdcAcnNWrNKTvu6AIV20+DgebJFV+CBbgaDhPqk8Bugkutmo8R25Kw
        1ZKwdRbhDpRZLOodNv3Wl/X6LVKhKB/R5295r8zWhWJxp3Sj7zzmAGJpxKcwC80eE0cJDrnK
        FkDbaMyvZ7a/r4xSC8uKqiyCbDkoVZSIMq9jNtx408SlPx7LFYU2qyxby0oDCGiCz2CGT5w1
        cUyRUHVElMpiWADl0CSfxZjpt00caxbs4mFRLBelNbWApnlgMnyKYZokmsXKYmuJfU3mNzIo
        KSmJy0xUEm0xnRxAL9ApijdWn2DkcsEmW82reHYM59amcXQQvaTLYvaoDKuqlorSx666DUzS
        Hy4Ttz5BiJP30BhScktn/jmvwCnKJcf9gMlRI0pbHcahrS6FYX8uhr62VAh5ddAzaQTX+FvQ
        d2w/BDurYOBONUx9WINg6vpRBJdu1CNwz7Qi+GbOg2D5c+UmXd1LCNrml5W27QMMf3cdxRD8
        1Ynh7vcuDI+G2jH0/Xkfw9jlBxhOjbQSEJluJ+DhR7MEBD0PCGhrOkbCXNBHwt1PJkj4fXyS
        hMiZkxSEOk9T95QUsZKiocKtpmgX7P+T4uo0/i1dDfLOSPvnQ8u780/67hyvY7/1NWR/GTWO
        RVL/te+acBRc8H8d6T99/aFLXz8ebDp8kbgW3elgpPM7Gq801oWfoaKaocWn9kaqF+A1dvSJ
        MV/f9BcoI4fal525N/x67tWOXrmwjq+tznsyb+hQT9622QMFzzrDDVmVb2zq/NT64+LoKZ6U
        LUL+c4QkC/8Brf5tmFwEAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>

This is the out-of-tree patch for DU CMM driver support from
Yocto release v3.4.0.

Link: https://github.com/renesas-rcar/du_cmm/commit/2d8ea2b667ad4616aa639c54ecc11f7c4b58959d.patch

Following is from the patch description:

    du_cmm: Release for Yocto v3.4.0

    This patch made the following correspondence.

      - Corresponds to kernel v 4.14.
      - Double buffer only is supported.
      - Fix CLU / LUT update timing.
      - Add CMM Channel occupation mode.
      - Fix Close process.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Tsutomu Muroya <muroya@ksk.co.jp>
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

      - Removal of rcar specific ioctals
      - Resolved checkpatch errors
      - Resolved merge conflicts according to latest version
      - Included CMM drivers and included files from base patch
      - Removed rcar_du_drm.h include file

Signed-off-by: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
---
 drivers/gpu/drm/rcar-du/Makefile        |    2 +
 drivers/gpu/drm/rcar-du/rcar_du_cmm.c   | 1200 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  |   24 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h  |   16 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c   |   43 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h   |   16 +-
 drivers/gpu/drm/rcar-du/rcar_du_group.c |    5 +
 drivers/gpu/drm/rcar-du/rcar_du_regs.h  |   92 +++
 include/drm/drm_ioctl.h                 |    7 +
 9 files changed, 1398 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_cmm.c

diff --git a/drivers/gpu/drm/rcar-du/Makefile b/drivers/gpu/drm/rcar-du/Makefile
index 2a3b8d7..595e719 100644
--- a/drivers/gpu/drm/rcar-du/Makefile
+++ b/drivers/gpu/drm/rcar-du/Makefile
@@ -6,12 +6,14 @@ rcar-du-drm-y := rcar_du_crtc.o \
 		 rcar_du_kms.o \
 		 rcar_du_plane.o
 
+rcar-du-drm-y += rcar_du_cmm.o
 rcar-du-drm-$(CONFIG_DRM_RCAR_LVDS)	+= rcar_du_of.o \
 					   rcar_du_of_lvds_r8a7790.dtb.o \
 					   rcar_du_of_lvds_r8a7791.dtb.o \
 					   rcar_du_of_lvds_r8a7793.dtb.o \
 					   rcar_du_of_lvds_r8a7795.dtb.o \
 					   rcar_du_of_lvds_r8a7796.dtb.o
+
 rcar-du-drm-$(CONFIG_DRM_RCAR_VSP)	+= rcar_du_vsp.o
 
 obj-$(CONFIG_DRM_RCAR_DU)		+= rcar-du-drm.o
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_cmm.c b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
new file mode 100644
index 0000000..ac613a6e
--- /dev/null
+++ b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
@@ -0,0 +1,1200 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*************************************************************************/ /*
+ * DU CMM
+ *
+ * Copyright (C) 2018 Renesas Electronics Corporation
+ *
+ * License        Dual MIT/GPLv2
+ *
+ * The contents of this file are subject to the MIT license as set out below.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * Alternatively, the contents of this file may be used under the terms of
+ * the GNU General Public License Version 2 ("GPL") in which case the provisions
+ * of GPL are applicable instead of those above.
+ *
+ * If you wish to allow use of your version of this file only under the terms of
+ * GPL, and not to allow others to use your version of this file under the terms
+ * of the MIT license, indicate your decision by deleting the provisions above
+ * and replace them with the notice and other provisions required by GPL as set
+ * out in the file called "GPL-COPYING" included in this distribution. If you do
+ * not delete the provisions above, a recipient may use your version of this
+ * file under the terms of either the MIT license or GPL.
+ *
+ * This License is also included in this distribution in the file called
+ * "MIT-COPYING".
+ *
+ * EXCEPT AS OTHERWISE STATED IN A NEGOTIATED AGREEMENT: (A) THE SOFTWARE IS
+ * PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
+ * BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
+ * PARTICULAR PURPOSE AND NONINFRINGEMENT; AND (B) IN NO EVENT SHALL THE AUTHORS
+ * OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
+ * IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ *
+ * GPLv2:
+ * If you wish to use this file under the terms of GPL, following terms are
+ * effective.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */ /*************************************************************************/
+#include <linux/syscalls.h>
+#include <linux/workqueue.h>
+
+#include <linux/reset.h>
+#include <linux/sys_soc.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+
+#include "rcar_du_crtc.h"
+#include "rcar_du_drv.h"
+#include "rcar_du_kms.h"
+#include "rcar_du_plane.h"
+#include "rcar_du_regs.h"
+#include <linux/clk.h>
+
+/* #define DEBUG_PROCE_TIME 1 */
+
+#define CMM_LUT_NUM 256
+#define CMM_CLU_NUM (17 * 17 * 17)
+#define CMM_HGO_NUM 64
+/* rcar_du_drm.h Include */
+#define LUT_DOUBLE_BUFFER_AUTO		0
+#define LUT_DOUBLE_BUFFER_A		1
+#define LUT_DOUBLE_BUFFER_B		2
+/* DRM_RCAR_DU_CMM_WAIT_EVENT: DU-CMM done event */
+#define CMM_EVENT_CLU_DONE		BIT(0)
+#define CMM_EVENT_HGO_DONE		BIT(1)
+#define CMM_EVENT_LUT_DONE		BIT(2)
+
+#define CLU_DOUBLE_BUFFER_AUTO		0
+#define CLU_DOUBLE_BUFFER_A		1
+#define CLU_DOUBLE_BUFFER_B		2
+enum {
+	QUE_STAT_PENDING,
+	QUE_STAT_ACTIVE,
+	QUE_STAT_DONE,
+};
+
+static const struct soc_device_attribute rcar_du_cmm_r8a7795_es1[] = {
+	{ .soc_id = "r8a7795", .revision = "ES1.*" },
+	{ /* sentinel */ }
+};
+
+struct rcar_du_cmm;
+struct rcar_du_cmm_file_priv;
+
+struct rcar_du_cmm_pending_event {
+	struct list_head link;
+	struct list_head  fpriv_link;
+	unsigned int event;
+	unsigned int stat;
+	unsigned long callback_data;
+	struct drm_gem_object *gem_obj;
+	struct rcar_du_cmm *du_cmm;
+	struct rcar_du_cmm_file_priv *fpriv;
+};
+
+struct cmm_module_t {
+	struct list_head list;
+	union {
+		struct {
+			struct rcar_du_cmm_pending_event *p;
+			int buf_mode;
+			bool one_side;
+		};
+		int reset;
+	};
+};
+
+struct cmm_reg_save {
+#ifdef CONFIG_PM_SLEEP
+	wait_queue_head_t wait;
+
+	u32 *lut_table;
+	u32 *clu_table;
+#endif /* CONFIG_PM_SLEEP */
+
+	u32 cm2_ctl0;	/* CM2_CTL0 */
+	u32 hgo_offset;	/* CMM_HGO_OFFSET */
+	u32 hgo_size;	/* CMM_HGO_SIZE */
+	u32 hgo_mode;	/* CMM_HGO_MODE */
+};
+
+struct rcar_du_cmm {
+	struct rcar_du_crtc *rcrtc;
+
+	/* CMM base address */
+	void __iomem *cmm_base;
+	struct clk *clock;
+
+	struct cmm_module_t lut;
+	struct cmm_module_t clu;
+	struct cmm_module_t hgo;
+
+	struct mutex lock;	/* lock for register setting */
+	struct workqueue_struct *workqueue;
+	struct work_struct work;
+
+	struct cmm_reg_save reg_save;
+	bool active;
+	bool dbuf;
+	bool clu_dbuf;
+	bool init;
+	bool direct;
+	bool vsync;
+	bool authority;
+	pid_t pid;
+	bool soc_support;
+};
+
+struct rcar_du_cmm_file_priv {
+	wait_queue_head_t event_wait;
+	struct list_head list;
+	struct list_head active_list;
+	struct list_head *done_list;
+};
+
+static DEFINE_MUTEX(cmm_event_lock);
+static DEFINE_SPINLOCK(cmm_direct_lock);
+
+static inline void event_prev_cancel_locked(struct cmm_module_t *module);
+
+static inline u32 cmm_index(struct rcar_du_cmm *_cmm)
+{
+	struct rcar_du_device *rcdu = _cmm->rcrtc->group->dev;
+
+	if (rcar_du_has(rcdu, RCAR_DU_FEATURE_R8A77965_REGS)) {
+		if ((_cmm)->rcrtc->index == 3)
+			return 2;
+	}
+	return (_cmm)->rcrtc->index;
+}
+
+#define cmm_done_list(_cmm, _fpriv) \
+	(&((_fpriv)->done_list[cmm_index(_cmm)]))
+
+static inline u32 rcar_du_cmm_read(struct rcar_du_cmm *du_cmm, u32 reg)
+{
+	return ioread32(du_cmm->cmm_base + reg);
+}
+
+static inline void rcar_du_cmm_write(struct rcar_du_cmm *du_cmm,
+				     u32 reg, u32 data)
+{
+	iowrite32(data, du_cmm->cmm_base + reg);
+}
+
+/* create default CLU table data */
+static inline u32 index_to_clu_data(int index)
+{
+	int r, g, b;
+
+	r = index % 17;
+	index /= 17;
+	g = index % 17;
+	index /= 17;
+	b = index % 17;
+
+	r = (r << 20);
+	if (r > (255 << 16))
+		r = (255 << 16);
+	g = (g << 12);
+	if (g > (255 << 8))
+		g = (255 << 8);
+	b = (b << 4);
+	if (b > (255 << 0))
+		b = (255 << 0);
+
+	return r | g | b;
+}
+
+#ifdef DEBUG_PROCE_TIME
+static long long diff_timevals(struct timeval *start, struct timeval *end)
+{
+	return (end->tv_sec * 1000000LL + end->tv_usec) -
+		(start->tv_sec * 1000000LL + start->tv_usec);
+}
+#endif
+
+static void du_cmm_clk(struct rcar_du_cmm *du_cmm, bool on)
+{
+	if (on)
+		clk_prepare_enable(du_cmm->clock);
+	else
+		clk_disable_unprepare(du_cmm->clock);
+}
+
+int rcar_du_cmm_start_stop(struct rcar_du_crtc *rcrtc, bool on)
+{
+	struct rcar_du_cmm *du_cmm = rcrtc->cmm_handle;
+	int i;
+	u32 table_data;
+	const struct drm_display_mode *mode;
+	int w, h, x, y;
+
+	if (!du_cmm)
+		return -EINVAL;
+
+	mutex_lock(&du_cmm->lock);
+
+	if (!on) {
+		du_cmm->active = false;
+
+		rcar_du_cmm_write(du_cmm, CMM_LUT_CTRL, 0x00000000);
+		rcar_du_cmm_write(du_cmm, CMM_CLU_CTRL, 0x00000000);
+
+		du_cmm_clk(du_cmm, false);
+
+		goto end;
+	}
+
+	du_cmm_clk(du_cmm, true);
+
+	if (du_cmm->init)
+		goto init_done;
+
+	du_cmm->init = true;
+
+	mode = &du_cmm->rcrtc->crtc.mode;
+
+	x = (du_cmm->reg_save.hgo_offset >> 16) & 0xFFFF;
+	y = (du_cmm->reg_save.hgo_offset >> 0)  & 0xFFFF;
+	w = (du_cmm->reg_save.hgo_size >> 16) & 0xFFFF;
+	h = (du_cmm->reg_save.hgo_size >> 0)  & 0xFFFF;
+	if ((mode->hdisplay < (w + x)) || w == 0) {
+		x = 0;
+		w = mode->hdisplay;
+	}
+	if ((mode->vdisplay < (h + y)) || h == 0) {
+		y = 0;
+		h = mode->vdisplay;
+	}
+	du_cmm->reg_save.hgo_offset = (x << 16) | y;
+	du_cmm->reg_save.hgo_size = (w << 16) | h;
+
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+		du_cmm->reg_save.cm2_ctl0 |= CMM_CTL0_VPOL;
+	else
+		du_cmm->reg_save.cm2_ctl0 &= ~CMM_CTL0_VPOL;
+
+	rcar_du_cmm_write(du_cmm, CM2_CTL0, du_cmm->reg_save.cm2_ctl0);
+	rcar_du_cmm_write(du_cmm, CMM_HGO_OFFSET, du_cmm->reg_save.hgo_offset);
+	rcar_du_cmm_write(du_cmm, CMM_HGO_SIZE, du_cmm->reg_save.hgo_size);
+	rcar_du_cmm_write(du_cmm, CMM_HGO_MODE, du_cmm->reg_save.hgo_mode);
+	rcar_du_cmm_write(du_cmm, CMM_HGO_LB_TH, 0);
+	rcar_du_cmm_write(du_cmm, CMM_HGO_LB0_H, 0);
+	rcar_du_cmm_write(du_cmm, CMM_HGO_LB0_V, 0);
+	rcar_du_cmm_write(du_cmm, CMM_HGO_LB1_H, 0);
+	rcar_du_cmm_write(du_cmm, CMM_HGO_LB1_V, 0);
+	rcar_du_cmm_write(du_cmm, CMM_HGO_LB2_H, 0);
+	rcar_du_cmm_write(du_cmm, CMM_HGO_LB2_V, 0);
+	rcar_du_cmm_write(du_cmm, CMM_HGO_LB3_H, 0);
+	rcar_du_cmm_write(du_cmm, CMM_HGO_LB3_V, 0);
+
+	/* init color table */
+	for (i = 0; i < CMM_LUT_NUM; i++) {
+	#ifdef CONFIG_PM_SLEEP
+		table_data = du_cmm->reg_save.lut_table[i];
+	#else
+		table_data = ((i << 16) | (i << 8) | (i << 0));
+	#endif /* CONFIG_PM_SLEEP */
+		rcar_du_cmm_write(du_cmm, CMM_LUT_TBLA(i), table_data);
+
+		if (du_cmm->dbuf)
+			rcar_du_cmm_write(du_cmm, CMM_LUT_TBLB(i),
+					  table_data);
+	}
+
+	rcar_du_cmm_write(du_cmm, CMM_CLU_CTRL,
+			  CMM_CLU_CTRL_AAI | CMM_CLU_CTRL_MVS);
+
+	rcar_du_cmm_write(du_cmm, CMM_CLU_ADDR, 0);
+	if (du_cmm->clu_dbuf)
+		rcar_du_cmm_write(du_cmm, CMM_CLU_ADDR2, 0);
+
+	for (i = 0; i < CMM_CLU_NUM; i++) {
+	#ifdef CONFIG_PM_SLEEP
+		table_data = du_cmm->reg_save.clu_table[i];
+	#else
+		table_data = index_to_clu_data(i);
+	#endif /* CONFIG_PM_SLEEP */
+		rcar_du_cmm_write(du_cmm, CMM_CLU_DATA, table_data);
+
+		if (du_cmm->dbuf)
+			rcar_du_cmm_write(du_cmm, CMM_CLU_DATA2,
+					  table_data);
+	}
+
+init_done:
+	/* enable color table */
+	rcar_du_cmm_write(du_cmm, CMM_LUT_CTRL, CMM_LUT_CTRL_EN);
+	rcar_du_cmm_write(du_cmm, CMM_CLU_CTRL, CMM_CLU_CTRL_AAI |
+			  CMM_CLU_CTRL_MVS | CMM_CLU_CTRL_EN);
+
+	du_cmm->active = true;
+end:
+	mutex_unlock(&du_cmm->lock);
+
+	return 0;
+}
+
+#define gem_to_vaddr(gem_obj) \
+	(container_of((gem_obj), struct drm_gem_cma_object, base)->vaddr)
+
+static inline void cmm_vblank_put(struct rcar_du_cmm_pending_event *p)
+{
+	if (p->du_cmm)
+		drm_crtc_vblank_put(&p->du_cmm->rcrtc->crtc);
+}
+
+static inline void
+cmm_gem_object_unreference(struct rcar_du_cmm_pending_event *p)
+{
+	if (p->gem_obj)
+		drm_gem_object_unreference_unlocked(p->gem_obj);
+}
+
+static inline void _event_done_locked(struct rcar_du_cmm_pending_event *p)
+{
+	cmm_gem_object_unreference(p);
+
+	if (p->fpriv) {
+		p->stat = QUE_STAT_DONE;
+		list_del(&p->link); /* delete from p->fpriv->active_list */
+		list_add_tail(&p->link, cmm_done_list(p->du_cmm, p->fpriv));
+		wake_up_interruptible(&p->fpriv->event_wait);
+	} else {
+		/* link deleted by rcar_du_cmm_postclose */
+		kfree(p);
+	}
+}
+
+/* cancel from active_list (case of LUT/CLU double buffer mode) */
+static inline void event_prev_cancel_locked(struct cmm_module_t *module)
+{
+	struct rcar_du_cmm_pending_event *p = module->p;
+
+	if (!p)
+		return;
+
+	module->p = NULL;
+
+	_event_done_locked(p);
+}
+
+static inline void event_done(struct rcar_du_cmm_pending_event *p)
+{
+	/* vblank is put */
+
+	mutex_lock(&cmm_event_lock);
+
+	_event_done_locked(p);
+
+	mutex_unlock(&cmm_event_lock);
+}
+
+static inline void lc_event_done(struct cmm_module_t *module,
+				 struct rcar_du_cmm_pending_event *p,
+				 bool done)
+{
+	/* vblank is put */
+
+	mutex_lock(&cmm_event_lock);
+
+	if (!done && list_empty(&module->list))
+		module->p = p;
+	else
+		_event_done_locked(p);
+
+	mutex_unlock(&cmm_event_lock);
+}
+
+static inline struct rcar_du_cmm_pending_event *
+event_pop_locked(struct cmm_module_t *module)
+{
+	struct rcar_du_cmm_pending_event *p =
+		list_first_entry(&module->list,
+				 struct rcar_du_cmm_pending_event,
+				 link);
+
+	p->stat = QUE_STAT_ACTIVE;
+	list_del(&p->link); /* delete from du_cmm->[lut|clu|hgo].list */
+	list_add_tail(&p->link, &p->fpriv->active_list);
+	cmm_vblank_put(p);
+
+	return p;
+}
+
+struct rcar_du_cmm_work_stat {
+	union {
+		struct {
+			struct rcar_du_cmm_pending_event *p;
+			bool done;
+			bool table_copy;
+		};
+		struct {
+			struct rcar_du_cmm_pending_event *p2;
+			bool reset;
+		};
+	};
+};
+
+static inline void one_side(struct rcar_du_cmm *du_cmm,
+			    struct cmm_module_t *module,
+			    bool on)
+{
+	if (on && !module->one_side) {
+		module->one_side = true;
+		drm_crtc_vblank_get(&du_cmm->rcrtc->crtc);
+	} else if (!on && module->one_side) {
+		module->one_side = false;
+		drm_crtc_vblank_put(&du_cmm->rcrtc->crtc);
+	}
+}
+
+/* pop LUT que */
+static int lut_pop_locked(struct rcar_du_cmm *du_cmm,
+			  struct rcar_du_cmm_work_stat *stat)
+{
+	bool is_one_side = false;
+
+	stat->done = true;
+	stat->table_copy = false;
+
+	if (!list_empty(&du_cmm->lut.list)) {
+		stat->p = event_pop_locked(&du_cmm->lut);
+
+		/* prev lut table */
+		event_prev_cancel_locked(&du_cmm->lut);
+
+		if (du_cmm->lut.buf_mode == LUT_DOUBLE_BUFFER_AUTO) {
+			is_one_side = true;
+			if (list_empty(&du_cmm->lut.list))
+				stat->done = false;
+		}
+
+	} else if (du_cmm->lut.p) {
+		/* prev lut table */
+		stat->p = du_cmm->lut.p;
+		du_cmm->lut.p = NULL;
+	} else {
+		stat->done = false;
+		stat->p = NULL;
+		stat->table_copy = du_cmm->lut.one_side;
+	}
+
+	one_side(du_cmm, &du_cmm->lut, is_one_side);
+
+	return 0;
+}
+
+static int lut_table_copy(struct rcar_du_cmm *du_cmm)
+{
+	int i;
+	u32 src, dst;
+
+	if (rcar_du_cmm_read(du_cmm, CM2_CTL1) & CMM_CTL1_BFS) {
+		dst = CMM_LUT_TBLA(0);
+		src = CMM_LUT_TBLB(0);
+	} else {
+		dst = CMM_LUT_TBLB(0);
+		src = CMM_LUT_TBLA(0);
+	}
+
+	for (i = 0; i < CMM_LUT_NUM; i++) {
+		rcar_du_cmm_write(du_cmm, dst, rcar_du_cmm_read(du_cmm, src));
+		dst += 4;
+		src += 4;
+	}
+
+	return 0;
+}
+
+/* set 1D look up table */
+static int lut_set(struct rcar_du_cmm *du_cmm,
+		   struct rcar_du_cmm_work_stat *stat)
+{
+	int i;
+	u32 lut_base;
+	u32 *lut_buf;
+
+	if (!stat->p) {
+		if (stat->table_copy)
+			lut_table_copy(du_cmm);
+		return 0; /* skip */
+	}
+
+	/* set LUT */
+	switch (du_cmm->lut.buf_mode) {
+	case LUT_DOUBLE_BUFFER_A:
+		lut_base = CMM_LUT_TBLA(0);
+		break;
+
+	case LUT_DOUBLE_BUFFER_AUTO:
+		if (rcar_du_cmm_read(du_cmm, CM2_CTL1) & CMM_CTL1_BFS) {
+			lut_base = CMM_LUT_TBLA(0);
+			break;
+		}
+		lut_base = CMM_LUT_TBLB(0);
+		break;
+	case LUT_DOUBLE_BUFFER_B:
+		lut_base = CMM_LUT_TBLB(0);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	lut_buf = gem_to_vaddr(stat->p->gem_obj);
+	for (i = 0; i < CMM_LUT_NUM; i++)
+		rcar_du_cmm_write(du_cmm, lut_base + i * 4, lut_buf[i]);
+
+	lc_event_done(&du_cmm->lut, stat->p, stat->done);
+
+	return 0;
+}
+
+/* pop CLU que */
+static int clu_pop_locked(struct rcar_du_cmm *du_cmm,
+			  struct rcar_du_cmm_work_stat *stat)
+{
+	bool is_one_side = false;
+
+	stat->done = true;
+	stat->table_copy = false;
+
+	if (!list_empty(&du_cmm->clu.list)) {
+		stat->p = event_pop_locked(&du_cmm->clu);
+
+		/* prev clu table */
+		event_prev_cancel_locked(&du_cmm->clu);
+
+		if (du_cmm->clu.buf_mode == CLU_DOUBLE_BUFFER_AUTO) {
+			is_one_side = true;
+			if (list_empty(&du_cmm->clu.list))
+				stat->done = false;
+		}
+
+	} else if (du_cmm->clu.p) {
+		/* prev clu table */
+		stat->p = du_cmm->clu.p;
+		du_cmm->clu.p = NULL;
+	} else {
+		stat->done = false;
+		stat->p = NULL;
+		stat->table_copy = du_cmm->clu.one_side;
+	}
+
+	one_side(du_cmm, &du_cmm->clu, is_one_side);
+
+	return 0;
+}
+
+static int clu_table_copy(struct rcar_du_cmm *du_cmm)
+{
+	int i, j, k;
+	u32 src_addr, src_data, dst_addr, dst_data;
+
+	if (rcar_du_cmm_read(du_cmm, CM2_CTL1) & CMM_CTL1_BFS) {
+		dst_addr = CMM_CLU_ADDR;
+		dst_data = CMM_CLU_DATA;
+		src_addr = CMM_CLU_ADDR2;
+		src_data = CMM_CLU_DATA2;
+	} else {
+		dst_addr = CMM_CLU_ADDR2;
+		dst_data = CMM_CLU_DATA2;
+		src_addr = CMM_CLU_ADDR;
+		src_data = CMM_CLU_DATA;
+	}
+
+	rcar_du_cmm_write(du_cmm, dst_addr, 0);
+	for (i = 0; i < 17; i++) {
+		for (j = 0; j < 17; j++) {
+			for (k = 0; k < 17; k++) {
+				rcar_du_cmm_write(du_cmm, src_addr,
+						  (k << 16) | (j << 8) |
+						  (i << 0));
+				rcar_du_cmm_write(du_cmm, dst_data,
+						  rcar_du_cmm_read(du_cmm,
+								   src_data));
+			}
+		}
+	}
+
+	return 0;
+}
+
+/* set 3D look up table */
+static int clu_set(struct rcar_du_cmm *du_cmm,
+		   struct rcar_du_cmm_work_stat *stat)
+{
+	int i;
+	u32 addr_reg, data_reg;
+	u32 *clu_buf;
+
+	if (!stat->p) {
+		if (stat->table_copy)
+			clu_table_copy(du_cmm);
+		return 0; /* skip */
+	}
+
+	/* set CLU */
+	switch (du_cmm->clu.buf_mode) {
+	case CLU_DOUBLE_BUFFER_A:
+		addr_reg = CMM_CLU_ADDR;
+		data_reg = CMM_CLU_DATA;
+		break;
+
+	case CLU_DOUBLE_BUFFER_AUTO:
+		if (rcar_du_cmm_read(du_cmm, CM2_CTL1) & CMM_CTL1_BFS) {
+			addr_reg = CMM_CLU_ADDR;
+			data_reg = CMM_CLU_DATA;
+			break;
+		}
+		addr_reg = CMM_CLU_ADDR2;
+		data_reg = CMM_CLU_DATA2;
+		break;
+	case CLU_DOUBLE_BUFFER_B:
+		addr_reg = CMM_CLU_ADDR2;
+		data_reg = CMM_CLU_DATA2;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	clu_buf = gem_to_vaddr(stat->p->gem_obj);
+	rcar_du_cmm_write(du_cmm, addr_reg, 0);
+	for (i = 0; i < CMM_CLU_NUM; i++)
+		rcar_du_cmm_write(du_cmm, data_reg, clu_buf[i]);
+
+	lc_event_done(&du_cmm->clu, stat->p, stat->done);
+
+	return 0;
+}
+
+/* pop HGO que */
+static int hgo_pop_locked(struct rcar_du_cmm *du_cmm,
+			  struct rcar_du_cmm_work_stat *stat)
+{
+	struct rcar_du_cmm_pending_event *_p = NULL;
+
+	if (!list_empty(&du_cmm->hgo.list))
+		_p = event_pop_locked(&du_cmm->hgo);
+
+	if (du_cmm->hgo.reset) {
+		drm_crtc_vblank_put(&du_cmm->rcrtc->crtc);
+		du_cmm->hgo.reset = 0;
+		stat->reset = true;
+	} else {
+		stat->reset = false;
+	}
+
+	stat->p2 = _p;
+
+	return 0;
+}
+
+/* get histogram */
+static int hgo_get(struct rcar_du_cmm *du_cmm,
+		   struct rcar_du_cmm_work_stat *stat)
+{
+	int i, j;
+	const u32 histo_offset[3] = {
+		CMM_HGO_R_HISTO(0),
+		CMM_HGO_G_HISTO(0),
+		CMM_HGO_B_HISTO(0),
+	};
+	void *vaddr;
+
+	if (!stat->p2) {
+		if (stat->reset)
+			goto hgo_reset;
+
+		return 0; /* skip */
+	}
+
+	vaddr = gem_to_vaddr(stat->p2->gem_obj);
+	for (i = 0; i < 3; i++) {
+		u32 *hgo_buf = vaddr + CMM_HGO_NUM * 4 * i;
+
+		for (j = 0; j < CMM_HGO_NUM; j++)
+			hgo_buf[j] = rcar_du_cmm_read(du_cmm,
+						      histo_offset[i] + j * 4);
+	}
+
+	event_done(stat->p2);
+
+hgo_reset:
+	rcar_du_cmm_write(du_cmm, CMM_HGO_REGRST, CMM_HGO_REGRST_RCLEA);
+
+	return 0;
+}
+
+static bool du_cmm_vsync_get(struct rcar_du_cmm *du_cmm)
+{
+	unsigned long flags;
+	bool vsync;
+
+	spin_lock_irqsave(&cmm_direct_lock, flags);
+	vsync = du_cmm->vsync;
+	du_cmm->vsync = false;
+	spin_unlock_irqrestore(&cmm_direct_lock, flags);
+
+	return vsync;
+}
+
+static void du_cmm_vsync_set(struct rcar_du_cmm *du_cmm, bool vsync)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cmm_direct_lock, flags);
+	du_cmm->vsync = vsync;
+	spin_unlock_irqrestore(&cmm_direct_lock, flags);
+}
+
+static void du_cmm_work(struct work_struct *work)
+{
+	struct rcar_du_cmm *du_cmm =
+			container_of(work, struct rcar_du_cmm, work);
+	struct rcar_du_cmm_work_stat s_lut;
+	struct rcar_du_cmm_work_stat s_clu;
+	struct rcar_du_cmm_work_stat s_hgo;
+#ifdef DEBUG_PROCE_TIME
+	struct timeval start_time, end_time;
+	unsigned long lut_time, clu_time, hgo_time;
+#endif
+	bool vsync_status = false;
+
+	memset(&s_lut, 0, sizeof(struct rcar_du_cmm_work_stat));
+	memset(&s_clu, 0, sizeof(struct rcar_du_cmm_work_stat));
+	memset(&s_hgo, 0, sizeof(struct rcar_du_cmm_work_stat));
+
+	vsync_status = du_cmm_vsync_get(du_cmm);
+
+	mutex_lock(&cmm_event_lock);
+
+	lut_pop_locked(du_cmm, &s_lut);
+	clu_pop_locked(du_cmm, &s_clu);
+	if (vsync_status)
+		hgo_pop_locked(du_cmm, &s_hgo);
+
+	mutex_unlock(&cmm_event_lock);
+
+	/* set LUT */
+#ifdef DEBUG_PROCE_TIME
+	do_gettimeofday(&start_time);
+#endif
+	lut_set(du_cmm, &s_lut);
+#ifdef DEBUG_PROCE_TIME
+	do_gettimeofday(&end_time);
+	lut_time = (long)diff_timevals(&start_time, &end_time);
+#endif
+
+	/* set CLU */
+#ifdef DEBUG_PROCE_TIME
+	do_gettimeofday(&start_time);
+#endif
+	clu_set(du_cmm, &s_clu);
+#ifdef DEBUG_PROCE_TIME
+	do_gettimeofday(&end_time);
+	clu_time = (long)diff_timevals(&start_time, &end_time);
+#endif
+
+	/* get HGO */
+#ifdef DEBUG_PROCE_TIME
+	do_gettimeofday(&start_time);
+#endif
+	if (vsync_status)
+		hgo_get(du_cmm, &s_hgo);
+#ifdef DEBUG_PROCE_TIME
+	do_gettimeofday(&end_time);
+	hgo_time = (long)diff_timevals(&start_time, &end_time);
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+	wake_up_interruptible(&du_cmm->reg_save.wait);
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef DEBUG_PROCE_TIME
+	{
+		struct rcar_du_device *rcdu = du_cmm->rcrtc->group->dev;
+
+		if (s_lut.p)
+			dev_info(rcdu->dev, "LUT %ld usec.\n", lut_time);
+		if (s_clu.p)
+			dev_info(rcdu->dev, "LUT %ld usec.\n", clu_time);
+		if (s_hgo.p2)
+			dev_info(rcdu->dev, "HGO %ld usec.\n", hgo_time);
+	}
+#endif
+}
+
+static int du_cmm_que_empty(struct rcar_du_cmm *du_cmm)
+{
+	if (list_empty(&du_cmm->lut.list) && !du_cmm->lut.p &&
+	    !du_cmm->lut.one_side &&
+	    list_empty(&du_cmm->clu.list) && !du_cmm->clu.p &&
+	    !du_cmm->clu.one_side &&
+	    list_empty(&du_cmm->hgo.list) && !du_cmm->hgo.reset)
+		return 1;
+
+	return 0;
+}
+
+void rcar_du_cmm_kick(struct rcar_du_crtc *rcrtc)
+{
+	struct rcar_du_cmm *du_cmm = rcrtc->cmm_handle;
+
+	if (!du_cmm)
+		return;
+
+	if (!du_cmm->active)
+		return;
+
+	if (!du_cmm_que_empty(du_cmm)) {
+		du_cmm_vsync_set(du_cmm, true);
+		queue_work(du_cmm->workqueue, &du_cmm->work);
+	}
+}
+
+#ifdef CONFIG_PM_SLEEP
+int rcar_du_cmm_pm_suspend(struct rcar_du_crtc *rcrtc)
+{
+	struct rcar_du_cmm *du_cmm = rcrtc->cmm_handle;
+	struct rcar_du_device *rcdu = rcrtc->group->dev;
+	int i, j, k, index;
+	int ret;
+
+	if (!du_cmm)
+		return 0;
+
+	ret = wait_event_timeout(du_cmm->reg_save.wait,
+				 du_cmm_que_empty(du_cmm),
+				 msecs_to_jiffies(500));
+	if (ret == 0)
+		dev_err(rcdu->dev, "rcar-du cmm suspend : timeout\n");
+
+	if (!du_cmm->init)
+		return 0;
+
+	du_cmm->init = false;
+
+	if (!du_cmm->active)
+		du_cmm_clk(du_cmm, true);
+
+	/* table save */
+	for (i = 0; i < CMM_LUT_NUM; i++) {
+		du_cmm->reg_save.lut_table[i] =
+			rcar_du_cmm_read(du_cmm, CMM_LUT_TBLA(i));
+	}
+
+	index = 0;
+	for (i = 0; i < 17; i++) {
+		for (j = 0; j < 17; j++) {
+			for (k = 0; k < 17; k++) {
+				rcar_du_cmm_write(du_cmm, CMM_CLU_ADDR,
+						  (k << 16) | (j << 8) |
+						  (i << 0));
+				du_cmm->reg_save.clu_table[index++] =
+					rcar_du_cmm_read(du_cmm, CMM_CLU_DATA);
+			}
+		}
+	}
+
+	if (!du_cmm->active)
+		du_cmm_clk(du_cmm, false);
+
+	return 0;
+}
+
+int rcar_du_cmm_pm_resume(struct rcar_du_crtc *rcrtc)
+{
+	/* none */
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+int rcar_du_cmm_driver_open(struct drm_device *dev, struct drm_file *file_priv)
+{
+	struct rcar_du_device *rcdu = dev->dev_private;
+	struct rcar_du_cmm_file_priv *fpriv;
+	int i;
+
+	if (!rcar_du_has(rcdu, RCAR_DU_FEATURE_CMM))
+		return 0;
+
+	file_priv->driver_priv = NULL;
+
+	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
+	if (unlikely(!fpriv))
+		return -ENOMEM;
+
+	fpriv->done_list = kcalloc(rcdu->info->num_crtcs,
+				   sizeof(*fpriv->done_list),
+				   GFP_KERNEL);
+	if (unlikely(!fpriv->done_list)) {
+		kfree(fpriv);
+		return -ENOMEM;
+	}
+
+	init_waitqueue_head(&fpriv->event_wait);
+	INIT_LIST_HEAD(&fpriv->list);
+	INIT_LIST_HEAD(&fpriv->active_list);
+	for (i = 0; i < rcdu->info->num_crtcs; i++)
+		INIT_LIST_HEAD(&fpriv->done_list[i]);
+
+	file_priv->driver_priv = fpriv;
+
+	return 0;
+}
+
+void rcar_du_cmm_postclose(struct drm_device *dev, struct drm_file *file_priv)
+{
+	struct rcar_du_device *rcdu = dev->dev_private;
+	struct rcar_du_cmm_file_priv *fpriv = file_priv->driver_priv;
+	struct rcar_du_cmm_pending_event *p, *pt;
+	struct rcar_du_crtc *rcrtc;
+	struct rcar_du_cmm *du_cmm;
+	int i, crtcs_cnt, ret;
+	u32 table_data;
+
+	if (!rcar_du_has(rcdu, RCAR_DU_FEATURE_CMM))
+		return;
+
+	mutex_lock(&cmm_event_lock);
+
+	/* Unlink file priv events */
+	list_for_each_entry_safe(p, pt, &fpriv->list, fpriv_link) {
+		list_del(&p->fpriv_link);
+		list_del(&p->link);
+		switch (p->stat) {
+		case QUE_STAT_PENDING:
+			cmm_vblank_put(p);
+			cmm_gem_object_unreference(p);
+			kfree(p);
+			break;
+		case QUE_STAT_DONE:
+			kfree(p);
+			break;
+		case QUE_STAT_ACTIVE:
+			p->fpriv = NULL;
+			break;
+		}
+	}
+
+	mutex_unlock(&cmm_event_lock);
+
+	kfree(fpriv->done_list);
+	kfree(fpriv);
+	file_priv->driver_priv = NULL;
+
+	for (crtcs_cnt = 0; crtcs_cnt < rcdu->num_crtcs; crtcs_cnt++) {
+		rcrtc = &rcdu->crtcs[crtcs_cnt];
+		du_cmm = rcrtc->cmm_handle;
+		if (du_cmm->authority && du_cmm->pid == task_pid_nr(current)) {
+			du_cmm->authority = false;
+			du_cmm->pid = 0;
+			ret = wait_event_timeout(du_cmm->reg_save.wait,
+						 du_cmm_que_empty(du_cmm),
+						 msecs_to_jiffies(500));
+			if (ret == 0)
+				dev_err(rcdu->dev, "rcar-du cmm close : timeout\n");
+
+			for (i = 0; i < CMM_LUT_NUM; i++)
+				du_cmm->reg_save.lut_table[i] = (i << 16) |
+								(i << 8) |
+								(i << 0);
+
+			for (i = 0; i < CMM_CLU_NUM; i++) {
+				du_cmm->reg_save.clu_table[i] =
+							index_to_clu_data(i);
+			}
+
+			for (i = 0; i < CMM_LUT_NUM; i++) {
+#ifdef CONFIG_PM_SLEEP
+				table_data = du_cmm->reg_save.lut_table[i];
+#else
+				table_data = ((i << 16) | (i << 8) | (i << 0));
+#endif /* CONFIG_PM_SLEEP */
+				rcar_du_cmm_write(du_cmm, CMM_LUT_TBLA(i),
+						  table_data);
+				if (du_cmm->dbuf) {
+					rcar_du_cmm_write(du_cmm,
+							  CMM_LUT_TBLB(i),
+							  table_data);
+				}
+			}
+
+			for (i = 0; i < CMM_CLU_NUM; i++) {
+#ifdef CONFIG_PM_SLEEP
+				table_data = du_cmm->reg_save.clu_table[i];
+#else
+				table_data = index_to_clu_data(i);
+#endif /* CONFIG_PM_SLEEP */
+				rcar_du_cmm_write(du_cmm, CMM_CLU_DATA,
+						  table_data);
+
+				if (du_cmm->dbuf) {
+					rcar_du_cmm_write(du_cmm, CMM_CLU_DATA2,
+							  table_data);
+				}
+			}
+		}
+	}
+}
+
+int rcar_du_cmm_init(struct rcar_du_crtc *rcrtc)
+{
+	struct rcar_du_cmm *du_cmm;
+	int ret;
+	int i;
+	struct rcar_du_device *rcdu = rcrtc->group->dev;
+	char name[64];
+	struct resource *mem;
+
+	if (!rcar_du_has(rcdu, RCAR_DU_FEATURE_CMM))
+		return 0;
+
+	du_cmm = devm_kzalloc(rcdu->dev, sizeof(*du_cmm), GFP_KERNEL);
+	if (!du_cmm) {
+		ret = -ENOMEM;
+		goto error_alloc;
+	}
+
+	/* DU-CMM mapping */
+	sprintf(name, "cmm.%u", rcrtc->index);
+	mem = platform_get_resource_byname(to_platform_device(rcdu->dev),
+					   IORESOURCE_MEM, name);
+	if (!mem) {
+		dev_err(rcdu->dev, "rcar-du cmm init : failed to get memory resource\n");
+		ret = -EINVAL;
+		goto error_mapping_cmm;
+	}
+	du_cmm->cmm_base = devm_ioremap_nocache(rcdu->dev, mem->start,
+						resource_size(mem));
+	if (!du_cmm->cmm_base) {
+		dev_err(rcdu->dev, "rcar-du cmm init : failed to map iomem\n");
+		ret = -EINVAL;
+		goto error_mapping_cmm;
+	}
+	du_cmm->clock = devm_clk_get(rcdu->dev, name);
+	if (IS_ERR(du_cmm->clock)) {
+		dev_err(rcdu->dev, "failed to get clock\n");
+		ret = PTR_ERR(du_cmm->clock);
+		goto error_clock_cmm;
+	}
+
+	du_cmm->rcrtc = rcrtc;
+
+	du_cmm->reg_save.cm2_ctl0 = 0;
+	du_cmm->reg_save.hgo_offset = 0;
+	du_cmm->reg_save.hgo_size = 0;
+	du_cmm->reg_save.hgo_mode = 0;
+
+	du_cmm->dbuf = rcar_du_has(rcdu, RCAR_DU_FEATURE_CMM_LUT_DBUF);
+	if (du_cmm->dbuf) {
+		du_cmm->lut.buf_mode = LUT_DOUBLE_BUFFER_AUTO;
+		du_cmm->reg_save.cm2_ctl0 |= CMM_CTL0_DBUF;
+	} else {
+		dev_err(rcdu->dev, "single buffer is not supported.\n");
+		du_cmm->dbuf = true;
+		du_cmm->lut.buf_mode = LUT_DOUBLE_BUFFER_AUTO;
+		du_cmm->reg_save.cm2_ctl0 |= CMM_CTL0_DBUF;
+	}
+
+	du_cmm->clu_dbuf = rcar_du_has(rcdu, RCAR_DU_FEATURE_CMM_CLU_DBUF);
+	if (du_cmm->clu_dbuf) {
+		du_cmm->clu.buf_mode = CLU_DOUBLE_BUFFER_AUTO;
+		du_cmm->reg_save.cm2_ctl0 |= CMM_CTL0_CLUDB;
+	} else {
+		dev_err(rcdu->dev, "single buffer is not supported.\n");
+		du_cmm->clu_dbuf = true;
+		du_cmm->clu.buf_mode = CLU_DOUBLE_BUFFER_AUTO;
+		du_cmm->reg_save.cm2_ctl0 |= CMM_CTL0_CLUDB;
+	}
+
+#ifdef CONFIG_PM_SLEEP
+	du_cmm->reg_save.lut_table =
+		devm_kzalloc(rcdu->dev, CMM_LUT_NUM * 4, GFP_KERNEL);
+	if (!du_cmm->reg_save.lut_table) {
+		ret = -ENOMEM;
+		goto error_lut_reg_save_buf;
+	}
+	for (i = 0; i < CMM_LUT_NUM; i++)
+		du_cmm->reg_save.lut_table[i] = (i << 16) | (i << 8) | (i << 0);
+
+	du_cmm->reg_save.clu_table =
+		devm_kzalloc(rcdu->dev, CMM_CLU_NUM * 4, GFP_KERNEL);
+	if (!du_cmm->reg_save.clu_table) {
+		ret = -ENOMEM;
+		goto error_clu_reg_save_buf;
+	}
+	for (i = 0; i < CMM_CLU_NUM; i++)
+		du_cmm->reg_save.clu_table[i] = index_to_clu_data(i);
+
+	init_waitqueue_head(&du_cmm->reg_save.wait);
+#endif /* CONFIG_PM_SLEEP */
+	if (soc_device_match(rcar_du_cmm_r8a7795_es1))
+		du_cmm->soc_support = false;
+	else
+		du_cmm->soc_support = true;
+
+	du_cmm->active = false;
+	du_cmm->init = false;
+	du_cmm->direct = true;
+
+	mutex_init(&du_cmm->lock);
+	INIT_LIST_HEAD(&du_cmm->lut.list);
+	du_cmm->lut.p = NULL;
+	du_cmm->lut.one_side = false;
+	INIT_LIST_HEAD(&du_cmm->clu.list);
+	du_cmm->clu.p = NULL;
+	du_cmm->clu.one_side = false;
+	INIT_LIST_HEAD(&du_cmm->hgo.list);
+	du_cmm->hgo.reset = 0;
+
+	sprintf(name, "du-cmm%d", rcrtc->index);
+	du_cmm->workqueue = create_singlethread_workqueue(name);
+	INIT_WORK(&du_cmm->work, du_cmm_work);
+
+	rcrtc->cmm_handle = du_cmm;
+
+	dev_info(rcdu->dev, "DU%d use CMM(%s buffer)\n",
+		 rcrtc->index, du_cmm->dbuf ? "Double" : "Single");
+
+	return 0;
+
+#ifdef CONFIG_PM_SLEEP
+error_clu_reg_save_buf:
+error_lut_reg_save_buf:
+#endif /* CONFIG_PM_SLEEP */
+error_clock_cmm:
+	devm_iounmap(rcdu->dev, du_cmm->cmm_base);
+error_mapping_cmm:
+	devm_kfree(rcdu->dev, du_cmm);
+error_alloc:
+	return ret;
+}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 15dc9ca..864fb94 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -296,6 +296,19 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 	rcar_du_crtc_write(rcrtc, HDSR, mode->htotal - mode->hsync_start - 19);
 	rcar_du_crtc_write(rcrtc, HDER, mode->htotal - mode->hsync_start +
 					mode->hdisplay - 19);
+	if (rcar_du_has(rcrtc->group->dev, RCAR_DU_FEATURE_CMM)) {
+		rcar_du_crtc_write(rcrtc, HDSR, mode->htotal -
+						mode->hsync_start - 19 - 25);
+		rcar_du_crtc_write(rcrtc, HDER, mode->htotal -
+						mode->hsync_start +
+						mode->hdisplay - 19 - 25);
+	} else {
+		rcar_du_crtc_write(rcrtc, HDSR, mode->htotal -
+						mode->hsync_start - 19);
+		rcar_du_crtc_write(rcrtc, HDER, mode->htotal -
+						mode->hsync_start +
+						mode->hdisplay - 19);
+	}
 	rcar_du_crtc_write(rcrtc, HSWR, mode->hsync_end -
 					mode->hsync_start - 1);
 	rcar_du_crtc_write(rcrtc, HCR,  mode->htotal - 1);
@@ -530,6 +543,9 @@ static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 			     DSYSR_TVM_MASTER);
 
 	rcar_du_group_start_stop(rcrtc->group, true);
+
+	if (rcar_du_has(rcrtc->group->dev, RCAR_DU_FEATURE_CMM))
+		rcar_du_cmm_start_stop(rcrtc, true);
 }
 
 static void rcar_du_crtc_disable_planes(struct rcar_du_crtc *rcrtc)
@@ -565,6 +581,9 @@ static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
 {
 	struct drm_crtc *crtc = &rcrtc->crtc;
 
+	if (rcar_du_has(rcrtc->group->dev, RCAR_DU_FEATURE_CMM))
+		rcar_du_cmm_start_stop(rcrtc, false);
+
 	/*
 	 * Disable all planes and wait for the change to take effect. This is
 	 * required as the plane enable registers are updated on vblank, and no
@@ -899,6 +918,9 @@ static irqreturn_t rcar_du_crtc_irq(int irq, void *arg)
 			rcar_du_crtc_finish_page_flip(rcrtc);
 		}
 
+		if (rcar_du_has(rcrtc->group->dev, RCAR_DU_FEATURE_CMM))
+			rcar_du_cmm_kick(rcrtc);
+
 		ret = IRQ_HANDLED;
 	}
 
@@ -999,5 +1021,7 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int swindex,
 		return ret;
 	}
 
+	rcar_du_cmm_init(rcrtc);
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
index 7680cb2..74e0a22 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -67,6 +67,10 @@ struct rcar_du_crtc {
 	struct rcar_du_group *group;
 	struct rcar_du_vsp *vsp;
 	unsigned int vsp_pipe;
+	int lvds_ch;
+
+	void *cmm_handle;
+
 };
 
 #define to_rcar_crtc(c)	container_of(c, struct rcar_du_crtc, crtc)
@@ -104,4 +108,16 @@ void rcar_du_crtc_route_output(struct drm_crtc *crtc,
 			       enum rcar_du_output output);
 void rcar_du_crtc_finish_page_flip(struct rcar_du_crtc *rcrtc);
 
+/* DU-CMM functions */
+int rcar_du_cmm_init(struct rcar_du_crtc *rcrtc);
+int rcar_du_cmm_driver_open(struct drm_device *dev, struct drm_file *file_priv);
+void rcar_du_cmm_postclose(struct drm_device *dev, struct drm_file *file_priv);
+int rcar_du_cmm_start_stop(struct rcar_du_crtc *rcrtc, bool on);
+void rcar_du_cmm_kick(struct rcar_du_crtc *rcrtc);
+
+#ifdef CONFIG_PM_SLEEP
+int rcar_du_cmm_pm_suspend(struct rcar_du_crtc *rcrtc);
+int rcar_du_cmm_pm_resume(struct rcar_du_crtc *rcrtc);
+#endif /* CONFIG_PM_SLEEP */
+
 #endif /* __RCAR_DU_CRTC_H__ */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 02aee6c..838b7c9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -26,8 +26,8 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
-
 #include "rcar_du_drv.h"
+#include "rcar_du_encoder.h"
 #include "rcar_du_kms.h"
 #include "rcar_du_of.h"
 #include "rcar_du_regs.h"
@@ -128,7 +128,9 @@ static const struct rcar_du_device_info rcar_du_r8a7790_info = {
 static const struct rcar_du_device_info rcar_du_r8a7791_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_CMM,
+	.num_crtcs = 2,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -190,7 +192,10 @@ static const struct rcar_du_device_info rcar_du_r8a7795_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_CMM | RCAR_DU_FEATURE_CMM_LUT_DBUF
+		  | RCAR_DU_FEATURE_CMM_CLU_DBUF,
+	.num_crtcs = 4,
 	.channels_mask = BIT(3) | BIT(2) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -222,7 +227,10 @@ static const struct rcar_du_device_info rcar_du_r8a7796_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_CMM | RCAR_DU_FEATURE_CMM_LUT_DBUF
+		  | RCAR_DU_FEATURE_CMM_CLU_DBUF,
+	.num_crtcs = 3,
 	.channels_mask = BIT(2) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -250,7 +258,11 @@ static const struct rcar_du_device_info rcar_du_r8a77965_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_R8A77965_REGS
+		  | RCAR_DU_FEATURE_CMM | RCAR_DU_FEATURE_CMM_LUT_DBUF
+		  | RCAR_DU_FEATURE_CMM_CLU_DBUF,
+	.num_crtcs = 3,
 	.channels_mask = BIT(3) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -328,6 +340,8 @@ DEFINE_DRM_GEM_CMA_FOPS(rcar_du_fops);
 static struct drm_driver rcar_du_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME
 				| DRIVER_ATOMIC,
+	.open			= rcar_du_cmm_driver_open,
+	.postclose		= rcar_du_cmm_postclose,
 	.lastclose		= rcar_du_lastclose,
 	.gem_free_object_unlocked = drm_gem_cma_free_object,
 	.gem_vm_ops		= &drm_gem_cma_vm_ops,
@@ -358,6 +372,12 @@ static int rcar_du_pm_suspend(struct device *dev)
 {
 	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
 	struct drm_atomic_state *state;
+	int i;
+
+	if (rcar_du_has(rcdu, RCAR_DU_FEATURE_CMM)) {
+		for (i = 0; i < rcdu->num_crtcs; ++i)
+			rcar_du_cmm_pm_suspend(&rcdu->crtcs[i]);
+	}
 
 	drm_kms_helper_poll_disable(rcdu->ddev);
 	drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
@@ -377,7 +397,20 @@ static int rcar_du_pm_suspend(struct device *dev)
 static int rcar_du_pm_resume(struct device *dev)
 {
 	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
+#if IS_ENABLED(CONFIG_DRM_RCAR_DW_HDMI)
+	struct drm_encoder *encoder;
+	int i;
+
+	if (rcar_du_has(rcdu, RCAR_DU_FEATURE_CMM)) {
+		for (i = 0; (i < rcdu->num_crtcs); ++i)
+			rcar_du_cmm_pm_resume(&rcdu->crtcs[i]);
+	}
 
+	list_for_each_entry(encoder, &rcdu->ddev->mode_config.encoder_list,
+			    head) {
+		to_rcar_encoder(encoder);
+	}
+#endif
 	drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
 	drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
 	drm_kms_helper_poll_enable(rcdu->ddev);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index b3a25e8..f2afe36 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -30,8 +30,19 @@ struct rcar_du_device;
 #define RCAR_DU_FEATURE_CRTC_IRQ_CLOCK	(1 << 0)	/* Per-CRTC IRQ and clock */
 #define RCAR_DU_FEATURE_EXT_CTRL_REGS	(1 << 1)	/* Has extended control registers */
 #define RCAR_DU_FEATURE_VSP1_SOURCE	(1 << 2)	/* Has inputs from VSP1 */
-
-#define RCAR_DU_QUIRK_ALIGN_128B	(1 << 0)	/* Align pitches to 128 bytes */
+/* Use R8A77965 registers */
+#define RCAR_DU_FEATURE_R8A77965_REGS	BIT(3)
+
+/* Has DEF7R register & CMM */
+#define RCAR_DU_FEATURE_CMM		BIT(10)
+/* Has CMM LUT Double buffer */
+#define RCAR_DU_FEATURE_CMM_LUT_DBUF	BIT(11)
+/* Has CMM CLU Double buffer */
+#define RCAR_DU_FEATURE_CMM_CLU_DBUF	BIT(12)
+/* Align pitches to 128 bytes */
+#define RCAR_DU_QUIRK_ALIGN_128B	BIT(0)
+/* LVDS lanes 1 and 3 inverted */
+#define RCAR_DU_QUIRK_LVDS_LANES	BIT(1)
 
 /*
  * struct rcar_du_output_routing - Output routing specification
@@ -61,6 +72,7 @@ struct rcar_du_device_info {
 	unsigned int features;
 	unsigned int quirks;
 	unsigned int channels_mask;
+	unsigned int num_crtcs;
 	struct rcar_du_output_routing routes[RCAR_DU_OUTPUT_MAX];
 	unsigned int num_lvds;
 	unsigned int dpll_ch;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/rcar-du/rcar_du_group.c
index d539cb2..83a2836 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
@@ -130,6 +130,11 @@ static void rcar_du_group_setup(struct rcar_du_group *rgrp)
 	if (rcdu->info->gen >= 3)
 		rcar_du_group_write(rgrp, DEFR10, DEFR10_CODE | DEFR10_DEFE10);
 
+	if (rcar_du_has(rgrp->dev, RCAR_DU_FEATURE_CMM)) {
+		rcar_du_group_write(rgrp, DEF7R, DEF7R_CODE |
+				    DEF7R_CMME1 | DEF7R_CMME0);
+	}
+
 	/*
 	 * Use DS1PR and DS2PR to configure planes priorities and connects the
 	 * superposition 0 to DU0 pins. DU1 pins will be configured dynamically.
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_regs.h b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
index 9dfd220..b20e783 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_regs.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
@@ -200,6 +200,11 @@
 #define DEFR6_MLOS1		(1 << 2)
 #define DEFR6_DEFAULT		(DEFR6_CODE | DEFR6_TCNE1)
 
+#define DEF7R			0x000ec
+#define DEF7R_CODE		(0x7779 << 16)
+#define DEF7R_CMME1		BIT(6)
+#define DEF7R_CMME0		BIT(4)
+
 /* -----------------------------------------------------------------------------
  * R8A7790-only Control Registers
  */
@@ -552,4 +557,91 @@
 #define GCBCR			0x11098
 #define BCBCR			0x1109c
 
+/* -----------------------------------------------------------------------------
+ * DU Color Management Module Registers
+ */
+
+#define CMM_LUT_CTRL			0x0000
+#define CMM_LUT_CTRL_EN			BIT(0)
+
+#define CMM_CLU_CTRL			0x0100
+#define CMM_CLU_CTRL_EN			BIT(0)
+#define CMM_CLU_CTRL_MVS		BIT(24)
+#define CMM_CLU_CTRL_AAI		BIT(28)
+
+#define CMM_CTL0			0x0180
+#define CM2_CTL0			CMM_CTL0
+#define CMM_CTL0_CLUDB			BIT(24)
+#define CMM_CTL0_HISTS			BIT(20)
+#define CMM_CTL0_TM1_MASK		(3 << 16)
+#define CMM_CTL0_TM1_BT601_YC240	(0 << 16)
+#define CMM_CTL0_TM1_BT601_YC255	BIT(16)
+#define CMM_CTL0_TM1_BT709_RG255	(2 << 16)
+#define CMM_CTL0_TM1_BT709_RG235	(3 << 16)
+#define CMM_CTL0_TM0_MASK		(3 << 12)
+#define CMM_CTL0_TM0_BT601_YC240	(0 << 12)
+#define CMM_CTL0_TM0_BT601_YC255	BIT(12)
+#define CMM_CTL0_TM0_BT709_RG255	(2 << 12)
+#define CMM_CTL0_TM0_BT709_RG235	(3 << 12)
+#define CMM_CTL0_TM_BT601_YC240		(CMM_CTL0_TM1_BT601_YC240 |\
+					 CMM_CTL0_TM0_BT601_YC240)
+#define CMM_CTL0_TM_BT601_YC255		(CMM_CTL0_TM1_BT601_YC255 |\
+					 CMM_CTL0_TM0_BT601_YC255)
+#define CMM_CTL0_TM_BT709_RG255		(CMM_CTL0_TM1_BT709_RG255 |\
+					 CMM_CTL0_TM0_BT709_RG255)
+#define CMM_CTL0_TM_BT709_RG235		(CMM_CTL0_TM1_BT709_RG235 |\
+					 CMM_CTL0_TM0_BT709_RG235)
+#define CMM_CTL0_YC			BIT(8)
+#define CMM_CTL0_VPOL			BIT(4)
+#define CMM_CTL0_DBUF			BIT(0)
+
+#define CMM_CTL1			0x0184
+#define CM2_CTL1			CMM_CTL1
+#define CMM_CTL1_BFS			BIT(0)
+
+#define CMM_CTL2			0x0188
+#define CMM_HGO_OFFSET			0x0200
+#define CMM_HGO_SIZE			0x0204
+#define CMM_HGO_MODE			0x0208
+#define CMM_HGO_MODE_MASK		(0xFF)
+#define CMM_HGO_MODE_MAXRGB		BIT(7)
+#define CMM_HGO_MODE_OFSB_R		BIT(6)
+#define CMM_HGO_MODE_OFSB_G		BIT(5)
+#define CMM_HGO_MODE_OFSB_B		BIT(4)
+#define CMM_HGO_MODE_HRATIO_NO_SKIPP		(0 << 2)
+#define CMM_HGO_MODE_HRATIO_HALF_SKIPP		BIT(2)
+#define CMM_HGO_MODE_HRATIO_QUARTER_SKIPP	(2 << 2)
+#define CMM_HGO_MODE_VRATIO_NO_SKIPP		(0 << 0)
+#define CMM_HGO_MODE_VRATIO_HALF_SKIPP		BIT(0)
+#define CMM_HGO_MODE_VRATIO_QUARTER_SKIPP	(2 << 0)
+#define CMM_HGO_LB_TH			0x020C
+#define CMM_HGO_LB0_H			0x0210
+#define CMM_HGO_LB0_V			0x0214
+#define CMM_HGO_LB1_H			0x0218
+#define CMM_HGO_LB1_V			0x021C
+#define CMM_HGO_LB2_H			0x0220
+#define CMM_HGO_LB2_V			0x0224
+#define CMM_HGO_LB3_H			0x0228
+#define CMM_HGO_LB3_V			0x022C
+#define CMM_HGO_R_HISTO(n)		(0x0230 + ((n) * 4))
+#define CMM_HGO_R_MAXMIN		0x0330
+#define CMM_HGO_R_SUM			0x0334
+#define CMM_HGO_R_LB_DET		0x0338
+#define CMM_HGO_G_HISTO(n)		(0x0340 + ((n) * 4))
+#define CMM_HGO_G_MAXMIN		0x0440
+#define CMM_HGO_G_SUM			0x0444
+#define CMM_HGO_G_LB_DET		0x0448
+#define CMM_HGO_B_HISTO(n)		(0x0450 + ((n) * 4))
+#define CMM_HGO_B_MAXMIN		0x0550
+#define CMM_HGO_B_SUM			0x0554
+#define CMM_HGO_B_LB_DET		0x0558
+#define CMM_HGO_REGRST			0x05FC
+#define CMM_HGO_REGRST_RCLEA		BIT(0)
+#define CMM_LUT_TBLA(n)			(0x0600 + ((n) * 4))
+#define CMM_CLU_ADDR			0x0A00
+#define CMM_CLU_DATA			0x0A04
+#define CMM_LUT_TBLB(n)			(0x0B00 + ((n) * 4))
+#define CMM_CLU_ADDR2			0x0F00
+#define CMM_CLU_DATA2			0x0F04
+
 #endif /* __RCAR_DU_REGS_H__ */
diff --git a/include/drm/drm_ioctl.h b/include/drm/drm_ioctl.h
index fafb6f5..add4280 100644
--- a/include/drm/drm_ioctl.h
+++ b/include/drm/drm_ioctl.h
@@ -109,6 +109,13 @@ enum drm_ioctl_flags {
 	 */
 	DRM_ROOT_ONLY		= BIT(2),
 	/**
+	 * @DRM_CONTROL_ALLOW:
+	 *
+	 * Deprecated, do not use. Control nodes are in the process of getting
+	 * removed.
+	 */
+	DRM_CONTROL_ALLOW	= BIT(3),
+	/**
 	 * @DRM_UNLOCKED:
 	 *
 	 * Whether &drm_ioctl_desc.func should be called with the DRM BKL held
-- 
2.7.4

