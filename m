Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D76C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0CF20896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391248AbfFKNm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:42:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50412 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387770AbfFKNm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:42:58 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A6B5B115DE343A56FF18;
        Tue, 11 Jun 2019 21:42:50 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Jun 2019
 21:42:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <bnvandana@gmail.com>,
        <Matt.Sickler@daktronics.com>, <valerio.click@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] Staging: kpc2000: kpc_dma: Make some symbols static
Date:   Tue, 11 Jun 2019 21:42:28 +0800
Message-ID: <20190611134228.24460-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c:46:6: warning: symbol 'kpc_dma_del_device' was not declared. Should it be static?
drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c:84:1: warning: symbol 'dev_attr_engine_regs' was not declared. Should it be static?
drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c:91:14: warning: symbol 'kpc_dma_class' was not declared. Should it be static?
drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c:199:24: warning: symbol 'kpc_dma_plat_driver_i' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
index 9acf1ea..ca76073 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
@@ -43,7 +43,7 @@ static void kpc_dma_add_device(struct kpc_dma_device *ldev)
 	mutex_unlock(&kpc_dma_mtx);
 }
 
-void kpc_dma_del_device(struct kpc_dma_device *ldev)
+static void kpc_dma_del_device(struct kpc_dma_device *ldev)
 {
 	mutex_lock(&kpc_dma_mtx);
 	list_del(&ldev->list);
@@ -81,14 +81,14 @@ static ssize_t  show_engine_regs(struct device *dev, struct device_attribute *at
 		ldev->desc_completed
 	);
 }
-DEVICE_ATTR(engine_regs, 0444, show_engine_regs, NULL);
+static DEVICE_ATTR(engine_regs, 0444, show_engine_regs, NULL);
 
 static const struct attribute *ndd_attr_list[] = {
 	&dev_attr_engine_regs.attr,
 	NULL,
 };
 
-struct class *kpc_dma_class;
+static struct class *kpc_dma_class;
 
 /**********  Platform Driver Functions  **********/
 static
@@ -196,7 +196,7 @@ int  kpc_dma_remove(struct platform_device *pldev)
 }
 
 /**********  Driver Functions  **********/
-struct platform_driver kpc_dma_plat_driver_i = {
+static struct platform_driver kpc_dma_plat_driver_i = {
 	.probe        = kpc_dma_probe,
 	.remove       = kpc_dma_remove,
 	.driver = {
-- 
2.7.4


