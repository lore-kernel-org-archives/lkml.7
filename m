Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18093C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE66920854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EmnAyXTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbfJPHis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:38:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56144 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbfJPHis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:38:48 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G7Z421009054
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:38:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=5XOqhNR1oYjQKzKi/BOcNoUUF5+GyL1uiCud6eTs4WQ=;
 b=EmnAyXTCC6IaOeAylreWmYEFaFaC86iQvxYnsadI7EZPie02NsNcfvea+azo9Xt9MG4d
 XjfuEgwmGc4HQ3oqCzgcMCBlzjqoZJ6CGfTQdTsyzA1Dhmdw6bFgy3NyWVmOHOPXSyKj
 SGAAHPwO0RZBSQRGpIaxvROvBwnWjh7ulDo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vn8jv60et-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:38:47 -0700
Received: from 2401:db00:30:6007:face:0:1:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 16 Oct 2019 00:38:45 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 15F5862E2A2F; Wed, 16 Oct 2019 00:38:45 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 3/4] mm/thp: allow drop THP from page cache
Date:   Wed, 16 Oct 2019 00:37:30 -0700
Message-ID: <20191016073731.4076725-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016073731.4076725-1-songliubraving@fb.com>
References: <20191016073731.4076725-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_03:2019-10-15,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=582 phishscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160070
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Once a THP is added to the page cache, it cannot be dropped via
/proc/sys/vm/drop_caches. Fix this issue with proper handling in
invalidate_mapping_pages() and __remove_mapping().

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/truncate.c | 12 ++++++++++++
 mm/vmscan.c   |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 8563339041f6..dd9ebc1da356 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -592,6 +592,16 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					unlock_page(page);
 					continue;
 				}
+
+				/* Take a pin outside pagevec */
+				get_page(page);
+
+				/*
+				 * Drop extra pins before trying to invalidate
+				 * the huge page.
+				 */
+				pagevec_remove_exceptionals(&pvec);
+				pagevec_release(&pvec);
 			}
 
 			ret = invalidate_inode_page(page);
@@ -602,6 +612,8 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 			 */
 			if (!ret)
 				deactivate_file_page(page);
+			if (PageTransHuge(page))
+				put_page(page);
 			count += ret;
 		}
 		pagevec_remove_exceptionals(&pvec);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c6659bb758a4..1d80a188ad4a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -932,7 +932,8 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	 * Note that if SetPageDirty is always performed via set_page_dirty,
 	 * and thus under the i_pages lock, then this ordering is not required.
 	 */
-	if (unlikely(PageTransHuge(page)) && PageSwapCache(page))
+	if (unlikely(PageTransHuge(page)) &&
+			(PageSwapCache(page) || !PageSwapBacked(page)))
 		refcount = 1 + HPAGE_PMD_NR;
 	else
 		refcount = 2;
-- 
2.17.1

