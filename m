Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0222FA3735
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BF021925
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="e0lDytQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502859AbfJQQmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:42:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12450 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502698AbfJQQmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:42:51 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9HGV6r4003253
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:42:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=mxxwNAzZrls6tfJ060ELcx7ju3XNeq5KMWMl6d4cOI4=;
 b=e0lDytQZcDJTqZKRJP4dEBlfVzKaPES42qqQyByt/YglezV5nzbEQ7GxkLkVVMqLGQJ7
 yBYOWn3C3ZJ9TguQ0tDGt9vsviD7RW8Y/tVRllI8X6kWSz7sAqmBSPL5TYbSgF2tYNkc
 mU0pyjwGiHfVLK8GWk5ovDIgHys7upo1a6s= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vp5k0e28t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:42:50 -0700
Received: from 2401:db00:2120:81ca:face:0:31:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 17 Oct 2019 09:42:49 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 5892662E1477; Thu, 17 Oct 2019 09:42:47 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 3/5] mm: Support removing arbitrary sized pages from mapping
Date:   Thu, 17 Oct 2019 09:42:20 -0700
Message-ID: <20191017164223.2762148-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017164223.2762148-1-songliubraving@fb.com>
References: <20191017164223.2762148-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_05:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=2 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=607
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910170149
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Kucharski <william.kucharski@oracle.com>

__remove_mapping() assumes that pages can only be either base pages
or HPAGE_PMD_SIZE.  Ask the page what size it is.

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Signed-off-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/vmscan.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c6659bb758a4..f870da1f4bb7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -932,10 +932,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	 * Note that if SetPageDirty is always performed via set_page_dirty,
 	 * and thus under the i_pages lock, then this ordering is not required.
 	 */
-	if (unlikely(PageTransHuge(page)) && PageSwapCache(page))
-		refcount = 1 + HPAGE_PMD_NR;
-	else
-		refcount = 2;
+	refcount = 1 + compound_nr(page);
 	if (!page_ref_freeze(page, refcount))
 		goto cannot_free;
 	/* note: atomic_cmpxchg in page_ref_freeze provides the smp_rmb */
-- 
2.17.1

