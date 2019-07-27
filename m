Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5465FC7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 06:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDEE2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 06:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfG0GPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 02:15:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbfG0GPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 02:15:07 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 280C896D19A24E0FC5DE;
        Sat, 27 Jul 2019 14:15:06 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Sat, 27 Jul 2019 14:14:55 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <maz@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        <guoheyi@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] irqchip/gic-v3-its: Remove the redundant set_bit for lpi_map
Date:   Sat, 27 Jul 2019 06:14:22 +0000
Message-ID: <1564208062-35208-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We try to find a free LPI region in device's lpi_map and allocate them
(set them to 1) when we want to allocate LPIs for this device. This is
what bitmap_find_free_region() has done for us. The following set_bit
is redundant and a bit confusing (since we only set_bit against the first
allocated LPI idx). Remove it, and make the set_bit explicit by comment.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 472053c..7c69176 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2464,6 +2464,7 @@ static int its_alloc_device_irq(struct its_device *dev, int nvecs, irq_hw_number
 {
 	int idx;
 
+	/* Find a free LPI region in lpi_map and allocate them. */
 	idx = bitmap_find_free_region(dev->event_map.lpi_map,
 				      dev->event_map.nr_lpis,
 				      get_count_order(nvecs));
@@ -2471,7 +2472,6 @@ static int its_alloc_device_irq(struct its_device *dev, int nvecs, irq_hw_number
 		return -ENOSPC;
 
 	*hwirq = dev->event_map.lpi_base + idx;
-	set_bit(idx, dev->event_map.lpi_map);
 
 	return 0;
 }
-- 
1.8.3.1


