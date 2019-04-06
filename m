Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0541C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 15:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4B82087F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 15:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDFPPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 11:15:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbfDFPPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 11:15:39 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 75009377418EABF1BDD7;
        Sat,  6 Apr 2019 23:15:34 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Sat, 6 Apr 2019
 23:15:28 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <broonie@kernel.org>, <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <eric@anholt.net>, <stefan.wahren@i2se.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] spi: bcm2835aux: Fix build error without CONFIG_DEBUG_FS
Date:   Sat, 6 Apr 2019 23:14:57 +0800
Message-ID: <20190406151457.32104-1-yuehaibing@huawei.com>
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

When building CONFIG_DEBUG_FS is not set
gcc warn this:

drivers/spi/spi-bcm2835aux.c: In function bcm2835aux_spi_probe:
drivers/spi/spi-bcm2835aux.c:591:2: error: too many arguments to function bcm2835aux_debugfs_create
  bcm2835aux_debugfs_create(bs, dev_name(&pdev->dev));
  ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/spi/spi-bcm2835aux.c:145:13: note: declared here
 static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs)

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 8048d151eb4d ("spi: bcm2835aux: add driver stats to debugfs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/spi/spi-bcm2835aux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index fd8252d..bbf87ad 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -142,7 +142,8 @@ static void bcm2835aux_debugfs_remove(struct bcm2835aux_spi *bs)
 	bs->debugfs_dir = NULL;
 }
 #else
-static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs)
+static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs,
+				      const char *dname)
 {
 }
 
-- 
2.7.4


