Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5353FC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9D7216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfEJNwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:52:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727247AbfEJNwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:52:11 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EC27525E10A64F991FC1;
        Fri, 10 May 2019 21:52:08 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 May 2019
 21:51:59 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <Matt.Sickler@daktronics.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] staging: kpc2000: Fix build error without CONFIG_UIO
Date:   Fri, 10 May 2019 21:47:24 +0800
Message-ID: <20190510134724.41052-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc build error while CONFIG_UIO is not set

ERROR: "uio_unregister_device" [drivers/staging/kpc2000/kpc2000/kpc2000.ko] undefined!
ERROR: "__uio_register_device" [drivers/staging/kpc2000/kpc2000/kpc2000.ko] undefined!

Add UIO Kconfig dependency to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 7dc7967fc39a ("staging: kpc2000: add initial set of Daktronics drivers")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/kpc2000/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/kpc2000/Kconfig b/drivers/staging/kpc2000/Kconfig
index fb59229..febe4f8 100644
--- a/drivers/staging/kpc2000/Kconfig
+++ b/drivers/staging/kpc2000/Kconfig
@@ -3,6 +3,7 @@
 config KPC2000
 	bool "Daktronics KPC Device support"
 	depends on PCI
+	depends on UIO
 	help
 	  Select this if you wish to use the Daktronics KPC PCI devices
 
-- 
2.7.4


