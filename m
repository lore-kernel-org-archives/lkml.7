Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4785EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139B0214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413612;
	bh=3vH00exyIQyNbX1NgPWY1DGyFajZzYi3+9s1khJuGOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SCIgxkSLEhuGFxgXWsj5vZElP+MGyAsUmOsb4S2UIr1pHr0tIFpccua58SbMOZMjP
	 /wui1VdfFPMNc+incH6ijLVM1jQltvjQe2VXEANOJo7ro6gUv6ebUk2VoedBrkVBn4
	 z35juU4FylLc87XGFtm2SXEjozkYyQQJUXiM5/Wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfCLSAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbfCLRN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:26 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9869D2183F;
        Tue, 12 Mar 2019 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410805;
        bh=3vH00exyIQyNbX1NgPWY1DGyFajZzYi3+9s1khJuGOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuQMh+ggMzgf6bVWf76Y33BTZq+WCAAn6E/2rX3H4dCdwc9+9TYM0F7oLJIZfKLuc
         +sLHGQyguRMcwzdLmcJDIKZF4IuUXYnLvv5OPaquGEedQ36GU4PxNIGThAz/WGdKy9
         sK0qP571oPGIqK2BzkTfp2HN8Yp6W6qY+meXvAE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 134/171] i2c: omap: Use noirq system sleep pm ops to idle device for suspend
Date:   Tue, 12 Mar 2019 10:08:34 -0700
Message-Id: <20190312170359.239895051@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index b1086bfb0465..cd9c65f3d404 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1500,8 +1500,7 @@ static int omap_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int omap_i2c_runtime_suspend(struct device *dev)
+static int __maybe_unused omap_i2c_runtime_suspend(struct device *dev)
 {
 	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
 
@@ -1527,7 +1526,7 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int omap_i2c_runtime_resume(struct device *dev)
+static int __maybe_unused omap_i2c_runtime_resume(struct device *dev)
 {
 	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
 
@@ -1542,20 +1541,18 @@ static int omap_i2c_runtime_resume(struct device *dev)
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



