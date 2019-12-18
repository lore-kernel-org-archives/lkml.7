Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F49C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9234C21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLRM2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:28:51 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:44118 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfLRM2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:28:48 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 3T3KoRmV9Py30sZPTGEDgjAKtwTDSgm7SAz7UQP8GZQSxk3GxrpdcrK/C+j1je6uuhMUdz6OKG
 1ICPttIlHldLWudaJYckOz2hzh0NnH150DzQ5KQbUwF1chd97jIO5y5aCZPaVjqMB8Apf7uxoS
 32YDP/FHy9keakW+bZsYb9YGLhQnZsWb6gcTtSj0UkQxlhVeXHuVzOjCRuQdKQ1OcUo3XwdOWc
 2KbrzomS+hhbeMSQxSfaWmVsnGHHq6pZKaFWckjM0I5r2w6FkT6nIvt2cDIujswuIJfSH/qw3J
 mwA=
X-IronPort-AV: E=Sophos;i="5.69,329,1571727600"; 
   d="scan'208";a="62156189"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 05:28:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 05:28:46 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 18 Dec 2019 05:28:44 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <boris.brezillon@bootlin.com>, <airlied@linux.ie>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <lee.jones@linaro.org>, <sam@ravnborg.org>
CC:     <peda@axentia.se>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 4/6] mfd: atmel-hlcdc: return in case of error
Date:   Wed, 18 Dec 2019 14:28:27 +0200
Message-ID: <1576672109-22707-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
References: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
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
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
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
+				"Timeout! Clock domain synchronization is in progress!\n");
+			return ret;
+		}
 	}
 
 	writel(val, hregmap->regs + reg);
-- 
2.7.4

