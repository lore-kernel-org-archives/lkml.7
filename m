Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BE7C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E727D204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egFodboY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKMCzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:55:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60435 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726979AbfKMCzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573613707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEZEFdfBLqCpFlj0HXUJ3Rk++O0w0ySIrg0cr29shO0=;
        b=egFodboYag0t06Ms/UlDr/jt8AI+A8NN+Sngj92AQI4UIg4FzfftodGLJHHmTTSrwDp7hE
        7SzF1aqSLj76/93xayvTDp8JJ3pMrX83fgFgGexF6gUbOg9w1G2MBojRm9nFfKLY5dmebU
        aAQk6U/3Wzn52JdEV/6EEM7TElKXTRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-Wd7ywj7cPE2UeQJY8jww4Q-1; Tue, 12 Nov 2019 21:55:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E61DB801E54;
        Wed, 13 Nov 2019 02:55:01 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-42.rdu2.redhat.com [10.10.122.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD846600F8;
        Wed, 13 Nov 2019 02:55:00 +0000 (UTC)
Subject: Re: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
To:     Mike Kravetz <mike.kravetz@oracle.com>,
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
 <33d1fcc8-ebec-bd37-2969-daa0125479df@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <28b721b1-38f3-f10a-60e3-20e247c4ecb7@redhat.com>
Date:   Tue, 12 Nov 2019 21:55:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <33d1fcc8-ebec-bd37-2969-daa0125479df@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Wd7ywj7cPE2UeQJY8jww4Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 6:11 PM, Mike Kravetz wrote:
> On 11/12/19 9:27 AM, Waiman Long wrote:
>> On 11/8/19 8:47 PM, Mike Kravetz wrote:
>>> On 11/8/19 11:10 AM, Mike Kravetz wrote:
>>>> On 11/7/19 6:04 PM, Davidlohr Bueso wrote:
>>>>> On Thu, 07 Nov 2019, Mike Kravetz wrote:
>>>>>
>>>>>> Note that huge_pmd_share now increments the page count with the sema=
phore
>>>>>> held just in read mode.  It is OK to do increments in parallel witho=
ut
>>>>>> synchronization.  However, we don't want anyone else changing the co=
unt
>>>>>> while that check in huge_pmd_unshare is happening.  Hence, the need =
for
>>>>>> taking the semaphore in write mode.
>>>>> This would be a nice addition to the changelog methinks.
>>>> Last night I remembered there is one place where we currently take
>>>> i_mmap_rwsem in read mode and potentially call huge_pmd_unshare.  That
>>>> is in try_to_unmap_one.  Yes, there is a potential race here today.
>>> Actually there is no race there today.  Callers to huge_pmd_unshare
>>> hold the page table lock.  So, this synchronizes those unshare calls
>>> from  page migration and page poisoning.
>>>
>>>> But that race is somewhat contained as you need two threads doing some
>>>> combination of page migration and page poisoning to race.  This change
>>>> now allows migration or poisoning to race with page fault.  I would
>>>> really prefer if we do not open up the race window in this manner.
>>> But, we do open a race window by changing huge_pmd_share to take the
>>> i_mmap_rwsem in read mode as in the original patch. =20
>>>
>>> Here is the additional code needed to take the semaphore in write mode
>>> for the huge_pmd_unshare calls via try_to_unmap_one.  We would need to
>>> combine this with Longman's patch.  Please take a look and provide feed=
back.
>>> Some of the changes are subtle, especially the exception for MAP_PRIVAT=
E
>>> mappings, but I tried to add sufficient comments.
>>>
>>> From 21735818a520705c8573b8d543b8f91aa187bd5d Mon Sep 17 00:00:00 2001
>>> From: Mike Kravetz <mike.kravetz@oracle.com>
>>> Date: Fri, 8 Nov 2019 17:25:37 -0800
>>> Subject: [PATCH] Changes needed for taking i_mmap_rwsem in write mode b=
efore
>>>  call to huge_pmd_unshare in try_to_unmap_one.
>>>
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>>  mm/hugetlb.c        |  9 ++++++++-
>>>  mm/memory-failure.c | 28 +++++++++++++++++++++++++++-
>>>  mm/migrate.c        | 27 +++++++++++++++++++++++++--
>>>  3 files changed, 60 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index f78891f92765..73d9136549a5 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -4883,7 +4883,14 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsi=
gned long addr, pud_t *pud)
>>>   * indicated by page_count > 1, unmap is achieved by clearing pud and
>>>   * decrementing the ref count. If count =3D=3D 1, the pte page is not =
shared.
>>>   *
>>> - * called with page table lock held.
>>> + * Must be called while holding page table lock.
>>> + * In general, the caller should also hold the i_mmap_rwsem in write m=
ode.
>>> + * This is to prevent races with page faults calling huge_pmd_share wh=
ich
>>> + * will not be holding the page table lock, but will be holding i_mmap=
_rwsem
>>> + * in read mode.  It is possible to call without holding i_mmap_rwsem =
in
>>> + * write mode if the caller KNOWS the page table is associated with a =
private
>>> + * mapping.  This is because private mappings can not share PMDs and c=
an
>>> + * not race with huge_pmd_share calls during page faults.
>> So the page table lock here is the huge_pte_lock(). Right? In
>> huge_pmd_share(), the pte lock has to be taken before one can share it.
>> So would you mind explaining where exactly is the race?
> My concern was that this code in huge_pmd_share:
>
> =09=09saddr =3D page_table_shareable(svma, vma, addr, idx);
> =09=09if (saddr) {
> =09=09=09spte =3D huge_pte_offset(svma->vm_mm, saddr,
> =09=09=09=09=09       vma_mmu_pagesize(svma));
> =09=09=09if (spte) {
> =09=09=09=09get_page(virt_to_page(spte));
> =09=09=09=09break;
> =09=09=09}
> =09=09}
>
> and this code in huge_pmd_unshare:
>
>         BUG_ON(page_count(virt_to_page(ptep)) =3D=3D 0);
>         if (page_count(virt_to_page(ptep)) =3D=3D 1)
>                 return 0;
>
> could run concurrently.  Note that return code for huge_pmd_unshare is
> specified as,
>
>  * returns: 1 successfully unmapped a shared pte page
>  *          0 the underlying pte page is not shared, or it is the last us=
er
>
> And, callers take different action depending on the return value.
>
> Now, since the code blocks above can run concurrently it is possible that=
:
> - huge_pmd_unshare sees page_count =3D=3D 1
> - huge_pmd_share increments page_count in anticipation of sharing
> - huge_pmd_unshare returns 0 indicating there is no pmd sharing
> - huge_pmd_share waits for page table lock to insert pmd page before it
>   sharts sharing
>
> My concern was with what might happen if a huge_pmd_unshare caller receiv=
ed
> a 0 return code and thought there were no other users of the pmd.  In the
> specific case mentioned here (try_to_unmap_one) I now do not believe ther=
e
> are any issues.  The caller is simply going to clear one entry on the pmd
> page.  I can not think of a way this could impact the other thread waitin=
g
> to share the pmd.  It will simply start sharing the pmd after it gets the
> page table lock and the entry has been removed.
>
> As the result of your question, I went back and took a really close look
> at the code in question.  While that huge_pmd_share/huge_pmd_unshare code
> running concurrently does make me a bit nervous, I can not find any speci=
fic
> problem.  In addition, I ran a test causes this race for several hours
> without issue.
>
> Sorry for the churn/second thoughts.  This code is subtle, and sometimes =
hard
> to understand.  IMO, Longman's patch (V2) can go forward, but please dele=
te
> the following blob in the commit message from me:
>
> "Note that huge_pmd_share now increments the page count with the
>  semaphore held just in read mode.  It is OK to do increments in
>  parallel without synchronization.  However, we don't want anyone else
>  changing the count while that check in huge_pmd_unshare is happening.=20
>  Hence, the need for taking the semaphore in write mode."
>
Thanks for the explanation. I understand that it is often time hard to
figure out if a race exists or not. I got confused myself many times.
Anyway, as long as any destructive action is only taken while holding
the page table lock, it should be safe.

Cheers,
Longman

