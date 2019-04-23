Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44608C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0905620652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfDWHkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:40:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbfDWHk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 789FDD335BAD8644D13F;
        Tue, 23 Apr 2019 15:40:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:14 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-rtc@vger.kernel.org>
Subject: [PATCH next 21/25] rtc: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:50:16 +0800
Message-ID: <20190423075020.173734-22-wangkefeng.wang@huawei.com>
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

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/rtc/rtc-hid-sensor-time.c |  3 +--
 drivers/rtc/rtc-pxa.c             |  3 +--
 drivers/rtc/rtc-rk808.c           |  6 ++----
 drivers/rtc/rtc-tx4939.c          | 17 ++++++-----------
 drivers/rtc/rtc-wm831x.c          | 18 +++++++-----------
 drivers/rtc/rtc-wm8350.c          | 12 ++++--------
 6 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor-time.c
index 3e1abb455472..f27c40e8331f 100644
--- a/drivers/rtc/rtc-hid-sensor-time.c
+++ b/drivers/rtc/rtc-hid-sensor-time.c
@@ -205,8 +205,7 @@ static int hid_time_parse_report(struct platform_device *pdev,
 static int hid_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long flags;
-	struct hid_time_state *time_state =
-		platform_get_drvdata(to_platform_device(dev));
+	struct hid_time_state *time_state = dev_get_drvdata(dev);
 	int ret;
 
 	reinit_completion(&time_state->comp_last_time);
diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index e1887b86fdc7..d4766734e40b 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -145,8 +145,7 @@ static void rtsr_set_bits(struct pxa_rtc *pxa_rtc, u32 mask)
 
 static irqreturn_t pxa_rtc_irq(int irq, void *dev_id)
 {
-	struct platform_device *pdev = to_platform_device(dev_id);
-	struct pxa_rtc *pxa_rtc = platform_get_drvdata(pdev);
+	struct pxa_rtc *pxa_rtc = dev_get_drvdata(dev_id);
 	u32 rtsr;
 	unsigned long events = 0;
 
diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index 1fb864d4ef83..5c5d9f125669 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -336,8 +336,7 @@ static const struct rtc_class_ops rk808_rtc_ops = {
 /* Turn off the alarm if it should not be a wake source. */
 static int rk808_rtc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rk808_rtc *rk808_rtc = dev_get_drvdata(&pdev->dev);
+	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev))
 		enable_irq_wake(rk808_rtc->irq);
@@ -350,8 +349,7 @@ static int rk808_rtc_suspend(struct device *dev)
  */
 static int rk808_rtc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rk808_rtc *rk808_rtc = dev_get_drvdata(&pdev->dev);
+	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(rk808_rtc->irq);
diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 2d24babc4057..5a29915a06ec 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -42,11 +42,6 @@ struct tx4939rtc_plat_data {
 	spinlock_t lock;
 };
 
-static struct tx4939rtc_plat_data *get_tx4939rtc_plat_data(struct device *dev)
-{
-	return platform_get_drvdata(to_platform_device(dev));
-}
-
 static int tx4939_rtc_cmd(struct tx4939_rtc_reg __iomem *rtcreg, int cmd)
 {
 	int i = 0;
@@ -64,7 +59,7 @@ static int tx4939_rtc_cmd(struct tx4939_rtc_reg __iomem *rtcreg, int cmd)
 
 static int tx4939_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
+	struct tx4939rtc_plat_data *pdata = dev_get_drvdata(dev);
 	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
 	unsigned long secs = rtc_tm_to_time64(tm);
 	int i, ret;
@@ -89,7 +84,7 @@ static int tx4939_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 static int tx4939_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
+	struct tx4939rtc_plat_data *pdata = dev_get_drvdata(dev);
 	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
 	int i, ret;
 	unsigned long sec;
@@ -115,7 +110,7 @@ static int tx4939_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int tx4939_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
+	struct tx4939rtc_plat_data *pdata = dev_get_drvdata(dev);
 	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
 	int i, ret;
 	unsigned long sec;
@@ -140,7 +135,7 @@ static int tx4939_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int tx4939_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
+	struct tx4939rtc_plat_data *pdata = dev_get_drvdata(dev);
 	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
 	int i, ret;
 	unsigned long sec;
@@ -170,7 +165,7 @@ static int tx4939_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int tx4939_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
-	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
+	struct tx4939rtc_plat_data *pdata = dev_get_drvdata(dev);
 
 	spin_lock_irq(&pdata->lock);
 	tx4939_rtc_cmd(pdata->rtcreg,
@@ -182,7 +177,7 @@ static int tx4939_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 static irqreturn_t tx4939_rtc_interrupt(int irq, void *dev_id)
 {
-	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev_id);
+	struct tx4939rtc_plat_data *pdata = dev_get_drvdata(dev_id);
 	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
 	unsigned long events = RTC_IRQF;
 
diff --git a/drivers/rtc/rtc-wm831x.c b/drivers/rtc/rtc-wm831x.c
index 6a0defd16088..ff7460853416 100644
--- a/drivers/rtc/rtc-wm831x.c
+++ b/drivers/rtc/rtc-wm831x.c
@@ -344,11 +344,10 @@ static const struct rtc_class_ops wm831x_rtc_ops = {
 /* Turn off the alarm if it should not be a wake source. */
 static int wm831x_rtc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct wm831x_rtc *wm831x_rtc = dev_get_drvdata(&pdev->dev);
+	struct wm831x_rtc *wm831x_rtc = dev_get_drvdata(dev);
 	int ret, enable;
 
-	if (wm831x_rtc->alarm_enabled && device_may_wakeup(&pdev->dev))
+	if (wm831x_rtc->alarm_enabled && device_may_wakeup(dev))
 		enable = WM831X_RTC_ALM_ENA;
 	else
 		enable = 0;
@@ -356,7 +355,7 @@ static int wm831x_rtc_suspend(struct device *dev)
 	ret = wm831x_set_bits(wm831x_rtc->wm831x, WM831X_RTC_CONTROL,
 			      WM831X_RTC_ALM_ENA, enable);
 	if (ret != 0)
-		dev_err(&pdev->dev, "Failed to update RTC alarm: %d\n", ret);
+		dev_err(dev, "Failed to update RTC alarm: %d\n", ret);
 
 	return 0;
 }
@@ -366,15 +365,13 @@ static int wm831x_rtc_suspend(struct device *dev)
  */
 static int wm831x_rtc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct wm831x_rtc *wm831x_rtc = dev_get_drvdata(&pdev->dev);
+	struct wm831x_rtc *wm831x_rtc = dev_get_drvdata(dev);
 	int ret;
 
 	if (wm831x_rtc->alarm_enabled) {
 		ret = wm831x_rtc_start_alarm(wm831x_rtc);
 		if (ret != 0)
-			dev_err(&pdev->dev,
-				"Failed to restart RTC alarm: %d\n", ret);
+			dev_err(dev, "Failed to restart RTC alarm: %d\n", ret);
 	}
 
 	return 0;
@@ -383,14 +380,13 @@ static int wm831x_rtc_resume(struct device *dev)
 /* Unconditionally disable the alarm */
 static int wm831x_rtc_freeze(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct wm831x_rtc *wm831x_rtc = dev_get_drvdata(&pdev->dev);
+	struct wm831x_rtc *wm831x_rtc = dev_get_drvdata(dev);
 	int ret;
 
 	ret = wm831x_set_bits(wm831x_rtc->wm831x, WM831X_RTC_CONTROL,
 			      WM831X_RTC_ALM_ENA, 0);
 	if (ret != 0)
-		dev_err(&pdev->dev, "Failed to stop RTC alarm: %d\n", ret);
+		dev_err(dev, "Failed to stop RTC alarm: %d\n", ret);
 
 	return 0;
 }
diff --git a/drivers/rtc/rtc-wm8350.c b/drivers/rtc/rtc-wm8350.c
index 483c7993516b..f54fa12c4b4b 100644
--- a/drivers/rtc/rtc-wm8350.c
+++ b/drivers/rtc/rtc-wm8350.c
@@ -340,8 +340,7 @@ static const struct rtc_class_ops wm8350_rtc_ops = {
 #ifdef CONFIG_PM_SLEEP
 static int wm8350_rtc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct wm8350 *wm8350 = dev_get_drvdata(&pdev->dev);
+	struct wm8350 *wm8350 = dev_get_drvdata(dev);
 	int ret = 0;
 	u16 reg;
 
@@ -351,8 +350,7 @@ static int wm8350_rtc_suspend(struct device *dev)
 	    reg & WM8350_RTC_ALMSTS) {
 		ret = wm8350_rtc_stop_alarm(wm8350);
 		if (ret != 0)
-			dev_err(&pdev->dev, "Failed to stop RTC alarm: %d\n",
-				ret);
+			dev_err(dev, "Failed to stop RTC alarm: %d\n", ret);
 	}
 
 	return ret;
@@ -360,15 +358,13 @@ static int wm8350_rtc_suspend(struct device *dev)
 
 static int wm8350_rtc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct wm8350 *wm8350 = dev_get_drvdata(&pdev->dev);
+	struct wm8350 *wm8350 = dev_get_drvdata(dev);
 	int ret;
 
 	if (wm8350->rtc.alarm_enabled) {
 		ret = wm8350_rtc_start_alarm(wm8350);
 		if (ret != 0)
-			dev_err(&pdev->dev,
-				"Failed to restart RTC alarm: %d\n", ret);
+			dev_err(dev, "Failed to restart RTC alarm: %d\n", ret);
 	}
 
 	return 0;
-- 
2.20.1

