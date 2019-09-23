Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE86C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF6A2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403995AbfIWCH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 22:07:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2765 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389942AbfIWCH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 22:07:57 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A4BF83F0F452F01E0864;
        Mon, 23 Sep 2019 10:07:55 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Mon, 23 Sep 2019 10:07:47 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>
CC:     <lars@metafoo.de>, <pmeerw@pmeerw.net>, <zhongjiang@huawei.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: Fix an undefied reference error in noa1305_probe
Date:   Mon, 23 Sep 2019 10:04:32 +0800
Message-ID: <1569204272-20365-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hit the following error when compile the kernel.

drivers/iio/light/noa1305.o: In function `noa1305_probe':
noa1305.c:(.text+0x65): undefined reference to `__devm_regmap_init_i2c'
make: *** [vmlinux] Error 1

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 08d7e1e..4a1a883 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -314,6 +314,7 @@ config MAX44009
 config NOA1305
 	tristate "ON Semiconductor NOA1305 ambient light sensor"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	 Say Y here if you want to build support for the ON Semiconductor
 	 NOA1305 ambient light sensor.
-- 
1.7.12.4

