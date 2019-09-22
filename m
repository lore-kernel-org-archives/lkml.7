Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56E1C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCB32070C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfIVKF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 06:05:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727741AbfIVKF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 06:05:59 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 55743E99B679547D9151;
        Sun, 22 Sep 2019 18:05:57 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sun, 22 Sep
 2019 18:05:47 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] erofs: fix mis-inplace determination related with noio chain
Date:   Sun, 22 Sep 2019 18:04:34 +0800
Message-ID: <20190922100434.229340-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a recent cleanup patch. noio (bypass) chain is
handled asynchronously against submit chain, therefore
inplace I/O or pagevec cannot be applied to such pages.
Add detailed comment for this as well.

Fixes: 97e86a858bc3 ("staging: erofs: tidy up decompression frontend")
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

[ Need stress for more hours on phones to catch this race.
  No more smoke out till now on latest mainline for our
  stress I/O & memory workloads compared with old versions. ]

 fs/erofs/zdata.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 96e34c90f814..fad80c97d247 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -575,7 +575,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	struct erofs_map_blocks *const map = &fe->map;
 	struct z_erofs_collector *const clt = &fe->clt;
 	const loff_t offset = page_offset(page);
-	bool tight = (clt->mode >= COLLECT_PRIMARY_HOOKED);
+	bool tight = true;
 
 	enum z_erofs_cache_alloctype cache_strategy;
 	enum z_erofs_page_type page_type;
@@ -628,8 +628,16 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
 				 cache_strategy, pagepool);
 
-	tight &= (clt->mode >= COLLECT_PRIMARY_HOOKED);
 hitted:
+	/*
+	 * Ensure the current partial page belongs to this submit chain rather
+	 * than other concurrent submit chains or the noio(bypass) chain since
+	 * those chains are handled asynchronously thus the page cannot be used
+	 * for inplace I/O or pagevec (should be processed in strict order.)
+	 */
+	tight &= (clt->mode >= COLLECT_PRIMARY_HOOKED &&
+		  clt->mode != COLLECT_PRIMARY_FOLLOWED_NOINPLACE);
+
 	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
-- 
2.17.1

