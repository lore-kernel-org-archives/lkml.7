Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B231C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2195E20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfDWHk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:40:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbfDWHkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 56F3C6428DE525D46D18;
        Tue, 23 Apr 2019 15:40:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:07 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH next 08/25] iio: adc: at91: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:50:03 +0800
Message-ID: <20190423075020.173734-9-wangkefeng.wang@huawei.com>
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

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 12 ++++--------
 drivers/iio/adc/at91_adc.c         |  4 ++--
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index d5ea84cf6460..a3a4ca946308 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1586,8 +1586,7 @@ static void at91_adc_hw_init(struct at91_adc_state *st)
 static ssize_t at91_adc_get_fifo_state(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *indio_dev =
-			platform_get_drvdata(to_platform_device(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n", !!st->dma_st.dma_chan);
@@ -1596,8 +1595,7 @@ static ssize_t at91_adc_get_fifo_state(struct device *dev,
 static ssize_t at91_adc_get_watermark(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *indio_dev =
-			platform_get_drvdata(to_platform_device(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n", st->dma_st.watermark);
@@ -1849,8 +1847,7 @@ static int at91_adc_remove(struct platform_device *pdev)
 
 static __maybe_unused int at91_adc_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev =
-			platform_get_drvdata(to_platform_device(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	/*
@@ -1870,8 +1867,7 @@ static __maybe_unused int at91_adc_suspend(struct device *dev)
 
 static __maybe_unused int at91_adc_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev =
-			platform_get_drvdata(to_platform_device(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 	int ret;
 
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 596841a3c4db..1aa8af3491fd 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1360,7 +1360,7 @@ static int at91_adc_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int at91_adc_suspend(struct device *dev)
 {
-	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
+	struct iio_dev *idev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(idev);
 
 	pinctrl_pm_select_sleep_state(dev);
@@ -1371,7 +1371,7 @@ static int at91_adc_suspend(struct device *dev)
 
 static int at91_adc_resume(struct device *dev)
 {
-	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
+	struct iio_dev *idev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(idev);
 
 	clk_prepare_enable(st->clk);
-- 
2.20.1

