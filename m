Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607FFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C79E2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfH2V0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:26:00 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:36921 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfH2VZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:25:58 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 6458DC0005;
        Thu, 29 Aug 2019 21:25:56 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/5] rtc: pcf8563: add Microcrystal RV8564 compatible
Date:   Thu, 29 Aug 2019 23:25:44 +0200
Message-Id: <20190829212547.19185-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829212547.19185-1-alexandre.belloni@bootlin.com>
References: <20190829212547.19185-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for the Microcrystal RV8564.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/rtc/pcf8563.txt | 4 +++-
 drivers/rtc/rtc-pcf8563.c                         | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/pcf8563.txt b/Documentation/devicetree/bindings/rtc/pcf8563.txt
index cef61675312c..6076fe76dbfa 100644
--- a/Documentation/devicetree/bindings/rtc/pcf8563.txt
+++ b/Documentation/devicetree/bindings/rtc/pcf8563.txt
@@ -3,7 +3,9 @@
 Philips PCF8563/Epson RTC8564 Real Time Clock
 
 Required properties:
-- compatible: Should contain "nxp,pcf8563" or "epson,rtc8564".
+- compatible: Should contain "nxp,pcf8563",
+	"epson,rtc8564" or
+	"microcrystal,rv8564"
 - reg: I2C address for chip.
 
 Optional property:
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index f72ec94acaf5..1b452da75eb8 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -633,6 +633,7 @@ MODULE_DEVICE_TABLE(i2c, pcf8563_id);
 static const struct of_device_id pcf8563_of_match[] = {
 	{ .compatible = "nxp,pcf8563" },
 	{ .compatible = "epson,rtc8564" },
+	{ .compatible = "microcrystal,rv8564" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pcf8563_of_match);
-- 
2.21.0

