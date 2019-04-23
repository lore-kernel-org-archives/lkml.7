Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BA2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6155F21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfDWHlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:41:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbfDWHkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4F0C7C361AD2AF2CF9F5;
        Tue, 23 Apr 2019 15:40:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:11 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH next 16/25] mfd: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:50:11 +0800
Message-ID: <20190423075020.173734-17-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_get_drvdata directly.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/mfd/ssbi.c     |  2 +-
 drivers/mfd/t7l66xb.c  | 12 ++++--------
 drivers/mfd/tc6387xb.c | 12 ++++--------
 drivers/mfd/tc6393xb.c | 21 +++++++--------------
 4 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/mfd/ssbi.c b/drivers/mfd/ssbi.c
index 36b96fee4ce6..50f87d0f9151 100644
--- a/drivers/mfd/ssbi.c
+++ b/drivers/mfd/ssbi.c
@@ -80,7 +80,7 @@ struct ssbi {
 	int (*write)(struct ssbi *, u16 addr, const u8 *buf, int len);
 };
 
-#define to_ssbi(dev)	platform_get_drvdata(to_platform_device(dev))
+#define to_ssbi(dev)	dev_get_drvdata(dev)
 
 static inline u32 ssbi_readl(struct ssbi *ssbi, u32 reg)
 {
diff --git a/drivers/mfd/t7l66xb.c b/drivers/mfd/t7l66xb.c
index 43d8683266de..e9cfb147345e 100644
--- a/drivers/mfd/t7l66xb.c
+++ b/drivers/mfd/t7l66xb.c
@@ -82,8 +82,7 @@ struct t7l66xb {
 
 static int t7l66xb_mmc_enable(struct platform_device *mmc)
 {
-	struct platform_device *dev = to_platform_device(mmc->dev.parent);
-	struct t7l66xb *t7l66xb = platform_get_drvdata(dev);
+	struct t7l66xb *t7l66xb = dev_get_drvdata(mmc->dev.parent);
 	unsigned long flags;
 	u8 dev_ctl;
 	int ret;
@@ -108,8 +107,7 @@ static int t7l66xb_mmc_enable(struct platform_device *mmc)
 
 static int t7l66xb_mmc_disable(struct platform_device *mmc)
 {
-	struct platform_device *dev = to_platform_device(mmc->dev.parent);
-	struct t7l66xb *t7l66xb = platform_get_drvdata(dev);
+	struct t7l66xb *t7l66xb = dev_get_drvdata(mmc->dev.parent);
 	unsigned long flags;
 	u8 dev_ctl;
 
@@ -128,16 +126,14 @@ static int t7l66xb_mmc_disable(struct platform_device *mmc)
 
 static void t7l66xb_mmc_pwr(struct platform_device *mmc, int state)
 {
-	struct platform_device *dev = to_platform_device(mmc->dev.parent);
-	struct t7l66xb *t7l66xb = platform_get_drvdata(dev);
+	struct t7l66xb *t7l66xb = dev_get_drvdata(mmc->dev.parent);
 
 	tmio_core_mmc_pwr(t7l66xb->scr + 0x200, 0, state);
 }
 
 static void t7l66xb_mmc_clk_div(struct platform_device *mmc, int state)
 {
-	struct platform_device *dev = to_platform_device(mmc->dev.parent);
-	struct t7l66xb *t7l66xb = platform_get_drvdata(dev);
+	struct t7l66xb *t7l66xb = dev_get_drvdata(mmc->dev.parent);
 
 	tmio_core_mmc_clk_div(t7l66xb->scr + 0x200, 0, state);
 }
diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
index 85fab3729102..f417c6fecfe2 100644
--- a/drivers/mfd/tc6387xb.c
+++ b/drivers/mfd/tc6387xb.c
@@ -80,16 +80,14 @@ static int tc6387xb_resume(struct platform_device *dev)
 
 static void tc6387xb_mmc_pwr(struct platform_device *mmc, int state)
 {
-	struct platform_device *dev = to_platform_device(mmc->dev.parent);
-	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
+	struct tc6387xb *tc6387xb = dev_get_drvdata(mmc->dev.parent);
 
 	tmio_core_mmc_pwr(tc6387xb->scr + 0x200, 0, state);
 }
 
 static void tc6387xb_mmc_clk_div(struct platform_device *mmc, int state)
 {
-	struct platform_device *dev = to_platform_device(mmc->dev.parent);
-	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
+	struct tc6387xb *tc6387xb = dev_get_drvdata(mmc->dev.parent);
 
 	tmio_core_mmc_clk_div(tc6387xb->scr + 0x200, 0, state);
 }
@@ -97,8 +95,7 @@ static void tc6387xb_mmc_clk_div(struct platform_device *mmc, int state)
 
 static int tc6387xb_mmc_enable(struct platform_device *mmc)
 {
-	struct platform_device *dev      = to_platform_device(mmc->dev.parent);
-	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
+	struct tc6387xb *tc6387xb = dev_get_drvdata(mmc->dev.parent);
 
 	clk_prepare_enable(tc6387xb->clk32k);
 
@@ -110,8 +107,7 @@ static int tc6387xb_mmc_enable(struct platform_device *mmc)
 
 static int tc6387xb_mmc_disable(struct platform_device *mmc)
 {
-	struct platform_device *dev      = to_platform_device(mmc->dev.parent);
-	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
+	struct tc6387xb *tc6387xb = dev_get_drvdata(mmc->dev.parent);
 
 	clk_disable_unprepare(tc6387xb->clk32k);
 
diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index 0c9f0390e891..ad0351f22675 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -122,8 +122,7 @@ enum {
 
 static int tc6393xb_nand_enable(struct platform_device *nand)
 {
-	struct platform_device *dev = to_platform_device(nand->dev.parent);
-	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
+	struct tc6393xb *tc6393xb = dev_get_drvdata(nand->dev.parent);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
@@ -312,8 +311,7 @@ static int tc6393xb_fb_disable(struct platform_device *dev)
 
 int tc6393xb_lcd_set_power(struct platform_device *fb, bool on)
 {
-	struct platform_device *dev = to_platform_device(fb->dev.parent);
-	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
+	struct tc6393xb *tc6393xb = dev_get_drvdata(fb->dev.parent);
 	u8 fer;
 	unsigned long flags;
 
@@ -334,8 +332,7 @@ EXPORT_SYMBOL(tc6393xb_lcd_set_power);
 
 int tc6393xb_lcd_mode(struct platform_device *fb,
 					const struct fb_videomode *mode) {
-	struct platform_device *dev = to_platform_device(fb->dev.parent);
-	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
+	struct tc6393xb *tc6393xb = dev_get_drvdata(fb->dev.parent);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&tc6393xb->lock, flags);
@@ -351,8 +348,7 @@ EXPORT_SYMBOL(tc6393xb_lcd_mode);
 
 static int tc6393xb_mmc_enable(struct platform_device *mmc)
 {
-	struct platform_device *dev = to_platform_device(mmc->dev.parent);
-	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
+	struct tc6393xb *tc6393xb = dev_get_drvdata(mmc->dev.parent);
 
 	tmio_core_mmc_enable(tc6393xb->scr + 0x200, 0,
 		tc6393xb_mmc_resources[0].start & 0xfffe);
@@ -362,8 +358,7 @@ static int tc6393xb_mmc_enable(struct platform_device *mmc)
 
 static int tc6393xb_mmc_resume(struct platform_device *mmc)
 {
-	struct platform_device *dev = to_platform_device(mmc->dev.parent);
-	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
+	struct tc6393xb *tc6393xb = dev_get_drvdata(mmc->dev.parent);
 
 	tmio_core_mmc_resume(tc6393xb->scr + 0x200, 0,
 		tc6393xb_mmc_resources[0].start & 0xfffe);
@@ -373,16 +368,14 @@ static int tc6393xb_mmc_resume(struct platform_device *mmc)
 
 static void tc6393xb_mmc_pwr(struct platform_device *mmc, int state)
 {
-	struct platform_device *dev = to_platform_device(mmc->dev.parent);
-	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
+	struct tc6393xb *tc6393xb = dev_get_drvdata(mmc->dev.parent);
 
 	tmio_core_mmc_pwr(tc6393xb->scr + 0x200, 0, state);
 }
 
 static void tc6393xb_mmc_clk_div(struct platform_device *mmc, int state)
 {
-	struct platform_device *dev = to_platform_device(mmc->dev.parent);
-	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
+	struct tc6393xb *tc6393xb = dev_get_drvdata(mmc->dev.parent);
 
 	tmio_core_mmc_clk_div(tc6393xb->scr + 0x200, 0, state);
 }
-- 
2.20.1

