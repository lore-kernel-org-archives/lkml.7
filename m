Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E56DCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131E4222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504009AbfJRFFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:05:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2503979AbfJRFFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:05:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F1BE8DCDEFF3CAD5009F;
        Fri, 18 Oct 2019 11:19:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 18 Oct 2019 11:19:31 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        "Andy Shevchenko" <andy@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v2 20/33] platform/x86: intel_oaktrail: Use pr_warn instead of pr_warning
Date:   Fri, 18 Oct 2019 11:18:37 +0800
Message-ID: <20191018031850.48498-20-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018031850.48498-1-wangkefeng.wang@huawei.com>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Corentin Chary <corentin.chary@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/platform/x86/intel_oaktrail.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel_oaktrail.c b/drivers/platform/x86/intel_oaktrail.c
index 3c0438ba385e..1a09a75bd16d 100644
--- a/drivers/platform/x86/intel_oaktrail.c
+++ b/drivers/platform/x86/intel_oaktrail.c
@@ -243,7 +243,7 @@ static int oaktrail_backlight_init(void)
 
 	if (IS_ERR(bd)) {
 		oaktrail_bl_device = NULL;
-		pr_warning("Unable to register backlight device\n");
+		pr_warn("Unable to register backlight device\n");
 		return PTR_ERR(bd);
 	}
 
@@ -313,20 +313,20 @@ static int __init oaktrail_init(void)
 
 	ret = platform_driver_register(&oaktrail_driver);
 	if (ret) {
-		pr_warning("Unable to register platform driver\n");
+		pr_warn("Unable to register platform driver\n");
 		goto err_driver_reg;
 	}
 
 	oaktrail_device = platform_device_alloc(DRIVER_NAME, -1);
 	if (!oaktrail_device) {
-		pr_warning("Unable to allocate platform device\n");
+		pr_warn("Unable to allocate platform device\n");
 		ret = -ENOMEM;
 		goto err_device_alloc;
 	}
 
 	ret = platform_device_add(oaktrail_device);
 	if (ret) {
-		pr_warning("Unable to add platform device\n");
+		pr_warn("Unable to add platform device\n");
 		goto err_device_add;
 	}
 
@@ -338,7 +338,7 @@ static int __init oaktrail_init(void)
 
 	ret = oaktrail_rfkill_init();
 	if (ret) {
-		pr_warning("Setup rfkill failed\n");
+		pr_warn("Setup rfkill failed\n");
 		goto err_rfkill;
 	}
 
-- 
2.20.1

