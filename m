Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BBAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AE220645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfDWHmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:42:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbfDWHkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:21 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3E4371C2465DBF8BAE62;
        Tue, 23 Apr 2019 15:40:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:10 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Anup Patel <anup.patel@broadcom.com>,
        "Jassi Brar" <jaswinder.singh@linaro.org>
Subject: [PATCH next 14/25] mailbox: bcm-flexrm-mailbox: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:50:09 +0800
Message-ID: <20190423075020.173734-15-wangkefeng.wang@huawei.com>
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

Cc: Anup Patel <anup.patel@broadcom.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index a64116586b4c..0cfdd53d04a1 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1165,8 +1165,7 @@ static int flexrm_process_completions(struct flexrm_ring *ring)
 
 static int flexrm_debugfs_conf_show(struct seq_file *file, void *offset)
 {
-	struct platform_device *pdev = to_platform_device(file->private);
-	struct flexrm_mbox *mbox = platform_get_drvdata(pdev);
+	struct flexrm_mbox *mbox = dev_get_drvdata(file->private);
 
 	/* Write config in file */
 	flexrm_write_config_in_seqfile(mbox, file);
@@ -1176,8 +1175,7 @@ static int flexrm_debugfs_conf_show(struct seq_file *file, void *offset)
 
 static int flexrm_debugfs_stats_show(struct seq_file *file, void *offset)
 {
-	struct platform_device *pdev = to_platform_device(file->private);
-	struct flexrm_mbox *mbox = platform_get_drvdata(pdev);
+	struct flexrm_mbox *mbox = dev_get_drvdata(file->private);
 
 	/* Write stats in file */
 	flexrm_write_stats_in_seqfile(mbox, file);
-- 
2.20.1

