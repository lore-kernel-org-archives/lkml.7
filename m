Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2849BC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29FA20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GhNiV36W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390066AbfJPHjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:39:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10166 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729325AbfJPHi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:38:59 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G7cugn021628
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:38:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=00M2Zmb8EjQQsf3z9EhzhacGFhr4Fd0esCs83QIMeBs=;
 b=GhNiV36WJTf2qUTDVV39HVYc5+QgmMc2HrkW4QYwOr9REATGjJ7+FmZ12PJXN/pjAKrK
 jJcNeIolnZwdRIymsG37FbEty4O2AhTDCJ1u39TyMCtu465jGYN2vadiqDJUyOzX0t3D
 9r+lPbckjsCg6eiC8P9m3vLGx30tQRzX2MY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vnpry1q2d-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:38:58 -0700
Received: from 2401:db00:2050:5076:face:0:9:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Oct 2019 00:38:35 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E1DAC62E2A2F; Wed, 16 Oct 2019 00:38:34 -0700 (PDT)
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
Subject: [PATCH 1/4] proc/meminfo: fix output alignment
Date:   Wed, 16 Oct 2019 00:37:28 -0700
Message-ID: <20191016073731.4076725-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016073731.4076725-1-songliubraving@fb.com>
References: <20191016073731.4076725-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_03:2019-10-15,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 mlxlogscore=902 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160071
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Add extra space for FileHugePages and FilePmdMapped, so the output is
aligned with other rows.

Fixes: 60fbf0ab5da1 ("mm,thp: stats for file backed THP")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 fs/proc/meminfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index ac9247371871..8c1f1bb1a5ce 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -132,9 +132,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		    global_node_page_state(NR_SHMEM_THPS) * HPAGE_PMD_NR);
 	show_val_kb(m, "ShmemPmdMapped: ",
 		    global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
-	show_val_kb(m, "FileHugePages: ",
+	show_val_kb(m, "FileHugePages:  ",
 		    global_node_page_state(NR_FILE_THPS) * HPAGE_PMD_NR);
-	show_val_kb(m, "FilePmdMapped: ",
+	show_val_kb(m, "FilePmdMapped:  ",
 		    global_node_page_state(NR_FILE_PMDMAPPED) * HPAGE_PMD_NR);
 #endif
 
-- 
2.17.1

