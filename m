Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA9C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43599206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="adRZqoe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfJGTDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:03:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33296 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGTDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:03:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97InZkX109522;
        Mon, 7 Oct 2019 19:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=vqjFRmkzoX1rAt9xalycqM22xrgbSL0OjpcVDq1Gfu4=;
 b=adRZqoe5+YBdH61hYUJz5kymPytFqJ9tkCyFVfEfAOUOehyQyxllkfOW4m0PqTbnWyOU
 3zKy40TYgcy6ftyAp8aMssiAUBpwoN9nHzzvh2Qxbhn5M+95JEzwameC4P3Yd2ETm+hn
 C/r9HlSnlTd4xP0QcKz4pt1dtWa6dBYNxrIIQNMZx9wrqIUG9eqQGxFl7gDvt0ewyB5s
 qgUmhylYQ0V+jhLjBlidNhG7a9uCel8/Q1repl342xD+rbgStfzCKqKQAoHwn0d1MYr4
 korxadd8livwDvSMdqB+7EShtYqJcCmyYEt9448F9KHxyiI1ji+xUQcJo9veHuysTj6b Ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vek4q8tp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 19:03:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97IrdoH062548;
        Mon, 7 Oct 2019 19:03:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vg204dujs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 19:03:34 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x97J3Vpr026483;
        Mon, 7 Oct 2019 19:03:32 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 12:03:31 -0700
Subject: Re: [PATCH] mm, hugetlb: allow hugepage allocations to excessively
 reclaim
To:     Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>
References: <20191007075548.12456-1-mhocko@kernel.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <312f4447-a260-8876-2f9d-f300c5c99dc3@oracle.com>
Date:   Mon, 7 Oct 2019 12:03:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191007075548.12456-1-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/19 12:55 AM, Michal Hocko wrote:
> From: David Rientjes <rientjes@google.com>
> 
> b39d0ee2632d ("mm, page_alloc: avoid expensive reclaim when compaction
> may not succeed") has chnaged the allocator to bail out from the
> allocator early to prevent from a potentially excessive memory
> reclaim. __GFP_RETRY_MAYFAIL is designed to retry the allocation,
> reclaim and compaction loop as long as there is a reasonable chance to
> make a forward progress. Neither COMPACT_SKIPPED nor COMPACT_DEFERRED
> at the INIT_COMPACT_PRIORITY compaction attempt gives this feedback.
> 
> The most obvious affected subsystem is hugetlbfs which allocates huge
> pages based on an admin request (or via admin configured overcommit).
> I have done a simple test which tries to allocate half of the memory
> for hugetlb pages while the memory is full of a clean page cache. This
> is not an unusual situation because we try to cache as much of the
> memory as possible and sysctl/sysfs interface to allocate huge pages is
> there for flexibility to allocate hugetlb pages at any time.
> 
> System has 1GB of RAM and we are requesting 515MB worth of hugetlb pages
> after the memory is prefilled by a clean page cache:
> root@test1:~# cat hugetlb_test.sh
> 
> set -x
> echo 0 > /proc/sys/vm/nr_hugepages
> echo 3 > /proc/sys/vm/drop_caches
> echo 1 > /proc/sys/vm/compact_memory
> dd if=/mnt/data/file-1G of=/dev/null bs=$((4<<10))
> TS=$(date +%s)
> echo 256 > /proc/sys/vm/nr_hugepages
> cat /proc/sys/vm/nr_hugepages
> 
> The results for 2 consecutive runs on clean 5.3
> root@test1:~# sh hugetlb_test.sh
> + echo 0
> + echo 3
> + echo 1
> + dd if=/mnt/data/file-1G of=/dev/null bs=4096
> 262144+0 records in
> 262144+0 records out
> 1073741824 bytes (1.1 GB) copied, 21.0694 s, 51.0 MB/s
> + date +%s
> + TS=1569905284
> + echo 256
> + cat /proc/sys/vm/nr_hugepages
> 256
> root@test1:~# sh hugetlb_test.sh
> + echo 0
> + echo 3
> + echo 1
> + dd if=/mnt/data/file-1G of=/dev/null bs=4096
> 262144+0 records in
> 262144+0 records out
> 1073741824 bytes (1.1 GB) copied, 21.7548 s, 49.4 MB/s
> + date +%s
> + TS=1569905311
> + echo 256
> + cat /proc/sys/vm/nr_hugepages
> 256
> 
> Now with b39d0ee2632d applied
> root@test1:~# sh hugetlb_test.sh
> + echo 0
> + echo 3
> + echo 1
> + dd if=/mnt/data/file-1G of=/dev/null bs=4096
> 262144+0 records in
> 262144+0 records out
> 1073741824 bytes (1.1 GB) copied, 20.1815 s, 53.2 MB/s
> + date +%s
> + TS=1569905516
> + echo 256
> + cat /proc/sys/vm/nr_hugepages
> 11
> root@test1:~# sh hugetlb_test.sh
> + echo 0
> + echo 3
> + echo 1
> + dd if=/mnt/data/file-1G of=/dev/null bs=4096
> 262144+0 records in
> 262144+0 records out
> 1073741824 bytes (1.1 GB) copied, 21.9485 s, 48.9 MB/s
> + date +%s
> + TS=1569905541
> + echo 256
> + cat /proc/sys/vm/nr_hugepages
> 12
> 
> The success rate went down by factor of 20!
> 
> Although hugetlb allocation requests might fail and it is reasonable to
> expect them to under extremely fragmented memory or when the memory is
> under a heavy pressure but the above situation is not that case.
> 
> Fix the regression by reverting back to the previous behavior for
> __GFP_RETRY_MAYFAIL requests and disable the beail out heuristic for
> those requests.

Thank you Michal for doing this.

hugetlbfs allocations are commonly done via sysctl/sysfs shortly after boot
where this may not be as much of an issue.  However, I am aware of at least
three use cases where allocations are made after the system has been up and
running for quite some time:
- DB reconfiguration.  If sysctl/sysfs fails to get required number of huge
  pages, system is rebooted to perform allocation after boot.
- VM provisioning.  If unable get required number of huge pages, fall back
  to base pages.
- An application that does not preallocate pool, but rather allocates pages
  at fault time for optimal NUMA locality.
In all cases, I would expect b39d0ee2632d to cause regressions and noticable
behavior changes.

My quick/limited testing in [1] was insufficient.  It was also mentioned that
if something like b39d0ee2632d went forward, I would like exemptions for
__GFP_RETRY_MAYFAIL requests as in this patch.

> 
> [mhocko@suse.com: reworded changelog]
> Fixes: b39d0ee2632d ("mm, page_alloc: avoid expensive reclaim when compaction may not succeed")
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

FWIW,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

[1] https://lkml.kernel.org/r/3468b605-a3a9-6978-9699-57c52a90bd7e@oracle.com
-- 
Mike Kravetz
