Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F76C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523F321951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LyqW3tnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfGXRuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:50:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57492 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfGXRut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:50:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OHdv8A050046;
        Wed, 24 Jul 2019 17:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=pckymHbnRHu+rafvqysstMGQoahE6dDQ06s/gXDYrBc=;
 b=LyqW3tnXiUeCTD+OMYyOSyntNW7Oow0QdHShbM20ewy7LYaVgE4PMeTNIpvjuyZ15caD
 hPxkaqYeG04m9CEi7QtXOE5KpwMEv4M3Jq7b0c+JP5RWhNaVUcOrt5c8IODDciMT5psW
 gDxMsdLQZQDCn/mAv1Dsb/eV4uZDzv98dvxlp62wO4nuoIFfnV7/5XG7ks35LsH4QQrA
 2sBjEQbze+uv+5o0AsuixJHizx7SwmJGo+qLG+u7O9XgyNAdeeAsGkNpQGXozlmUxzdp
 +8sSckHg0Bgz0jkpb9AZg3/wkBffjkmvIVtoq0E9DjdQpxA9fQwfx18xpdb+pX1ZeTTF QA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tx61by0ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 17:50:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OHcAF9185415;
        Wed, 24 Jul 2019 17:50:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tx60y960j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 17:50:29 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6OHoTE7022375;
        Wed, 24 Jul 2019 17:50:29 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jul 2019 10:50:29 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 3/3] hugetlbfs: don't retry when pool page allocations start to fail
Date:   Wed, 24 Jul 2019 10:50:14 -0700
Message-Id: <20190724175014.9935-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724175014.9935-1-mike.kravetz@oracle.com>
References: <20190724175014.9935-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240191
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating hugetlbfs pool pages via /proc/sys/vm/nr_hugepages,
the pages will be interleaved between all nodes of the system.  If
nodes are not equal, it is quite possible for one node to fill up
before the others.  When this happens, the code still attempts to
allocate pages from the full node.  This results in calls to direct
reclaim and compaction which slow things down considerably.

When allocating pool pages, note the state of the previous allocation
for each node.  If previous allocation failed, do not use the
aggressive retry algorithm on successive attempts.  The allocation
will still succeed if there is memory available, but it will not try
as hard to free up memory.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ede7e7f5d1ab..f3c50344a9b4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1405,12 +1405,27 @@ pgoff_t __basepage_index(struct page *page)
 }
 
 static struct page *alloc_buddy_huge_page(struct hstate *h,
-		gfp_t gfp_mask, int nid, nodemask_t *nmask)
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
 {
 	int order = huge_page_order(h);
 	struct page *page;
+	bool alloc_try_hard = true;
 
-	gfp_mask |= __GFP_COMP|__GFP_RETRY_MAYFAIL|__GFP_NOWARN;
+	/*
+	 * By default we always try hard to allocate the page with
+	 * __GFP_RETRY_MAYFAIL flag.  However, if we are allocating pages in
+	 * a loop (to adjust global huge page counts) and previous allocation
+	 * failed, do not continue to try hard on the same node.  Use the
+	 * node_alloc_noretry bitmap to manage this state information.
+	 */
+	if (node_alloc_noretry && node_isset(nid, *node_alloc_noretry))
+		alloc_try_hard = false;
+	gfp_mask |= __GFP_COMP|__GFP_NOWARN;
+	if (alloc_try_hard)
+		gfp_mask |= __GFP_RETRY_MAYFAIL;
+	else
+		gfp_mask |= __GFP_NORETRY;
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
 	page = __alloc_pages_nodemask(gfp_mask, order, nid, nmask);
@@ -1419,6 +1434,22 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 	else
 		__count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
 
+	/*
+	 * If we did not specify __GFP_RETRY_MAYFAIL, but still got a page this
+	 * indicates an overall state change.  Clear bit so that we resume
+	 * normal 'try hard' allocations.
+	 */
+	if (node_alloc_noretry && page && !alloc_try_hard)
+		node_clear(nid, *node_alloc_noretry);
+
+	/*
+	 * If we tried hard to get a page but failed, set bit so that
+	 * subsequent attempts will not try as hard until there is an
+	 * overall state change.
+	 */
+	if (node_alloc_noretry && !page && alloc_try_hard)
+		node_set(nid, *node_alloc_noretry);
+
 	return page;
 }
 
@@ -1427,7 +1458,8 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
  * should use this function to get new hugetlb pages
  */
 static struct page *alloc_fresh_huge_page(struct hstate *h,
-		gfp_t gfp_mask, int nid, nodemask_t *nmask)
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
 {
 	struct page *page;
 
@@ -1435,7 +1467,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 		page = alloc_gigantic_page(h, gfp_mask, nid, nmask);
 	else
 		page = alloc_buddy_huge_page(h, gfp_mask,
-				nid, nmask);
+				nid, nmask, node_alloc_noretry);
 	if (!page)
 		return NULL;
 
@@ -1450,14 +1482,16 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
  * Allocates a fresh page to the hugetlb allocator pool in the node interleaved
  * manner.
  */
-static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
+static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
+				nodemask_t *node_alloc_noretry)
 {
 	struct page *page;
 	int nr_nodes, node;
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
 	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
-		page = alloc_fresh_huge_page(h, gfp_mask, node, nodes_allowed);
+		page = alloc_fresh_huge_page(h, gfp_mask, node, nodes_allowed,
+						node_alloc_noretry);
 		if (page)
 			break;
 	}
@@ -1601,7 +1635,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 		goto out_unlock;
 	spin_unlock(&hugetlb_lock);
 
-	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask);
+	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
 	if (!page)
 		return NULL;
 
@@ -1637,7 +1671,7 @@ struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask);
+	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
 	if (!page)
 		return NULL;
 
@@ -2207,13 +2241,31 @@ static void __init gather_bootmem_prealloc(void)
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long i;
+	nodemask_t *node_alloc_noretry;
+
+	if (!hstate_is_gigantic(h)) {
+		/*
+		 * bit mask controlling how hard we retry per-node
+		 * allocations.
+		 */
+		node_alloc_noretry = kmalloc(sizeof(*node_alloc_noretry),
+						GFP_KERNEL | __GFP_NORETRY);
+	} else {
+		/* allocations done at boot time */
+		node_alloc_noretry = NULL;
+	}
+
+	/* bit mask controlling how hard we retry per-node allocations */
+	if (node_alloc_noretry)
+		nodes_clear(*node_alloc_noretry);
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
 			if (!alloc_bootmem_huge_page(h))
 				break;
 		} else if (!alloc_pool_huge_page(h,
-					 &node_states[N_MEMORY]))
+					 &node_states[N_MEMORY],
+					 node_alloc_noretry))
 			break;
 		cond_resched();
 	}
@@ -2225,6 +2277,9 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 			h->max_huge_pages, buf, i);
 		h->max_huge_pages = i;
 	}
+
+	if (node_alloc_noretry)
+		kfree(node_alloc_noretry);
 }
 
 static void __init hugetlb_init_hstates(void)
@@ -2323,6 +2378,12 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
 	unsigned long min_count, ret;
+	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry,
+						GFP_KERNEL | __GFP_NORETRY);
+
+	/* bit mask controlling how hard we retry per-node allocations */
+	if (node_alloc_noretry)
+		nodes_clear(*node_alloc_noretry);
 
 	spin_lock(&hugetlb_lock);
 
@@ -2356,6 +2417,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 		if (count > persistent_huge_pages(h)) {
 			spin_unlock(&hugetlb_lock);
+			if (node_alloc_noretry)
+				NODEMASK_FREE(node_alloc_noretry);
 			return -EINVAL;
 		}
 		/* Fall through to decrease pool */
@@ -2388,7 +2451,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
-		ret = alloc_pool_huge_page(h, nodes_allowed);
+		ret = alloc_pool_huge_page(h, nodes_allowed,
+						node_alloc_noretry);
 		spin_lock(&hugetlb_lock);
 		if (!ret)
 			goto out;
@@ -2429,6 +2493,9 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	h->max_huge_pages = persistent_huge_pages(h);
 	spin_unlock(&hugetlb_lock);
 
+	if (node_alloc_noretry)
+		NODEMASK_FREE(node_alloc_noretry);
+
 	return 0;
 }
 
-- 
2.20.1

