Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 02:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B29A20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 02:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfCYCva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 22:51:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43406 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729154AbfCYCv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 22:51:29 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D9E78FA6F3661C05EE9B;
        Mon, 25 Mar 2019 10:51:26 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Mon, 25 Mar 2019
 10:51:20 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <gerrit@erg.abdn.ac.uk>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dccp@vger.kernel.org>, <mojha@codeaurora.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v3] dccp: Fix memleak in __feat_register_sp
Date:   Mon, 25 Mar 2019 10:41:06 +0800
Message-ID: <20190325024106.10808-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

If dccp_feat_push_change fails, we forget free the mem
which is alloced by kmemdup in dccp_feat_clone_sp_val.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e8ef967a54f4 ("dccp: Registration routines for changing feature values")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v3: fix compile issue, sorry for this again
v2: kfree 'val --> 'fval'
---
 net/dccp/feat.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/dccp/feat.c b/net/dccp/feat.c
index f227f00..db87d9f 100644
--- a/net/dccp/feat.c
+++ b/net/dccp/feat.c
@@ -738,7 +738,12 @@ static int __feat_register_sp(struct list_head *fn, u8 feat, u8 is_local,
 	if (dccp_feat_clone_sp_val(&fval, sp_val, sp_len))
 		return -ENOMEM;
 
-	return dccp_feat_push_change(fn, feat, is_local, mandatory, &fval);
+	if (dccp_feat_push_change(fn, feat, is_local, mandatory, &fval)) {
+		kfree(fval.sp.vec);
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 /**
-- 
2.7.4


