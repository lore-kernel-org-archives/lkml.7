Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0C6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34133218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfCUHDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:03:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34012 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfCUHDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:03:19 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2BC0471981955D2E5DCD;
        Thu, 21 Mar 2019 15:03:17 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Mar 2019
 15:03:06 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <keescook@chromium.org>,
        <ktkhai@virtuozzo.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] genetlink: Fix a memory leak on error path
Date:   Thu, 21 Mar 2019 15:02:50 +0800
Message-ID: <20190321070250.20128-1-yuehaibing@huawei.com>
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

In genl_register_family(), when idr_alloc() fails,
we forget to free the memory we possibly allocate for
family->attrbuf.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 2ae0f17df1cd ("genetlink: use idr to track families")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/netlink/genetlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 25eeb6d..f0ec068 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -366,7 +366,7 @@ int genl_register_family(struct genl_family *family)
 			       start, end + 1, GFP_KERNEL);
 	if (family->id < 0) {
 		err = family->id;
-		goto errout_locked;
+		goto errout_free;
 	}
 
 	err = genl_validate_assign_mc_groups(family);
@@ -385,6 +385,7 @@ int genl_register_family(struct genl_family *family)
 
 errout_remove:
 	idr_remove(&genl_fam_idr, family->id);
+errout_free:
 	kfree(family->attrbuf);
 errout_locked:
 	genl_unlock_all();
-- 
2.7.0


