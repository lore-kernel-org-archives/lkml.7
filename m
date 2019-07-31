Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82274C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFDA206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PPotgx+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfGaSeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:34:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8374 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729992AbfGaSeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:34:01 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VIWCZu005889
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:34:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=S84BXpGsArP8gRpx4jT/dGDAfOA51Safqnff7k6UND8=;
 b=PPotgx+T02mUnkJtzfdAahQCsMtNDPcOAJE4FsfH+HW1pFFI/GAnG3RGLnj/ayFXv3Hf
 K7xVsCp9+Mb36e/m12+ceQcP2hzCvMVdNcyS5aMsmOUD9uCKSOtfJoI6wv2iHyoVHkB1
 l6YE5YpZyMsDIU/I3dIEmMpkGyxrZ9ytfAE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u2uhtma26-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:34:00 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 11:33:57 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6ABC962E1BBA; Wed, 31 Jul 2019 11:33:55 -0700 (PDT)
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
Subject: [PATCH v2 2/2] uprobe: collapse THP pmd after removing all uprobes
Date:   Wed, 31 Jul 2019 11:33:31 -0700
Message-ID: <20190731183331.2565608-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731183331.2565608-1-songliubraving@fb.com>
References: <20190731183331.2565608-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=424 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310186
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After all uprobes are removed from the huge page (with PTE pgtable), it
is possible to collapse the pmd and benefit from THP again. This patch
does the collapse by calling collapse_pte_mapped_thp().

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/uprobes.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 27b596f14463..e5c30941ea04 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -26,6 +26,7 @@
 #include <linux/percpu-rwsem.h>
 #include <linux/task_work.h>
 #include <linux/shmem_fs.h>
+#include <linux/khugepaged.h>
 
 #include <linux/uprobes.h>
 
@@ -472,6 +473,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
 	int ret, is_register, ref_ctr_updated = 0;
+	bool orig_page_huge = false;
 
 	is_register = is_swbp_insn(&opcode);
 	uprobe = container_of(auprobe, struct uprobe, arch);
@@ -529,6 +531,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 				/* let go new_page */
 				put_page(new_page);
 				new_page = NULL;
+
+				if (PageCompound(orig_page))
+					orig_page_huge = true;
 			}
 			put_page(orig_page);
 		}
@@ -547,6 +552,10 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret && is_register && ref_ctr_updated)
 		update_ref_ctr(uprobe, mm, -1);
 
+	/* try collapse pmd for compound page */
+	if (!ret && orig_page_huge)
+		collapse_pte_mapped_thp(mm, vaddr & HPAGE_PMD_MASK);
+
 	return ret;
 }
 
-- 
2.17.1

