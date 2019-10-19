Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4713CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 20:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E673222C5
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 20:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfJSUts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 16:49:48 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:42437 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfJSUtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 16:49:47 -0400
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 0F1A1240004;
        Sat, 19 Oct 2019 20:49:45 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6/9] rtc: ds1343: check regmap_read return value
Date:   Sat, 19 Oct 2019 22:49:38 +0200
Message-Id: <20191019204941.6203-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019204941.6203-1-alexandre.belloni@bootlin.com>
References: <20191019204941.6203-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check whether regmap_read fails before continuing in the sysfs .show
callbacks.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1343.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index 7532a2e8407e..c96a505972e6 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -92,8 +92,11 @@ static ssize_t ds1343_show_glitchfilter(struct device *dev,
 {
 	struct ds1343_priv *priv = dev_get_drvdata(dev->parent);
 	int glitch_filt_status, data;
+	int res;
 
-	regmap_read(priv->map, DS1343_CONTROL_REG, &data);
+	res = regmap_read(priv->map, DS1343_CONTROL_REG, &data);
+	if (res)
+		return res;
 
 	glitch_filt_status = !!(data & DS1343_EGFIL);
 
@@ -147,10 +150,12 @@ static ssize_t ds1343_show_tricklecharger(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct ds1343_priv *priv = dev_get_drvdata(dev->parent);
-	int data;
+	int res, data;
 	char *diodes = "disabled", *resistors = " ";
 
-	regmap_read(priv->map, DS1343_TRICKLE_REG, &data);
+	res = regmap_read(priv->map, DS1343_TRICKLE_REG, &data);
+	if (res)
+		return res;
 
 	if ((data & 0xf0) == DS1343_TRICKLE_MAGIC) {
 		switch (data & 0x0c) {
-- 
2.21.0

