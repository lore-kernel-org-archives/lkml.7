Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DABDC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BED2176D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/6qph6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLPWw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:52:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26212 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726448AbfLPWw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576536744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sprdJbzrcYgB8goX1vCpRjORoPnAOw6aRMXZkfaGarU=;
        b=Z/6qph6Yw3sC3AYXY4ngeLbrwFUDKnL3xKhhhQpDqLkzoeTH/lWJJPfW/1Xbi6O2+/ZhLf
        CsEmwxa6J6DNqm3xynUOhjf488XxM70KkcZbsGuD+jAMUu8Vs2jo7CSfjJ+eyyp8yEEPET
        e2nlw/+/p5PT8URPHlBCgecj2jTi2cc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-Uo-WBHi9NR21aGRkvdF4aw-1; Mon, 16 Dec 2019 17:52:20 -0500
X-MC-Unique: Uo-WBHi9NR21aGRkvdF4aw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 137131854331;
        Mon, 16 Dec 2019 22:52:19 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-151.rdu2.redhat.com [10.10.120.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA3905C1B0;
        Mon, 16 Dec 2019 22:52:17 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: Defer freeing of huge pages if in non-task
 context
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20191216182739.26880-1-longman@redhat.com>
 <20191216135110.b6fb283ba5551c8cfb22494e@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a4789a59-d54e-2052-bd4d-3ab44a9726b6@redhat.com>
Date:   Mon, 16 Dec 2019 17:52:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191216135110.b6fb283ba5551c8cfb22494e@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 4:51 PM, Andrew Morton wrote:
> On Mon, 16 Dec 2019 13:27:39 -0500 Waiman Long <longman@redhat.com> wrote:
>
>> The following lockdep splat was observed when a certain hugetlbfs test
>> was run:
>>
>> ...
>>
>> Both the hugetbl_lock and the subpool lock can be acquired in
>> free_huge_page(). One way to solve the problem is to make both locks
>> irq-safe. Another alternative is to defer the freeing to a workqueue job.
>>
>> This patch implements the deferred freeing by adding a
>> free_hpage_workfn() work function to do the actual freeing. The
>> free_huge_page() call in a non-task context saves the page to be freed
>> in the hpage_freelist linked list in a lockless manner.
>>
>> The generic workqueue is used to process the work, but a dedicated
>> workqueue can be used instead if it is desirable to have the huge page
>> freed ASAP.
>>
>> ...
>>
>> @@ -1199,6 +1199,73 @@ void free_huge_page(struct page *page)
>>  	spin_unlock(&hugetlb_lock);
>>  }
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
> The NEXT_PENDING stuff could do with come commenting, I think.  It's
> reasonably obvious, but not obvious enough.  For example, why does the
> second write to page->mapping use WRITE_ONCE() but the first does not. 
> Please spell out the design, fully.

Sure. The idea is that the setting of the next pointer and the writing
to hpage_freelist cannot be done atomically without using a lock. Before
xchg(), the page isn't visible to a concurrent work function. So no
special write is needed, the mb() in xchg will ensure that the
page->mapping will be visible to all. After the xchg, page->mapping is
subjected to concurrent access. So WRITE_ONCE() is used to make sure
that is no write tearing.

I will update the patch with more comment once I gather other feedbacks
from other reviewers.

>
>> +		schedule_work(&free_hpage_work);
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Racing may prevent some deferred huge pages in hpage_freelist
>> +	 * from being freed. Check here and call schedule_work() if that
>> +	 * is the case.
>> +	 */
>> +	if (unlikely(hpage_freelist && !work_pending(&free_hpage_work)))
>> +		schedule_work(&free_hpage_work);
>> +
>> +	__free_huge_page(page);
>> +}
>> +
>>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>>  {
>>  	INIT_LIST_HEAD(&page->lru);
> Otherwise it looks OK to me.  Deferring freeing in this way is
> generally lame and gives rise to concerns about memory exhaustion in
> strange situations, and to concerns about various memory accounting
> stats being logically wrong for short periods.  But we already do this
> in (too) many places, so fingers crossed :(
>
It is actually quite rare to hit the condition that a huge page will
have to be freed in an irq context. Otherwise, this problem will be
found earlier. Hopefully the workfn won't be invoked in that many occasions.

Cheers,
Longman

