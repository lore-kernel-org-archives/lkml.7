Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3978C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EEF20449
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ig+gtw/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437297AbfHBWmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:42:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437252AbfHBWmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:42:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72Mcsj7121652;
        Fri, 2 Aug 2019 22:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=V+S2cCRMzMkTYxl1DBlk1mcxDep6bRomMR5hspXDz/A=;
 b=ig+gtw/nHmMxdo2vG1ndB2NiEqFfiYcUxaaBUSJx4t41mk4jtfIZQjRxMKN/dFhqn3b5
 XQsuzLmoTDHEQCqi/cbSkIPx12KXT7FhePPM23IFMtCWoFs3MHcr/RL2XeLj7XCh9hrt
 AyBcRTJJW0AQqob8Dj6P3LUnk81ChUJssJVpahmd0Ax318/0mOiMPzywXJfWsFd+BKx9
 O2sZAt/f97yK9exYSXetY3PCHpaDSjSvcfn1twbJUfZdnX2pqJwMU5ylqUYjxJNcBGrA
 vptAdemis7KpqPAfGyaYys7n0jALfXZPnwkzD4orTRXtnc3rKcw7Q1qkiRmqKO1Dvapo Eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2u0e1ucymc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 22:41:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72Mbq8A062797;
        Fri, 2 Aug 2019 22:39:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2u4vsj1upb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 22:39:41 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x72MdZrw022117;
        Fri, 2 Aug 2019 22:39:35 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Aug 2019 15:39:34 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/3] address hugetlb page allocation stalls
Date:   Fri,  2 Aug 2019 15:39:27 -0700
Message-Id: <20190802223930.30971-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908020238
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908020238
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
The issues were initially discussed in mail thread [1] and RFC code at [2].

This series addresses the issues causing the stalls.  There are two distinct
fixes, and an optimization.  The reclaim patch by Hillf and compaction patch
by Vlasitmil address corner cases in their respective areas.  hugetlb page
allocation could stall due to either of these issues.  The hugetlb patch by
Mike is an optimization suggested during the debug and development process.

[1] http://lkml.kernel.org/r/d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com
[2] http://lkml.kernel.org/r/20190724175014.9935-1-mike.kravetz@oracle.com

Hillf Danton (1):
  mm, reclaim: make should_continue_reclaim perform dryrun detection

Mike Kravetz (1):
  hugetlbfs: don't retry when pool page allocations start to fail

Vlastimil Babka (1):
  mm, compaction: raise compaction priority after it withdrawns

 include/linux/compaction.h | 22 +++++++---
 mm/hugetlb.c               | 86 +++++++++++++++++++++++++++++++++-----
 mm/page_alloc.c            | 16 +++++--
 mm/vmscan.c                | 28 +++++++------
 4 files changed, 120 insertions(+), 32 deletions(-)

-- 
2.20.1

