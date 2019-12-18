Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83BAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D5524650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfLRM2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:28:39 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:6265 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfLRM2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:28:39 -0500
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
IronPort-SDR: iwa+LFGDEj2VHhKMiirVOph9liCldbkNPs3a2DdYrgytvFbPh4YLPT4L/u0zdSYqk+PC4UnATC
 9Jqe9z/vk7PxLqEC75pzXK9Okax4Hm1487vaK7W60DqwadiKzTAfFcGQLrN6geXR8B47CRsxgh
 9EAu9fR5WLOeChwzIMIITWd1fY/92Y/P5ZRUGUeiQ32vb8xbFslFq6/aNQ0wR8vpGf6jprH3b5
 WkSSyD6uJ289KBf0fkGN038itl4DaDqPGKNtmThBMjsRdNwuYZRPT8TQW2F3UooKmKheP2GJFI
 0WU=
X-IronPort-AV: E=Sophos;i="5.69,329,1571727600"; 
   d="scan'208";a="60203831"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 05:28:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 05:28:37 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 18 Dec 2019 05:28:34 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <boris.brezillon@bootlin.com>, <airlied@linux.ie>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <lee.jones@linaro.org>, <sam@ravnborg.org>
CC:     <peda@axentia.se>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 1/6] drm: atmel-hlcdc: use double rate for pixel clock only if supported
Date:   Wed, 18 Dec 2019 14:28:24 +0200
Message-ID: <1576672109-22707-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
References: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doubled system clock should be used as pixel cock source only if this
is supported. This is emphasized by the value of
atmel_hlcdc_crtc::dc::desc::fixed_clksrc.

Fixes: a6eca2abdd42 ("drm: atmel-hlcdc: add config option for clock selection")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index f2e73e6d46b8..5040ed8d0871 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -95,14 +95,14 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 		     (adj->crtc_hdisplay - 1) |
 		     ((adj->crtc_vdisplay - 1) << 16));
 
+	prate = clk_get_rate(crtc->dc->hlcdc->sys_clk);
+	mode_rate = adj->crtc_clock * 1000;
 	if (!crtc->dc->desc->fixed_clksrc) {
+		prate *= 2;
 		cfg |= ATMEL_HLCDC_CLKSEL;
 		mask |= ATMEL_HLCDC_CLKSEL;
 	}
 
-	prate = 2 * clk_get_rate(crtc->dc->hlcdc->sys_clk);
-	mode_rate = adj->crtc_clock * 1000;
-
 	div = DIV_ROUND_UP(prate, mode_rate);
 	if (div < 2) {
 		div = 2;
-- 
2.7.4

