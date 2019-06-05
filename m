Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF2AC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB78206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfFEOQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:16:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18085 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728116AbfFEOQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:16:47 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0A7A0CBCC519B925B9D5;
        Wed,  5 Jun 2019 22:16:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 5 Jun 2019 22:16:35 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        <cluster-devel@redhat.com>
Subject: [PATCH] fs: gfs2: Use IS_ERR_OR_NULL
Date:   Wed, 5 Jun 2019 22:24:24 +0800
Message-ID: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IS_ERR_OR_NULL where appropriate.

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/gfs2/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index db9a05244a35..3925efd3fd83 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -857,7 +857,7 @@ static struct gfs2_dirent *gfs2_dirent_search(struct inode *inode,
 		return ERR_PTR(error);
 	dent = gfs2_dirent_scan(inode, bh->b_data, bh->b_size, scan, name, NULL);
 got_dent:
-	if (unlikely(dent == NULL || IS_ERR(dent))) {
+	if (IS_ERR_OR_NULL(dent)) {
 		brelse(bh);
 		bh = NULL;
 	}
-- 
2.20.1

