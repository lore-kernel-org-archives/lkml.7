Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F70DC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DDD2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfD1DvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 23:51:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbfD1DvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 23:51:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 59107FC5BA5E2B3058D3;
        Sun, 28 Apr 2019 11:51:02 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Sun, 28 Apr 2019 11:50:55 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vinod Koul <vinod.koul@intel.com>, <dmaengine@vger.kernel.org>
Subject: [PATCH next v2 1/2] dmaengine: bcm-sba-raid: Use dev_get_drvdata()
Date:   Sun, 28 Apr 2019 12:00:24 +0800
Message-ID: <20190428040025.142181-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426115235.GX28103@vkoul-mobl>
References: <20190426115235.GX28103@vkoul-mobl>
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
 drivers/dma/bcm-sba-raid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 72878ac5c78d..fa81d0177765 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -1459,8 +1459,7 @@ static void sba_receive_message(struct mbox_client *cl, void *msg)
 
 static int sba_debugfs_stats_show(struct seq_file *file, void *offset)
 {
-	struct platform_device *pdev = to_platform_device(file->private);
-	struct sba_device *sba = platform_get_drvdata(pdev);
+	struct sba_device *sba = dev_get_drvdata(file->private);
 
 	/* Write stats in file */
 	sba_write_stats_in_seqfile(sba, file);
-- 
2.20.1

