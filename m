Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9B6C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505062171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfDLPT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:19:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33540 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbfDLPT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:19:58 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2FEC83D1CC4337667563;
        Fri, 12 Apr 2019 23:19:54 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Fri, 12 Apr 2019
 23:19:47 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <andriy.shevchenko@linux.intel.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <rjw@rjwysocki.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v3] gpio: merrifield: Fix build err without CONFIG_ACPI
Date:   Fri, 12 Apr 2019 23:19:11 +0800
Message-ID: <20190412151911.12084-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190405142112.26592-1-yuehaibing@huawei.com>
References: <20190405142112.26592-1-yuehaibing@huawei.com>
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
                   ^~

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes:d00d2109c367 ("gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()")
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v3: move helper to acpi_bus.h, and change name to acpi_dev_put
---
 drivers/gpio/gpio-merrifield.c | 2 +-
 include/acpi/acpi_bus.h        | 4 ++++
 include/linux/acpi.h           | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 2383dc7..3302125 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -385,7 +385,7 @@ static const char *mrfld_gpio_get_pinctrl_dev_name(struct mrfld_gpio *priv)
 	adev = acpi_dev_get_first_match_dev("INTC1002", NULL, -1);
 	if (adev) {
 		name = devm_kstrdup(priv->dev, acpi_dev_name(adev), GFP_KERNEL);
-		put_device(&adev->dev);
+		acpi_dev_put(adev);
 	} else {
 		name = "pinctrl-merrifield";
 	}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f798175..2a462cf 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -687,6 +687,10 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
 		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
 }
 
+static inline void acpi_dev_put(struct acpi_device *adev)
+{
+	put_device(&adev->dev);
+}
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a1bd789..e22c237 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -679,6 +679,8 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
 	return NULL;
 }
 
+static inline void acpi_dev_put(struct acpi_device *adev) {}
+
 static inline bool is_acpi_node(struct fwnode_handle *fwnode)
 {
 	return false;
-- 
2.7.4


