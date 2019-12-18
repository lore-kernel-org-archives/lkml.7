Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F318C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF6521582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfLRM2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:28:47 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:44118 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfLRM2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:28:45 -0500
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
IronPort-SDR: pYkUasD8xQa4jYl5/A4AC1B0RcMipD5T6P7Ws6rULLLzunqgBX0cHB401B/mZCeEu/1GTzoOAb
 fq8xeZVqOIlOURGaIbSapCpARCzMFiJJ8eCHWPs3iaVDyG/xwYijTcJe+F7GOUsRte/+ZobAiP
 G5kl9/3Yc7+WPBRjESW3+eX+CYHhiRtANiyUqxBSTCQdoFLKvxRYWuptZOenLh/aD63JV9l05k
 1DTopQdcYIMPyfb2R2mLL9J9oh5niSB8C/0KSHIelJywW3najGjEsZswg3kPGwc+yD/ioLqpI6
 z/g=
X-IronPort-AV: E=Sophos;i="5.69,329,1571727600"; 
   d="scan'208";a="62156186"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 05:28:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 05:28:42 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 18 Dec 2019 05:28:41 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <boris.brezillon@bootlin.com>, <airlied@linux.ie>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <lee.jones@linaro.org>, <sam@ravnborg.org>
CC:     <peda@axentia.se>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 3/6] mfd: atmel-hlcdc: add struct device member to struct atmel_hlcdc_regmap
Date:   Wed, 18 Dec 2019 14:28:26 +0200
Message-ID: <1576672109-22707-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
References: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add struct device member to struct atmel_hlcdc_regmap to be
able to use dev_*() specific logging functions.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/atmel-hlcdc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index 64013c57a920..92bfcaa62ace 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -19,6 +19,7 @@
 
 struct atmel_hlcdc_regmap {
 	void __iomem *regs;
+	struct device *dev;
 };
 
 static const struct mfd_cell atmel_hlcdc_cells[] = {
@@ -90,6 +91,8 @@ static int atmel_hlcdc_probe(struct platform_device *pdev)
 	if (IS_ERR(hregmap->regs))
 		return PTR_ERR(hregmap->regs);
 
+	hregmap->dev = &pdev->dev;
+
 	hlcdc->irq = platform_get_irq(pdev, 0);
 	if (hlcdc->irq < 0)
 		return hlcdc->irq;
-- 
2.7.4

