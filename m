Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C05C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE78F24676
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gecwp+ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfLPXUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:20:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40714 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726712AbfLPXUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 18:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576538453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WybyJqeK/JlWGOgL6X/S+wyjYOZmCLqRfMhWN/qPKQY=;
        b=Gecwp+ul4t6wi4uvGVqskzCTHC5pkknexiaaJQIiGLnWVvfAZFR32M4Glu2YeVDs9DSXkB
        QyJJUKW9Bxp7KT/lsJK6/hH2fiTj0KalhXPyY+SHvv7zJ0Jk0zOBOsbvDeIquwc+2lF2CZ
        n6QWsPIcRWhMvQrhU/vVuUD/jK7fwi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-xGWTaAvXPgmCllng39WPPA-1; Mon, 16 Dec 2019 18:20:50 -0500
X-MC-Unique: xGWTaAvXPgmCllng39WPPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF1B9107ACC7;
        Mon, 16 Dec 2019 23:20:48 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-151.rdu2.redhat.com [10.10.120.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A65B15D9C9;
        Mon, 16 Dec 2019 23:20:47 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: Defer freeing of huge pages if in non-task
 context
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20191216182739.26880-1-longman@redhat.com>
 <530afa00-4da9-61cd-d1f3-66803bcd30e6@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2d7c31f9-371d-9a46-96c4-c37dd761c28d@redhat.com>
Date:   Mon, 16 Dec 2019 18:20:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <530afa00-4da9-61cd-d1f3-66803bcd30e6@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 5:40 PM, Mike Kravetz wrote:
> On 12/16/19 10:27 AM, Waiman Long wrote:
>> The following lockdep splat was observed when a certain hugetlbfs test
>> was run:
> <snip>
>> This patch implements the deferred freeing by adding a
>> free_hpage_workfn() work function to do the actual freeing. The
>> free_huge_page() call in a non-task context saves the page to be freed
>> in the hpage_freelist linked list in a lockless manner.
>>
>> The generic workqueue is used to process the work, but a dedicated
>> workqueue can be used instead if it is desirable to have the huge page
>> freed ASAP.
>>
> <snip>
>>  
>> +/*
>> + * As free_huge_page() can be called from a non-task context, we have
>> + * to defer the actual freeing in a workqueue to prevent potential
>> + * hugetlb_lock deadlock.
>> + *
>> + * free_hpage_workfn() locklessly retrieves the linked list of pages to
>> + * be freed and frees them one-by-one. As the page->mapping pointer is
>> + * going to be cleared in __free_huge_page() anyway, it is reused as the
>> + * next pointer of a singly linked list of huge pages to be freed.
>> + */
>> +#define NEXT_PENDING	((struct page *)-1)
>> +static struct page *hpage_freelist;
>> +
>> +static void free_hpage_workfn(struct work_struct *work)
>> +{
>> +	struct page *curr, *next;
>> +	int cnt = 0;
>> +
>> +	do {
>> +		curr = xchg(&hpage_freelist, NULL);
>> +		if (!curr)
>> +			break;
>> +
>> +		while (curr) {
>> +			next = (struct page *)READ_ONCE(curr->mapping);
>> +			if (next == NEXT_PENDING) {
>> +				cpu_relax();
>> +				continue;
>> +			}
>> +			__free_huge_page(curr);
>> +			curr = next;
>> +			cnt++;
>> +		}
>> +	} while (!READ_ONCE(hpage_freelist));
>> +
>> +	if (!cnt)
>> +		return;
>> +	pr_debug("HugeTLB: free_hpage_workfn() frees %d huge page(s)\n", cnt);
>> +}
>> +static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
>> +
>> +void free_huge_page(struct page *page)
>> +{
>> +	/*
>> +	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
>> +	 */
>> +	if (!in_task()) {
>> +		struct page *next;
>> +
>> +		page->mapping = (struct address_space *)NEXT_PENDING;
>> +		next = xchg(&hpage_freelist, page);
>> +		WRITE_ONCE(page->mapping, (struct address_space *)next);
>> +		schedule_work(&free_hpage_work);
>> +		return;
>> +	}
> As Andrew mentioned, the design for the lockless queueing could use more
> explanation.  I had to draw some diagrams before I felt relatively confident
> in the design.
>
>> +
>> +	/*
>> +	 * Racing may prevent some deferred huge pages in hpage_freelist
>> +	 * from being freed. Check here and call schedule_work() if that
>> +	 * is the case.
>> +	 */
>> +	if (unlikely(hpage_freelist && !work_pending(&free_hpage_work)))
>> +		schedule_work(&free_hpage_work);
> Can you describe the race which would leave deferred huge pages on
> hpage_freelist?  I am having a hard time determining how that can happen.
I am being cautious here. It is related how the workqueue works. Whether
a call to schedule_work() has any effect depends on the pending bit in
the workqueue structure. I suppose that it is cleared once the work is
done. So depending on when the bit is cleared, there may be a small
timing window where free_hpage_workfn() is done but the bit has not been
cleared yet. A concurrent softIRQ task may update hpage_freelist and
call schedule_work() without actually queuing it. Perhaps I can check
the return status of schedule_work() and wait for a while there until
the queuing is successfully or the free list is changed. I will need to
look more carefully at the workqueue code to see how big this timing
window is.
> And, if this indeed can happen then I would have to ask what happens if
> a page is 'stuck' and we do not call free_huge_page?  Do we need to take
> that case into account?

As said above, there may be way to reduce the racing window or eliminate
it altogether. I need a bit more time to investigate that. If there is
no way to eliminate the racing window, it is possible that a huge page
may get stuck in the free list for a while.

Cheers,
Longman

