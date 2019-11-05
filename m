Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD713C1747C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893EC21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389587AbfKEOft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:35:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730671AbfKEOft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:35:49 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6651DD1F6090D5C4B9CC;
        Tue,  5 Nov 2019 22:35:46 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 5 Nov 2019
 22:35:39 +0800
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
Message-ID: <8bdc7a86-e464-9c46-3d40-4f3c75111ce6@huawei.com>
Date:   Tue, 5 Nov 2019 22:35:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two problems after commit 0f27cff8597d ("ACPI: sysfs: Make
ACPI GPE mask kernel parameter cover all GPEs"):

1. ACPI_MASKABLE_GPE_MAX is changed from 0x80 to 0xff, so the check
condition "gpe > ACPI_MASKABLE_GPE_MAX" is not valid because the type of
gpe is u8.

2. The size of bitmap is ACPI_MASKABLE_GPE_MAX, so it is not support the
num 255 for gpe.

Update the macro ACPI_MASKABLE_GPE_MAX to 0x100, and change the type of
gpe to u32, also modify the checking condition for gpe.

Bye the way, update the docs for kernel parameter acpi_mask_gpe.

Fixes: 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel parameter cover all GPEs")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 drivers/acpi/sysfs.c                            | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a84a83f8881e..dd878e2491e1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -114,6 +114,7 @@
 			This facility can be used to prevent such uncontrolled
 			GPE floodings.
 			Format: <int>
+			Support masking of GPEs numbered from 0x00 to 0xff

 	acpi_no_auto_serialize	[HW,ACPI]
 			Disable auto-serialization of AML methods
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 75948a3f1a20..3c3302583d78 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -819,14 +819,14 @@ static ssize_t counter_set(struct kobject *kobj,
  * interface:
  *   echo unmask > /sys/firmware/acpi/interrupts/gpe00
  */
-#define ACPI_MASKABLE_GPE_MAX	0xFF
+#define ACPI_MASKABLE_GPE_MAX	0x100
 static DECLARE_BITMAP(acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) __initdata;

 static int __init acpi_gpe_set_masked_gpes(char *val)
 {
-	u8 gpe;
+	u32 gpe;

-	if (kstrtou8(val, 0, &gpe) || gpe > ACPI_MASKABLE_GPE_MAX)
+	if (kstrtouint(val, 0, &gpe) || gpe >= ACPI_MASKABLE_GPE_MAX)
 		return -EINVAL;
 	set_bit(gpe, acpi_masked_gpes_map);

@@ -838,7 +838,7 @@ void __init acpi_gpe_apply_masked_gpes(void)
 {
 	acpi_handle handle;
 	acpi_status status;
-	u8 gpe;
+	u32 gpe;

 	for_each_set_bit(gpe, acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) {
 		status = acpi_get_gpe_device(gpe, &handle);
-- 
2.7.4

