Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C23C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27BD216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfICMGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:06:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5731 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726936AbfICMGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:06:47 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 419D8DE259044BDD655F;
        Tue,  3 Sep 2019 20:06:45 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 20:06:35 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <pawell@cadence.com>,
        <felipe.balbi@linux.intel.com>, <yuehaibing@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] usb: cdns3: Fix Wunused-but-set-variable warning
Date:   Tue, 3 Sep 2019 20:06:15 +0800
Message-ID: <20190903120615.19504-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/usb/cdns3/ep0.c: In function cdns3_ep0_feature_handle_device:
drivers/usb/cdns3/ep0.c:290:6: warning: variable wIndex set but not used [-Wunused-but-set-variable]
drivers/usb/cdns3/ep0.c:289:6: warning: variable wValue set but not used [-Wunused-but-set-variable]

wIndex is never used, so remove it.
wValue should be use in the switch statement.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/cdns3/ep0.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index e94f55d..44f652e8 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -287,15 +287,13 @@ static int cdns3_ep0_feature_handle_device(struct cdns3_device *priv_dev,
 	enum usb_device_speed speed;
 	int ret = 0;
 	u32 wValue;
-	u32 wIndex;
 	u16 tmode;
 
 	wValue = le16_to_cpu(ctrl->wValue);
-	wIndex = le16_to_cpu(ctrl->wIndex);
 	state = priv_dev->gadget.state;
 	speed = priv_dev->gadget.speed;
 
-	switch (ctrl->wValue) {
+	switch (wValue) {
 	case USB_DEVICE_REMOTE_WAKEUP:
 		priv_dev->wake_up_flag = !!set;
 		break;
-- 
2.7.4


