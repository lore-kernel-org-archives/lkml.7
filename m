Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DDFC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5992A24D92
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbfE3Dui convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:50:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:44611 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729795AbfE3Duf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:50:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 20:50:34 -0700
X-ExtLoop1: 1
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 29 May 2019 20:50:34 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 29 May 2019 20:50:34 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 29 May 2019 20:50:34 -0700
Received: from shsmsx107.ccr.corp.intel.com ([169.254.9.98]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.137]) with mapi id 14.03.0415.000;
 Thu, 30 May 2019 11:50:32 +0800
From:   "Chang, Junxiao" <junxiao.chang@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Li, Lili" <lili.li@intel.com>
Subject: RE: [PATCH] platform: release resource itself instead of resource
 tree
Thread-Topic: [PATCH] platform: release resource itself instead of resource
 tree
Thread-Index: AQHU+y/55Via5j+fREqcQbqrpZ0MZqaDO8ow
Date:   Thu, 30 May 2019 03:50:32 +0000
Message-ID: <840F6BCBBBA89F46BAD0D7D6EF39E6E350F220C7@SHSMSX107.ccr.corp.intel.com>
References: <1556173458-9318-1-git-send-email-junxiao.chang@intel.com>
In-Reply-To: <1556173458-9318-1-git-send-email-junxiao.chang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2Y1N2M5YTUtZGZlNS00NWM4LWFiOWUtYTgyNzczNmNlZTdhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibVhXU1lZSkoyQ2lqaWRZdDZPS210MlgwZlcxOUtOU1czNDMxVHpkK2NFZWhBVkpiWUk1Q3dvNzdmZTY1U0pxRSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any update?

This issue could be reproduced in one intel platform. To simulate the issue, adding following code could reproduce the issue.
Without the fix, device 2's resource will be released but the device is still registered.
With the fix, by cat /proc/iomem, device 2's resource is still there after device 1 is unregistered, this is expected.

Any comment is welcome, thanks,
Junxiao

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4d17298..6832833 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1500,3 +1500,63 @@ void __init early_platform_cleanup(void)
 	}
 }
 
+static struct resource resource1[] = {
+	{
+		.start = 0xfed1a000,
+		.end = 0xfed1afff,
+		.flags = IORESOURCE_MEM,
+	}
+};
+
+static struct resource resource2[] = {
+	{
+		.start = 0xfed1a200,
+		.end = 0xfed1a2ff,
+		.flags = IORESOURCE_MEM,
+	}
+};
+
+static int __init simulate_insmod_rmmod(void)
+{
+	struct platform_device *pdev1, *pdev2;
+
+	const struct platform_device_info pdevinfo1 = {
+		.parent = NULL,
+		.name = "device1",
+		.id = -1,
+		.res = resource1,
+		.num_res = 1,
+		};
+
+	const struct platform_device_info pdevinfo2 = {
+		.parent = NULL,
+		.name = "device2",
+		.id = -1,
+		.res = resource2,
+		.num_res = 1,
+	};
+
+	// Register platform test device 1, resource 0xfed1a000 ~ 0xfed1afff
+	pdev1 = platform_device_register_full(&pdevinfo1);
+	if (IS_ERR(pdev1)) {
+		printk("Unable to register device 1\n");
+		return -1;
+	}
+
+	// Register platform test device 2, resource 0xfed1a200 ~ 0xfed1a2ff
+	pdev2 = platform_device_register_full(&pdevinfo2);
+	if (IS_ERR(pdev2)) {
+		printk("Unable to register device 2\n");
+		platform_device_unregister(pdev1);
+		return -1;
+	}
+
+
+	// Now platform device 2 resource should be device 1 resource's child
+
+	// Unregister device 1 only
+	platform_device_unregister(pdev1);
+
+	return 0;
+}
+fs_initcall(simulate_insmod_rmmod);

-----Original Message-----
From: Chang, Junxiao 
Sent: Thursday, April 25, 2019 2:24 PM
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org; rafael@kernel.org; Chang, Junxiao <junxiao.chang@intel.com>; Li, Lili <lili.li@intel.com>
Subject: [PATCH] platform: release resource itself instead of resource tree

From: Junxiao Chang <junxiao.chang@intel.com>

When platform device is deleted or there is error in adding device, platform device resources should be released. Currently API release_resource is used to release platform device resources.
However, this API releases not only platform resource itself but also its child resources. It might release resources which are still in use. Calling remove_resource only releases current resource itself, not resource tree, it moves its child resources to up level.

For example, platform device 1 and device 2 are registered, then only device 1 is unregistered in below code:

  ...
  // Register platform test device 1, resource 0xfed1a000 ~ 0xfed1afff
  pdev1 = platform_device_register_full(&pdevinfo1);

  // Register platform test device 2, resource 0xfed1a200 ~ 0xfed1a2ff
  pdev2 = platform_device_register_full(&pdevinfo2);

  // Now platform device 2 resource should be device 1 resource's child

  // Unregister device 1 only
  platform_device_unregister(pdev1);
  ...

Platform device 2 resource will be released as well because its parent resource(device 1's resource) is released, this is not expected.
If using API remove_resource, device 2 resource will not be released.

This change fixed an intel pmc platform device resource issue when intel pmc ipc kernel module is inserted/removed for twice.

Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 drivers/base/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c index dab0a5a..5fd1a41 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -461,7 +461,7 @@ int platform_device_add(struct platform_device *pdev)
 	while (--i >= 0) {
 		struct resource *r = &pdev->resource[i];
 		if (r->parent)
-			release_resource(r);
+			remove_resource(r);
 	}
 
  err_out:
@@ -492,7 +492,7 @@ void platform_device_del(struct platform_device *pdev)
 		for (i = 0; i < pdev->num_resources; i++) {
 			struct resource *r = &pdev->resource[i];
 			if (r->parent)
-				release_resource(r);
+				remove_resource(r);
 		}
 	}
 }
--
2.7.4

