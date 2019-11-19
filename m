Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC02C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDAC222A5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L8sUCCjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfKSORV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:17:21 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50538 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfKSORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:17:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAJEHFYj017634;
        Tue, 19 Nov 2019 08:17:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574173035;
        bh=AQ0B5jw9HQqxEfttQOLTZY4PnRmM6mThulC0kGIUZ/o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=L8sUCCjpHI2zs3QNnypYLVzmskKaWo9zFsm4X7jJP/y1eklvM7p5mRstl7rY57/TU
         +n0vsqJohy/RsU4zS2au5UxzjmlRjyAAlC7Fc7pOFxKYiiF1LHb3/hI/S1QGpF0gVC
         UFPbrSWpIw9038mz+KX9SYhmOMrzHNx4sgGFee8A=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAJEHF2e100514
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Nov 2019 08:17:15 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 19
 Nov 2019 08:17:12 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 19 Nov 2019 08:17:11 -0600
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAJEGvYx027070;
        Tue, 19 Nov 2019 08:17:10 -0600
From:   Tero Kristo <t-kristo@ti.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 06/15] remoteproc/omap: Initialize and assign reserved memory node
Date:   Tue, 19 Nov 2019 16:16:36 +0200
Message-ID: <20191119141645.19777-7-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119141645.19777-1-t-kristo@ti.com>
References: <20191119141645.19777-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The reserved memory nodes are not assigned to platform devices by
default in the driver core to avoid the lookup for every platform
device and incur a penalty as the real users are expected to be
only a few devices.

OMAP remoteproc devices fall into the above category and the OMAP
remoteproc driver _requires_ specific CMA pools to be assigned
for each device at the moment to align on the location of the
vrings and vring buffers in the RTOS-side firmware images. So,
use the of_reserved_mem_device_init/release() API appropriately
to assign the corresponding reserved memory region to the OMAP
remoteproc device. Note that only one region per device is
allowed by the framework.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/omap_remoteproc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 28f14e24b389..3ad74c4b4071 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/remoteproc.h>
@@ -479,14 +480,22 @@ static int omap_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
+	ret = of_reserved_mem_device_init(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "device does not have specific CMA pool\n");
+		goto free_rproc;
+	}
+
 	platform_set_drvdata(pdev, rproc);
 
 	ret = rproc_add(rproc);
 	if (ret)
-		goto free_rproc;
+		goto release_mem;
 
 	return 0;
 
+release_mem:
+	of_reserved_mem_device_release(&pdev->dev);
 free_rproc:
 	rproc_free(rproc);
 	return ret;
@@ -498,6 +507,7 @@ static int omap_rproc_remove(struct platform_device *pdev)
 
 	rproc_del(rproc);
 	rproc_free(rproc);
+	of_reserved_mem_device_release(&pdev->dev);
 
 	return 0;
 }
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
