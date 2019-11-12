Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229D4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E860621925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e34MTtlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfKLR1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:27:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52901 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726738AbfKLR1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573579667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3GFD3RmbDO5HoBdK1kzcUxkVYIC30uFtwy9Gv2par0=;
        b=e34MTtlqWbufI2q0Qt0CCn7x6h2jcnwNern5rHXHAPRrfuOrzScd5aoExnXrv2e07UpuPG
        iMZZZ8L+6ySW8fZjWpKIt7jDOqbF4zIe+unsuMwFLPhntm4Zc7EpHgzJtDHQSslyfcFDLC
        8+qnkTVL5aJhvSqdaNuZ2nWMzSJv0W0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-__xu1CdDNUuR6B77fHh4Kw-1; Tue, 12 Nov 2019 12:27:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49E8410B889E;
        Tue, 12 Nov 2019 17:27:42 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0462F60923;
        Tue, 12 Nov 2019 17:27:40 +0000 (UTC)
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
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <fd29a337-c067-ebf6-4be2-3b6e2f703ac4@redhat.com>
Date:   Tue, 12 Nov 2019 12:27:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5059733e-95aa-2c9e-6f5d-4f45f6a130b3@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: __xu1CdDNUuR6B77fHh4Kw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/19 8:47 PM, Mike Kravetz wrote:
> On 11/8/19 11:10 AM, Mike Kravetz wrote:
>> On 11/7/19 6:04 PM, Davidlohr Bueso wrote:
>>> On Thu, 07 Nov 2019, Mike Kravetz wrote:
>>>
>>>> Note that huge_pmd_share now increments the page count with the semaph=
ore
>>>> held just in read mode.  It is OK to do increments in parallel without
>>>> synchronization.  However, we don't want anyone else changing the coun=
t
>>>> while that check in huge_pmd_unshare is happening.  Hence, the need fo=
r
>>>> taking the semaphore in write mode.
>>> This would be a nice addition to the changelog methinks.
>> Last night I remembered there is one place where we currently take
>> i_mmap_rwsem in read mode and potentially call huge_pmd_unshare.  That
>> is in try_to_unmap_one.  Yes, there is a potential race here today.
> Actually there is no race there today.  Callers to huge_pmd_unshare
> hold the page table lock.  So, this synchronizes those unshare calls
> from  page migration and page poisoning.
>
>> But that race is somewhat contained as you need two threads doing some
>> combination of page migration and page poisoning to race.  This change
>> now allows migration or poisoning to race with page fault.  I would
>> really prefer if we do not open up the race window in this manner.
> But, we do open a race window by changing huge_pmd_share to take the
> i_mmap_rwsem in read mode as in the original patch. =20
>
> Here is the additional code needed to take the semaphore in write mode
> for the huge_pmd_unshare calls via try_to_unmap_one.  We would need to
> combine this with Longman's patch.  Please take a look and provide feedba=
ck.
> Some of the changes are subtle, especially the exception for MAP_PRIVATE
> mappings, but I tried to add sufficient comments.
>
> From 21735818a520705c8573b8d543b8f91aa187bd5d Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Fri, 8 Nov 2019 17:25:37 -0800
> Subject: [PATCH] Changes needed for taking i_mmap_rwsem in write mode bef=
ore
>  call to huge_pmd_unshare in try_to_unmap_one.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c        |  9 ++++++++-
>  mm/memory-failure.c | 28 +++++++++++++++++++++++++++-
>  mm/migrate.c        | 27 +++++++++++++++++++++++++--
>  3 files changed, 60 insertions(+), 4 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f78891f92765..73d9136549a5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4883,7 +4883,14 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsign=
ed long addr, pud_t *pud)
>   * indicated by page_count > 1, unmap is achieved by clearing pud and
>   * decrementing the ref count. If count =3D=3D 1, the pte page is not sh=
ared.
>   *
> - * called with page table lock held.
> + * Must be called while holding page table lock.
> + * In general, the caller should also hold the i_mmap_rwsem in write mod=
e.
> + * This is to prevent races with page faults calling huge_pmd_share whic=
h
> + * will not be holding the page table lock, but will be holding i_mmap_r=
wsem
> + * in read mode.  It is possible to call without holding i_mmap_rwsem in
> + * write mode if the caller KNOWS the page table is associated with a pr=
ivate
> + * mapping.  This is because private mappings can not share PMDs and can
> + * not race with huge_pmd_share calls during page faults.

So the page table lock here is the huge_pte_lock(). Right? In
huge_pmd_share(), the pte lock has to be taken before one can share it.
So would you mind explaining where exactly is the race?

Thanks,
Longman

>   *
>   * returns: 1 successfully unmapped a shared pte page
>   *=09    0 the underlying pte page is not shared, or it is the last user
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3151c87dff73..8f52b22cf71b 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1030,7 +1030,33 @@ static bool hwpoison_user_mappings(struct page *p,=
 unsigned long pfn,
>  =09if (kill)
>  =09=09collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
> =20
> -=09unmap_success =3D try_to_unmap(hpage, ttu);
> +=09if (!PageHuge(hpage)) {
> +=09=09unmap_success =3D try_to_unmap(hpage, ttu);
> +=09} else {
> +=09=09mapping =3D page_mapping(hpage);
> +=09=09if (mapping) {
> +=09=09=09/*
> +=09=09=09 * For hugetlb pages, try_to_unmap could potentially
> +=09=09=09 * call huge_pmd_unshare.  Because of this, take
> +=09=09=09 * semaphore in write mode here and set TTU_RMAP_LOCKED
> +=09=09=09 * to indicate we have taken the lock at this higher
> +=09=09=09 * level.
> +=09=09=09 */
> +=09=09=09i_mmap_lock_write(mapping);
> +=09=09=09unmap_success =3D try_to_unmap(hpage,
> +=09=09=09=09=09=09=09ttu|TTU_RMAP_LOCKED);
> +=09=09=09i_mmap_unlock_write(mapping);
> +=09=09} else {
> +=09=09=09/*
> +=09=09=09 * !mapping implies a MAP_PRIVATE huge page mapping.
> +=09=09=09 * Since PMDs will never be shared in a private
> +=09=09=09 * mapping, it is safe to let huge_pmd_unshare be
> +=09=09=09 * called with the semaphore in read mode.
> +=09=09=09 */
> +=09=09=09unmap_success =3D try_to_unmap(hpage, ttu);
> +=09=09}
> +=09}
> +
>  =09if (!unmap_success)
>  =09=09pr_err("Memory failure: %#lx: failed to unmap page (mapcount=3D%d)=
\n",
>  =09=09       pfn, page_mapcount(hpage));
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4fe45d1428c8..9cae5a4f1e48 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1333,8 +1333,31 @@ static int unmap_and_move_huge_page(new_page_t get=
_new_page,
>  =09=09goto put_anon;
> =20
>  =09if (page_mapped(hpage)) {
> -=09=09try_to_unmap(hpage,
> -=09=09=09TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
> +=09=09struct address_space *mapping =3D page_mapping(hpage);
> +
> +=09=09if (mapping) {
> +=09=09=09/*
> +=09=09=09 * try_to_unmap could potentially call huge_pmd_unshare.
> +=09=09=09 * Because of this, take semaphore in write mode here
> +=09=09=09 * and set TTU_RMAP_LOCKED to indicate we have taken
> +=09=09=09 * the lock at this higher level.
> +=09=09=09 */
> +=09=09=09i_mmap_lock_write(mapping);
> +=09=09=09try_to_unmap(hpage,
> +=09=09=09=09TTU_MIGRATION|TTU_IGNORE_MLOCK|
> +=09=09=09=09TTU_IGNORE_ACCESS|TTU_RMAP_LOCKED);
> +=09=09=09i_mmap_unlock_write(mapping);
> +=09=09} else {
> +=09=09=09/*
> +=09=09=09 * !mapping implies a MAP_PRIVATE huge page mapping.
> +=09=09=09 * Since PMDs will never be shared in a private
> +=09=09=09 * mapping, it is safe to let huge_pmd_unshare be
> +=09=09=09 * called with the semaphore in read mode.
> +=09=09=09 */
> +=09=09=09try_to_unmap(hpage,
> +=09=09=09=09TTU_MIGRATION|TTU_IGNORE_MLOCK|
> +=09=09=09=09TTU_IGNORE_ACCESS);
> +=09=09}
>  =09=09page_was_mapped =3D 1;
>  =09}
> =20


