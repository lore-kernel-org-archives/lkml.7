Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C706FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996AA218BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141969;
	bh=XSc49gLZDnT5iD6+dqt3KN9TjzN4HO4lpDf5yK9KBYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mRLmV45rBoiMyO1BLgnbTVb+s5U7mG38QMp2RyFj0Bqq4v5gQGzzeCktheJj1lhRo
	 kEZjc/QZ72JRDz8tWXmiXZHiOAJD4ZRQXnsUB7oLrWWCPYuUNXCdEbkZ3ce8x93/Fa
	 5axRBL4cGIJoVXEoZULYeDgAA9efF9Wi4iKW4BXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfKSFj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:39:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730285AbfKSFjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:39:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 990D4222A4;
        Tue, 19 Nov 2019 05:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141965;
        bh=XSc49gLZDnT5iD6+dqt3KN9TjzN4HO4lpDf5yK9KBYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JafbXqatE0id5CSEfexJwY3UVkQvSVhHA5c7BnDLY7Ke/VZUlcPwhgaC+HOWp1xca
         9h7uGv+ZL2M10m9D0n2pniuRZTstUKjEQSDIXTEPBINCwjIpjtcN6Isc6tvNTBHsW3
         91hroJqv2GQVMIpE0czBZIPT6BIkO55/owhAX8B8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 340/422] phy: phy-twl4030-usb: fix denied runtime access
Date:   Tue, 19 Nov 2019 06:18:57 +0100
Message-Id: <20191119051421.048533050@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



