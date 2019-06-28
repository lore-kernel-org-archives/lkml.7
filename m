Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8E3C5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913632147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfF1LQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 07:16:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7669 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbfF1LP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:15:58 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F423FB8F5F2F43676CB0;
        Fri, 28 Jun 2019 19:15:55 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 28 Jun 2019 19:15:49 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH RFC 1/3] ACPI / scan: evaluate _STA for processors declared via ASL Device statement
Date:   Fri, 28 Jun 2019 19:13:10 +0800
Message-ID: <1561720392-45907-2-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we scan all the acpi namespace node in
acpi_scan_init()->acpi_bus_scan(), we evaluate '_STA' method for processor
type node to determine whether the device is present. But processors can
also be declared via ASL Device statement. ACPI 6.3 spec specifically
says that the Processor statement is deprecated and a Device statement
should be used for processors. In that case, acpi_object_type is
ACPI_TYPE_DEVICE rather than ACPI_TYPE_PROCESSOR.

Current code doesn't evaluate '_STA' for nodes with ACPI_TYPE_DEVICE, and
the device status is set to 'present' as default. This patch get the
device status from '_STA' method for processors declared via ASL Device
statement if it does have a '_STA' method.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

---
I am not sure if I should set 'type' as ACPI_BUS_TYPE_PROCESSOR rather than
ACPI_BUS_TYPE_DEVICE for processors declared via ASL Device statement.
---
 drivers/acpi/scan.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e1b6231..ad50904 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/x86/apple.h>
 
+#include <acpi/processor.h>
 #include <asm/pgtable.h>
 
 #include "internal.h"
@@ -1691,6 +1692,7 @@ static int acpi_bus_type_and_status(acpi_handle handle, int *type,
 {
 	acpi_status status;
 	acpi_object_type acpi_type;
+	struct acpi_device_info *info;
 
 	status = acpi_get_type(handle, &acpi_type);
 	if (ACPI_FAILURE(status))
@@ -1703,6 +1705,16 @@ static int acpi_bus_type_and_status(acpi_handle handle, int *type,
 			return -ENODEV;
 
 		*type = ACPI_BUS_TYPE_DEVICE;
+
+		status = acpi_get_object_info(handle, &info);
+		if (ACPI_SUCCESS(status) && info->valid & ACPI_VALID_HID &&
+		    !strcmp(info->hardware_id.string,
+					ACPI_PROCESSOR_DEVICE_HID)) {
+			status = acpi_bus_get_status_handle(handle, sta);
+			if (ACPI_SUCCESS(status))
+				break;
+		}
+
 		/*
 		 * acpi_add_single_object updates this once we've an acpi_device
 		 * so that acpi_bus_get_status' quirk handling can be used.
-- 
1.7.12.4

