Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639FEC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3088C20643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611874;
	bh=s+tljU0Cp3vfIIyP182jEbkOG5raNkpGie7i3yySZiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pb9LiA9Ennpf///9KgRvniVEIpEgd+AA9q/QV2mPIPLp1LNheyfbT8q7b7t7Sq0TB
	 jduAJ8H9iKzExhr7yDfx1sBHhCRNnoJqE8XOJP4ehewQWqSk3XPh8mhdgi7RRq0ZjQ
	 KRxeIpzoqAYz8KGnV65QkmZScQmtqGK1MYV6G0AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391364AbfDRSFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:05:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390694AbfDRSFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:05:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85680206B6;
        Thu, 18 Apr 2019 18:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610741;
        bh=s+tljU0Cp3vfIIyP182jEbkOG5raNkpGie7i3yySZiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yhNRBmM83RxPeF2YhMNlb19r3dFpekp5DUcfDG1FNUx9TArQ2HL0rjD+UkmPh3YGA
         GK44xz89uqxIYRDQuHLsocbqwjKoGFWt9Zr4/hr3jbv3zQPfT2dUSH45Qja/tlgoCT
         jPZyDcrv/efWmeGxdZZND1cjcV7cZceg848M6XyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 65/92] drm/nouveau/volt/gf117: fix speedo readout register
Date:   Thu, 18 Apr 2019 19:57:23 +0200
Message-Id: <20190418160435.916319479@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fc782242749fa4235592854fafe1a1297583c1fb ]

GF117 appears to use the same register as GK104 (but still with the
general Fermi readout mechanism).

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=108980
Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/nouveau/include/nvkm/subdev/volt.h    |  1 +
 .../gpu/drm/nouveau/nvkm/engine/device/base.c |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/volt/Kbuild   |  1 +
 .../gpu/drm/nouveau/nvkm/subdev/volt/gf117.c  | 60 +++++++++++++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gf117.c

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/volt.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/volt.h
index 8a0f85f5fc1a..6a765682fbfa 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/volt.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/volt.h
@@ -38,6 +38,7 @@ int nvkm_volt_set_id(struct nvkm_volt *, u8 id, u8 min_id, u8 temp,
 
 int nv40_volt_new(struct nvkm_device *, int, struct nvkm_volt **);
 int gf100_volt_new(struct nvkm_device *, int, struct nvkm_volt **);
+int gf117_volt_new(struct nvkm_device *, int, struct nvkm_volt **);
 int gk104_volt_new(struct nvkm_device *, int, struct nvkm_volt **);
 int gk20a_volt_new(struct nvkm_device *, int, struct nvkm_volt **);
 int gm20b_volt_new(struct nvkm_device *, int, struct nvkm_volt **);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
index e096a5d9c292..f8dd78e21456 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
@@ -1612,7 +1612,7 @@ nvd7_chipset = {
 	.pci = gf106_pci_new,
 	.therm = gf119_therm_new,
 	.timer = nv41_timer_new,
-	.volt = gf100_volt_new,
+	.volt = gf117_volt_new,
 	.ce[0] = gf100_ce_new,
 	.disp = gf119_disp_new,
 	.dma = gf119_dma_new,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/Kbuild b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/Kbuild
index bcd179ba11d0..146adcdd316a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/Kbuild
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/Kbuild
@@ -2,6 +2,7 @@ nvkm-y += nvkm/subdev/volt/base.o
 nvkm-y += nvkm/subdev/volt/gpio.o
 nvkm-y += nvkm/subdev/volt/nv40.o
 nvkm-y += nvkm/subdev/volt/gf100.o
+nvkm-y += nvkm/subdev/volt/gf117.o
 nvkm-y += nvkm/subdev/volt/gk104.o
 nvkm-y += nvkm/subdev/volt/gk20a.o
 nvkm-y += nvkm/subdev/volt/gm20b.o
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gf117.c b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gf117.c
new file mode 100644
index 000000000000..547a58f0aeac
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gf117.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright 2019 Ilia Mirkin
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Ilia Mirkin
+ */
+#include "priv.h"
+
+#include <subdev/fuse.h>
+
+static int
+gf117_volt_speedo_read(struct nvkm_volt *volt)
+{
+	struct nvkm_device *device = volt->subdev.device;
+	struct nvkm_fuse *fuse = device->fuse;
+
+	if (!fuse)
+		return -EINVAL;
+
+	return nvkm_fuse_read(fuse, 0x3a8);
+}
+
+static const struct nvkm_volt_func
+gf117_volt = {
+	.oneinit = gf100_volt_oneinit,
+	.vid_get = nvkm_voltgpio_get,
+	.vid_set = nvkm_voltgpio_set,
+	.speedo_read = gf117_volt_speedo_read,
+};
+
+int
+gf117_volt_new(struct nvkm_device *device, int index, struct nvkm_volt **pvolt)
+{
+	struct nvkm_volt *volt;
+	int ret;
+
+	ret = nvkm_volt_new_(&gf117_volt, device, index, &volt);
+	*pvolt = volt;
+	if (ret)
+		return ret;
+
+	return nvkm_voltgpio_init(volt);
+}
-- 
2.19.1



