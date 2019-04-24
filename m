Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5D2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025A9218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfDXGn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:43:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42082 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbfDXGn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:43:28 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3EC467775C670794A6CA;
        Wed, 24 Apr 2019 14:43:26 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Apr 2019
 14:43:16 +0800
From:   Xiaojun Wang <wangxiaojun11@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <wangxiaojun11@huawei.com>
Subject: [f2fs-dev] [PATCH] f2fs-tools:fix memory leak in write dquot
Date:   Wed, 24 Apr 2019 14:47:42 +0800
Message-ID: <1556088462-21693-1-git-send-email-wangxiaojun11@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch free ddquot in qtree_write_dquot to avoid memory leak

Signed-off-by: Xiaojun Wang <wangxiaojun11@huawei.com>
---
 fsck/quotaio_tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/quotaio_tree.c b/fsck/quotaio_tree.c
index ebee862..de25a60 100644
--- a/fsck/quotaio_tree.c
+++ b/fsck/quotaio_tree.c
@@ -353,6 +353,7 @@ int qtree_write_dquot(struct dquot *dquot)
 	if (ret != info->dqi_entry_size) {
 		log_err("Quota write failed (id %u): %s",
 			(unsigned int)dquot->dq_id, strerror(errno));
+		quota_free_mem(&ddquot);
 		return ret;
 	}
 	quota_free_mem(&ddquot);
-- 
2.7.4

