Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FFBC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7DE2133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfEYOi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 10:38:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbfEYOiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 10:38:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 69BACF60F0138FAA61DA;
        Sat, 25 May 2019 22:38:23 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 22:38:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] USB: ohci-spear: Remove set but not used variable 'ohci'
Date:   Sat, 25 May 2019 22:38:08 +0800
Message-ID: <20190525143808.14308-1-yuehaibing@huawei.com>
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

drivers/usb/host/ohci-spear.c: In function spear_ohci_hcd_drv_probe:
drivers/usb/host/ohci-spear.c:38:19: warning: variable ohci set but not used [-Wunused-but-set-variable]

It is never used since commit 1cc6ac59ffaa ("USB:
OHCI: make ohci-spear a separate driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/host/ohci-spear.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 69fa04697793..5cc05449281c 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -35,7 +35,6 @@ static struct hc_driver __read_mostly ohci_spear_hc_driver;
 static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
 {
 	const struct hc_driver *driver = &ohci_spear_hc_driver;
-	struct ohci_hcd *ohci;
 	struct usb_hcd *hcd = NULL;
 	struct clk *usbh_clk;
 	struct spear_ohci *sohci_p;
@@ -85,8 +84,6 @@ static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(sohci_p->clk);
 
-	ohci = hcd_to_ohci(hcd);
-
 	retval = usb_add_hcd(hcd, platform_get_irq(pdev, 0), 0);
 	if (retval == 0) {
 		device_wakeup_enable(hcd->self.controller);
-- 
2.17.1


