Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FA7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A150921A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GdafzKPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKLXLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:11:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40712 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKLXL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:11:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACN4VIh085733;
        Tue, 12 Nov 2019 23:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=FyCT2WC098LLp1SKE0SMEzo1iZbKjezjYTbv92kCGNg=;
 b=GdafzKPpn/YIYBUORoYcX1L0moEjwH3HGfJqiG21wpJLk1hUSuXJ1kofDjrpgqipELJC
 S4Ei5gUm9Xnh5TZyOgxvnlVhrlVJle4Mwpvq5lQehpnMqey4NPfl0XDvOB3Olva/jmNo
 CpB/xd2Z74trpHGAPrXvnfxgP7ccd5rTFS9TkXUHMDybk6FrWBfprzWUloXjQCzIzNZZ
 tdwjfdG+Mo7+IOIUPcBqB1xH+iBadWGqGHigrMYENF9d9mR0zxiOhYa/M35/tKdQWJNx
 Oyows3ev8pRdO3nBTKVICYAULGVZmy0ubU+QgDXm20t6mPuDx9lcbjR0zGQTZwVqr0HC OA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w5p3qr3ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 23:11:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACN4lek004368;
        Tue, 12 Nov 2019 23:11:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2w7vpn79t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 23:11:09 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xACNB7G2026351;
        Tue, 12 Nov 2019 23:11:07 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 15:11:07 -0800
Subject: Re: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
To:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
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
 <5059733e-95aa-2c9e-6f5d-4f45f6a130b3@oracle.com>
 <fd29a337-c067-ebf6-4be2-3b6e2f703ac4@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <33d1fcc8-ebec-bd37-2969-daa0125479df@oracle.com>
Date:   Tue, 12 Nov 2019 15:11:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <fd29a337-c067-ebf6-4be2-3b6e2f703ac4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120199
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 9:27 AM, Waiman Long wrote:
> On 11/8/19 8:47 PM, Mike Kravetz wrote:
>> On 11/8/19 11:10 AM, Mike Kravetz wrote:
>>> On 11/7/19 6:04 PM, Davidlohr Bueso wrote:
>>>> On Thu, 07 Nov 2019, Mike Kravetz wrote:
>>>>
>>>>> Note that huge_pmd_share now increments the page count with the semaphore
>>>>> held just in read mode.  It is OK to do increments in parallel without
>>>>> synchronization.  However, we don't want anyone else changing the count
>>>>> while that check in huge_pmd_unshare is happening.  Hence, the need for
>>>>> taking the semaphore in write mode.
>>>> This would be a nice addition to the changelog methinks.
>>> Last night I remembered there is one place where we currently take
>>> i_mmap_rwsem in read mode and potentially call huge_pmd_unshare.  That
>>> is in try_to_unmap_one.  Yes, there is a potential race here today.
>> Actually there is no race there today.  Callers to huge_pmd_unshare
>> hold the page table lock.  So, this synchronizes those unshare calls
>> from  page migration and page poisoning.
>>
>>> But that race is somewhat contained as you need two threads doing some
>>> combination of page migration and page poisoning to race.  This change
>>> now allows migration or poisoning to race with page fault.  I would
>>> really prefer if we do not open up the race window in this manner.
>> But, we do open a race window by changing huge_pmd_share to take the
>> i_mmap_rwsem in read mode as in the original patch.  
>>
>> Here is the additional code needed to take the semaphore in write mode
>> for the huge_pmd_unshare calls via try_to_unmap_one.  We would need to
>> combine this with Longman's patch.  Please take a look and provide feedback.
>> Some of the changes are subtle, especially the exception for MAP_PRIVATE
>> mappings, but I tried to add sufficient comments.
>>
>> From 21735818a520705c8573b8d543b8f91aa187bd5d Mon Sep 17 00:00:00 2001
>> From: Mike Kravetz <mike.kravetz@oracle.com>
>> Date: Fri, 8 Nov 2019 17:25:37 -0800
>> Subject: [PATCH] Changes needed for taking i_mmap_rwsem in write mode before
>>  call to huge_pmd_unshare in try_to_unmap_one.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  mm/hugetlb.c        |  9 ++++++++-
>>  mm/memory-failure.c | 28 +++++++++++++++++++++++++++-
>>  mm/migrate.c        | 27 +++++++++++++++++++++++++--
>>  3 files changed, 60 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index f78891f92765..73d9136549a5 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -4883,7 +4883,14 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
>>   * indicated by page_count > 1, unmap is achieved by clearing pud and
>>   * decrementing the ref count. If count == 1, the pte page is not shared.
>>   *
>> - * called with page table lock held.
>> + * Must be called while holding page table lock.
>> + * In general, the caller should also hold the i_mmap_rwsem in write mode.
>> + * This is to prevent races with page faults calling huge_pmd_share which
>> + * will not be holding the page table lock, but will be holding i_mmap_rwsem
>> + * in read mode.  It is possible to call without holding i_mmap_rwsem in
>> + * write mode if the caller KNOWS the page table is associated with a private
>> + * mapping.  This is because private mappings can not share PMDs and can
>> + * not race with huge_pmd_share calls during page faults.
> 
> So the page table lock here is the huge_pte_lock(). Right? In
> huge_pmd_share(), the pte lock has to be taken before one can share it.
> So would you mind explaining where exactly is the race?

My concern was that this code in huge_pmd_share:

		saddr = page_table_shareable(svma, vma, addr, idx);
		if (saddr) {
			spte = huge_pte_offset(svma->vm_mm, saddr,
					       vma_mmu_pagesize(svma));
			if (spte) {
				get_page(virt_to_page(spte));
				break;
			}
		}

and this code in huge_pmd_unshare:

        BUG_ON(page_count(virt_to_page(ptep)) == 0);
        if (page_count(virt_to_page(ptep)) == 1)
                return 0;

could run concurrently.  Note that return code for huge_pmd_unshare is
specified as,

 * returns: 1 successfully unmapped a shared pte page
 *          0 the underlying pte page is not shared, or it is the last user

And, callers take different action depending on the return value.

Now, since the code blocks above can run concurrently it is possible that:
- huge_pmd_unshare sees page_count == 1
- huge_pmd_share increments page_count in anticipation of sharing
- huge_pmd_unshare returns 0 indicating there is no pmd sharing
- huge_pmd_share waits for page table lock to insert pmd page before it
  sharts sharing

My concern was with what might happen if a huge_pmd_unshare caller received
a 0 return code and thought there were no other users of the pmd.  In the
specific case mentioned here (try_to_unmap_one) I now do not believe there
are any issues.  The caller is simply going to clear one entry on the pmd
page.  I can not think of a way this could impact the other thread waiting
to share the pmd.  It will simply start sharing the pmd after it gets the
page table lock and the entry has been removed.

As the result of your question, I went back and took a really close look
at the code in question.  While that huge_pmd_share/huge_pmd_unshare code
running concurrently does make me a bit nervous, I can not find any specific
problem.  In addition, I ran a test causes this race for several hours
without issue.

Sorry for the churn/second thoughts.  This code is subtle, and sometimes hard
to understand.  IMO, Longman's patch (V2) can go forward, but please delete
the following blob in the commit message from me:

"Note that huge_pmd_share now increments the page count with the
 semaphore held just in read mode.  It is OK to do increments in
 parallel without synchronization.  However, we don't want anyone else
 changing the count while that check in huge_pmd_unshare is happening. 
 Hence, the need for taking the semaphore in write mode."

-- 
Mike Kravetz
