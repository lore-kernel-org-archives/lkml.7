Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C1CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39F5214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZEVW2RS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfJVEOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 00:14:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32864 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJVEOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 00:14:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id i76so9139341pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 21:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rs9LAlJ/Mb8c9Q5mqnJ0h++sIssMn8kGp7hyQlxdI80=;
        b=QZEVW2RSSdkh1WJhJ+2zM6gvI5OM1zukP2RcEMAPrk+gYXdCshBt6eo69Xdgf3piwH
         2jsrvgUWf8cb/5otO7cLp0OZTGHxclN0W7hqZny+giRNR8fylKD+GerxqjcUfDHD2lG2
         0KEw2YMYwQxe0KdAWRk8BFnaKDfT6Y4Mi/ezDoYAsR2aM80Bu/w8isG2AaVlXU5mmZZi
         ZsbERCij07rF7+9yS69wVKkOmNcbWkmFlmMwOqEO0p+lgpHQoaJBcTEvA3l4FlUVr5em
         877NV13qWH29BIhewCk+S4alQLXyTiejyaeVxvRhyP2IOZ4F9mgRTLfTePWYZ1dO2ZV+
         Z9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rs9LAlJ/Mb8c9Q5mqnJ0h++sIssMn8kGp7hyQlxdI80=;
        b=SWEReylUAQmA1wUmEr1BB8h4gQdVVjThVOb9qoGaFEYLWQv1K0xqs4xlRvx+uKN+cz
         7SurrV7u34PwT/8pwcnGdLSIf245sASAi+dzIRV+tzbJDrA6b9soEekmTtBkNA/Dw6YG
         CLm9F39FZI2/FozJ8QKw72LEcSHZINiFCQduBSTf0hwL1MzhwCh2daE2+xWKQK+UybJO
         jgudE3Xhxybq/rysHg0XogVYCK/V3X+vv1xxAUAaeap8sfvN6Lli5eRbzFjWJkx3+bl8
         FdUuVsyhOV8c48Jrk4B4261O5pA9w6ypDETLBuIyw1ZJg5HEi3l5vZJe1OFf7uG3yP5Z
         O6Nw==
X-Gm-Message-State: APjAAAWEj1Z+kE3OIh2X3+x/GDQZ1QIA11gX1XVPEx54MgZhGzSTOHJ/
        bOIHVen+ZSX5SZm3PsC3BDg=
X-Google-Smtp-Source: APXvYqxuxUG7glI4cNP3QMXePzxvwJJd44e9KiYRq8sAvVisFJ5DBx1aafSGvsKs5wZCfJW9UfCxWA==
X-Received: by 2002:a62:1c96:: with SMTP id c144mr278831pfc.219.1571717689798;
        Mon, 21 Oct 2019 21:14:49 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id b3sm15042191pjp.13.2019.10.21.21.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 21:14:48 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: imx: Drop imx_anatop_usb_chrg_detect_disable()
Date:   Mon, 21 Oct 2019 21:14:45 -0700
Message-Id: <20191022041445.23897-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit b5bbe2235361 ("usb: phy: mxs: Disable external charger
detect in mxs_phy_hw_init()") in tree all of the necessary charger
setup is done by the USB PHY driver which covers all of the affected
i.MX6 SoCs.

NOTE: imx_anatop_usb_chrg_detect_disable() was also called for i.MX7D,
but looking at its datasheet it appears to have a different USB PHY IP
block, so executing i.MX6 charger disable configuration seems
unnecessary.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peter Chen <peter.chen@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v1]:

    - Scope of the patch reduced to remove only
      imx_anatop_usb_chrg_detect_disable() instead of
      imx_anatop_init()

[v1] lore.kernel.org/lkml/20190731180131.8597-1-andrew.smirnov@gmail.com

 arch/arm/mach-imx/anatop.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 777d8c255501..8fb68c0ec34c 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -19,8 +19,6 @@
 #define ANADIG_REG_2P5		0x130
 #define ANADIG_REG_CORE		0x140
 #define ANADIG_ANA_MISC0	0x150
-#define ANADIG_USB1_CHRG_DETECT	0x1b0
-#define ANADIG_USB2_CHRG_DETECT	0x210
 #define ANADIG_DIGPROG		0x260
 #define ANADIG_DIGPROG_IMX6SL	0x280
 #define ANADIG_DIGPROG_IMX7D	0x800
@@ -33,8 +31,6 @@
 #define BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG	0x1000
 /* Below MISC0_DISCON_HIGH_SNVS is only for i.MX6SL */
 #define BM_ANADIG_ANA_MISC0_DISCON_HIGH_SNVS	0x2000
-#define BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B	0x80000
-#define BM_ANADIG_USB_CHRG_DETECT_EN_B		0x100000
 
 static struct regmap *anatop;
 
@@ -96,16 +92,6 @@ void imx_anatop_post_resume(void)
 
 }
 
-static void imx_anatop_usb_chrg_detect_disable(void)
-{
-	regmap_write(anatop, ANADIG_USB1_CHRG_DETECT,
-		BM_ANADIG_USB_CHRG_DETECT_EN_B
-		| BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B);
-	regmap_write(anatop, ANADIG_USB2_CHRG_DETECT,
-		BM_ANADIG_USB_CHRG_DETECT_EN_B |
-		BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B);
-}
-
 void __init imx_init_revision_from_anatop(void)
 {
 	struct device_node *np;
@@ -171,10 +157,6 @@ void __init imx_init_revision_from_anatop(void)
 void __init imx_anatop_init(void)
 {
 	anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
-	if (IS_ERR(anatop)) {
+	if (IS_ERR(anatop))
 		pr_err("%s: failed to find imx6q-anatop regmap!\n", __func__);
-		return;
-	}
-
-	imx_anatop_usb_chrg_detect_disable();
 }
-- 
2.21.0

