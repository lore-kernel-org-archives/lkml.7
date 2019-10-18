Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C14CCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE0421D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UMvBPf6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505669AbfJRSD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:03:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29880 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbfJRSD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:03:57 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9II2wBw008978
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:03:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=C9I2JQCkwhgmNcawYjp9ktOND4N69jgabqizXoyl1NM=;
 b=UMvBPf6ZOMQ+Dpt3VIm/m96Oaq/2F6zAAXBbRvJsMk0/g/2cGkWfmmPE6rcwAX10HKM6
 3LL4UtpA5H7DxM+WEfGC0S4/MXer+TitoyTneCwedZSncePeAl+dB3/NzHRAI8Pqmm4b
 IPOxj5Ry7kKWJSAg6VAHcOBDPnJYWT3n+Yk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vqhgjr8g2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:03:56 -0700
Received: from 2401:db00:30:6007:face:0:1:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 18 Oct 2019 11:03:50 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 2CA3962E1ADD; Fri, 18 Oct 2019 11:03:49 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3] mm,thp: recheck each page before collapsing file THP
Date:   Fri, 18 Oct 2019 11:03:45 -0700
Message-ID: <20191018180345.4188310-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_04:2019-10-18,2019-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=926 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180164
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In collapse_file(), after locking the page, it is necessary to recheck
that the page is up-to-date. Add PageUptodate() check for both shmem THP
and file THP.

Current khugepaged should not try to collapse dirty file THP, because it
is limited to read only text. Add a PageDirty check and warning for file
THP. This is added after page_mapping() check, because if the page is
truncated, it might be dirty.

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Song Liu <songliubraving@fb.com>

---
Changes v1 => v2:
Rearrange the checks per feedback from Johannes, Rik, and Kirill.

Changes v2 => v3:
Remove redudant checks before trylock_page(). (Johannes)
---
 mm/khugepaged.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0a1b4b484ac5..e20bb9d3482d 100644
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
@@ -1642,6 +1636,15 @@ static void collapse_file(struct mm_struct *mm,
 			goto out_unlock;
 		}
 
+		/*
+		 * khugepaged should not try to collapse dirty pages for
+		 * file THP. Show warning if this somehow happens.
+		 */
+		if (WARN_ON_ONCE(!is_shmem && PageDirty(page))) {
+			result = SCAN_FAIL;
+			goto out_unlock;
+		}
+
 		if (isolate_lru_page(page)) {
 			result = SCAN_DEL_PAGE_LRU;
 			goto out_unlock;
-- 
2.17.1

