Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B6BECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC53217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WEqJD3pH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390174AbfJPHjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:39:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33584 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbfJPHjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:39:20 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G7cA5K009678
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:39:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=9YL48c8sA85SUwytp3BDEyL/Vk45Rf8+qPMvMrZQs/Q=;
 b=WEqJD3pH0WfXYeis4eYwfzTE9AZruyfyYlsdTwXo4+3MLGR1h2rewEdt2Za6cL7CNKPU
 7hqcNNZZfJh9KmkkyHuAkBqrbGXH+4LnhAezW1KSo2q3kUkGmYX+o7CQihcmY3dNV9Qh
 2n9FL17T6rNYDkqm2gbeCfYq4o+vCvptNEY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vnmy2a9ht-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:39:18 -0700
Received: from 2401:db00:2120:81ca:face:0:31:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Oct 2019 00:39:16 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 2003D62E2A2F; Wed, 16 Oct 2019 00:39:16 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, Song Liu <songliubraving@fb.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 4/4] uprobe: only do FOLL_SPLIT_PMD for uprobe register
Date:   Wed, 16 Oct 2019 00:37:31 -0700
Message-ID: <20191016073731.4076725-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016073731.4076725-1-songliubraving@fb.com>
References: <20191016073731.4076725-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_03:2019-10-15,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 mlxlogscore=887 bulkscore=0
 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160071
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attaching uprobe to text section in THP splits the PMD mapped page table
into PTE mapped entries. On uprobe detach, we would like to regroup PMD
mapped page table entry to regain performance benefit of THP.

However, the regroup is broken For perf_event based trace_uprobe. This is
because perf_event based trace_uprobe calls uprobe_unregister twice on
close: first in TRACE_REG_PERF_CLOSE, then in TRACE_REG_PERF_UNREGISTER.
The second call will split the PMD mapped page table entry, which is not
the desired behavior.

Fix this by only use FOLL_SPLIT_PMD for uprobe register case.

Also add a WARN() to confirm uprobe unregister never work on huge pages.

Fixes: 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/uprobes.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 94d38a39d72e..d7a556cc589e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -474,14 +474,17 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	int ret, is_register, ref_ctr_updated = 0;
 	bool orig_page_huge = false;
+	unsigned int gup_flags = FOLL_FORCE;
 
 	is_register = is_swbp_insn(&opcode);
 	uprobe = container_of(auprobe, struct uprobe, arch);
 
 retry:
+	if (is_register)
+		gup_flags |= FOLL_SPLIT_PMD;
 	/* Read the page with vaddr into memory */
-	ret = get_user_pages_remote(NULL, mm, vaddr, 1,
-			FOLL_FORCE | FOLL_SPLIT_PMD, &old_page, &vma, NULL);
+	ret = get_user_pages_remote(NULL, mm, vaddr, 1, gup_flags,
+				    &old_page, &vma, NULL);
 	if (ret <= 0)
 		return ret;
 
@@ -489,6 +492,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret <= 0)
 		goto put_old;
 
+	WARN(!is_register && PageCompound(old_page),
+	     "uprobe unregister should never work on compound page\n");
+
 	/* We are going to replace instruction, update ref_ctr. */
 	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
 		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
-- 
2.17.1

