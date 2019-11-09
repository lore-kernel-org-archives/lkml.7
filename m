Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB592C17440
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BA620865
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hSU2uBLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfKIBry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 20:47:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41140 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfKIBry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 20:47:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA91kwIF161899;
        Sat, 9 Nov 2019 01:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=RDaArW/XqS52bxXI2GDucXkCgk42HxOuT5sk7BxFnA0=;
 b=hSU2uBLNtTUdrhIczXBD4Ao5A7MxQNv+v6hDSuE3JmNU2P4bQbtSSeHvXycKmoyqXrKG
 TgkHsdG/sjg3bIpHzY97Ez+cadRcOsrqH5ikekwNxSNGuY4qUGf5tNB4StM4NCgvch++
 KbpptL4lXD2skCuw+ta7VaXOUmE0RQjo8DSgNHtaNMmZEgt2WjiDMV12EBZlX5ZvRql9
 +4u3sH8acPObm6jT2Wblnv/J64bkm1+FU8YS+eoHcW9HPDVH1rPFs0gNrNRh4N4Mq6EG
 F3ZTZ5XcOobAHVQ2D2MD8eegrsJMfBBWMqm+SZKKdbasbKrM3/aT9XDXkWSQys5VzHwC Vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w5hgwra47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Nov 2019 01:47:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA91hjdM193643;
        Sat, 9 Nov 2019 01:47:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2w5kh3t316-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Nov 2019 01:47:14 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA91l7SI029014;
        Sat, 9 Nov 2019 01:47:08 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 17:47:07 -0800
Subject: Re: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
References: <20191107190628.22667-1-longman@redhat.com>
 <20191107195441.GF11823@bombadil.infradead.org>
 <ed46ef09-7766-eb80-a4ad-4c72d8dba188@oracle.com>
 <20191108020456.sulyjskhq3s5zcaa@linux-p48b>
 <ea057d15-5205-9992-af95-b2727df577c4@oracle.com>
Message-ID: <5059733e-95aa-2c9e-6f5d-4f45f6a130b3@oracle.com>
Date:   Fri, 8 Nov 2019 17:47:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <ea057d15-5205-9992-af95-b2727df577c4@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9435 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911090014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9435 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911090014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/19 11:10 AM, Mike Kravetz wrote:
> On 11/7/19 6:04 PM, Davidlohr Bueso wrote:
>> On Thu, 07 Nov 2019, Mike Kravetz wrote:
>>
>>> Note that huge_pmd_share now increments the page count with the semaphore
>>> held just in read mode.  It is OK to do increments in parallel without
>>> synchronization.  However, we don't want anyone else changing the count
>>> while that check in huge_pmd_unshare is happening.  Hence, the need for
>>> taking the semaphore in write mode.
>>
>> This would be a nice addition to the changelog methinks.
> 
> Last night I remembered there is one place where we currently take
> i_mmap_rwsem in read mode and potentially call huge_pmd_unshare.  That
> is in try_to_unmap_one.  Yes, there is a potential race here today.

Actually there is no race there today.  Callers to huge_pmd_unshare
hold the page table lock.  So, this synchronizes those unshare calls
from  page migration and page poisoning.

> But that race is somewhat contained as you need two threads doing some
> combination of page migration and page poisoning to race.  This change
> now allows migration or poisoning to race with page fault.  I would
> really prefer if we do not open up the race window in this manner.

But, we do open a race window by changing huge_pmd_share to take the
i_mmap_rwsem in read mode as in the original patch.  

Here is the additional code needed to take the semaphore in write mode
for the huge_pmd_unshare calls via try_to_unmap_one.  We would need to
combine this with Longman's patch.  Please take a look and provide feedback.
Some of the changes are subtle, especially the exception for MAP_PRIVATE
mappings, but I tried to add sufficient comments.

From 21735818a520705c8573b8d543b8f91aa187bd5d Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 8 Nov 2019 17:25:37 -0800
Subject: [PATCH] Changes needed for taking i_mmap_rwsem in write mode before
 call to huge_pmd_unshare in try_to_unmap_one.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c        |  9 ++++++++-
 mm/memory-failure.c | 28 +++++++++++++++++++++++++++-
 mm/migrate.c        | 27 +++++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f78891f92765..73d9136549a5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4883,7 +4883,14 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
  * indicated by page_count > 1, unmap is achieved by clearing pud and
  * decrementing the ref count. If count == 1, the pte page is not shared.
  *
- * called with page table lock held.
+ * Must be called while holding page table lock.
+ * In general, the caller should also hold the i_mmap_rwsem in write mode.
+ * This is to prevent races with page faults calling huge_pmd_share which
+ * will not be holding the page table lock, but will be holding i_mmap_rwsem
+ * in read mode.  It is possible to call without holding i_mmap_rwsem in
+ * write mode if the caller KNOWS the page table is associated with a private
+ * mapping.  This is because private mappings can not share PMDs and can
+ * not race with huge_pmd_share calls during page faults.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3151c87dff73..8f52b22cf71b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1030,7 +1030,33 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	if (kill)
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
-	unmap_success = try_to_unmap(hpage, ttu);
+	if (!PageHuge(hpage)) {
+		unmap_success = try_to_unmap(hpage, ttu);
+	} else {
+		mapping = page_mapping(hpage);
+		if (mapping) {
+			/*
+			 * For hugetlb pages, try_to_unmap could potentially
+			 * call huge_pmd_unshare.  Because of this, take
+			 * semaphore in write mode here and set TTU_RMAP_LOCKED
+			 * to indicate we have taken the lock at this higher
+			 * level.
+			 */
+			i_mmap_lock_write(mapping);
+			unmap_success = try_to_unmap(hpage,
+							ttu|TTU_RMAP_LOCKED);
+			i_mmap_unlock_write(mapping);
+		} else {
+			/*
+			 * !mapping implies a MAP_PRIVATE huge page mapping.
+			 * Since PMDs will never be shared in a private
+			 * mapping, it is safe to let huge_pmd_unshare be
+			 * called with the semaphore in read mode.
+			 */
+			unmap_success = try_to_unmap(hpage, ttu);
+		}
+	}
+
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
 		       pfn, page_mapcount(hpage));
diff --git a/mm/migrate.c b/mm/migrate.c
index 4fe45d1428c8..9cae5a4f1e48 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1333,8 +1333,31 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		goto put_anon;
 
 	if (page_mapped(hpage)) {
-		try_to_unmap(hpage,
-			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
+		struct address_space *mapping = page_mapping(hpage);
+
+		if (mapping) {
+			/*
+			 * try_to_unmap could potentially call huge_pmd_unshare.
+			 * Because of this, take semaphore in write mode here
+			 * and set TTU_RMAP_LOCKED to indicate we have taken
+			 * the lock at this higher level.
+			 */
+			i_mmap_lock_write(mapping);
+			try_to_unmap(hpage,
+				TTU_MIGRATION|TTU_IGNORE_MLOCK|
+				TTU_IGNORE_ACCESS|TTU_RMAP_LOCKED);
+			i_mmap_unlock_write(mapping);
+		} else {
+			/*
+			 * !mapping implies a MAP_PRIVATE huge page mapping.
+			 * Since PMDs will never be shared in a private
+			 * mapping, it is safe to let huge_pmd_unshare be
+			 * called with the semaphore in read mode.
+			 */
+			try_to_unmap(hpage,
+				TTU_MIGRATION|TTU_IGNORE_MLOCK|
+				TTU_IGNORE_ACCESS);
+		}
 		page_was_mapped = 1;
 	}
 
-- 
2.23.0

