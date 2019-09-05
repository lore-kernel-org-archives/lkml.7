Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB66C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873D620870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbfIEQSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:18:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387697AbfIEQSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:18:09 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BB640AF43E2DBB16F63A;
        Fri,  6 Sep 2019 00:18:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Sep 2019 00:18:39 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mchehab@kernel.org>
CC:     <hansverk@cisco.com>, <daniel.vetter@ffwll.ch>,
        <zhongjiang@huawei.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] media: uvcvideo: Use DIV_ROUND_CLOSEST directly to make it readable
Date:   Fri, 6 Sep 2019 00:14:51 +0800
Message-ID: <1567700092-27769-4-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1567700092-27769-1-git-send-email-zhongjiang@huawei.com>
References: <1567700092-27769-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel.h macro DIV_ROUND_CLOSEST performs the computation (x + d/2)/d
but is perhaps more readable.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index e399b9f..9f3697161 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1604,8 +1604,8 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		if (step == 0)
 			step = 1;
 
-		xctrl->value = min + ((u32)(xctrl->value - min) + step / 2)
-			     / step * step;
+		xctrl->value = min + DIV_ROUND_CLOSEST((u32)(xctrl->value - min),
+							step) * step;
 		if (mapping->data_type == UVC_CTRL_DATA_TYPE_SIGNED)
 			xctrl->value = clamp(xctrl->value, min, max);
 		else
-- 
1.7.12.4

