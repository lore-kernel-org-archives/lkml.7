Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DB9C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA28207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 20:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfL2UpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 15:45:07 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49227 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfL2UpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 15:45:05 -0500
X-Originating-IP: 92.184.100.83
Received: from localhost (unknown [92.184.100.83])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E5FB6240002;
        Sun, 29 Dec 2019 20:45:02 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Eugen.Hristev@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/9] rtc: at91rm9200: add sama5d4 and sama5d2 compatibles
Date:   Sun, 29 Dec 2019 21:44:15 +0100
Message-Id: <20191229204421.337612-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191229204421.337612-1-alexandre.belloni@bootlin.com>
References: <20191229204421.337612-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the sama5d4 and sama5d2 RTCs have more features than the previous
RTCs, add a compatible string for them.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml       | 2 ++
 drivers/rtc/rtc-at91rm9200.c                                | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
index 55bd87e884d3..0c642e1c855b 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
@@ -17,6 +17,8 @@ properties:
     enum:
       - atmel,at91rm9200-rtc
       - atmel,at91sam9x5-rtc
+      - atmel,sama5d4-rtc
+      - atmel,sama5d2-rtc
 
   reg:
     maxItems: 1
diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 89d91ecd8ccf..bda8e009076f 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -312,6 +312,12 @@ static const struct of_device_id at91_rtc_dt_ids[] = {
 	}, {
 		.compatible = "atmel,at91sam9x5-rtc",
 		.data = &at91sam9x5_config,
+	}, {
+		.compatible = "atmel,sama5d4-rtc",
+		.data = &at91rm9200_config,
+	}, {
+		.compatible = "atmel,sama5d2-rtc",
+		.data = &at91rm9200_config,
 	}, {
 		/* sentinel */
 	}
-- 
2.23.0

