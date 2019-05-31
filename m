Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF2AC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E25226BCA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfEaQLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:11:47 -0400
Received: from smtprz14.163.net ([106.3.154.247]:36482 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfEaQLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:11:47 -0400
Received: from my-app01.tom.com (my-app01.tom.com [127.0.0.1])
        by freemail01.tom.com (Postfix) with ESMTP id 38A5B1C81BB1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 23:50:59 +0800 (CST)
Received: from my-app01.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app01 (TOM SMTP Server) with SMTP ID 390728459
          for <linux-kernel@vger.kernel.org>;
          Fri, 31 May 2019 23:50:59 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail01.tom.com (Postfix) with ESMTP id 5CFC71C81B97
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 23:50:58 +0800 (CST)
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 583E510018B7
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 23:50:58 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PcrpKDZU1KxI for <linux-kernel@vger.kernel.org>;
        Fri, 31 May 2019 23:50:57 +0800 (CST)
Received: from localhost (unknown [222.209.18.96])
        by antispam1.tom.com (Postfix) with ESMTPA id 317E3100112A;
        Fri, 31 May 2019 23:50:57 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com, Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH v2] fs: buffer: fix fully_mapped reset in block_read_full_page()
Date:   Fri, 31 May 2019 23:50:51 +0800
Message-Id: <1559317851-3861-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because get_block() might set the buffer mapped, fully_mapped reset 
should be done according to the result of buffer_mapped(bh) 
which check the buffer mapped attribute again after get_block().

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---

Changes in v2:
 change comment

 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e450c55..987aadb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2243,7 +2243,6 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 		if (!buffer_mapped(bh)) {
 			int err = 0;
 
-			fully_mapped = 0;
 			if (iblock < lblock) {
 				WARN_ON(bh->b_size != blocksize);
 				err = get_block(inode, iblock, bh, 0);
@@ -2251,6 +2250,7 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 					SetPageError(page);
 			}
 			if (!buffer_mapped(bh)) {
+				fully_mapped = 0;
 				zero_user(page, i * blocksize, blocksize);
 				if (!err)
 					set_buffer_uptodate(bh);
-- 
1.9.1

