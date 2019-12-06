Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D09C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211AD21835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLFMnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:43:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbfLFMnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:43:18 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 34E8698A8BE4491AEB20;
        Fri,  6 Dec 2019 20:43:15 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Dec 2019
 20:43:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>, <andrew@lunn.ch>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] watchdog: tqmx86_wdt: Fix build error
Date:   Fri, 6 Dec 2019 20:42:59 +0800
Message-ID: <20191206124259.25880-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If TQMX86_WDT is y and WATCHDOG_CORE is m, building fails:

drivers/watchdog/tqmx86_wdt.o: In function `tqmx86_wdt_probe':
tqmx86_wdt.c:(.text+0x46e): undefined reference to `watchdog_init_timeout'
tqmx86_wdt.c:(.text+0x4e0): undefined reference to `devm_watchdog_register_device'

Select WATCHDOG_CORE to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e3c21e088f89 ("watchdog: tqmx86: Add watchdog driver for the IO controller")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1679e0d..20bd967 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1444,6 +1444,7 @@ config SMSC37B787_WDT
 config TQMX86_WDT
 	tristate "TQ-Systems TQMX86 Watchdog Timer"
 	depends on X86
+	select WATCHDOG_CORE
 	help
 	This is the driver for the hardware watchdog timer in the TQMX86 IO
 	controller found on some of their ComExpress Modules.
-- 
2.7.4


