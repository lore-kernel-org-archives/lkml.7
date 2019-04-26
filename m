Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138C2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C081D20693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfDZQkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:40:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbfDZQkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:40:31 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EE351BFE4C79D3028E09;
        Sat, 27 Apr 2019 00:40:27 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Sat, 27 Apr 2019
 00:40:17 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] iio: dac: ad5758: remove set but not used variable 'dc_dc_mode'
Date:   Sat, 27 Apr 2019 00:40:06 +0800
Message-ID: <20190426164006.26928-1-yuehaibing@huawei.com>
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

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/iio/dac/ad5758.c: In function ad5758_write_powerdown:
drivers/iio/dac/ad5758.c:585:15: warning: variable dc_dc_mode set but not used [-Wunused-but-set-variable]

It is not used any more since
commit edde945257e2 ("iio: dac: ad5758: Modifications for new revision")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iio/dac/ad5758.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index a513c70..570f69e 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -582,7 +582,7 @@ static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5758_state *st = iio_priv(indio_dev);
 	bool pwr_down;
-	unsigned int dc_dc_mode, dac_config_mode, val;
+	unsigned int dac_config_mode, val;
 	unsigned long int dac_config_msk;
 	int ret;
 
@@ -591,13 +591,10 @@ static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
 		return ret;
 
 	mutex_lock(&st->lock);
-	if (pwr_down) {
-		dc_dc_mode = AD5758_DCDC_MODE_POWER_OFF;
+	if (pwr_down)
 		val = 0;
-	} else {
-		dc_dc_mode = st->dc_dc_mode;
+	else
 		val = 1;
-	}
 
 	dac_config_mode = AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
 			  AD5758_DAC_CONFIG_INT_EN_MODE(val);
-- 
2.7.4


