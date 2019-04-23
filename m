Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05568C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C737320652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfDWHll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:41:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726696AbfDWHkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 690377113B4E5AA2585A;
        Tue, 23 Apr 2019 15:40:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:06 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>
Subject: [PATCH next 07/25] hwmon: s3c: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:50:02 +0800
Message-ID: <20190423075020.173734-8-wangkefeng.wang@huawei.com>
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

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/hwmon/s3c-hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index 0c4710d35d16..0d65aa5985e2 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -98,7 +98,7 @@ static int s3c_hwmon_read_ch(struct device *dev,
 static ssize_t s3c_hwmon_show_raw(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct s3c_hwmon *adc = platform_get_drvdata(to_platform_device(dev));
+	struct s3c_hwmon *adc = dev_get_drvdata(dev);
 	struct sensor_device_attribute *sa = to_sensor_dev_attr(attr);
 	int ret;
 
@@ -164,7 +164,7 @@ static ssize_t s3c_hwmon_ch_show(struct device *dev,
 				 char *buf)
 {
 	struct sensor_device_attribute *sen_attr = to_sensor_dev_attr(attr);
-	struct s3c_hwmon *hwmon = platform_get_drvdata(to_platform_device(dev));
+	struct s3c_hwmon *hwmon = dev_get_drvdata(dev);
 	struct s3c_hwmon_pdata *pdata = dev_get_platdata(dev);
 	struct s3c_hwmon_chcfg *cfg;
 	int ret;
-- 
2.20.1

