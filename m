Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240E8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 01:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D0C2147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 01:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CFQd/O0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfHFBs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 21:48:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33240 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731308AbfHFBs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 21:48:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x761j1x2152776;
        Tue, 6 Aug 2019 01:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=PksSkVmoG9RKY5k8FKRMXWO1ygGnlV7x3HQDnLYr2FU=;
 b=CFQd/O0TdL+fJb035wg6lmymH5MX9AHuF4oVojbk+VxMLMspY/DNPeS9dkdWIQ4FJqc2
 eCIYep9sP3irX1q6LyutjUmOFekjEnPB80LwBIDMPeefJ9SPm4oIPJiHt4T5KsL0T5YQ
 est/H9CCbwCFcXnYR+JmPegsB8Q4rMxeEOjy+VnBFMoym8uJHqy5zbE4bS7mAcxJ42RX
 2VDgUaT7acIwZrctN2S+CbvI5qMeXM/qXeeNR3skj6Nh8gMMrCDbccP4G2rmcZvCUvBb
 vbR6v0Y6f9mWr3NW9Md414D/WMd98TmdLlNbD0MXm4pNy4wEyWu/B3REyaYowbvQWpnT /Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u527pjm9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 01:48:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x761m4Tu012645;
        Tue, 6 Aug 2019 01:48:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2u5233qged-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 01:48:03 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x761lpsf017771;
        Tue, 6 Aug 2019 01:47:52 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Aug 2019 18:47:51 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 0/4] address hugetlb page allocation stalls
Date:   Mon,  5 Aug 2019 18:47:40 -0700
Message-Id: <20190806014744.15446-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.20.1
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

Allocation of hugetlb pages via sysctl or procfs can stall for minutes
or hours.  A simple example on a two node system with 8GB of memory is
as follows:

echo 4096 > /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages
echo 4096 > /proc/sys/vm/nr_hugepages

Obviously, both allocation attempts will fall short of their 8GB goal.
However, one or both of these commands may stall and not be interruptible.
The issues were initially discussed in mail thread [1] and RFC code at [2].

This series addresses the issues causing the stalls.  There are two distinct
fixes, a cleanup, and an optimization.  The reclaim patch by Hillf and
compaction patch by Vlasitmil address corner cases in their respective areas.
hugetlb page allocation could stall due to either of these issues.  Vlasitmil
added a cleanup patch after Hillf's modifications.  The hugetlb patch by
Mike is an optimization suggested during the debug and development process.

v2 changes/modifications are mentioned in each of the patches.

[1] http://lkml.kernel.org/r/d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com
[2] http://lkml.kernel.org/r/20190724175014.9935-1-mike.kravetz@oracle.com

Hillf Danton (1):
  mm, reclaim: make should_continue_reclaim perform dryrun detection

Mike Kravetz (1):
  hugetlbfs: don't retry when pool page allocations start to fail

Vlastimil Babka (2):
  mm, reclaim: cleanup should_continue_reclaim()
  mm, compaction: raise compaction priority after it withdrawns

 include/linux/compaction.h | 22 +++++++---
 mm/hugetlb.c               | 89 +++++++++++++++++++++++++++++++++-----
 mm/page_alloc.c            | 16 +++++--
 mm/vmscan.c                | 57 ++++++++++--------------
 4 files changed, 130 insertions(+), 54 deletions(-)

-- 
2.20.1

