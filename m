Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74E2C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7737320863
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfEYOLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 10:11:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbfEYOLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 10:11:54 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E345C50BA5424489044A;
        Sat, 25 May 2019 22:11:45 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 22:11:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dmitry.torokhov@gmail.com>, <cheiny@synaptics.com>,
        <nick@shmanahar.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] Input: synaptics-rmi4 - Remove set but not used variable 'sensor_flags'
Date:   Sat, 25 May 2019 22:11:19 +0800
Message-ID: <20190525141119.11852-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/input/rmi4/rmi_f12.c: In function rmi_f12_read_sensor_tuning:
drivers/input/rmi4/rmi_f12.c:76:6: warning: variable sensor_flags set but not used [-Wunused-but-set-variable]

It's not used since introduction in
commit b43d2c1e9353 ("Input: synaptics-rmi4 - add support for F12")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/input/rmi4/rmi_f12.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 5c7f48915779..72b5498e1a9f 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -73,7 +73,6 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 	int pitch_y = 0;
 	int rx_receivers = 0;
 	int tx_receivers = 0;
-	int sensor_flags = 0;
 
 	item = rmi_get_register_desc_item(&f12->control_reg_desc, 8);
 	if (!item) {
@@ -129,10 +128,8 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 		offset += 2;
 	}
 
-	if (rmi_register_desc_has_subpacket(item, 4)) {
-		sensor_flags = buf[offset];
+	if (rmi_register_desc_has_subpacket(item, 4))
 		offset += 1;
-	}
 
 	sensor->x_mm = (pitch_x * rx_receivers) >> 12;
 	sensor->y_mm = (pitch_y * tx_receivers) >> 12;
-- 
2.17.1


