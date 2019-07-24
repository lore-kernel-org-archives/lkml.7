Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A854C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EDF2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lkP+47eS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfGXRvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:51:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38456 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGXRvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:51:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OHdfUU134750;
        Wed, 24 Jul 2019 17:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=NX/s/A5OLVDNZD4fNK87u3UpZfdfRBOaB3nXPLcsPas=;
 b=lkP+47eSi6lNelJK4kH8PvDDkmDI4KwgfHOhbC5Lp/E4hBF1MY44i5mbaW+evRfZPfVk
 R0E2hYBeVSx9InL7HjrmIAPY9jsoPtf007rUUpbwwU4kMeu5SwrRL/OaqngDPPnDxpRy
 AejMJlnkqk7kWLvjxvzRIKfTgu0PhLBMNO6svrheEboBLTglFaBcAp8E2cYbg0nGn284
 JFJedRP7waYMAXMhlD29ywDn9b0RVde89rNmiQn3yImeq7Z8T8QNjtY/7dNVqr76HLnN
 PdLeHUc6OyBQYDGzt2p6cj94UzzJYNWaB+pds0fvtZPlZ+ppJhobynJmlWoICT2GKsSF 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2tx61by15s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 17:50:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OHcEMc018710;
        Wed, 24 Jul 2019 17:50:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tx60xv7j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 17:50:28 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6OHoPsb022353;
        Wed, 24 Jul 2019 17:50:25 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jul 2019 10:50:25 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 1/3] mm, reclaim: make should_continue_reclaim perform dryrun detection
Date:   Wed, 24 Jul 2019 10:50:12 -0700
Message-Id: <20190724175014.9935-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724175014.9935-1-mike.kravetz@oracle.com>
References: <20190724175014.9935-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240191
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hillf Danton <hdanton@sina.com>

Address the issue of should_continue_reclaim continuing true too often
for __GFP_RETRY_MAYFAIL attempts when !nr_reclaimed and nr_scanned.
This could happen during hugetlb page allocation causing stalls for
minutes or hours.

Restructure code so that false will be returned in this case even if
there are plenty of inactive pages.

Need better description from Hillf Danton
Need SOB from Hillf Danton
---
 mm/vmscan.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f4fd02ae233e..484b6b1a954e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2673,18 +2673,6 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 			return false;
 	}
 
-	/*
-	 * If we have not reclaimed enough pages for compaction and the
-	 * inactive lists are large enough, continue reclaiming
-	 */
-	pages_for_compaction = compact_gap(sc->order);
-	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (get_nr_swap_pages() > 0)
-		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
-	if (sc->nr_reclaimed < pages_for_compaction &&
-			inactive_lru_pages > pages_for_compaction)
-		return true;
-
 	/* If compaction would go ahead or the allocation would succeed, stop */
 	for (z = 0; z <= sc->reclaim_idx; z++) {
 		struct zone *zone = &pgdat->node_zones[z];
@@ -2700,7 +2688,21 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 			;
 		}
 	}
-	return true;
+
+	/*
+	 * If we have not reclaimed enough pages for compaction and the
+	 * inactive lists are large enough, continue reclaiming
+	 */
+	pages_for_compaction = compact_gap(sc->order);
+	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
+	if (get_nr_swap_pages() > 0)
+		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
+
+	return inactive_lru_pages > pages_for_compaction &&
+		/*
+		 * avoid dryrun with plenty of inactive pages
+		 */
+		nr_scanned && nr_reclaimed;
 }
 
 static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
-- 
2.20.1

