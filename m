Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD9AC3401A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA64246D0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfLMPFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:05:18 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:27581 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfLMPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:05:17 -0500
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
IronPort-SDR: gtmPn2XNJzW7sD0TANvArFiV5PPQvV+eQVVKGffOVJrke1qLCFR75hUDHij1cH2bmDLCnyKpJs
 xJbHyLnT+1lLXzZA+nOQw3v4MeQuQg9ibC7+aOFkoCd/iJoA78xOd65Znd3DZIU2XUCfKV/RB/
 qT4c7ui0pBTbudnhhyJF7O6tSuXA3VhPK6iUPvxtm8ARH2DBO3K3ZDsoRKYKmD2sxuiFtkAoy9
 AZWZ+fh/W9oV6hrSKvxuslX8Ryd0kWd5TOKiVj5aOjNgZOcD/0U6L/u8LP5ndQe7XB7TIzRnfM
 Dcs=
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="61646979"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2019 08:05:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Dec 2019 08:05:15 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 13 Dec 2019 08:05:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <sam@ravnborg.org>, <bbrezillon@kernel.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <lee.jones@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/6] drm: atmel-hlcdc: enable clock before configuring timing engine
Date:   Fri, 13 Dec 2019 17:04:52 +0200
Message-ID: <1576249496-4849-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576249496-4849-1-git-send-email-claudiu.beznea@microchip.com>
References: <1576249496-4849-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing pixel clock source without having this clock source enabled
will block the timing engine and the next operations after (in this case
setting ATMEL_HLCDC_CFG(5) settings in atmel_hlcdc_crtc_mode_set_nofb()
will fail). It is recomended (although in datasheet this is not present)
to actually enabled pixel clock source before doing any changes on timing
enginge (only SAM9X60 datasheet specifies that the peripheral clock and
pixel clock must be enabled before using LCD controller).

Fixes: 1a396789f65a ("drm: add Atmel HLCDC Display Controller support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 5040ed8d0871..721fa88bf71d 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -73,7 +73,11 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 	unsigned long prate;
 	unsigned int mask = ATMEL_HLCDC_CLKDIV_MASK | ATMEL_HLCDC_CLKPOL;
 	unsigned int cfg = 0;
-	int div;
+	int div, ret;
+
+	ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
+	if (ret)
+		return;
 
 	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
 	vm.vback_porch = adj->crtc_vtotal - adj->crtc_vsync_end;
@@ -147,6 +151,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 			   ATMEL_HLCDC_VSPSU | ATMEL_HLCDC_VSPHO |
 			   ATMEL_HLCDC_GUARDTIME_MASK | ATMEL_HLCDC_MODE_MASK,
 			   cfg);
+
+	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
 }
 
 static enum drm_mode_status
-- 
2.7.4

