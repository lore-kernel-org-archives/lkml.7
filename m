Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02595C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA26420645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfDSTAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:00:01 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:37320 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfDSS77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:59:59 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 9F4433A8D56;
        Fri, 19 Apr 2019 08:00:22 +0000 (UTC)
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C0335FF809;
        Fri, 19 Apr 2019 08:00:21 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 8/8] rtc: ep93xx: fix checkpatch issues
Date:   Fri, 19 Apr 2019 10:00:05 +0200
Message-Id: <20190419080005.16138-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419080005.16138-1-alexandre.belloni@bootlin.com>
References: <20190419080005.16138-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sysfs attribute declaration as suggested by checkpatch.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ep93xx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index 8dd85d602afd..1766496385fe 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -15,10 +15,10 @@
 #define EP93XX_RTC_DATA			0x000
 #define EP93XX_RTC_MATCH		0x004
 #define EP93XX_RTC_STATUS		0x008
-#define  EP93XX_RTC_STATUS_INTR		 (1<<0)
+#define  EP93XX_RTC_STATUS_INTR		 BIT(0)
 #define EP93XX_RTC_LOAD			0x00C
 #define EP93XX_RTC_CONTROL		0x010
-#define  EP93XX_RTC_CONTROL_MIE		 (1<<0)
+#define  EP93XX_RTC_CONTROL_MIE		 BIT(0)
 #define EP93XX_RTC_SWCOMP		0x108
 #define  EP93XX_RTC_SWCOMP_DEL_MASK	 0x001f0000
 #define  EP93XX_RTC_SWCOMP_DEL_SHIFT	 16
@@ -31,7 +31,7 @@ struct ep93xx_rtc {
 };
 
 static int ep93xx_rtc_get_swcomp(struct device *dev, unsigned short *preload,
-				unsigned short *delete)
+				 unsigned short *delete)
 {
 	struct ep93xx_rtc *ep93xx_rtc = dev_get_platdata(dev);
 	unsigned long comp;
@@ -87,8 +87,8 @@ static const struct rtc_class_ops ep93xx_rtc_ops = {
 	.proc		= ep93xx_rtc_proc,
 };
 
-static ssize_t ep93xx_rtc_show_comp_preload(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t comp_preload_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	unsigned short preload;
 
@@ -96,10 +96,10 @@ static ssize_t ep93xx_rtc_show_comp_preload(struct device *dev,
 
 	return sprintf(buf, "%d\n", preload);
 }
-static DEVICE_ATTR(comp_preload, S_IRUGO, ep93xx_rtc_show_comp_preload, NULL);
+static DEVICE_ATTR_RO(comp_preload);
 
-static ssize_t ep93xx_rtc_show_comp_delete(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t comp_delete_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	unsigned short delete;
 
@@ -107,7 +107,7 @@ static ssize_t ep93xx_rtc_show_comp_delete(struct device *dev,
 
 	return sprintf(buf, "%d\n", delete);
 }
-static DEVICE_ATTR(comp_delete, S_IRUGO, ep93xx_rtc_show_comp_delete, NULL);
+static DEVICE_ATTR_RO(comp_delete);
 
 static struct attribute *ep93xx_rtc_attrs[] = {
 	&dev_attr_comp_preload.attr,
-- 
2.20.1

