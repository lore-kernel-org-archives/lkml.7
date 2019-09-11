Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E48ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EBA21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfIKGm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 02:42:29 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:20595 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfIKGm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:42:28 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: kKMjRAAZRfQP8ldFMWZ9rtRtaBtbyAKdH6+ji7vxUAGWqspR4W0LQVw1FNe6++Emca5ZQRIuBL
 fP0kUXqUOfsjD6jhiTwEDe0SI33wiIUCFUQN44mExXFbS7zXhkWhRaygm9v1j3n6jrQljaZzJ7
 9WlKKHpRp46oJAynHh9eINzGxK/W3yO7m9Ce/cyZEkKcnyLFNzehSTnfurb1HQyPYgVN5LyL/u
 xe4YU8NOJNrtD/b2C8sDqUQOH3Oh7H/FhStkS4zB/hov1tHNbCAFo5XLFT0JQ5Yp0NveeUAhRA
 Z6w=
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="47503534"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2019 23:42:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Sep 2019 23:42:27 -0700
Received: from tenerife.corp.atmel.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 10 Sep 2019 23:42:26 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <Boris.Krasnovskiy@lairdconnect.com>, <linux-usb@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 1/3] USB: host: ohci-at91: completely shutdown the controller in at91_stop_hc()
Date:   Wed, 11 Sep 2019 08:41:52 +0200
Message-ID: <20190911064154.28633-2-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190911064154.28633-1-nicolas.ferre@microchip.com>
References: <20190911064154.28633-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Krasnovskiy <Boris.Krasnovskiy@lairdconnect.com>

When removing the ohci-at91 module, the fact of not running complete shutdown
of all the ports was keeping additional analog cells consuming power for no
reason.
Doing Reset (OHCI_HCR) to HcCommandStatus register is the way to go, but using
the OHCI controller shutdown procedure is just perfect for this.

Signed-off-by: Boris Krasnovskiy <Boris.Krasnovskiy@lairdconnect.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/usb/host/ohci-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index fc35a7993b7b..cb63bcd5049a 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -123,7 +123,7 @@ static void at91_stop_hc(struct platform_device *pdev)
 	/*
 	 * Put the USB host controller into reset.
 	 */
-	writel(0, &regs->control);
+	usb_hcd_platform_shutdown(pdev);
 
 	/*
 	 * Stop the USB clocks.
-- 
2.17.1

