Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C61C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3738820882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfDDOT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:19:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53930 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbfDDOT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:19:57 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 06EAF2BCCF8260A31802;
        Thu,  4 Apr 2019 22:19:53 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 4 Apr 2019
 22:19:42 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <myungjoo.ham@samsung.com>, <cw00.choi@samsung.com>,
        <wens@csie.org>, <hdegoede@redhat.com>, <rjw@rjwysocki.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] extcon: axp288: Add a depends on ACPI to the Kconfig entry
Date:   Thu, 4 Apr 2019 22:17:48 +0800
Message-ID: <20190404141748.27048-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190404104222.23900-1-yuehaibing@huawei.com>
References: <20190404104222.23900-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

As Hans de Goede pointed, using this driver without ACPI
makes little sense, so add ACPI dependency to Kconfig entry
to fix a build error while CONFIG_ACPI is not set.

drivers/extcon/extcon-axp288.c: In function 'axp288_extcon_probe':
drivers/extcon/extcon-axp288.c:363:20: error: dereferencing pointer to incomplete type
    put_device(&adev->dev);

Fixes: 0cf064db948a ("extcon: axp288: Convert to use acpi_dev_get_first_match_dev()")
Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: rework patch
---
 drivers/extcon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 1ed4b45..de06faf 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -30,7 +30,7 @@ config EXTCON_ARIZONA
 
 config EXTCON_AXP288
 	tristate "X-Power AXP288 EXTCON support"
-	depends on MFD_AXP20X && USB_SUPPORT && X86
+	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
 	select USB_ROLE_SWITCH
 	help
 	  Say Y here to enable support for USB peripheral detection
-- 
2.7.4


