Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37CCCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B445121920
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406239AbfJWNzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:55:20 -0400
Received: from out28-146.mail.aliyun.com ([115.124.28.146]:58893 "EHLO
        out28-146.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406181AbfJWNzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:55:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1084395|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.434615-0.0129558-0.552429;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03312;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.FpNUs9Y_1571838908;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.FpNUs9Y_1571838908)
          by smtp.aliyun-inc.com(10.194.97.246);
          Wed, 23 Oct 2019 21:55:09 +0800
From:   Liu Xiang <liuxiang_1999@126.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, liuxiang_1999@126.com
Subject: [PATCH] mm: gup: fix comment of __get_user_pages()
Date:   Wed, 23 Oct 2019 21:51:47 +0800
Message-Id: <1571838707-4994-1-git-send-email-liuxiang_1999@126.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because nr_pages is unsigned long, it can not be negative.

Signed-off-by: Liu Xiang <liuxiang_1999@126.com>
---
 mm/gup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 8f236a3..0236954 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -735,10 +735,10 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
  * @nonblocking: whether waiting for disk IO or mmap_sem contention
  *
  * Returns number of pages pinned. This may be fewer than the number
- * requested. If nr_pages is 0 or negative, returns 0. If no pages
- * were pinned, returns -errno. Each page returned must be released
- * with a put_page() call when it is finished with. vmas will only
- * remain valid while mmap_sem is held.
+ * requested. If nr_pages is 0, returns 0. If no pages were pinned,
+ * returns -errno. Each page returned must be released with a
+ * put_page() call when it is finished with. vmas will only remain
+ * valid while mmap_sem is held.
  *
  * Must be called with mmap_sem held.  It may be released.  See below.
  *
-- 
1.9.1

