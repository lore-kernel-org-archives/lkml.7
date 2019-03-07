Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A448C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F405520840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfCGPSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:18:21 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:37207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCGPSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:18:21 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MHVWT-1hEmwK0EGP-00DXlI; Thu, 07 Mar 2019 16:18:09 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dmaengine: edma: make edma_filter_fn private
Date:   Thu,  7 Mar 2019 16:16:10 +0100
Message-Id: <20190307151646.1016966-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190307151646.1016966-1-arnd@arndb.de>
References: <20190307151646.1016966-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hu6jPXZ5aq6eAOti9DqkxbzZf58m3D7/bSUI/OESUJyxDYdXcC1
 1PyZfLdpIZ++HXYUuK2hzEpggwEfovdn1roh5unXNA86Y8FYVaZ4+X6uxB8fGNHdDAgMzvx
 6eQeVxIFItZfL/pVK5ablekSSj6MYg/5vkCiB/1q5J25EeL3LmrWsP6HVVkgi1maIi1XIAI
 Ipl0iz7Cd6c8G073UwdRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oviKULBfuMc=:IZPP5yT4s6FPvDomebYYU7
 tJMiL92a4EYtCer+0La2UBUHUA/JDDFFluhUG5SFFWiCf0eI2shYxDCtUpPJ8hmMHQiUg6epP
 4Geol+KhIof0wa9qhk7QINUU+F2hqIrj/7HME46tbTKdtyKK6/V+531Yhkgr9KMYYDyy8Mdmu
 9LtWuGNrNIG3HF6tNRbm7ugwy+CdegbCyEstaqnIRD4CAXcXnWPIsOEZaPY0+fVKqVEBRf65P
 QxmBo6AlRDIRfbt+2uHw6yYLq6dPeyGHVdGnlr23pA2D6ByJ9RgI+FYfAAtHRXz/jwrUotGrD
 qVDxqKxjG35K44hxxLJ5FH2ozAIY4jxSbh2JjrpWE5Jf8qvTyewNMr3WH0swaYT5UGsuOD54E
 /9aWFg0wnDDuJifOQUTlx9A1P9SZKslreiXuKfS+nu3Dq97dI0mst8NO0E7nVxJUTmLqBW60q
 BVma00uSs4aJce8rxIM0zhu4EwT3xTjM0clbjiI3u1TBsA30wxoHmaX8ajI5cnifQmNY07soN
 C8KWhDfIiSt1GI+by9pYZX63BTU+9MNU9uWCLlPpRRVlZW0CRy9qypnnL2N4FwpAZUj2KIFmW
 wyWLuol+A+QM9mZdhAjGUaxQE4jI3Brq//pxNCTnk62tH3lcc8Nts3jfhFH6NTVLSyrdtXijt
 QIQcFDRIC/Owb7FGaXGesfyNmGIA8jAByg5Mh69YzY8P2OpUvFSHd5j/iz2Ao7VK5cP+MVbkV
 RmMIKqWPHl0rpA7y3EHvgZadifoOL4OzjtZg5w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the audio driver no longer referring to this function, it
can be made private to the dmaengine driver itself, and the
header file removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/ti/edma.c |  5 +++--
 include/linux/edma.h  | 29 -----------------------------
 2 files changed, 3 insertions(+), 31 deletions(-)
 delete mode 100644 include/linux/edma.h

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index ceabdea40ae0..f2549ee3fb49 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -15,7 +15,6 @@
 
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-#include <linux/edma.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -2185,6 +2184,8 @@ static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
 }
 #endif
 
+static bool edma_filter_fn(struct dma_chan *chan, void *param);
+
 static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_soc_info	*info = pdev->dev.platform_data;
@@ -2524,7 +2525,7 @@ static struct platform_driver edma_tptc_driver = {
 	},
 };
 
-bool edma_filter_fn(struct dma_chan *chan, void *param)
+static bool edma_filter_fn(struct dma_chan *chan, void *param)
 {
 	bool match = false;
 
diff --git a/include/linux/edma.h b/include/linux/edma.h
deleted file mode 100644
index a1307e7827e8..000000000000
--- a/include/linux/edma.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * TI EDMA DMA engine driver
- *
- * Copyright 2012 Texas Instruments
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __LINUX_EDMA_H
-#define __LINUX_EDMA_H
-
-struct dma_chan;
-
-#if defined(CONFIG_TI_EDMA) || defined(CONFIG_TI_EDMA_MODULE)
-bool edma_filter_fn(struct dma_chan *, void *);
-#else
-static inline bool edma_filter_fn(struct dma_chan *chan, void *param)
-{
-	return false;
-}
-#endif
-
-#endif
-- 
2.20.0

