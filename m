Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC232C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F3621852
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tup7p8Nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfGXRwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:52:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59926 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGXRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:52:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OHde6B049688;
        Wed, 24 Jul 2019 17:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=ijqWqbTQS+mO3BG8eUkyRBif1gJVoINohHHt0HHU2LM=;
 b=tup7p8NclfqJa8HNUqc3r507Q+5d5c4/aRy/NdyxP+wvdiYSD1QTyx+qJ3sVlK2w61oa
 /8aL4/T0MK/QwIQYhZUuPHUZtnMFaHKDwfvodoE3lwcHbZEdeQKrK95iB5wp3dQF4Jjt
 Qrvq2pJrRa4oIqvapHFz0oln13nyP3xnTKqZ2FRosyKvNT3T6FSzEGKNNF2mJ2Ljr1wU
 Rhr6EUlHq8ayFK6cUHVjTHzbplH8Gkry5a3eHkWHJS9P4KjOUjPpZ5NsgUUiseifT0KO
 zqOS7u4WCOMTmfW6V0K8L3f3fWuC379XJ4fwuQaoQhBWryFiL2qLEqdCJokb/HDjCdbP Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tx61by13q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 17:52:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OHcAo4188438;
        Wed, 24 Jul 2019 17:50:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tx60y698g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 17:50:28 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6OHoMOj019819;
        Wed, 24 Jul 2019 17:50:22 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jul 2019 10:50:22 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 0/3] fix hugetlb page allocation stalls
Date:   Wed, 24 Jul 2019 10:50:11 -0700
Message-Id: <20190724175014.9935-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.20.1
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

Allocation of hugetlb pages via sysctl or procfs can stall for minutes
or hours.  A simple example on a two node system with 8GB of memory is
as follows:

echo 4096 > /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages
echo 4096 > /proc/sys/vm/nr_hugepages

Obviously, both allocation attempts will fall short of their 8GB goal.
However, one or both of these commands may stall and not be interruptible.
The issues were discussed in this thread [1].

This series attempts to address the issues causing the stalls.  There are
two distinct issues, and an optimization.  For the reclaim and compaction
issues, suggestions were made to simply remove some existing code.  However,
the impact of such changes would be hard to address.  This series takes a
more conservative approach in an attempt to minimally impact existing
workloads.  The question of which approach is better is debatable, hence the
RFC designation.  Patches in the series address these issues:

1) Should_continue_reclaim returns true too often.
   Michal Hocko suggested removing the special casing for __GFP_RETRY_MAYFAIL
   in should_continue_reclaim.  This does indeed address the hugetlb
   allocations, but may impact other users.  Hillf Danton restructured
   the code in such a way to preserve much of the original semantics.  Hillf's
   patch also addresses hugetlb allocation issues and is included here.

2) With 1) addressed, should_compact_retry returns true too often.
   Mel Gorman suggested the removal of the compaction_zonelist_suitable() call.
   This routine/call was introduced by Michal Hocko for a specific use case.
   Therefore, removal would likely break that use case.  While examining the
   reasons for compaction_withdrawn() as in [2], it appears that there are
   several places where we should be using MIN_COMPACT_COSTLY_PRIORITY instead
   of MIN_COMPACT_PRIORITY for costly allocations.  This patch makes those
   changes which also causes more appropriate should_compact_retry behavior
   for hugetlb allocations.

3) This is simply an optimization of the allocation code for hugetlb pool
   pages.  After first __GFP_RETRY_MAYFAIL allocation failure on a node,
   it drops the __GFP_RETRY_MAYFAIL flag.


[1] http://lkml.kernel.org/r/d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com
[2] http://lkml.kernel.org/r/6377c199-2b9e-e30d-a068-c304d8a3f706@oracle.com

Hillf Danton (1):
  mm, reclaim: make should_continue_reclaim perform dryrun detection

Mike Kravetz (2):
  mm, compaction: use MIN_COMPACT_COSTLY_PRIORITY everywhere for costly
    orders
  hugetlbfs: don't retry when pool page allocations start to fail

 mm/compaction.c | 18 +++++++---
 mm/hugetlb.c    | 87 +++++++++++++++++++++++++++++++++++++++++++------
 mm/vmscan.c     | 28 ++++++++--------
 3 files changed, 105 insertions(+), 28 deletions(-)

-- 
2.20.1

