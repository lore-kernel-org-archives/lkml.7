Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3046C32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 01:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF75520C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 01:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r+8pq2FH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfHFBs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 21:48:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41830 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731328AbfHFBs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 21:48:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x761iAp9078264;
        Tue, 6 Aug 2019 01:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=WvV50/BsA1642B3kVRC1Mg6PgZqRAFj/+Pth1rANcxA=;
 b=r+8pq2FH8dpZq16OOdFBYhF3ZAl5enxyqlIZuDeucd7zEAYYbD98Gg6I8ZLzVsxriR4S
 wX4V+MeZ/v/Y62jbj0j2JBj2FKHTyLY6MAewgOybJO02N3xoJQuiu9qKI7nao42sIpMy
 FbvcSncFp1Cit1vGQoEKjASjMMuRoXTr+v6qqjFkXUwPueTZ/MteDWzYQSwd5EoWgH6V
 qNwZxuBTy7f+WIzk5vUKNt6hztBZw5Cyne7iKViGuOOuVjpHgCluoMbQDov4rr3fKPK5
 n2xrOCCfUl8y8L+C6VDusSQUxii0AKR5ulJ3XSIT4ZuXk9zkQJWlL2zpX3eRDSeFK5Zs nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u51ptts13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 01:48:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x761m4br162751;
        Tue, 6 Aug 2019 01:48:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2u4ycubsmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 01:48:04 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x761lvhP025251;
        Tue, 6 Aug 2019 01:47:57 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Aug 2019 18:47:57 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 3/4] mm, compaction: raise compaction priority after it withdrawns
Date:   Mon,  5 Aug 2019 18:47:43 -0700
Message-Id: <20190806014744.15446-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806014744.15446-1-mike.kravetz@oracle.com>
References: <20190806014744.15446-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908060020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vlastimil Babka <vbabka@suse.cz>

Mike Kravetz reports that "hugetlb allocations could stall for minutes
or hours when should_compact_retry() would return true more often then
it should.  Specifically, this was in the case where compact_result was
COMPACT_DEFERRED and COMPACT_PARTIAL_SKIPPED and no progress was being
made."

The problem is that the compaction_withdrawn() test in
should_compact_retry() includes compaction outcomes that are only possible
on low compaction priority, and results in a retry without increasing the
priority. This may result in furter reclaim, and more incomplete compaction
attempts.

With this patch, compaction priority is raised when possible, or
should_compact_retry() returns false.

The COMPACT_SKIPPED result doesn't really fit together with the other
outcomes in compaction_withdrawn(), as that's a result caused by
insufficient order-0 pages, not due to low compaction priority. With this
patch, it is moved to a new compaction_needs_reclaim() function, and for
that outcome we keep the current logic of retrying if it looks like reclaim
will be able to help.

Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
v2 - Commit message reformatted to avoid line wrap.  Added SOB.

 include/linux/compaction.h | 22 +++++++++++++++++-----
 mm/page_alloc.c            | 16 ++++++++++++----
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 9569e7c786d3..4b898cdbdf05 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -129,11 +129,8 @@ static inline bool compaction_failed(enum compact_result result)
 	return false;
 }
 
-/*
- * Compaction  has backed off for some reason. It might be throttling or
- * lock contention. Retrying is still worthwhile.
- */
-static inline bool compaction_withdrawn(enum compact_result result)
+/* Compaction needs reclaim to be performed first, so it can continue. */
+static inline bool compaction_needs_reclaim(enum compact_result result)
 {
 	/*
 	 * Compaction backed off due to watermark checks for order-0
@@ -142,6 +139,16 @@ static inline bool compaction_withdrawn(enum compact_result result)
 	if (result == COMPACT_SKIPPED)
 		return true;
 
+	return false;
+}
+
+/*
+ * Compaction has backed off for some reason after doing some work or none
+ * at all. It might be throttling or lock contention. Retrying might be still
+ * worthwhile, but with a higher priority if allowed.
+ */
+static inline bool compaction_withdrawn(enum compact_result result)
+{
 	/*
 	 * If compaction is deferred for high-order allocations, it is
 	 * because sync compaction recently failed. If this is the case
@@ -207,6 +214,11 @@ static inline bool compaction_failed(enum compact_result result)
 	return false;
 }
 
+static inline bool compaction_needs_reclaim(enum compact_result result)
+{
+	return false;
+}
+
 static inline bool compaction_withdrawn(enum compact_result result)
 {
 	return true;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d3bb601c461b..af29c05e23aa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3965,15 +3965,23 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 	if (compaction_failed(compact_result))
 		goto check_priority;
 
+	/*
+	 * compaction was skipped because there are not enough order-0 pages
+	 * to work with, so we retry only if it looks like reclaim can help.
+	 */
+	if (compaction_needs_reclaim(compact_result)) {
+		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
+		goto out;
+	}
+
 	/*
 	 * make sure the compaction wasn't deferred or didn't bail out early
 	 * due to locks contention before we declare that we should give up.
-	 * But do not retry if the given zonelist is not suitable for
-	 * compaction.
+	 * But the next retry should use a higher priority if allowed, so
+	 * we don't just keep bailing out endlessly.
 	 */
 	if (compaction_withdrawn(compact_result)) {
-		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
-		goto out;
+		goto check_priority;
 	}
 
 	/*
-- 
2.20.1

