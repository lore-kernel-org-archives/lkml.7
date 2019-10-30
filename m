Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A951CCA9EC4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3F12083E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfJ3IXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:23:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfJ3IXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:23:47 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F1936E4FAD7278817A31;
        Wed, 30 Oct 2019 16:23:42 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 30 Oct 2019 16:23:33 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <zhongjiang@huawei.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs fops
Date:   Wed, 30 Oct 2019 16:19:40 +0800
Message-ID: <1572423581-59762-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1572423581-59762-1-git-send-email-zhongjiang@huawei.com>
References: <1572423581-59762-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is more clear to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
operation rather than DEFINE_SIMPLE_ATTRIBUTE.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/iio/imu/adis16460.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index 6aed9e8..2e7a582 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -87,7 +87,7 @@ static int adis16460_show_serial_number(void *arg, u64 *val)
 
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(adis16460_serial_number_fops,
+DEFINE_DEBUGFS_ATTRIBUTE(adis16460_serial_number_fops,
 	adis16460_show_serial_number, NULL, "0x%.4llx\n");
 
 static int adis16460_show_product_id(void *arg, u64 *val)
@@ -105,7 +105,7 @@ static int adis16460_show_product_id(void *arg, u64 *val)
 
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(adis16460_product_id_fops,
+DEFINE_DEBUGFS_ATTRIBUTE(adis16460_product_id_fops,
 	adis16460_show_product_id, NULL, "%llu\n");
 
 static int adis16460_show_flash_count(void *arg, u64 *val)
@@ -123,7 +123,7 @@ static int adis16460_show_flash_count(void *arg, u64 *val)
 
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(adis16460_flash_count_fops,
+DEFINE_DEBUGFS_ATTRIBUTE(adis16460_flash_count_fops,
 	adis16460_show_flash_count, NULL, "%lld\n");
 
 static int adis16460_debugfs_init(struct iio_dev *indio_dev)
-- 
1.7.12.4

