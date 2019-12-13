Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0552EC3401C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4356D246B8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfLMPFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:05:43 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:49399 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfLMPFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:05:42 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ykhAAAECZnCZI8E2zOBJM46BZ6YwE0O/ABx5F/zDT9K2pj/dxCUQ+de86uNjHDFl7l9DwpoaHw
 VDzc8gcZ0LF5Iwf2EGeBRG0ZLnT0VRRo5JgSfaizZu2byI/yyjSHmTgRmNH6rkeicAyp+5vMiY
 1AXO5SCjRxyCuLWggAqcMePO1ocyhuauSs/EJMw1Ky9A6pd2OffkSwuLCh3fRRZvKoBNo5aOOX
 jZF8qy9H2U4Vg7KbmfArlYRY/beDIMmSF+nlP0sPPrS6Ume91tMGfExkTHycDEfheckai5gh5L
 OI4=
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="59718112"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2019 08:05:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Dec 2019 08:05:25 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 13 Dec 2019 08:05:21 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <sam@ravnborg.org>, <bbrezillon@kernel.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <lee.jones@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 4/6] mfd: atmel-hlcdc: return in case of error
Date:   Fri, 13 Dec 2019 17:04:54 +0200
Message-ID: <1576249496-4849-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576249496-4849-1-git-send-email-claudiu.beznea@microchip.com>
References: <1576249496-4849-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For HLCDC timing engine configurations bit ATMEL_HLCDC_SIP of
ATMEL_HLCDC_SR needs to be polled before applying new config. In case of
timeout there is no indicator about this, so, return in case of timeout
and also print a message about this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mfd/atmel-hlcdc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index 92bfcaa62ace..a1e46c87b956 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -40,10 +40,17 @@ static int regmap_atmel_hlcdc_reg_write(void *context, unsigned int reg,
 
 	if (reg <= ATMEL_HLCDC_DIS) {
 		u32 status;
-
-		readl_poll_timeout_atomic(hregmap->regs + ATMEL_HLCDC_SR,
-					  status, !(status & ATMEL_HLCDC_SIP),
-					  1, 100);
+		int ret;
+
+		ret = readl_poll_timeout_atomic(hregmap->regs + ATMEL_HLCDC_SR,
+						status,
+						!(status & ATMEL_HLCDC_SIP),
+						1, 100);
+		if (ret) {
+			dev_err(hregmap->dev,
+				"Timeout waiting for ATMEL_HLCDC_SIP\n");
+			return ret;
+		}
 	}
 
 	writel(val, hregmap->regs + reg);
-- 
2.7.4

