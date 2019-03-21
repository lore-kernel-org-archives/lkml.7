Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D2421874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfCUPVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:21:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727881AbfCUPVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:21:07 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 97D305438B409ADF1CC6;
        Thu, 21 Mar 2019 23:21:04 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Mar 2019
 23:20:54 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] uio: uio_fsl_elbc_gpcm: Make dev_attr_reg_br and dev_attr_reg_or static
Date:   Thu, 21 Mar 2019 23:20:50 +0800
Message-ID: <20190321152050.12404-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

drivers/uio/uio_fsl_elbc_gpcm.c:71:1: warning:
 symbol 'dev_attr_reg_br' was not declared. Should it be static?
drivers/uio/uio_fsl_elbc_gpcm.c:72:1: warning:
 symbol 'dev_attr_reg_or' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/uio/uio_fsl_elbc_gpcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio_fsl_elbc_gpcm.c b/drivers/uio/uio_fsl_elbc_gpcm.c
index 0ee3cd3..c112727 100644
--- a/drivers/uio/uio_fsl_elbc_gpcm.c
+++ b/drivers/uio/uio_fsl_elbc_gpcm.c
@@ -68,8 +68,8 @@ static ssize_t reg_show(struct device *dev, struct device_attribute *attr,
 static ssize_t reg_store(struct device *dev, struct device_attribute *attr,
 			 const char *buf, size_t count);
 
-DEVICE_ATTR(reg_br, S_IRUGO|S_IWUSR|S_IWGRP, reg_show, reg_store);
-DEVICE_ATTR(reg_or, S_IRUGO|S_IWUSR|S_IWGRP, reg_show, reg_store);
+static DEVICE_ATTR(reg_br, 0664, reg_show, reg_store);
+static DEVICE_ATTR(reg_or, 0664, reg_show, reg_store);
 
 static ssize_t reg_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
-- 
2.7.0


