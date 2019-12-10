Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD9FC2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12D3206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkHKgIf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLJJNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:13:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37307 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfLJJNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:13:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so1769073plz.4;
        Tue, 10 Dec 2019 01:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCfrkeTyXUifAsSXxqFl0DpIzo4W83I7gTVb/hoapZE=;
        b=AkHKgIf1NiMnG7Gj7x2uthUKxnDURwF3UhqrsyH10z+eftQxFXaF4KNAasJbiBZ9V1
         3DvKg/DU2FgCZgey7Q+RFcek3e9pYrWSojh9To8RPk8lHAjWbdQBq6fr6J6Jn7MzVFTO
         XO1k5vyjTDrqw6kPwy8BXjqDcioW9DTsi/qDyGx3srujFsYsftsXAb7qqqfvYHHIdbBQ
         qElqsCsYqMP9sQwR6BUM43EErFa5GQuFGe/K86FoGH7+6wKLHCvpPy9v2CMlpMPorGrr
         z89Pb+FS0zKRZJPzSXI26Dg2Khsi7CLQyL/0HqfXsoHzQiKS+MFJls+xi1Q43/FVFY2g
         7ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCfrkeTyXUifAsSXxqFl0DpIzo4W83I7gTVb/hoapZE=;
        b=gg0UjU6JYcedBa2kVK6pDhVdlL2bcyNkhj9dSAZSIuMj86h96SK01aJRMfG6Lefbm+
         +zFMBBAKSyKUlLgR76ONGZPfNWMsSDov/TN580lXevXQr2KEzOk8Nep7AUpLQDunvXqR
         S0AGZvnyIfwnSd4NC35Rcnfwg4v+3yoGVvfuZKpJ6js9ePXvi6GOtMKOoqH03eqViwcd
         WvZEAQ7CM4Bk284oNuE2bVgqZt5Y5jjD49sdfzR8yjsRLgAyqpnXgZlRv77q5Nx1iyiz
         K7fQRqIKCw/f/8TLPimQd82wgEq4VdoeCdpyT4jSxR2FHY0czp1mz5uRddHULMTOSJtf
         e/Hg==
X-Gm-Message-State: APjAAAVRQK7C3cnPuRnGt3Tt+2Ks5lx96d0d3dA6iLGQxqBnJ8XU7aNk
        cRJdVF18EG20tr2SYkgPVD0=
X-Google-Smtp-Source: APXvYqyXNyrvXoRs1b7KraoFUwxJ4zaBbmaXa6ETC/lHTsr+/c/QFgorcU4XpIjV8KJ9shxGexFy1w==
X-Received: by 2002:a17:90a:a881:: with SMTP id h1mr4259501pjq.50.1575969231329;
        Tue, 10 Dec 2019 01:13:51 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id g30sm2377368pgm.23.2019.12.10.01.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 01:13:50 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tejun Heo <tj@kernel.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ahci: imx: add a check for devm_thermal_zone_of_sensor_register
Date:   Tue, 10 Dec 2019 17:13:36 +0800
Message-Id: <20191210091336.23331-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver misses a check for devm_thermal_zone_of_sensor_register().
Add a check to fix it.

Fixes: 54643a83b41a ("ahci: imx: Add imx53 SATA temperature sensor support")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/ata/ahci_imx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 948d2c6557f3..c6206b3053c6 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -1121,6 +1121,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	    IS_ENABLED(CONFIG_HWMON)) {
 		/* Add the temperature monitor */
 		struct device *hwmon_dev;
+		struct thermal_zone_device *thermal_dev;
 
 		hwmon_dev =
 			devm_hwmon_device_register_with_groups(dev,
@@ -1131,8 +1132,13 @@ static int imx_ahci_probe(struct platform_device *pdev)
 			ret = PTR_ERR(hwmon_dev);
 			goto disable_clk;
 		}
-		devm_thermal_zone_of_sensor_register(hwmon_dev, 0, hwmon_dev,
+		thermal_dev = devm_thermal_zone_of_sensor_register(hwmon_dev,
+					     0, hwmon_dev,
 					     &fsl_sata_ahci_of_thermal_ops);
+		if (IS_ERR(thermal_dev)) {
+			ret = PTR_ERR(thermal_dev);
+			goto disable_clk;
+		}
 		dev_info(dev, "%s: sensor 'sata_ahci'\n", dev_name(hwmon_dev));
 	}
 
-- 
2.24.0

