Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55DBC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE5D2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389505AbfKGOdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:33:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388456AbfKGOdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:33:01 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 43DD08EECB916765CD18;
        Thu,  7 Nov 2019 22:32:58 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 7 Nov 2019
 22:32:50 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <gregkh@linuxfoundation.org>,
        <tglx@linutronix.de>, <rfontana@redhat.com>,
        <yuehaibing@huawei.com>, <joe@perches.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] staging: hp100: Use match_string() helper to simplify the code
Date:   Thu, 7 Nov 2019 22:32:23 +0800
Message-ID: <20191107143223.44696-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the array index of a matching string.
Use it instead of the open-coded implementation.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/hp/hp100.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hp/hp100.c b/drivers/staging/hp/hp100.c
index 6ec78f5..e2f0b58 100644
--- a/drivers/staging/hp/hp100.c
+++ b/drivers/staging/hp/hp100.c
@@ -339,14 +339,11 @@ static __init int hp100_isa_probe1(struct net_device *dev, int ioaddr)
 	if (sig == NULL)
 		goto err;
 
-	for (i = 0; i < ARRAY_SIZE(hp100_isa_tbl); i++) {
-		if (!strcmp(hp100_isa_tbl[i], sig))
-			break;
-
-	}
+	i = match_string(hp100_isa_tbl, ARRAY_SIZE(hp100_isa_tbl), sig);
+	if (i < 0)
+		goto err;
 
-	if (i < ARRAY_SIZE(hp100_isa_tbl))
-		return hp100_probe1(dev, ioaddr, HP100_BUS_ISA, NULL);
+	return hp100_probe1(dev, ioaddr, HP100_BUS_ISA, NULL);
  err:
 	return -ENODEV;
 
-- 
2.7.4


