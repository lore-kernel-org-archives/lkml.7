Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F943C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E80C206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBlh1sCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfGaSBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:01:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39340 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfGaSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:01:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so28310079pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KpKMaZxCj3prCeS1ZPMOBghg4R6UQ4TDRU+j0yUbTBg=;
        b=UBlh1sCr3rG6SVjzsTsDo0hidoycdVEiuLordVZFxIusys+7giye9SeSFQs174k6TD
         KlG3+mn9GuRKTmBQHpb3txhSo7E+j3QeBMhN7NbBdk63RfS6XrTiqiYbB0i0CDt2kxgp
         hUAWrcWLyCSBUpeD5wpmswQQlJq1Y3HlMs2xu1lHcELuR1lZFZ/Eb7f4/5xg1vJyT3aN
         yJmZoQFbRTod6ZQov+aJ4I1aZZ1Lq91S7m8X2Vpwu0APBXMhvO2xR0WxgaPxjzQ/SbSD
         aOfaeyIJPM6F7J56j+ZTlnJwiP4xJVaxbvlBu4mYj5zL9o45F9N838Y4KqKLI8TrR2od
         M3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KpKMaZxCj3prCeS1ZPMOBghg4R6UQ4TDRU+j0yUbTBg=;
        b=l/JbBF0aI2XPdWbjRbggdTwpE2HsJs5ySlTv+Ad5wOHX7SAz9kJpWTluvhtS0AszZO
         ijxWjRyKalmNSWroIq6syS5Ioka+RQ0S902T/beK0YorK07A4PZH8BrGhMQ4SZgPXxyy
         qY7UfqLTHWxHcm1pBfhBoEhzBoyktW4xaLuuklYmDGP85ZIWUJwJw2771Fjqs3ZMYktV
         MlaA/2LwPRPvBrnxoBZbpG5lklH4rjfzc/i2DD11D+ST57JzMVvwvKMahXR32F46hOtF
         +hpJcApXqmPYio9+6PtK7d/2zS9QLeHpFSFlm9KI8WrbkSXkWAtDbyWoo2E3PdJU3xx0
         Euhg==
X-Gm-Message-State: APjAAAXee/WBC4ggQ2Rf7+T17KFUbPlruTNQt1H4P6ODr9mzhOt1EXTD
        R3ZxX6eQ7WKdFsL/kP+WnfFeQRqy
X-Google-Smtp-Source: APXvYqye8pRiT4OLmGQ49v9XCAzTGn6IwpMK8l+7uH/1/MuE4yUSSO3uCy+BPB+6ONXP5nPcrdT/8Q==
X-Received: by 2002:a17:90a:2486:: with SMTP id i6mr4082885pje.125.1564596104666;
        Wed, 31 Jul 2019 11:01:44 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id g92sm7328677pje.11.2019.07.31.11.01.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 11:01:43 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: Drop imx_anatop_init()
Date:   Wed, 31 Jul 2019 11:01:31 -0700
Message-Id: <20190731180131.8597-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit b5bbe2235361 ("usb: phy: mxs: Disable external charger
detect in mxs_phy_hw_init()") in tree all of the necessary charger
setup is done by the USB PHY driver which covers all of the affected
i.MX6 SoCs.

NOTE: Imx_anatop_init() was also called for i.MX7D, but looking at its
datasheet it appears to have a different USB PHY IP block, so
executing i.MX6 charger disable configuration seems unnecessary.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peter Chen <peter.chen@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/mach-imx/anatop.c      | 25 -------------------------
 arch/arm/mach-imx/common.h      |  1 -
 arch/arm/mach-imx/mach-imx6q.c  |  1 -
 arch/arm/mach-imx/mach-imx6sl.c |  1 -
 arch/arm/mach-imx/mach-imx6sx.c |  1 -
 arch/arm/mach-imx/mach-imx6ul.c |  1 -
 arch/arm/mach-imx/mach-imx7d.c  |  1 -
 7 files changed, 31 deletions(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 777d8c255501..f2c9fe14198a 100644
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
@@ -167,14 +153,3 @@ void __init imx_init_revision_from_anatop(void)
 	mxc_set_cpu_type(digprog >> 16 & 0xff);
 	imx_set_soc_revision(revision);
 }
-
-void __init imx_anatop_init(void)
-{
-	anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
-	if (IS_ERR(anatop)) {
-		pr_err("%s: failed to find imx6q-anatop regmap!\n", __func__);
-		return;
-	}
-
-	imx_anatop_usb_chrg_detect_disable();
-}
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 912aeceb4ff8..debeda48fb98 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -96,7 +96,6 @@ void imx_gpc_mask_all(void);
 void imx_gpc_restore_all(void);
 void imx_gpc_hwirq_mask(unsigned int hwirq);
 void imx_gpc_hwirq_unmask(unsigned int hwirq);
-void imx_anatop_init(void);
 void imx_anatop_pre_suspend(void);
 void imx_anatop_post_resume(void);
 int imx6_set_lpm(enum mxc_cpu_pwr_mode mode);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index edd26e0ffeec..b4c2b99192c5 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -274,7 +274,6 @@ static void __init imx6q_init_machine(void)
 
 	of_platform_default_populate(NULL, NULL, parent);
 
-	imx_anatop_init();
 	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
 	imx6q_1588_init();
 	imx6q_axi_init();
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index e00818abe54d..1f3092be03fd 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -56,7 +56,6 @@ static void __init imx6sl_init_machine(void)
 
 	if (cpu_is_imx6sl())
 		imx6sl_fec_init();
-	imx_anatop_init();
 	imx6sl_pm_init();
 }
 
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index d5310bf307ff..0f93c2e023c3 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -72,7 +72,6 @@ static void __init imx6sx_init_machine(void)
 	of_platform_default_populate(NULL, NULL, parent);
 
 	imx6sx_enet_init();
-	imx_anatop_init();
 	imx6sx_pm_init();
 }
 
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 311f5e4ff723..d063e3b6e5da 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -64,7 +64,6 @@ static void __init imx6ul_init_machine(void)
 
 	of_platform_default_populate(NULL, NULL, parent);
 	imx6ul_enet_init();
-	imx_anatop_init();
 	imx6ul_pm_init();
 }
 
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index 95713450591a..dede6004bfc8 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -90,7 +90,6 @@ static void __init imx7d_init_machine(void)
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
 
-	imx_anatop_init();
 	imx7d_enet_init();
 }
 
-- 
2.21.0

