Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E24CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC2721872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VJJXGG+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbfJVTKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:10:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46202 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731436AbfJVTKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:10:51 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9MJAUq6026599
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 12:10:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=K7W6Cq68GUV+oF3NKZ7ALy9xAKZZYUngRToXuNpGikY=;
 b=VJJXGG+6FUX+J0ijs1vIb56b2s8RSj2WQbPQlx7XgGFUHcqq8DARUFJLdXjo/5LWkztS
 hU5vqwmgvgW4+Ga3Q6wQj2ennWK26+FXBrgBvoPAGTWCfeMzS6uiNhv3m2FW0Mwf26DT
 iXwaw/tli2P6MRQPuaqQ4g2z6zkUQc5eAs8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vsn6853r8-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 12:10:49 -0700
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 22 Oct 2019 12:10:17 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 27F5A62E1F04; Tue, 22 Oct 2019 12:10:17 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Hugh Dickins <hughd@google.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4] mm,thp: recheck each page before collapsing file THP
Date:   Tue, 22 Oct 2019 12:10:06 -0700
Message-ID: <20191022191006.411277-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_03:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220160
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In collapse_file(), for !is_shmem case, current check cannot guarantee
the locked page is up-to-date. Specifically, xas_unlock_irq() should not
be called before lock_page() and get_page(); and it is necessary to
recheck PageUptodate() after locking the page.

With this bug and CONFIG_READ_ONLY_THP_FOR_FS=y, madvise(HUGE)'ed .text
may contain corrupted data. This is because khugepaged mistakenly
collapses some not up-to-date sub pages into a huge page, and assumes the
huge page is up-to-date. This will NOT corrupt data in the disk, because
the page is read-only and never written back. Fix this by properly
checking PageUptodate() after locking the page. This check replaces
"VM_BUG_ON_PAGE(!PageUptodate(page), page);".

Also, move PageDirty() check after locking the page. Current khugepaged
only collapse read-only .text. Therefore, the page could only be dirty
if it hasn't been flushed since first write. In such case, calls
filemap_flush() and defer the collapse.

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Song Liu <songliubraving@fb.com>

---
Changes v1 => v2:
Rearrange the checks per feedback from Johannes, Rik, and Kirill.

Changes v2 => v3:
Remove redudant checks before trylock_page().

Changes v3 => v4:
Rewrite commit log.
Trigger filemap_flush() for PageDirty() case. This covers one-off
situation, where the file hasn't been flushed since first write.
---
 mm/khugepaged.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0a1b4b484ac5..cd480dce92c6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1601,17 +1601,6 @@ static void collapse_file(struct mm_struct *mm,
 					result = SCAN_FAIL;
 					goto xa_unlocked;
 				}
-			} else if (!PageUptodate(page)) {
-				xas_unlock_irq(&xas);
-				wait_on_page_locked(page);
-				if (!trylock_page(page)) {
-					result = SCAN_PAGE_LOCK;
-					goto xa_unlocked;
-				}
-				get_page(page);
-			} else if (PageDirty(page)) {
-				result = SCAN_FAIL;
-				goto xa_locked;
 			} else if (trylock_page(page)) {
 				get_page(page);
 				xas_unlock_irq(&xas);
@@ -1626,7 +1615,12 @@ static void collapse_file(struct mm_struct *mm,
 		 * without racing with truncate.
 		 */
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		VM_BUG_ON_PAGE(!PageUptodate(page), page);
+
+		/* double check the page is up to date */
+		if (unlikely(!PageUptodate(page))) {
+			result = SCAN_FAIL;
+			goto out_unlock;
+		}
 
 		/*
 		 * If file was truncated then extended, or hole-punched, before
@@ -1642,6 +1636,24 @@ static void collapse_file(struct mm_struct *mm,
 			goto out_unlock;
 		}
 
+		if (!is_shmem && PageDirty(page)) {
+			/*
+			 * khugepaged only works on read-only fd, so this
+			 * page is dirty because it hasn't been flushed
+			 * since first write. There won't be new dirty
+			 * pages.
+			 *
+			 * Trigger async flush here and hope the writeback
+			 * is done when khugepaged revisits this page.
+			 *
+			 * This is a one-off situation. We are not forcing
+			 * writeback in loop.
+			 */
+			filemap_flush(mapping);
+			result = SCAN_FAIL;
+			goto out_unlock;
+		}
+
 		if (isolate_lru_page(page)) {
 			result = SCAN_DEL_PAGE_LRU;
 			goto out_unlock;
-- 
2.17.1

