Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607FBC17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3672B208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354847;
	bh=XSc49gLZDnT5iD6+dqt3KN9TjzN4HO4lpDf5yK9KBYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HTYuJGXjySna5ypyaCZPaJq/I2oMytXT7wH1E3GHc5CciBW2rVCRRh9jrQi7Ur8gQ
	 b9AHA+YQFahdlDgI0rW/2o4uNDMcWylykHctO/17Yh7Y/lHgwfbAfkG1E1vNKlo0ub
	 eKSDBsI9WJ2kAmiIEs1UgkoN8LkYBlAj63WnzIA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfKJDAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729201AbfKJC4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:56:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D09FF222C9;
        Sun, 10 Nov 2019 02:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354049;
        bh=XSc49gLZDnT5iD6+dqt3KN9TjzN4HO4lpDf5yK9KBYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkY2zqvbtHww+mycph/++nXoBy3yepn4pPvP+YYENAI/CzbXZeH0jNW+pyY2rhSgK
         /XxanJyGCLQuIu97WpbIN7NhdbBnqU9ic5cBdITLTsTJ4VrLNcxMSAl9yXnuKLe9mq
         UYQBHxDIt4ffsUtKUrSnREITmutHAoDbntYRY6bY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 059/109] phy: phy-twl4030-usb: fix denied runtime access
Date:   Sat,  9 Nov 2019 21:44:51 -0500
Message-Id: <20191110024541.31567-59-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Kemnade <andreas@kemnade.info>

[ Upstream commit 6c7103aa026094a4ee2c2708ec6977a6dfc5331d ]

When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
the counter will be incremented but the resume callback not called,
so enumeration and charging will not start properly.
To avoid that happen, disable irq on suspend and recheck on resume.

Practically this happens when the device is woken up from suspend by
plugging in usb.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/ti/phy-twl4030-usb.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
index a44680d64f9b4..c267afb68f077 100644
--- a/drivers/phy/ti/phy-twl4030-usb.c
+++ b/drivers/phy/ti/phy-twl4030-usb.c
@@ -144,6 +144,7 @@
 #define PMBR1				0x0D
 #define GPIO_USB_4PIN_ULPI_2430C	(3 << 0)
 
+static irqreturn_t twl4030_usb_irq(int irq, void *_twl);
 /*
  * If VBUS is valid or ID is ground, then we know a
  * cable is present and we need to be runtime-enabled
@@ -395,6 +396,33 @@ static void __twl4030_phy_power(struct twl4030_usb *twl, int on)
 	WARN_ON(twl4030_usb_write_verify(twl, PHY_PWR_CTRL, pwr) < 0);
 }
 
+static int __maybe_unused twl4030_usb_suspend(struct device *dev)
+{
+	struct twl4030_usb *twl = dev_get_drvdata(dev);
+
+	/*
+	 * we need enabled runtime on resume,
+	 * so turn irq off here, so we do not get it early
+	 * note: wakeup on usb plug works independently of this
+	 */
+	dev_dbg(twl->dev, "%s\n", __func__);
+	disable_irq(twl->irq);
+
+	return 0;
+}
+
+static int __maybe_unused twl4030_usb_resume(struct device *dev)
+{
+	struct twl4030_usb *twl = dev_get_drvdata(dev);
+
+	dev_dbg(twl->dev, "%s\n", __func__);
+	enable_irq(twl->irq);
+	/* check whether cable status changed */
+	twl4030_usb_irq(0, twl);
+
+	return 0;
+}
+
 static int __maybe_unused twl4030_usb_runtime_suspend(struct device *dev)
 {
 	struct twl4030_usb *twl = dev_get_drvdata(dev);
@@ -655,6 +683,7 @@ static const struct phy_ops ops = {
 static const struct dev_pm_ops twl4030_usb_pm_ops = {
 	SET_RUNTIME_PM_OPS(twl4030_usb_runtime_suspend,
 			   twl4030_usb_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(twl4030_usb_suspend, twl4030_usb_resume)
 };
 
 static int twl4030_usb_probe(struct platform_device *pdev)
-- 
2.20.1

