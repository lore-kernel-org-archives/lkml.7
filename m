Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80539C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9BB20675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611541;
	bh=VqfAqdjv2UA9R3OtYQlfPqcKUrBwrpST/TsVByGc3ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VH7kJiiLXJi+Faa0mkN87VATkms0wH50CQ6Ny4X24/796PpQxC+nULmQM/OXDSIF3
	 pd81o98o6iQ591IHMstGMzbFtQnfmYHubERtIrChgqneJrXOA4Cz9ol1ts8iWvzWIl
	 dvY9h+B2/RnfdCdHE5pnK6hcxSyrIs525AubOgB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404080AbfDRSKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403809AbfDRSKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:10:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E1EE206B6;
        Thu, 18 Apr 2019 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611005;
        bh=VqfAqdjv2UA9R3OtYQlfPqcKUrBwrpST/TsVByGc3ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anIxDgyLdAuOTXboIV87BIn87RM1t4ARplyx7fVBBulweYaOukzUO3mWaZ74BcSyN
         BjoLHbg3q1ZS7CWGU9snNlVlOsVkw3ziyFiNDpCVTiRrIEgFoutaqCZ9g1CwBYtbqu
         ouwQQLqAgN6/Kb5skiQTiPzdci1OEFez8ucw29eA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 22/93] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
Date:   Thu, 18 Apr 2019 19:57:00 +0200
Message-Id: <20190418160438.986278963@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
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
index 720760cd493f..ba39647a690c 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -119,8 +119,7 @@ static const struct debugfs_reg32 bcm2835_thermal_regs[] = {
 
 static void bcm2835_thermal_debugfs(struct platform_device *pdev)
 {
-	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
-	struct bcm2835_thermal_data *data = tz->devdata;
+	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
 	struct debugfs_regset32 *regset;
 
 	data->debugfsdir = debugfs_create_dir("bcm2835_thermal", NULL);
@@ -266,7 +265,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 	data->tz = tz;
 
-	platform_set_drvdata(pdev, tz);
+	platform_set_drvdata(pdev, data);
 
 	/*
 	 * Thermal_zone doesn't enable hwmon as default,
@@ -290,8 +289,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
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



