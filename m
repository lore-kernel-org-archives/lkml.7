Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6D7CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DDF222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504069AbfJRFFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:05:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504045AbfJRFFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:05:11 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D13FC57D116AB90CF688;
        Fri, 18 Oct 2019 11:19:35 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 18 Oct 2019 11:19:24 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v2 10/33] gdrom: Use pr_warn instead of pr_warning
Date:   Fri, 18 Oct 2019 11:18:27 +0800
Message-ID: <20191018031850.48498-10-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018031850.48498-1-wangkefeng.wang@huawei.com>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/cdrom/gdrom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 6626c84f66d1..5b21dc421c94 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -742,7 +742,7 @@ static int probe_gdrom(struct platform_device *devptr)
 	int err;
 	/* Start the device */
 	if (gdrom_execute_diagnostic() != 1) {
-		pr_warning("ATA Probe for GDROM failed\n");
+		pr_warn("ATA Probe for GDROM failed\n");
 		return -ENODEV;
 	}
 	/* Print out firmware ID */
@@ -814,7 +814,7 @@ static int probe_gdrom(struct platform_device *devptr)
 probe_fail_no_mem:
 	unregister_blkdev(gdrom_major, GDROM_DEV_NAME);
 	gdrom_major = 0;
-	pr_warning("Probe failed - error is 0x%X\n", err);
+	pr_warn("Probe failed - error is 0x%X\n", err);
 	return err;
 }
 
-- 
2.20.1

