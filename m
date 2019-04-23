Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1826DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FAB20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfDWHkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:40:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbfDWHkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:16 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D35034C2A2796E794A24;
        Tue, 23 Apr 2019 15:40:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:02 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH next 01/25] ACPI / DPTF: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:49:56 +0800
Message-ID: <20190423075020.173734-2-wangkefeng.wang@huawei.com>
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

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/acpi/dptf/dptf_power.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index e1c242568341..0c081390930a 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -31,8 +31,7 @@ static ssize_t name##_show(struct device *dev,\
 			   struct device_attribute *attr,\
 			   char *buf)\
 {\
-	struct platform_device *pdev = to_platform_device(dev);\
-	struct acpi_device *acpi_dev = platform_get_drvdata(pdev);\
+	struct acpi_device *acpi_dev = dev_get_drvdata(dev);\
 	unsigned long long val;\
 	acpi_status status;\
 \
-- 
2.20.1

