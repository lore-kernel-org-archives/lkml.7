Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E19C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4FB205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbfDEOVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:21:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726730AbfDEOVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:21:46 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8FCA0EB8A12F5A7454F4;
        Fri,  5 Apr 2019 22:21:38 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Fri, 5 Apr 2019
 22:21:32 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <andriy.shevchenko@linux.intel.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <rjw@rjwysocki.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] gpio: merrifield: Fix build err without CONFIG_ACPI
Date:   Fri, 5 Apr 2019 22:21:12 +0800
Message-ID: <20190405142112.26592-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190404103925.25652-1-yuehaibing@huawei.com>
References: <20190404103925.25652-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

When building CONFIG_ACPI is not set
gcc warn this:

drivers/gpio/gpio-merrifield.c: In function mrfld_gpio_get_pinctrl_dev_name:
drivers/gpio/gpio-merrifield.c:388:19: error: dereferencing pointer to incomplete type struct acpi_device
   put_device(&adev->dev);
                   ^
Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes:d00d2109c367 ("gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: rework patch use put_acpi_device helper
---
 drivers/gpio/gpio-merrifield.c | 2 +-
 include/linux/acpi.h           | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 2383dc7..99ca18c 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -385,7 +385,7 @@ static const char *mrfld_gpio_get_pinctrl_dev_name(struct mrfld_gpio *priv)
 	adev = acpi_dev_get_first_match_dev("INTC1002", NULL, -1);
 	if (adev) {
 		name = devm_kstrdup(priv->dev, acpi_dev_name(adev), GFP_KERNEL);
-		put_device(&adev->dev);
+		put_acpi_device(adev);
 	} else {
 		name = "pinctrl-merrifield";
 	}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a1bd789..2563e13 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1331,12 +1331,19 @@ static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 
 #ifdef CONFIG_ACPI
 extern int acpi_platform_notify(struct device *dev, enum kobject_action action);
+
+static inline void put_acpi_device(struct acpi_device *adev)
+{
+	put_device(&adev->dev);
+}
 #else
 static inline int
 acpi_platform_notify(struct device *dev, enum kobject_action action)
 {
 	return 0;
 }
+
+static inline void put_acpi_device(struct acpi_device *adev) {}
 #endif
 
 #endif	/*_LINUX_ACPI_H*/
-- 
2.7.4


