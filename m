Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3636AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40472087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bIp8G+wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfD2Qzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:55:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45138 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfD2Qzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:55:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so1980525pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AMPQbvcwEN3ZxVejjVGKTdlBJSPIcIJE/Kqfir3TvYk=;
        b=bIp8G+wuW7rQ37gmaDIBfuVrDfU8/YiaQDK8l32Oica8Kx/A1l2ujRTouhaWa+Z+ij
         flAq4xBxcbvNGPlRN9vQpCyQPxD12S0O29alldRN9z70HpZdhWyiJSeZPCztOCgfQXnf
         O4JwOSc6XAbQ3t2XNr1sX0N3pkIf9wisrgu5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AMPQbvcwEN3ZxVejjVGKTdlBJSPIcIJE/Kqfir3TvYk=;
        b=ocZ9gr1PjHgo5NSBjM8jVQGW62XofkqA2EJhBU7qz/MjH+nYhP0u2o3Kn/ihDB1im4
         8An0jypb+KRJb+rTb95ph5S4HHpgY4PzyVoIdbD4hFPB+6eTifwdhFPl1y/tkC9W2xry
         y673Y7PLMGaqPm5F5A/w4aQKQS2eipbptzyFcezosTUot5XtLx/HZRkTvT/1g1l0r0gU
         gMCW31305p7eAqrFvOL81BL3BMU/NVFwVxl88i7dy7o/7p3N65imht5u4PEqw9l2VEvI
         0W2uyk0+qu2Fl31rhMTPBumAzKnDkquXGOrCjBoRj1XbmWV5cwp2xV+vDO1GIDbMFslQ
         ukNg==
X-Gm-Message-State: APjAAAUa8ZsjAZTWOogQCktUaE5IrPBX/MZoYcNSbzfhwtxVsQBRC0qc
        Xn4Zx3Yk4lzZV9doRsBeCN4y4Q==
X-Google-Smtp-Source: APXvYqxUDG2Rl+yER4noZW2kdX8sLT0Bu5I2nqTLysmUo8pb2pNLanJKAOumCSV+467bL/eGFeLSWA==
X-Received: by 2002:a63:500f:: with SMTP id e15mr59974587pgb.198.1556556946665;
        Mon, 29 Apr 2019 09:55:46 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 132sm24490812pfw.87.2019.04.29.09.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Apr 2019 09:55:45 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH] thermal: broadcom: Remove ACPI support
Date:   Mon, 29 Apr 2019 22:25:29 +0530
Message-Id: <1556556929-25704-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike DT framework, thermal-zones and its parameters can't be parsed
using ACPI framework. So that ACPI support is removed in this driver.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reported-by: David Woodhouse <dwmw2@infradead.org>
---
 drivers/thermal/broadcom/sr-thermal.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broadcom/sr-thermal.c
index 2284cbe..475ce29 100644
--- a/drivers/thermal/broadcom/sr-thermal.c
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Broadcom
  */
 
-#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -100,18 +99,11 @@ static const struct of_device_id sr_thermal_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sr_thermal_of_match);
 
-static const struct acpi_device_id sr_thermal_acpi_ids[] = {
-	{ .id = "BRCM0500" },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(acpi, sr_thermal_acpi_ids);
-
 static struct platform_driver sr_thermal_driver = {
 	.probe		= sr_thermal_probe,
 	.driver = {
 		.name = "sr-thermal",
 		.of_match_table = sr_thermal_of_match,
-		.acpi_match_table = ACPI_PTR(sr_thermal_acpi_ids),
 	},
 };
 module_platform_driver(sr_thermal_driver);
-- 
2.7.4

