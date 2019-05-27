Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00663C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E7F20665
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfE0N4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:56:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfE0N4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:56:34 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7DBC2F6231E3F38B7F47;
        Mon, 27 May 2019 21:56:32 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 27 May 2019
 21:56:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <maxime.chevallier@bootlin.com>,
        <antoine.tenart@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: mvpp2: cls: Remove unnessesary check in mvpp2_ethtool_cls_rule_ins
Date:   Mon, 27 May 2019 21:46:46 +0800
Message-ID: <20190527134646.21804-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix smatch warning:

drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c:1236
 mvpp2_ethtool_cls_rule_ins() warn: unsigned 'info->fs.location' is never less than zero.

'info->fs.location' is u32 type, never less than zero.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index a57d17ab91f0..914b93f27469 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -1232,8 +1232,7 @@ int mvpp2_ethtool_cls_rule_ins(struct mvpp2_port *port,
 	struct mvpp2_ethtool_fs *efs, *old_efs;
 	int ret = 0;
 
-	if (info->fs.location >= 4 ||
-	    info->fs.location < 0)
+	if (info->fs.location >= 4)
 		return -EINVAL;
 
 	efs = kzalloc(sizeof(*efs), GFP_KERNEL);
-- 
2.17.1


