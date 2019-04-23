Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8301AC10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5083F20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i++MhZXD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i++MhZXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfDWAQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 20:16:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50880 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbfDWAQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 20:16:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C987D615C2; Tue, 23 Apr 2019 00:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555978599;
        bh=PbPtAq5ScFALBxZVtpu7qsjSHRBTF4zyvTA/PxBdyvM=;
        h=From:To:Subject:Date:From;
        b=i++MhZXDYOvaAHNyIcTgCsy2qv6HwFUpnqycLt9xlb/Fg8Rh2Wx09QO7yog867EsN
         QPcZ3mFgZ7a1FM78uHoJg0L5xRckNqm79ddQ3wcCvW4h3sfZLOV/gWoCylX/9i9/R0
         o5OYZDpUpgVAOvkngOS9k4P9QDJrTJ2V3KUXzSMc=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A667A61194;
        Tue, 23 Apr 2019 00:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555978599;
        bh=PbPtAq5ScFALBxZVtpu7qsjSHRBTF4zyvTA/PxBdyvM=;
        h=From:To:Subject:Date:From;
        b=i++MhZXDYOvaAHNyIcTgCsy2qv6HwFUpnqycLt9xlb/Fg8Rh2Wx09QO7yog867EsN
         QPcZ3mFgZ7a1FM78uHoJg0L5xRckNqm79ddQ3wcCvW4h3sfZLOV/gWoCylX/9i9/R0
         o5OYZDpUpgVAOvkngOS9k4P9QDJrTJ2V3KUXzSMc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A667A61194
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net,
        alexander.deucher@amd.com, tsoni@codeaurora.org,
        psodagud@codeaurora.org, jshriram@codeaurora.org,
        vnkgutta@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: platform: Fix the usage of platform device name(pdev->name)
Date:   Mon, 22 Apr 2019 17:16:29 -0700
Message-Id: <1555978589-4998-1-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform core is using pdev->name as the platform device name to do
the binding of the devices with the drivers. But, when the platform
driver overrides the platform device name with dev_set_name(),
the pdev->name is pointing to a location which is freed and becomes
an invalid parameter to do the binding match.

use-after-free instance:

[   33.325013] BUG: KASAN: use-after-free in strcmp+0x8c/0xb0
[   33.330646] Read of size 1 at addr ffffffc10beae600 by task modprobe
[   33.339068] CPU: 5 PID: 518 Comm: modprobe Tainted:
			G S      W  O      4.19.30+ #3
[   33.346835] Hardware name: MTP (DT)
[   33.350419] Call trace:
[   33.352941]  dump_backtrace+0x0/0x3b8
[   33.356713]  show_stack+0x24/0x30
[   33.360119]  dump_stack+0x160/0x1d8
[   33.363709]  print_address_description+0x84/0x2e0
[   33.368549]  kasan_report+0x26c/0x2d0
[   33.372322]  __asan_report_load1_noabort+0x2c/0x38
[   33.377248]  strcmp+0x8c/0xb0
[   33.380306]  platform_match+0x70/0x1f8
[   33.384168]  __driver_attach+0x78/0x3a0
[   33.388111]  bus_for_each_dev+0x13c/0x1b8
[   33.392237]  driver_attach+0x4c/0x58
[   33.395910]  bus_add_driver+0x350/0x560
[   33.399854]  driver_register+0x23c/0x328
[   33.403886]  __platform_driver_register+0xd0/0xe0

So, use dev_name(&pdev->dev), which fetches the platform device name from
the kobject(dev->kobj->name) of the device instead of the pdev->name.

Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
---
 drivers/base/platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index dab0a5a..0e23aa2 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -888,7 +888,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 	if (len != -ENODEV)
 		return len;
 
-	len = snprintf(buf, PAGE_SIZE, "platform:%s\n", pdev->name);
+	len = snprintf(buf, PAGE_SIZE, "platform:%s\n", dev_name(&pdev->dev));
 
 	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
 }
@@ -964,7 +964,7 @@ static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
 		return rc;
 
 	add_uevent_var(env, "MODALIAS=%s%s", PLATFORM_MODULE_PREFIX,
-			pdev->name);
+			dev_name(&pdev->dev));
 	return 0;
 }
 
@@ -973,7 +973,7 @@ static const struct platform_device_id *platform_match_id(
 			struct platform_device *pdev)
 {
 	while (id->name[0]) {
-		if (strcmp(pdev->name, id->name) == 0) {
+		if (strcmp(dev_name(&pdev->dev), id->name) == 0) {
 			pdev->id_entry = id;
 			return id;
 		}
@@ -1017,7 +1017,7 @@ static int platform_match(struct device *dev, struct device_driver *drv)
 		return platform_match_id(pdrv->id_table, pdev) != NULL;
 
 	/* fall-back to driver name match */
-	return (strcmp(pdev->name, drv->name) == 0);
+	return (strcmp(dev_name(&pdev->dev), drv->name) == 0);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

