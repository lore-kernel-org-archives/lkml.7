Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E4DC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763BE2080F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfKJKb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 05:31:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39012 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbfKJKb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 05:31:27 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 25439E7F0BEA32D02061;
        Sun, 10 Nov 2019 18:31:25 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sun, 10 Nov 2019 18:31:18 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <zhengyongjun3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] firmware: arm_scmi: Remove set but not used variable 'val'
Date:   Sun, 10 Nov 2019 18:30:10 +0800
Message-ID: <20191110103010.117132-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/firmware/arm_scmi/perf.c: In function scmi_perf_fc_ring_db:
drivers/firmware/arm_scmi/perf.c:323:7: warning: variable val set but not used [-Wunused-but-set-variable]

val is never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/firmware/arm_scmi/perf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 4a8012e3cb8c..efa98d2ee045 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -319,10 +319,8 @@ static void scmi_perf_fc_ring_db(struct scmi_fc_db_info *db)
 		SCMI_PERF_FC_RING_DB(64);
 #else
 	{
-		u64 val = 0;
-
 		if (db->mask)
-			val = ioread64_hi_lo(db->addr) & db->mask;
+			ioread64_hi_lo(db->addr) & db->mask;
 		iowrite64_hi_lo(db->set, db->addr);
 	}
 #endif
-- 
2.23.0

