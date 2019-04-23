Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D287C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EB921738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfDWHk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:40:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbfDWHkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:25 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 581006EB7F09602779C8;
        Tue, 23 Apr 2019 15:40:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:14 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        "Steve Longerbeam" <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>
Subject: [PATCH next 22/25] media: staging/imx7: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:50:17 +0800
Message-ID: <20190423075020.173734-23-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_get_drvdata directly.

Cc: Rui Miguel Silva <rmfrfs@gmail.com>
Cc: Steve Longerbeam <slongerbeam@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-media@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/staging/media/imx/imx7-mipi-csis.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index 6cae2960eea1..19455f425416 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -1027,8 +1027,7 @@ static int mipi_csis_probe(struct platform_device *pdev)
 
 static int mipi_csis_pm_suspend(struct device *dev, bool runtime)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct v4l2_subdev *mipi_sd = platform_get_drvdata(pdev);
+	struct v4l2_subdev *mipi_sd = dev_get_drvdata(dev);
 	struct csi_state *state = mipi_sd_to_csis_state(mipi_sd);
 	int ret = 0;
 
@@ -1052,8 +1051,7 @@ static int mipi_csis_pm_suspend(struct device *dev, bool runtime)
 
 static int mipi_csis_pm_resume(struct device *dev, bool runtime)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct v4l2_subdev *mipi_sd = platform_get_drvdata(pdev);
+	struct v4l2_subdev *mipi_sd = dev_get_drvdata(dev);
 	struct csi_state *state = mipi_sd_to_csis_state(mipi_sd);
 	int ret = 0;
 
-- 
2.20.1

