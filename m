Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ECFECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2A321848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbfJIO7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:59:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731532AbfJIO7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:59:39 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4F3BE8EBFF3D4CEEE06C;
        Wed,  9 Oct 2019 22:59:16 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Wed, 9 Oct 2019 22:59:05 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mchehab@kernel.org>, <sean@mess.org>, <hansverk@cisco.com>,
        <daniel.vetter@ffwll.ch>
CC:     <linux-media@vger.kernel.org>, <zhongjiang@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] media: uvcvideo: Use DIV_ROUND_CLOSEST directly to make it readable
Date:   Wed, 9 Oct 2019 22:55:24 +0800
Message-ID: <1570632925-14926-4-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1570632925-14926-1-git-send-email-zhongjiang@huawei.com>
References: <1570632925-14926-1-git-send-email-zhongjiang@huawei.com>
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

