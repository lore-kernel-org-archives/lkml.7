Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE63C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361C5206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDKCsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:48:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfDKCsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:48:15 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A31FBB80ABA2886961B7;
        Thu, 11 Apr 2019 10:48:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 10:48:02 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Will Deacon <will.deacon@arm.com>, <ulf.hansson@linaro.org>,
        <axboe@kernel.dk>, <osandov@fb.com>, <hare@suse.de>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] memstick: remove set but not used variable 'data'
Date:   Thu, 11 Apr 2019 02:59:04 +0000
Message-ID: <20190411025904.188152-1-yuehaibing@huawei.com>
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

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/memstick/host/jmb38x_ms.c: In function 'jmb38x_ms_issue_cmd':
drivers/memstick/host/jmb38x_ms.c:371:17: warning:
 variable 'data' set but not used [-Wunused-but-set-variable]

It's never used since introduction and can be removed.
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/memstick/host/jmb38x_ms.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index e3a5af65dbce..acec09813419 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -368,7 +368,6 @@ static int jmb38x_ms_transfer_data(struct jmb38x_ms_host *host)
 static int jmb38x_ms_issue_cmd(struct memstick_host *msh)
 {
 	struct jmb38x_ms_host *host = memstick_priv(msh);
-	unsigned char *data;
 	unsigned int data_len, cmd, t_val;
 
 	if (!(STATUS_HAS_MEDIA & readl(host->addr + STATUS))) {
@@ -400,8 +399,6 @@ static int jmb38x_ms_issue_cmd(struct memstick_host *msh)
 			cmd |= TPC_WAIT_INT;
 	}
 
-	data = host->req->data;
-
 	if (!no_dma)
 		host->cmd_flags |= DMA_DATA;



