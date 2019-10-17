Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF8FFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D4A21835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gzk6ytAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502028AbfJQQmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:42:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35588 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409173AbfJQQmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:42:43 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9HGXgw3013827
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:42:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=00M2Zmb8EjQQsf3z9EhzhacGFhr4Fd0esCs83QIMeBs=;
 b=gzk6ytAjRsseMk7Bmx8YRYFmWGZdvMfi00C1oxNGw0MQFTCzJaDpqc4vpO2+lkmlb3Yx
 4fsdR53QVhw4ZptgzxsTnZrPRpuqTa/WTXjvxURzOXppYG33VlPi0AFSXi/TZyKgk/FE
 ITtgLPXyDWqELMFU5BE915OQ65dz3vfHnN4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpj8rtnvp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:42:42 -0700
Received: from 2401:db00:2120:80e1:face:0:29:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 17 Oct 2019 09:42:41 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id F123C62E1477; Thu, 17 Oct 2019 09:42:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 1/5] proc/meminfo: fix output alignment
Date:   Thu, 17 Oct 2019 09:42:18 -0700
Message-ID: <20191017164223.2762148-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017164223.2762148-1-songliubraving@fb.com>
References: <20191017164223.2762148-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_05:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=890
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910170149
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

