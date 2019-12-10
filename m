Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01B2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5C1206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYnm4R83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLJAqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:46:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38188 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727304AbfLJAqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575938810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cR00koTuXu0FvZFj5k+bBHHb0rpQ11Rkit1AVL+Mz9A=;
        b=hYnm4R83etxJ7ADjzyCnj+tSl8/0RM88hbDhCXpFTsRoRdBhrPllJzdoS+IZRDEnrsgiUM
        twF49oVjC38Mm+nnTj5CNlAR828KyT6O0ih6Aj/tGU84KjCD+w/D8ck9e+BWRvE7KLzqBc
        4xtL4fDOoez7alE9N49sOdfMt2r46eY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-owRi9mklM6mUydjAXoByXQ-1; Mon, 09 Dec 2019 19:46:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C42E801E53;
        Tue, 10 Dec 2019 00:46:47 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-0.rdu2.redhat.com [10.10.123.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D36986055C;
        Tue, 10 Dec 2019 00:46:46 +0000 (UTC)
Subject: Re: [PATCH] hugetlbfs: Disable IRQ when taking hugetlb_lock in
 set_max_huge_pages()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20191209160150.18064-1-longman@redhat.com>
 <20191209164907.GD32169@bombadil.infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a7ea9e1a-be9e-e6ee-5b30-602166041509@redhat.com>
Date:   Mon, 9 Dec 2019 19:46:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191209164907.GD32169@bombadil.infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: owRi9mklM6mUydjAXoByXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/19 11:49 AM, Matthew Wilcox wrote:
> On Mon, Dec 09, 2019 at 11:01:50AM -0500, Waiman Long wrote:
>> [  613.245273] Call Trace:
>> [  613.256273]  <IRQ>
>> [  613.265273]  dump_stack+0x9a/0xf0
>> [  613.281273]  mark_lock+0xd0c/0x12f0
>> [  613.341273]  __lock_acquire+0x146b/0x48c0
>> [  613.401273]  lock_acquire+0x14f/0x3b0
>> [  613.440273]  _raw_spin_lock+0x30/0x70
>> [  613.477273]  free_huge_page+0x36f/0xaa0
>> [  613.495273]  bio_check_pages_dirty+0x2fc/0x5c0
> Oh, this is fun.  So we kicked off IO to a hugepage, then truncated or
> otherwise caused the page to come free.  Then the IO finished and did the
> final put on the page ... from interrupt context.  Splat.  Not something
> that's going to happen often, but can happen if a process dies during
> IO or due to a userspace bug.
>
> Maybe we should schedule work to do the actual freeing of the page
> instead of this rather large patch.  It doesn't seem like a case we need
> to optimise for.
I think that may be a good idea to try it out.
>
> Further, this path is called from softirq context, not hardirq context.
> That means the whole mess could be a spin_lock_bh(), not spin_lock_irq()
> which is rather cheaper.  Anyway, I think the schedule-freeing-of-a-page-
> if-in-irq-context approach is likely to be better.

Yes, using spin_lock_bh() may be better.


>> +/*
>> + * Check to make sure that IRQ is enabled before calling spin_lock_irq()
>> + * so that after a matching spin_unlock_irq() the system won't be in an
>> + * incorrect state.
>> + */
>> +static __always_inline void spin_lock_irq_check(spinlock_t *lock)
>> +{
>> +	lockdep_assert_irqs_enabled();
>> +	spin_lock_irq(lock);
>> +}
>> +#ifdef spin_lock_irq
>> +#undef spin_lock_irq
>> +#endif
>> +#define spin_lock_irq(lock)	spin_lock_irq_check(lock)
> Don't leave your debugging code in the patch you submit for merging.

As I am not 100% sure that free_huge_page() is the only lock taking
function that will be called from the interrupt context, I purposely add
this to catch other possible code path when lockdep is enabled in a
debug kernel. It has no side effect when lockdep isn't enabled. In the
future, if other lock taking functions is being accessed from the
interrupt context, we can spot that more easily. I don't see this
preventive debug code as a problem.

This change, however, should be in a separate patch.

>> @@ -1775,7 +1793,11 @@ static void return_unused_surplus_pages(struct hstate *h,
>>  		unused_resv_pages--;
>>  		if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
>>  			goto out;
>> -		cond_resched_lock(&hugetlb_lock);
>> +		if (need_resched()) {
>> +			spin_unlock_irq(&hugetlb_lock);
>> +			cond_resched();
>> +			spin_lock_irq(&hugetlb_lock);
>> +		}
> This doesn't work.  need_resched() is only going to be set due to things
> happening in interrupt context.  But you've disabled interrupts, so
> need_resched() is never going to be set.

You are probably right. Thanks for pointing this out.

Cheers,
Longman

