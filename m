Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38191C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0692220645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfDWHkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:40:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726734AbfDWHkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 53D86F1D0CDA15B9BA9D;
        Tue, 23 Apr 2019 15:40:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:16 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michal Januszewski <spock@gentoo.org>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
Subject: [PATCH next 25/25] video: fbdev: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:50:20 +0800
Message-ID: <20190423075020.173734-26-wangkefeng.wang@huawei.com>
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

Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michal Januszewski <spock@gentoo.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/video/fbdev/nuc900fb.c  |  2 +-
 drivers/video/fbdev/s3c2410fb.c |  2 +-
 drivers/video/fbdev/uvesafb.c   | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/nuc900fb.c b/drivers/video/fbdev/nuc900fb.c
index 6680edae4696..44ea5380a546 100644
--- a/drivers/video/fbdev/nuc900fb.c
+++ b/drivers/video/fbdev/nuc900fb.c
@@ -455,7 +455,7 @@ static int nuc900fb_cpufreq_transition(struct notifier_block *nb,
 	struct fb_info *fbinfo;
 	long delta_f;
 	info = container_of(nb, struct nuc900fb_info, freq_transition);
-	fbinfo = platform_get_drvdata(to_platform_device(info->dev));
+	fbinfo = dev_get_drvdata(info->dev);
 
 	delta_f = info->clk_rate - clk_get_rate(info->clk);
 
diff --git a/drivers/video/fbdev/s3c2410fb.c b/drivers/video/fbdev/s3c2410fb.c
index a67e4567e656..a702da89910b 100644
--- a/drivers/video/fbdev/s3c2410fb.c
+++ b/drivers/video/fbdev/s3c2410fb.c
@@ -777,7 +777,7 @@ static int s3c2410fb_cpufreq_transition(struct notifier_block *nb,
 	long delta_f;
 
 	info = container_of(nb, struct s3c2410fb_info, freq_transition);
-	fbinfo = platform_get_drvdata(to_platform_device(info->dev));
+	fbinfo = dev_get_drvdata(info->dev);
 
 	/* work out change, <0 for speed-up */
 	delta_f = info->clk_rate - clk_get_rate(info->clk);
diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 34dc8e53a1e9..d707fdb97354 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1543,7 +1543,7 @@ static void uvesafb_ioremap(struct fb_info *info)
 static ssize_t uvesafb_show_vbe_ver(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	return snprintf(buf, PAGE_SIZE, "%.4x\n", par->vbe_ib.vbe_version);
@@ -1554,7 +1554,7 @@ static DEVICE_ATTR(vbe_version, S_IRUGO, uvesafb_show_vbe_ver, NULL);
 static ssize_t uvesafb_show_vbe_modes(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 	int ret = 0, i;
 
@@ -1573,7 +1573,7 @@ static DEVICE_ATTR(vbe_modes, S_IRUGO, uvesafb_show_vbe_modes, NULL);
 static ssize_t uvesafb_show_vendor(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	if (par->vbe_ib.oem_vendor_name_ptr)
@@ -1588,7 +1588,7 @@ static DEVICE_ATTR(oem_vendor, S_IRUGO, uvesafb_show_vendor, NULL);
 static ssize_t uvesafb_show_product_name(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	if (par->vbe_ib.oem_product_name_ptr)
@@ -1603,7 +1603,7 @@ static DEVICE_ATTR(oem_product_name, S_IRUGO, uvesafb_show_product_name, NULL);
 static ssize_t uvesafb_show_product_rev(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	if (par->vbe_ib.oem_product_rev_ptr)
@@ -1618,7 +1618,7 @@ static DEVICE_ATTR(oem_product_rev, S_IRUGO, uvesafb_show_product_rev, NULL);
 static ssize_t uvesafb_show_oem_string(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	if (par->vbe_ib.oem_string_ptr)
@@ -1633,7 +1633,7 @@ static DEVICE_ATTR(oem_string, S_IRUGO, uvesafb_show_oem_string, NULL);
 static ssize_t uvesafb_show_nocrtc(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", par->nocrtc);
@@ -1642,7 +1642,7 @@ static ssize_t uvesafb_show_nocrtc(struct device *dev,
 static ssize_t uvesafb_store_nocrtc(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	if (count > 0) {
-- 
2.20.1

