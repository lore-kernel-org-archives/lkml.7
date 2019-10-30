Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AC6CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1C12087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfJ3NwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:52:23 -0400
Received: from out28-125.mail.aliyun.com ([115.124.28.125]:51445 "EHLO
        out28-125.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfJ3NwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:52:21 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09516023|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.224792-0.0144767-0.760731;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03291;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.FsZxaJ3_1572443539;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.FsZxaJ3_1572443539)
          by smtp.aliyun-inc.com(10.194.98.253);
          Wed, 30 Oct 2019 21:52:19 +0800
From:   Liu Xiang <liuxiang_1999@126.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        liuxiang_1999@126.com
Subject: [PATCH v3] mm: gup: fix comments of __get_user_pages() and get_user_pages_remote()
Date:   Wed, 30 Oct 2019 21:52:13 +0800
Message-Id: <1572443533-3118-1-git-send-email-liuxiang_1999@126.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comments of __get_user_pages() and get_user_pages_remote(),
make them more clear.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Liu Xiang <liuxiang_1999@126.com>

---

Changes in v3:
 as suggested by John, apply the same fix to get_user_pages_remote().
---
 mm/gup.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 8f236a3..c36c621 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -734,11 +734,17 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
  *		Or NULL if the caller does not require them.
  * @nonblocking: whether waiting for disk IO or mmap_sem contention
  *
- * Returns number of pages pinned. This may be fewer than the number
- * requested. If nr_pages is 0 or negative, returns 0. If no pages
- * were pinned, returns -errno. Each page returned must be released
- * with a put_page() call when it is finished with. vmas will only
- * remain valid while mmap_sem is held.
+ * Returns either number of pages pinned (which may be less than the
+ * number requested), or an error. Details about the return value:
+ *
+ * -- If nr_pages is 0, returns 0.
+ * -- If nr_pages is >0, but no pages were pinned, returns -errno.
+ * -- If nr_pages is >0, and some pages were pinned, returns the number of
+ *    pages pinned. Again, this may be less than nr_pages.
+ *
+ * The caller is responsible for releasing returned @pages, via put_page().
+ *
+ * @vmas are valid only as long as mmap_sem is held.
  *
  * Must be called with mmap_sem held.  It may be released.  See below.
  *
@@ -1107,11 +1113,17 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
  *		subsequently whether VM_FAULT_RETRY functionality can be
  *		utilised. Lock must initially be held.
  *
- * Returns number of pages pinned. This may be fewer than the number
- * requested. If nr_pages is 0 or negative, returns 0. If no pages
- * were pinned, returns -errno. Each page returned must be released
- * with a put_page() call when it is finished with. vmas will only
- * remain valid while mmap_sem is held.
+ * Returns either number of pages pinned (which may be less than the
+ * number requested), or an error. Details about the return value:
+ *
+ * -- If nr_pages is 0, returns 0.
+ * -- If nr_pages is >0, but no pages were pinned, returns -errno.
+ * -- If nr_pages is >0, and some pages were pinned, returns the number of
+ *    pages pinned. Again, this may be less than nr_pages.
+ *
+ * The caller is responsible for releasing returned @pages, via put_page().
+ *
+ * @vmas are valid only as long as mmap_sem is held.
  *
  * Must be called with mmap_sem held for read or write.
  *
-- 
1.9.1

