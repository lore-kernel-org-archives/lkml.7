Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF36C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3206620645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfDWHmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:42:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6677 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbfDWHkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C0AB01FABA2A7D13B765;
        Tue, 23 Apr 2019 15:40:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:04 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vinod Koul <vinod.koul@intel.com>, <dmaengine@vger.kernel.org>
Subject: [PATCH next 03/25] dmaengine: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:49:58 +0800
Message-ID: <20190423075020.173734-4-wangkefeng.wang@huawei.com>
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

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/dma/bcm-sba-raid.c | 3 +--
 drivers/dma/nbpfaxi.c      | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

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

