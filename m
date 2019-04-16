Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C37C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E8B2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfDPIey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:34:54 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:45219 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbfDPIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:34:50 -0400
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3DA93240005;
        Tue, 16 Apr 2019 08:34:48 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/5] rtc: imxdi: use .set_time
Date:   Tue, 16 Apr 2019 10:34:30 +0200
Message-Id: <20190416083432.14483-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416083432.14483-1-alexandre.belloni@bootlin.com>
References: <20190416083432.14483-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .set_time instead of the deprecated .set_mmss.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-imxdi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 8a7ad1502e4f..254bc894105b 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -561,7 +561,7 @@ static int dryice_rtc_read_time(struct device *dev, struct rtc_time *tm)
  * set the seconds portion of dryice time counter and clear the
  * fractional part.
  */
-static int dryice_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int dryice_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
 	u32 dcr, dsr;
@@ -588,7 +588,7 @@ static int dryice_rtc_set_mmss(struct device *dev, unsigned long secs)
 	if (rc != 0)
 		return rc;
 
-	rc = di_write_wait(imxdi, secs, DTCMR);
+	rc = di_write_wait(imxdi, rtc_tm_to_time64(tm), DTCMR);
 	if (rc != 0)
 		return rc;
 
@@ -666,7 +666,7 @@ static int dryice_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 static const struct rtc_class_ops dryice_rtc_ops = {
 	.read_time		= dryice_rtc_read_time,
-	.set_mmss		= dryice_rtc_set_mmss,
+	.set_time		= dryice_rtc_set_time,
 	.alarm_irq_enable	= dryice_rtc_alarm_irq_enable,
 	.read_alarm		= dryice_rtc_read_alarm,
 	.set_alarm		= dryice_rtc_set_alarm,
-- 
2.20.1

