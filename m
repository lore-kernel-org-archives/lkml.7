Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C7EC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26197214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aWd2ZJxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfKFGKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:10:07 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36264 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbfKFGKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:10:06 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA66A2Jt030235
        for <linux-kernel@vger.kernel.org>; Tue, 5 Nov 2019 22:10:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ZNEK/2HxCUlHQJ5GI8dDxUQNL+Ty25u3PZmn8QkENtk=;
 b=aWd2ZJxEnjwy9mWP0mLdjqoDoSC7tBju9kJkVFyv3qvQvMZjsR88H8yginXnZ7BXVcCV
 WMElqehGQJuHsd0eri/rkc0B5sV6c0rNvhUzLg27TdaQozq6uwNwsdLJiR/PxCiSgZ/8
 0uwlkvTDYVlkPfr3i1jUxnWsVvWtjf34y4A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w3ddeugq7-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 22:10:05 -0800
Received: from 2401:db00:30:6012:face:0:17:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 5 Nov 2019 22:09:53 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id DAB0162E36EB; Tue,  5 Nov 2019 22:09:51 -0800 (PST)
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
Subject: [PATCH v5 1/2] mm,thp: recheck each page before collapsing file THP
Date:   Tue, 5 Nov 2019 22:09:29 -0800
Message-ID: <20191106060930.2571389-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106060930.2571389-1-songliubraving@fb.com>
References: <20191106060930.2571389-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_01:2019-11-05,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911060064
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In collapse_file(), for !is_shmem case, current check cannot guarantee
the locked page is up-to-date.  Specifically, xas_unlock_irq() should
not be called before lock_page() and get_page(); and it is necessary to
recheck PageUptodate() after locking the page.

With this bug and CONFIG_READ_ONLY_THP_FOR_FS=y, madvise(HUGE)'ed .text
may contain corrupted data.  This is because khugepaged mistakenly
collapses some not up-to-date sub pages into a huge page, and assumes
the huge page is up-to-date.  This will NOT corrupt data in the disk,
because the page is read-only and never written back.  Fix this by
properly checking PageUptodate() after locking the page.  This check
replaces "VM_BUG_ON_PAGE(!PageUptodate(page), page);".

Also, move PageDirty() check after locking the page.  Current
khugepaged should not try to collapse dirty file THP, because it is
limited to read-only .text. The only case we hit a dirty page here is
when the page hasn't been written since write. Bail out and retry when
this happens.

syzbot reported bug on previous version of this patch.

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Reported-by: syzbot+efb9e48b9fbdc49bb34a@syzkaller.appspotmail.com
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Song Liu <songliubraving@fb.com>

---

[songliubraving@fb.com: v4]
 Link: http://lkml.kernel.org/r/20191022191006.411277-1-songliubraving@fb.com
[songliubraving@fb.com: fix deadlock in collapse_file()]
 Link: http://lkml.kernel.org/r/20191028221414.3685035-1-songliubraving@fb.com
Link: http://lkml.kernel.org/r/20191018180345.4188310-1-songliubraving@fb.com
[songliubraving@fb.com: flush file for !is_shmem PageDirty() case in collapse_file()]
https://lkml.kernel.org/linux-mm/20191030200736.3455046-1-songliubraving@fb.com/

---
 mm/khugepaged.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0a1b4b484ac5..40215795d641 100644
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
+		/* make sure the page is up to date */
+		if (unlikely(!PageUptodate(page))) {
+			result = SCAN_FAIL;
+			goto out_unlock;
+		}

 		/*
 		 * If file was truncated then extended, or hole-punched, before
@@ -1642,6 +1636,16 @@ static void collapse_file(struct mm_struct *mm,
 			goto out_unlock;
 		}

+		if (!is_shmem && PageDirty(page)) {
+			/*
+			 * khugepaged only works on read-only fd, so this
+			 * page is dirty because it hasn't been flushed
+			 * since first write.
+			 */
+			result = SCAN_FAIL;
+			goto out_unlock;
+		}
+
 		if (isolate_lru_page(page)) {
 			result = SCAN_DEL_PAGE_LRU;
 			goto out_unlock;
--
2.17.1
