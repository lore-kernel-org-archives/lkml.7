Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405D4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1257F21904
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610608;
	bh=njTQZqlGVbGxU4CXh7Pye5ZQC0RdeXZifKC3Xry3Lj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=krShXQ0KH5tgaIok1b7GiJ9T6OPNM8P6hBZcgipdYqNyZ61lJaUGAXj58soFOQDXu
	 riC4GvCaS+QWW6gOGeqQf5lvoXouse1GbKkxSq56gUX1UPN+YlcWEE+mO50J5i2Hag
	 PnwXAbIWc639luSjXgToK/WESmTsKYQ8ebWIwpeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390925AbfDRSD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390170AbfDRSDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:03:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C072217FA;
        Thu, 18 Apr 2019 18:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610600;
        bh=njTQZqlGVbGxU4CXh7Pye5ZQC0RdeXZifKC3Xry3Lj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGyIp+xHef6nPwwaZw+nArGcMDRnOHTW8BZOWlHGggtbtwB1dEnfwj/Igox/D0vNU
         IWW8b3ddF3lh0VPMFiXyivDMwghnyCBjDm2mhyXlNQNESPPQtFna/nutcke8x+wDO+
         ZxYmvgPvQ28wLn8JK8Hsadl/Lc5HrnobagqX6Oe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 13/92] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
Date:   Thu, 18 Apr 2019 19:56:31 +0200
Message-Id: <20190418160431.531864834@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



