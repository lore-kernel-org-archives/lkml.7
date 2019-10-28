Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3437FCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A2321479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oMY63gGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfJ1WOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:14:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20486 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbfJ1WOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:14:53 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9SMEOLS006339
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 15:14:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Bw61RvUeSt9VNy7+1JLmIxhGU2iP6hPAzoxy1ZqvJxw=;
 b=oMY63gGir0KBr8MtiFGbx8ob022AEWHr05oWHbxiyPKBh814KA/APENpXYuKHB9T2gxY
 F2NhRU4fb369erWmTKI4LKjgNmCqDyOxs6zKIHZJAhss8TQY5gfqfQuaDbFUPrRaBN91
 bOH68Sa3rbHZOz91bji/713np3jvVDZhxY4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vvkyhu5ce-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 15:14:52 -0700
Received: from 2401:db00:2050:5076:face:0:1f:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 28 Oct 2019 15:14:16 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 058A762E2077; Mon, 28 Oct 2019 15:14:15 -0700 (PDT)
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
Subject: [PATCH] mm/thp: fix deadlock in collapse_file()
Date:   Mon, 28 Oct 2019 15:14:14 -0700
Message-ID: <20191028221414.3685035-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_07:2019-10-28,2019-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=882 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910280207
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As syzbot reported, we cannot call filemap_flush() with the page locked.
Remove the filemap_flush() as it is not required. khugepaged would just
wait until the page is flushed naturally.

Reported-by: syzbot+efb9e48b9fbdc49bb34a@syzkaller.appspotmail.com
Fixes: 9d840e58caa0 ("mmthp-recheck-each-page-before-collapsing-file-thp-v4")
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/khugepaged.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cd480dce92c6..3ec5333ae94d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1640,16 +1640,8 @@ static void collapse_file(struct mm_struct *mm,
 			/*
 			 * khugepaged only works on read-only fd, so this
 			 * page is dirty because it hasn't been flushed
-			 * since first write. There won't be new dirty
-			 * pages.
-			 *
-			 * Trigger async flush here and hope the writeback
-			 * is done when khugepaged revisits this page.
-			 *
-			 * This is a one-off situation. We are not forcing
-			 * writeback in loop.
+			 * since first write.
 			 */
-			filemap_flush(mapping);
 			result = SCAN_FAIL;
 			goto out_unlock;
 		}
-- 
2.17.1

