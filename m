Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115D0C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D069520645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfDWHle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:41:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbfDWHkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 62690D91CEAA2DD53310;
        Tue, 23 Apr 2019 15:40:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:10 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        <linux-media@vger.kernel.org>
Subject: [PATCH next 15/25] media: platform: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:50:10 +0800
Message-ID: <20190423075020.173734-16-wangkefeng.wang@huawei.com>
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

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-media@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/media/platform/cros-ec-cec/cros-ec-cec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
index 7bc4d8a9af28..2e218c7a3a1f 100644
--- a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
+++ b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
@@ -174,8 +174,7 @@ static const struct cec_adap_ops cros_ec_cec_ops = {
 #ifdef CONFIG_PM_SLEEP
 static int cros_ec_cec_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct cros_ec_cec *cros_ec_cec = dev_get_drvdata(&pdev->dev);
+	struct cros_ec_cec *cros_ec_cec = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev))
 		enable_irq_wake(cros_ec_cec->cros_ec->irq);
@@ -185,8 +184,7 @@ static int cros_ec_cec_suspend(struct device *dev)
 
 static int cros_ec_cec_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct cros_ec_cec *cros_ec_cec = dev_get_drvdata(&pdev->dev);
+	struct cros_ec_cec *cros_ec_cec = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(cros_ec_cec->cros_ec->irq);
-- 
2.20.1

