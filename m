Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3882EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115FF2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DUVDHpee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfFMRMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:12:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46606 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729008AbfFLWG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 18:06:59 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CLxUYH009662
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 15:06:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=IZysbkBOWuoojpHfDDSz6omhgc5cHCXvaawoTaDfhK0=;
 b=DUVDHpeehWi10Lab//cDJwDOb/LI4bsHpLt5aH50Rgna7p8/rCnjYziNeuis0xU0Wxws
 jfRURV1mTQbo2ldDDAYkYwWv7EwKRnaLoj2tPFSsi1yqOxUQeMk+3cyfGWoYULT+FU/k
 Czvqi3Ku+4e2072gRPXrVbJCSLzjTDFnxS0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t3338hk8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 15:06:57 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 12 Jun 2019 15:06:14 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 04C3C62E2CFA; Wed, 12 Jun 2019 15:03:41 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <namit@vmware.com>, <peterz@infradead.org>, <oleg@redhat.com>,
        <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 4/5] uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT
Date:   Wed, 12 Jun 2019 15:03:18 -0700
Message-ID: <20190612220320.2223898-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612220320.2223898-1-songliubraving@fb.com>
References: <20190612220320.2223898-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=730 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120153
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches uses newly added FOLL_SPLIT_PMD in uprobe. This enables easy
regroup of huge pmd after the uprobe is disabled (in next patch).

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/uprobes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f7c61a1ef720..a20d7b43a056 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -153,7 +153,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct page_vma_mapped_walk pvmw = {
-		.page = old_page,
+		.page = compound_head(old_page),
 		.vma = vma,
 		.address = addr,
 	};
@@ -165,8 +165,6 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, addr,
 				addr + PAGE_SIZE);
 
-	VM_BUG_ON_PAGE(PageTransHuge(old_page), old_page);
-
 	if (!orig) {
 		err = mem_cgroup_try_charge(new_page, vma->vm_mm, GFP_KERNEL,
 					    &memcg, false);
@@ -483,7 +481,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 retry:
 	/* Read the page with vaddr into memory */
 	ret = get_user_pages_remote(NULL, mm, vaddr, 1,
-			FOLL_FORCE | FOLL_SPLIT, &old_page, &vma, NULL);
+			FOLL_FORCE | FOLL_SPLIT_PMD, &old_page, &vma, NULL);
 	if (ret <= 0)
 		return ret;
 
-- 
2.17.1

