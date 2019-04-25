Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D045C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74B7214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfDYHkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:40:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbfDYHkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:40:09 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 189D7260C64FDC5FFC98;
        Thu, 25 Apr 2019 15:40:07 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 25 Apr 2019
 15:39:58 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <hdegoede@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] HID: logitech-dj: Fix build error without CONFIG_USB_HID
Date:   Thu, 25 Apr 2019 15:39:42 +0800
Message-ID: <20190425073942.36980-1-yuehaibing@huawei.com>
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

During randconfig builds, I occasionally run into an invalid configuration

drivers/hid/hid-logitech-dj.o: In function `logi_dj_probe':
hid-logitech-dj.c:(.text+0x32dc): undefined reference to `usb_hid_driver'

This is because CONFIG_USB_HID is not set, So this
patch selects it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: da12b224b7d5 ("HID: logitech-dj: deal with some KVMs adding an extra interface to the usbdev")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 76d8206..c3c390c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -521,6 +521,7 @@ config HID_LOGITECH
 
 config HID_LOGITECH_DJ
 	tristate "Logitech Unifying receivers full support"
+	depends on USB_HID
 	depends on HIDRAW
 	depends on HID_LOGITECH
 	select HID_LOGITECH_HIDPP
-- 
2.7.4


