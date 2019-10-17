Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EC6FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41BB21848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DqfZGrlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502709AbfJQQmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:42:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32042 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502087AbfJQQms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:42:48 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9HGYVu4026363
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:42:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=MK5hTX7LH355/cYgosDswthYAh0Wy8L1H+d9NWKNNBg=;
 b=DqfZGrlQTrWJitVh2pBtQuNngHCfcJmHUye9UOlCT7vdWh/n/8/GpwAQJNA1HK/oEmnN
 o8TqNkKhByRZrDDevF2YDed78zlBieF8bQGCsYzXz+MXwhSLzK9ukS349fzU8Sp4K8zU
 KDUdyV0x45/y3CnsTOyPAHTXCh9E4GiKsfI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vp84ad1mf-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:42:47 -0700
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 17 Oct 2019 09:42:44 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 7773F62E1477; Thu, 17 Oct 2019 09:42:43 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 2/5] mm/thp: fix node page state in split_huge_page_to_list()
Date:   Thu, 17 Oct 2019 09:42:19 -0700
Message-ID: <20191017164223.2762148-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017164223.2762148-1-songliubraving@fb.com>
References: <20191017164223.2762148-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_05:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=959 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910170149
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Make sure split_huge_page_to_list() handle the state of shmem THP and
file THP properly.

Fixes: 60fbf0ab5da1 ("mm,thp: stats for file backed THP")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/huge_memory.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c5cb6dcd6c69..13cc93785006 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2789,8 +2789,13 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			ds_queue->split_queue_len--;
 			list_del(page_deferred_list(head));
 		}
-		if (mapping)
-			__dec_node_page_state(page, NR_SHMEM_THPS);
+		if (mapping) {
+			if (PageSwapBacked(page))
+				__dec_node_page_state(page, NR_SHMEM_THPS);
+			else
+				__dec_node_page_state(page, NR_FILE_THPS);
+		}
+
 		spin_unlock(&ds_queue->split_queue_lock);
 		__split_huge_page(page, list, end, flags);
 		if (PageSwapCache(head)) {
-- 
2.17.1

