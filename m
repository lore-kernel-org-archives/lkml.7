Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC40CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A3B21835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mm7bQFO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405899AbfJRQiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:38:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43250 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732414AbfJRQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:38:06 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9IGXmUS027369
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:38:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=PhTOTrjxoPmCb5GN/6+zqpHWtyFNQ5eG+ujeT7hG9pk=;
 b=mm7bQFO7i/ABJ0h27pt06gAzZI3SL60tFA1WrzGWWqKdHMZaX2lOPOsel2hF5sDvZA3D
 Qrv4jOPpG0S0C5b+K9ZEjfNmZQ+FpRjAzW69y2fPpN/1apHgo33B2oMxIX3Ss7fwShxy
 wH7/pZ1jESf+cfPy9BsemrSP23BW43cDikI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpw9rcmb7-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:38:04 -0700
Received: from 2401:db00:2120:80e1:face:0:29:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 18 Oct 2019 09:38:01 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 7B46662E1976; Fri, 18 Oct 2019 09:37:56 -0700 (PDT)
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
Subject: [PATCH v2] mm,thp: recheck each page before collapsing file THP
Date:   Fri, 18 Oct 2019 09:37:54 -0700
Message-ID: <20191018163754.3736610-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_04:2019-10-18,2019-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=843
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180150
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

---
 mm/khugepaged.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0a1b4b484ac5..40c549302d36 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1626,7 +1626,12 @@ static void collapse_file(struct mm_struct *mm,
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
@@ -1642,6 +1647,15 @@ static void collapse_file(struct mm_struct *mm,
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

