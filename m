Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02B42064A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfCSQhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:37:04 -0400
Received: from sauhun.de ([88.99.104.3]:46138 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbfCSQgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:36:40 -0400
Received: from localhost (p5486CE21.dip0.t-ipconnect.de [84.134.206.33])
        by pokefinder.org (Postfix) with ESMTPSA id 200254A134E;
        Tue, 19 Mar 2019 17:36:38 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH 1/1] spi: mxic: simplify getting .driver_data
Date:   Tue, 19 Mar 2019 17:36:37 +0100
Message-Id: <20190319163637.30949-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/spi/spi-mxic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index e41ae6ef0f8a..f48563c09b97 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -492,8 +492,7 @@ static int mxic_spi_transfer_one(struct spi_master *master,
 
 static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct mxic_spi *mxic = spi_master_get_devdata(master);
 
 	mxic_spi_clk_disable(mxic);
@@ -504,8 +503,7 @@ static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
 
 static int __maybe_unused mxic_spi_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct mxic_spi *mxic = spi_master_get_devdata(master);
 	int ret;
 
-- 
2.11.0

