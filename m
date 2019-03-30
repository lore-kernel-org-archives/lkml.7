Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B792C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC90218D8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907313;
	bh=uvcSHLBCNSC7LVeh3qFCOeC9h1zv3W5nJkfCczyl6r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZGwjsj3mOXEwoKI4YrjCreLB8r13Zp6d8gPwo3oyulxkmpGv4mj9C6Om8aiwjnuNU
	 iPh68XFY1p2Sa0sPUEKN9voYmhOMv/6928sLiSnaVuivJgcbg1nvTsdvPpIQ479Bre
	 iJ0x/dW8+MIFFBaQl5LIFmmjmhZ/6ttrmHdImYWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbfC3AzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731156AbfC3AzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:55:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BCC52064A;
        Sat, 30 Mar 2019 00:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907302;
        bh=uvcSHLBCNSC7LVeh3qFCOeC9h1zv3W5nJkfCczyl6r0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CgTAZk/7RBgRwoKgLOtHiX4cOHBPw+8NHeVZXcIUKpAZcLw3zq63gyvE1ok3QpovS
         I/JDT/wF1HflJFkIcG8obH3b3JxVrSGhqzuSnnd5YIPNdmYj4wUlsKEleLbE6eFMDk
         oUpXHg1C792TneEojRg+y7dsFVR9OCPLgIu/iT8Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Phil Elwell <phil@raspberrypi.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 13/37] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
Date:   Fri, 29 Mar 2019 20:54:14 -0400
Message-Id: <20190330005441.27540-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005441.27540-1-sashal@kernel.org>
References: <20190330005441.27540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Elwell <phil@raspberrypi.org>

[ Upstream commit 35122495a8c6683e863acf7b05a7036b2be64c7a ]

"cat /sys/kernel/debug/bcm2835_thermal/regset" causes a NULL pointer
dereference in bcm2835_thermal_debugfs. The driver makes use of the
implementation details of the thermal framework to retrieve a pointer
to its private data from a struct thermal_zone_device, and gets it
wrong - leading to the crash. Instead, store its private data as the
drvdata and retrieve the thermal_zone_device pointer from it.

Fixes: bcb7dd9ef206 ("thermal: bcm2835: add thermal driver for bcm2835 SoC")

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 24b006a95142..8646fb7425f2 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -128,8 +128,7 @@ static const struct debugfs_reg32 bcm2835_thermal_regs[] = {
 
 static void bcm2835_thermal_debugfs(struct platform_device *pdev)
 {
-	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
-	struct bcm2835_thermal_data *data = tz->devdata;
+	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
 	struct debugfs_regset32 *regset;
 
 	data->debugfsdir = debugfs_create_dir("bcm2835_thermal", NULL);
@@ -275,7 +274,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 	data->tz = tz;
 
-	platform_set_drvdata(pdev, tz);
+	platform_set_drvdata(pdev, data);
 
 	/*
 	 * Thermal_zone doesn't enable hwmon as default,
@@ -299,8 +298,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 static int bcm2835_thermal_remove(struct platform_device *pdev)
 {
-	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
-	struct bcm2835_thermal_data *data = tz->devdata;
+	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
+	struct thermal_zone_device *tz = data->tz;
 
 	debugfs_remove_recursive(data->debugfsdir);
 	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
-- 
2.19.1

