Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5945BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CA9218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366812;
	bh=pCwHQl34S2HsgMzlYTacCLZAqw1pWJxxjN34L8LsDKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GdTXm2IlNBc/VW+9cJ8j3V6AvQQaOiKdqKMPWUcgopLzfnA98ujyfnVFWO/aQMOLP
	 f8wgIFlWL4AMpo9odPYL2AHjUFMsuR75ORSCvhX/Dul/KjTjVTu5RBR9BzS4RiWRNT
	 v+TD0MokUl/2LeXYRgN1WgTPQ3q4xNSdUbvnTm1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbfB1PNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388398AbfB1PNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:13:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F72F218D9;
        Thu, 28 Feb 2019 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366801;
        bh=pCwHQl34S2HsgMzlYTacCLZAqw1pWJxxjN34L8LsDKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSm8UcY0wNDK/8w+d0ZhXwbkUX+aVseZvY4Mi9D981W3EZu+0CXTKd8uKTX3jy5AG
         2LrxNcIsO0HboNGw6MzAtQpOP6OEo+aek0mPGR3B6QfHCGya4nVY2DwoL/F/kZkINp
         P6zttE5UbOfpGKbTjVHlvcCZAY6TolxQ27pKJ2kY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 56/64] i2c: omap: Use noirq system sleep pm ops to idle device for suspend
Date:   Thu, 28 Feb 2019 10:10:57 -0500
Message-Id: <20190228151105.11277-56-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit c6e2bd956936d925748581e4d0294f10f1d92f2c ]

We currently get the following error with pixcir_ts driver during a
suspend resume cycle:

omap_i2c 4802a000.i2c: controller timed out
pixcir_ts 1-005c: pixcir_int_enable: can't read reg 0x34 : -110
pixcir_ts 1-005c: Failed to disable interrupt generation: -110
pixcir_ts 1-005c: Failed to stop
dpm_run_callback(): pixcir_i2c_ts_resume+0x0/0x98
[pixcir_i2c_ts] returns -110
PM: Device 1-005c failed to resume: error -110

And at least am437x based devices with pixcir_ts will fail to resume
to a touchscreen that is configured as the wakeup-source in device
tree for these devices.

This is because pixcir_ts tries to reconfigure it's registers for
noirq suspend which fails. This also leaves i2c-omap in enabled state
for suspend.

Let's fix the pixcir_ts issue and make sure i2c-omap is suspended by
adding SET_NOIRQ_SYSTEM_SLEEP_PM_OPS.

Let's also get rid of some ifdefs while at it and replace them with
__maybe_unused as SET_RUNTIME_PM_OPS and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
already deal with the various PM Kconfig options.

Reported-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-omap.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 65d06a8193074..2ac86096ddd95 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1498,8 +1498,7 @@ static int omap_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int omap_i2c_runtime_suspend(struct device *dev)
+static int __maybe_unused omap_i2c_runtime_suspend(struct device *dev)
 {
 	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
 
@@ -1525,7 +1524,7 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int omap_i2c_runtime_resume(struct device *dev)
+static int __maybe_unused omap_i2c_runtime_resume(struct device *dev)
 {
 	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
 
@@ -1540,20 +1539,18 @@ static int omap_i2c_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops omap_i2c_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
 			   omap_i2c_runtime_resume, NULL)
 };
-#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
-#else
-#define OMAP_I2C_PM_OPS NULL
-#endif /* CONFIG_PM */
 
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
 	.remove		= omap_i2c_remove,
 	.driver		= {
 		.name	= "omap_i2c",
-		.pm	= OMAP_I2C_PM_OPS,
+		.pm	= &omap_i2c_pm_ops,
 		.of_match_table = of_match_ptr(omap_i2c_of_match),
 	},
 };
-- 
2.19.1

