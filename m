Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D916C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6C221835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgACMKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:10:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727350AbgACMKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:10:13 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 20C828252EFCD972B742;
        Fri,  3 Jan 2020 20:10:12 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 3 Jan 2020
 20:10:03 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] mfd: tqmx86: remove set but not used variable 'i2c_ien'
Date:   Fri, 3 Jan 2020 20:09:25 +0800
Message-ID: <20200103120925.460-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/mfd/tqmx86.c: In function ‘tqmx86_probe’:
drivers/mfd/tqmx86.c:161:29: warning: variable ‘i2c_ien’
set but not used I[-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/mfd/tqmx86.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 22d2f02d855c..b9f48e588d95 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -158,7 +158,7 @@ static int tqmx86_board_id_to_clk_rate(u8 board_id)
 
 static int tqmx86_probe(struct platform_device *pdev)
 {
-	u8 board_id, rev, i2c_det, i2c_ien, io_ext_int_val;
+	u8 board_id, rev, i2c_det, io_ext_int_val;
 	struct device *dev = &pdev->dev;
 	u8 gpio_irq_cfg, readback;
 	const char *board_name;
@@ -196,7 +196,6 @@ static int tqmx86_probe(struct platform_device *pdev)
 		 board_name, board_id, rev >> 4, rev & 0xf);
 
 	i2c_det = ioread8(io_base + TQMX86_REG_I2C_DETECT);
-	i2c_ien = ioread8(io_base + TQMX86_REG_I2C_INT_EN);
 
 	if (gpio_irq_cfg) {
 		io_ext_int_val =
-- 
2.17.2

