Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC7CC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BF320879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfEQKEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:04:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727788AbfEQKEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:04:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A4A91164ADCA12F9ABB6;
        Fri, 17 May 2019 18:03:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 17 May 2019 18:03:49 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] ipmi_si: fix unexpected driver unregister warning
Date:   Fri, 17 May 2019 18:12:44 +0800
Message-ID: <20190517101245.4341-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ipmi_si_platform_init()->platform_driver_register() fails,
platform_driver_unregister() called unconditionally will trigger
following warning,

ipmi_platform: Unable to register driver: -12
------------[ cut here ]------------
Unexpected driver unregister!
WARNING: CPU: 1 PID: 7210 at drivers/base/driver.c:193 driver_unregister+0x60/0x70 drivers/base/driver.c:193

Fix it by adding platform_registered variable, only unregister platform
driver when it is already successfully registered.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/char/ipmi/ipmi_si_platform.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index f2a91c4d8cab..0cd849675d99 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -19,6 +19,7 @@
 #include "ipmi_si.h"
 #include "ipmi_dmi.h"
 
+static bool platform_registered;
 static bool si_tryplatform = true;
 #ifdef CONFIG_ACPI
 static bool          si_tryacpi = true;
@@ -469,9 +470,12 @@ void ipmi_si_platform_init(void)
 	int rv = platform_driver_register(&ipmi_platform_driver);
 	if (rv)
 		pr_err("Unable to register driver: %d\n", rv);
+	else
+		platform_registered = true;
 }
 
 void ipmi_si_platform_shutdown(void)
 {
-	platform_driver_unregister(&ipmi_platform_driver);
+	if (platform_registered)
+		platform_driver_unregister(&ipmi_platform_driver);
 }
-- 
2.20.1

