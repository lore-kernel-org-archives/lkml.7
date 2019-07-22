Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE2CC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C4421953
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfGVCvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 22:51:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728886AbfGVCv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:51:27 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EEA9D1EB6F46BBC47F4D;
        Mon, 22 Jul 2019 10:51:23 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 10:51:16 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v3 19/24] erofs: add erofs_allocpage()
Date:   Mon, 22 Jul 2019 10:50:38 +0800
Message-ID: <20190722025043.166344-20-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722025043.166344-1-gaoxiang25@huawei.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces an temporary _on-stack_ page
pool to reuse the freed page directly as much as
it can for better performance and release all pages
at a time, it also slightly reduces the possibility of
the potential memory allocation failure.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/internal.h |  2 ++
 fs/erofs/utils.c    | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index dc5c6c5e4885..506a68efe507 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -495,6 +495,8 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 extern const struct file_operations erofs_dir_fops;
 
 /* utils.c */
+struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp, bool nofail);
+
 #if (EROFS_PCPUBUF_NR_PAGES > 0)
 void *erofs_get_pcpubuf(unsigned int pagenr);
 #define erofs_put_pcpubuf(buf) do { \
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index c430790a02e0..53ee6daa3f70 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -9,6 +9,20 @@
 #include "internal.h"
 #include <linux/pagevec.h>
 
+struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp, bool nofail)
+{
+	struct page *page;
+
+	if (!list_empty(pool)) {
+		page = lru_to_page(pool);
+		DBG_BUGON(page_ref_count(page) != 1);
+		list_del(&page->lru);
+	} else {
+		page = alloc_pages(gfp | (nofail ? __GFP_NOFAIL : 0), 0);
+	}
+	return page;
+}
+
 #if (EROFS_PCPUBUF_NR_PAGES > 0)
 static struct {
 	u8 data[PAGE_SIZE * EROFS_PCPUBUF_NR_PAGES];
-- 
2.17.1

