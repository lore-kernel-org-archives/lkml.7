Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FA2C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7BC2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfD1DvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 23:51:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41850 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbfD1DvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 23:51:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5569FD64A00A3743F17F;
        Sun, 28 Apr 2019 11:51:02 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Sun, 28 Apr 2019 11:50:56 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vinod Koul <vinod.koul@intel.com>, <dmaengine@vger.kernel.org>
Subject: [PATCH next v2 2/2] dmaengine: nbpfaxi: Use dev_get_drvdata()
Date:   Sun, 28 Apr 2019 12:00:25 +0800
Message-ID: <20190428040025.142181-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190428040025.142181-1-wangkefeng.wang@huawei.com>
References: <20190426115235.GX28103@vkoul-mobl>
 <20190428040025.142181-1-wangkefeng.wang@huawei.com>
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

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/dma/nbpfaxi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index a67b292190f4..594409a6e975 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1491,14 +1491,14 @@ MODULE_DEVICE_TABLE(platform, nbpf_ids);
 #ifdef CONFIG_PM
 static int nbpf_runtime_suspend(struct device *dev)
 {
-	struct nbpf_device *nbpf = platform_get_drvdata(to_platform_device(dev));
+	struct nbpf_device *nbpf = dev_get_drvdata(dev);
 	clk_disable_unprepare(nbpf->clk);
 	return 0;
 }
 
 static int nbpf_runtime_resume(struct device *dev)
 {
-	struct nbpf_device *nbpf = platform_get_drvdata(to_platform_device(dev));
+	struct nbpf_device *nbpf = dev_get_drvdata(dev);
 	return clk_prepare_enable(nbpf->clk);
 }
 #endif
-- 
2.20.1

