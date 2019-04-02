Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF87AC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E04120883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfDBNeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:34:36 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:40310 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBNef (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 2 Apr 2019 09:34:35 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 02 Apr 2019 15:34:34 +0200
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Tue, 02 Apr 2019 14:34:21 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mike.kravetz@oracle.com, n-horiguchi@ah.jp.nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm/hugetlb: Get rid of NODEMASK_ALLOC
Date:   Tue,  2 Apr 2019 15:34:15 +0200
Message-Id: <20190402133415.21983-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NODEMASK_ALLOC is used to allocate a nodemask bitmap, ant it does it by
first determining whether it should be allocated in the stack or dinamically
depending on NODES_SHIFT.
Right now, it goes the dynamic path whenever the nodemask_t is above 32
bytes.

Although we could bump it to a reasonable value, the largest a nodemask_t
can get is 128 bytes, so since __nr_hugepages_store_common is called from
a rather shore stack we can just get rid of the NODEMASK_ALLOC call here.

This reduces some code churn and complexity.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f79ae4e42159..9cb2f91af897 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2447,44 +2447,30 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 					   unsigned long count, size_t len)
 {
 	int err;
-	NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL | __GFP_NORETRY);
+	nodemask_t nodes_allowed, *n_mask;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported()) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+		return -EINVAL;
 
 	if (nid == NUMA_NO_NODE) {
 		/*
 		 * global hstate attribute
 		 */
 		if (!(obey_mempolicy &&
-				init_nodemask_of_mempolicy(nodes_allowed))) {
-			NODEMASK_FREE(nodes_allowed);
-			nodes_allowed = &node_states[N_MEMORY];
-		}
-	} else if (nodes_allowed) {
+				init_nodemask_of_mempolicy(&nodes_allowed)))
+			n_mask = &node_states[N_MEMORY];
+		else
+			n_mask = &nodes_allowed;
+	} else {
 		/*
 		 * Node specific request.  count adjustment happens in
 		 * set_max_huge_pages() after acquiring hugetlb_lock.
 		 */
-		init_nodemask_of_node(nodes_allowed, nid);
-	} else {
-		/*
-		 * Node specific request, but we could not allocate the few
-		 * words required for a node mask.  We are unlikely to hit
-		 * this condition.  Since we can not pass down the appropriate
-		 * node mask, just return ENOMEM.
-		 */
-		err = -ENOMEM;
-		goto out;
+		init_nodemask_of_node(&nodes_allowed, nid);
+		n_mask = &nodes_allowed;
 	}
 
-	err = set_max_huge_pages(h, count, nid, nodes_allowed);
-
-out:
-	if (nodes_allowed != &node_states[N_MEMORY])
-		NODEMASK_FREE(nodes_allowed);
+	err = set_max_huge_pages(h, count, nid, n_mask);
 
 	return err ? err : len;
 }
-- 
2.13.7

