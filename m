Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F54EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5402067D
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfHABdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 21:33:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfHABdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:33:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DBF2AD35E1504DA908C3;
        Thu,  1 Aug 2019 09:33:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 1 Aug 2019 09:33:27 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] intel_th: msu: Fix possible memory leak in mode_store()
Date:   Thu, 1 Aug 2019 01:38:25 +0000
Message-ID: <20190801013825.182543-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'mode' is malloced in mode_store() and should be freed before leaving
from the error handling cases, otherwise it will cause memory leak.

Fixes: 615c164da0eb ("intel_th: msu: Introduce buffer interface")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/hwtracing/intel_th/msu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index fc9f15f36ad4..2e7a04f566d4 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1849,8 +1849,10 @@ mode_store(struct device *dev, struct device_attribute *attr, const char *buf,
 
 	mode = kstrndup(buf, len, GFP_KERNEL);
 	i = match_string(msc_mode, ARRAY_SIZE(msc_mode), mode);
-	if (i >= 0)
+	if (i >= 0) {
+		kfree(mode);
 		goto found;
+	}
 
 	/* Buffer sinks only work with a usable IRQ */
 	if (!msc->do_irq) {



