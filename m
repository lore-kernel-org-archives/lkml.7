Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25888C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3C020729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfKOFe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 00:34:57 -0500
Received: from mail5.windriver.com ([192.103.53.11]:48684 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfKOFe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 00:34:57 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id xAF5Yh0X027136
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 14 Nov 2019 21:34:43 -0800
Received: from pek-lpggp6.wrs.com (128.224.153.40) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.468.0; Thu, 14 Nov 2019
 21:34:42 -0800
From:   Yongxin Liu <yongxin.liu@windriver.com>
To:     <andy@infradead.org>, <dvhart@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mario.limonciello@dell.com>
Subject: [PATCH] Revert "platform/x86: wmi: Destroy on cleanup rather than unregister"
Date:   Fri, 15 Nov 2019 13:27:10 +0800
Message-ID: <20191115052710.46880-1-yongxin.liu@windriver.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7b11e8989618581bc0226ad313264cdc05d48d86.

Consider the following hardware setting.

|-PNP0C14:00
|  |-- device #1
|-PNP0C14:01
|  |-- device #2

When unloading wmi driver module, device #2 will be first unregistered.
But device_destroy() using MKDEV(0, 0) will locate PNP0C14:00 first
and unregister it. This is incorrect. Should use device_unregister() to
unregister the real parent device.

Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
---
 drivers/platform/x86/wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 59e9aa0f9643..e16f660aa117 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1347,7 +1347,7 @@ static int acpi_wmi_remove(struct platform_device *device)
 	acpi_remove_address_space_handler(acpi_device->handle,
 				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
 	wmi_free_devices(acpi_device);
-	device_destroy(&wmi_bus_class, MKDEV(0, 0));
+	device_unregister((struct device *)dev_get_drvdata(&device->dev));
 
 	return 0;
 }
@@ -1401,7 +1401,7 @@ static int acpi_wmi_probe(struct platform_device *device)
 	return 0;
 
 err_remove_busdev:
-	device_destroy(&wmi_bus_class, MKDEV(0, 0));
+	device_unregister(wmi_bus_dev);
 
 err_remove_notify_handler:
 	acpi_remove_notify_handler(acpi_device->handle, ACPI_DEVICE_NOTIFY,
-- 
2.14.4

