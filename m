Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E769ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F5421848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mq5v6bkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503008AbfJQQnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:43:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10950 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502887AbfJQQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:42:57 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9HGV6rA003253
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:42:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=GOJk98uhPyGo6jkczqnhQiMYnPmAVYZKwD5wgDMMEkI=;
 b=mq5v6bkccQBlRlJBX9JafhKdSkicw458+1tuWO0KANGG+ERtKOKRumkZ6FyPBVBK1iK/
 JAFOSfFVL73w7TTKrEscRH6EooQitsFdfISVtp1Q/r+f17ZKiI+GLL3DnDMgccf7mR20
 boFB4Aa9xb8DGkGoyzYYjU9GbBQYE/k9rIA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vp5k0e297-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:42:56 -0700
Received: from 2401:db00:2120:80e1:face:0:29:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 17 Oct 2019 09:42:55 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6F1B362E1477; Thu, 17 Oct 2019 09:42:53 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 5/5] uprobe: only do FOLL_SPLIT_PMD for uprobe register
Date:   Thu, 17 Oct 2019 09:42:22 -0700
Message-ID: <20191017164223.2762148-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017164223.2762148-1-songliubraving@fb.com>
References: <20191017164223.2762148-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_05:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=770
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910170149
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

Add a WARN() to confirm uprobe unregister never work on huge pages, and
abort the operation when this WARN() triggers.

Fixes: 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/uprobes.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 94d38a39d72e..c74761004ee5 100644
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
 
@@ -489,6 +492,12 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret <= 0)
 		goto put_old;
 
+	if (WARN(!is_register && PageCompound(old_page),
+		 "uprobe unregister should never work on compound page\n")) {
+		ret = -EINVAL;
+		goto put_old;
+	}
+
 	/* We are going to replace instruction, update ref_ctr. */
 	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
 		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
-- 
2.17.1

