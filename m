Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DEEC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF5C20880
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Gv5UZLvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbfHGXhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:37:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17334 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389185AbfHGXhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:37:38 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77NXfme023061
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 16:37:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=LjmLHqeEBIcPM1EzxLLHUMjC3IQ3Iyup262DaJYHDoM=;
 b=Gv5UZLvIQpk3H5o9jYYsuAFPeT+5OaaAH9R4uN6i5nQ3Gskfy9CClU5zuv5DP2v/byKQ
 4v5SRjemSgck2QGK6iKRQWBviTZExsycZqi7esWLI27m2y6lE2oCe7Sg9/t57O0TNa59
 0xG5IKVQ8t0sxSRPn9CNiAZeuedzqIT2L8w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u87ue83xw-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 16:37:36 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Aug 2019 16:37:35 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id F006D62E2D9E; Wed,  7 Aug 2019 16:37:34 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <oleg@redhat.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <srikar@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v12 1/6] mm: move memcmp_pages() and pages_identical()
Date:   Wed, 7 Aug 2019 16:37:24 -0700
Message-ID: <20190807233729.3899352-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807233729.3899352-1-songliubraving@fb.com>
References: <20190807233729.3899352-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=976 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070208
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves memcmp_pages() to mm/util.c and pages_identical() to
mm.h, so that we can use them in other files.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/mm.h |  7 +++++++
 mm/ksm.c           | 18 ------------------
 mm/util.c          | 13 +++++++++++++
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0334ca97c584..f189176dabed 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2891,5 +2891,12 @@ void __init setup_nr_node_ids(void);
 static inline void setup_nr_node_ids(void) {}
 #endif
 
+extern int memcmp_pages(struct page *page1, struct page *page2);
+
+static inline int pages_identical(struct page *page1, struct page *page2)
+{
+	return !memcmp_pages(page1, page2);
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/mm/ksm.c b/mm/ksm.c
index 3dc4346411e4..dbee2eb4dd05 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1029,24 +1029,6 @@ static u32 calc_checksum(struct page *page)
 	return checksum;
 }
 
-static int memcmp_pages(struct page *page1, struct page *page2)
-{
-	char *addr1, *addr2;
-	int ret;
-
-	addr1 = kmap_atomic(page1);
-	addr2 = kmap_atomic(page2);
-	ret = memcmp(addr1, addr2, PAGE_SIZE);
-	kunmap_atomic(addr2);
-	kunmap_atomic(addr1);
-	return ret;
-}
-
-static inline int pages_identical(struct page *page1, struct page *page2)
-{
-	return !memcmp_pages(page1, page2);
-}
-
 static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 			      pte_t *orig_pte)
 {
diff --git a/mm/util.c b/mm/util.c
index e6351a80f248..0d5e2f425612 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -783,3 +783,16 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 out:
 	return res;
 }
+
+int memcmp_pages(struct page *page1, struct page *page2)
+{
+	char *addr1, *addr2;
+	int ret;
+
+	addr1 = kmap_atomic(page1);
+	addr2 = kmap_atomic(page2);
+	ret = memcmp(addr1, addr2, PAGE_SIZE);
+	kunmap_atomic(addr2);
+	kunmap_atomic(addr1);
+	return ret;
+}
-- 
2.17.1

