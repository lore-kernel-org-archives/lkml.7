Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB470C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E1A2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfLJNZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:25:11 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:2002 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfLJNZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:25:08 -0500
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
IronPort-SDR: hnRNOKiQG+WcQ2REtTRs0HF9PluczubB0dOz2SJEh6gMvibIra3FXVMK32FY8x4RR/L9l0qrLj
 WMBhNKk5d+h+TNUTmQ2wbVaTKRNlW8mrLYGEWVyND67jCb0r8lzOwCrBbPn5DJrTedKEGRtdgp
 AC+z0XS7OAJQeYBvX8xhKvD6ISPCfr0uPhMQhN78FKoulyew8XbmHkP7J75Jd9H/5Eae1VLaJZ
 lsMOanVYgXEBfqPZ+6tq434rMlH4AX5nkiEPpBvWSMEF5F8wu+QCvZmEoEg0P6NqnAQQrLIYVz
 /so=
X-IronPort-AV: E=Sophos;i="5.69,299,1571727600"; 
   d="scan'208";a="59325118"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2019 06:25:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Dec 2019 06:25:06 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 10 Dec 2019 06:25:08 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <sam@ravnborg.org>, <bbrezillon@kernel.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <lee.jones@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/5] mfd: atmel-hlcdc: return in case of error
Date:   Tue, 10 Dec 2019 15:24:45 +0200
Message-ID: <1575984287-26787-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
References: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For HLCDC timing engine configurations bit ATMEL_HLCDC_SIP of
ATMEL_HLCDC_SR needs to checked if it is equal with zero before applying
new configuration to timing engine. In case of timeout there is no
indicator about this, so, return with error in case of timeout in
regmap_atmel_hlcdc_reg_write() and also print a message about this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mfd/atmel-hlcdc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index 64013c57a920..19f1dbeb8bcd 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -39,10 +39,16 @@ static int regmap_atmel_hlcdc_reg_write(void *context, unsigned int reg,
 
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
+			pr_err("Timeout waiting for ATMEL_HLCDC_SIP\n");
+			return ret;
+		}
 	}
 
 	writel(val, hregmap->regs + reg);
-- 
2.7.4

