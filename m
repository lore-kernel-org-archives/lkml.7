Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE901C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D75207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfIEQUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:20:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733091AbfIEQSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:18:03 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D70742E5B8FC85451BFF;
        Fri,  6 Sep 2019 00:18:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Sep 2019 00:18:37 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mchehab@kernel.org>
CC:     <hansverk@cisco.com>, <daniel.vetter@ffwll.ch>,
        <zhongjiang@huawei.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] media: dvb-frontends: Use DIV_ROUND_CLOSEST directly to make it readable
Date:   Fri, 6 Sep 2019 00:14:49 +0800
Message-ID: <1567700092-27769-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1567700092-27769-1-git-send-email-zhongjiang@huawei.com>
References: <1567700092-27769-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel.h macro DIV_ROUND_CLOSEST performs the computation (x + d/2)/d
but is perhaps more readable.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/media/dvb-frontends/mt312.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/mt312.c b/drivers/media/dvb-frontends/mt312.c
index 7cae7d6..251ff41 100644
--- a/drivers/media/dvb-frontends/mt312.c
+++ b/drivers/media/dvb-frontends/mt312.c
@@ -137,7 +137,7 @@ static inline int mt312_writereg(struct mt312_state *state,
 
 static inline u32 mt312_div(u32 a, u32 b)
 {
-	return (a + (b / 2)) / b;
+	return DIV_ROUND_CLOSEST(a, b);
 }
 
 static int mt312_reset(struct mt312_state *state, const u8 full)
-- 
1.7.12.4

