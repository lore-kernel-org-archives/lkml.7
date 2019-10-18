Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD779CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5FF21835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BYLI6YFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441997AbfJRFIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:08:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40770 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726417AbfJRFIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:08:42 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I58ZPZ001251
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:08:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=z9MSPK39uBz8e7F9RtpOEmvL2JBZ9AR2BPSiBxoNbc0=;
 b=BYLI6YFR7zrjZcXkkXRcAYu4kLp0WDg5Y5hjPmon+rMbqVVs2yk3HgJPD5qujIw+nkOR
 lrdKE9ShYOc32meSBOlsFsPV3jUF9C4jdv/Vxx3I+Ub85Wvm8IOIYxhLy7L8ORdAAfrI
 Xy5gimLIE+FEoix/byX+P16nbhug6LkPaeE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpj8rwd5r-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:08:41 -0700
Received: from 2401:db00:2050:5076:face:0:7:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 22:08:38 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1100F62E3675; Thu, 17 Oct 2019 22:08:37 -0700 (PDT)
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
Subject: [PATCH] mm,thp: recheck each page before collapsing file THP
Date:   Thu, 17 Oct 2019 22:08:32 -0700
Message-ID: <20191018050832.1251306-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_01:2019-10-17,2019-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=866
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180048
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In collapse_file(), after locking the page, it is necessary to recheck
that the page is up-to-date, clean, and pointing to the proper mapping.
If any check fails, abort the collapse.

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/khugepaged.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0a1b4b484ac5..7da49b643c4d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1619,6 +1619,14 @@ static void collapse_file(struct mm_struct *mm,
 				result = SCAN_PAGE_LOCK;
 				goto xa_locked;
 			}
+
+			/* double check the page is correct and clean */
+			if (unlikely(!PageUptodate(page)) ||
+			    unlikely(PageDirty(page)) ||
+			    unlikely(page->mapping != mapping)) {
+				result = SCAN_FAIL;
+				goto out_unlock;
+			}
 		}
 
 		/*
-- 
2.17.1

