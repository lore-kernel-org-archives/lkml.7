Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BEAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B662075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="To6XGK9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfC1WGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 18:06:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57588 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfC1WGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 18:06:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2SLxmSs060297;
        Thu, 28 Mar 2019 22:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=efE+EqaifQWItnvqE5oHeBNSdF1slMZgpYXIiFbimNM=;
 b=To6XGK9fJKj9anhLwIkXsfVRTrO/rnl4b0e+jPhZakXVEEA9S4AhLDGLZD5Xl84ZVUrt
 fL4og7Mm4DjgLZoh7vDk7l/tR4AaCopqJmt7s2N9QBiR8e24wGvEN2zFT2yTsKU13/83
 94sdE6jFdDRK7tgzJCwy5yh5K4k8c3f/mhN7dwEQyGvYhTLikvR+gj10atYNRNXtwxvh
 GPFiWWagnMdp0WxDNq5fl9CDiXbOeTag9K8MKla6jjR2JFt5MEMfUSlP26cznvn4+ZpD
 ndfAExKYHUaW30O8Nnsfaqb76jPbfZxy+gvPC/nWGydJWVhTKuDQAJ8FmB6CQaMGhfO0 yA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2re6djsc20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 22:05:51 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2SM5nqo006298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 22:05:50 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2SM5jwF009891;
        Thu, 28 Mar 2019 22:05:45 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Mar 2019 15:05:45 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Alex Ghiti <alex@ghiti.fr>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>
Subject: [PATCH REBASED] hugetlbfs: fix potential over/underflow setting node specific nr_hugepages
Date:   Thu, 28 Mar 2019 15:05:33 -0700
Message-Id: <20190328220533.19884-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9209 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of node specific huge pages can be set via a file such as:
/sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages
When a node specific value is specified, the global number of huge
pages must also be adjusted.  This adjustment is calculated as the
specified node specific value + (global value - current node value).
If the node specific value provided by the user is large enough, this
calculation could overflow an unsigned long leading to a smaller
than expected number of huge pages.

To fix, check the calculation for overflow.  If overflow is detected,
use ULONG_MAX as the requested value.  This is inline with the user
request to allocate as many huge pages as possible.

It was also noticed that the above calculation was done outside the
hugetlb_lock.  Therefore, the values could be inconsistent and result
in underflow.  To fix, the calculation is moved within the routine
set_max_huge_pages() where the lock is held.

In addition, the code in __nr_hugepages_store_common() which tries to
handle the case of not being able to allocate a node mask would likely
result in incorrect behavior.  Luckily, it is very unlikely we will
ever take this path.  If we do, simply return ENOMEM.

Reported-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
This was sent upstream during 5.1 merge window, but dropped as it was
based on an earlier version of Alex Ghiti's patch which was dropped.
Now rebased on top of Alex Ghiti's "[PATCH v8 0/4] Fix free/allocation
of runtime gigantic pages" series which was just added to mmotm.

 mm/hugetlb.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f3e84c1bef11..f79ae4e42159 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2287,13 +2287,33 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 }
 
 #define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
-static int set_max_huge_pages(struct hstate *h, unsigned long count,
+static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
 	unsigned long min_count, ret;
 
 	spin_lock(&hugetlb_lock);
 
+	/*
+	 * Check for a node specific request.
+	 * Changing node specific huge page count may require a corresponding
+	 * change to the global count.  In any case, the passed node mask
+	 * (nodes_allowed) will restrict alloc/free to the specified node.
+	 */
+	if (nid != NUMA_NO_NODE) {
+		unsigned long old_count = count;
+
+		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
+		/*
+		 * User may have specified a large count value which caused the
+		 * above calculation to overflow.  In this case, they wanted
+		 * to allocate as many huge pages as possible.  Set count to
+		 * largest possible value to align with their intention.
+		 */
+		if (count < old_count)
+			count = ULONG_MAX;
+	}
+
 	/*
 	 * Gigantic pages runtime allocation depend on the capability for large
 	 * page range allocation.
@@ -2445,15 +2465,22 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 		}
 	} else if (nodes_allowed) {
 		/*
-		 * per node hstate attribute: adjust count to global,
-		 * but restrict alloc/free to the specified node.
+		 * Node specific request.  count adjustment happens in
+		 * set_max_huge_pages() after acquiring hugetlb_lock.
 		 */
-		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
 		init_nodemask_of_node(nodes_allowed, nid);
-	} else
-		nodes_allowed = &node_states[N_MEMORY];
+	} else {
+		/*
+		 * Node specific request, but we could not allocate the few
+		 * words required for a node mask.  We are unlikely to hit
+		 * this condition.  Since we can not pass down the appropriate
+		 * node mask, just return ENOMEM.
+		 */
+		err = -ENOMEM;
+		goto out;
+	}
 
-	err = set_max_huge_pages(h, count, nodes_allowed);
+	err = set_max_huge_pages(h, count, nid, nodes_allowed);
 
 out:
 	if (nodes_allowed != &node_states[N_MEMORY])
-- 
2.20.1

