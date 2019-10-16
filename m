Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A3EC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B18A20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Wgi2xGQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbfJPHiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:38:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10260 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733249AbfJPHiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:38:52 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G7cn7O023120
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:38:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=MK5hTX7LH355/cYgosDswthYAh0Wy8L1H+d9NWKNNBg=;
 b=Wgi2xGQETunqs82rEJNJGxZ8bzKMLYxxCIkXSeQ8TXILl2qPzkjHgf+7JNw8VOFLaoyY
 mnNcVXPH3gf27zy68odhTUAk92vuhcIgDxz/FE9h1QHRE6EKZfZi1Fo88TGg44Klr0dO
 cA3/zrwRa8fdN3qvv5qrqFxqbQIW0Ebsz6k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vna13wfsb-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:38:50 -0700
Received: from 2401:db00:2120:81ca:face:0:31:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Oct 2019 00:38:43 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id F17B762E2A2F; Wed, 16 Oct 2019 00:38:42 -0700 (PDT)
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
Subject: [PATCH 2/4] mm/thp: fix node page state in split_huge_page_to_list()
Date:   Wed, 16 Oct 2019 00:37:29 -0700
Message-ID: <20191016073731.4076725-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016073731.4076725-1-songliubraving@fb.com>
References: <20191016073731.4076725-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_03:2019-10-15,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 mlxlogscore=981 priorityscore=1501 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160071
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

