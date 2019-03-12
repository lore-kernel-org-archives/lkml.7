Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7767AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C022077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfCLVLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:11:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfCLVLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:11:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3EB26307D844;
        Tue, 12 Mar 2019 21:11:23 +0000 (UTC)
Received: from sky.random (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA5474C3;
        Tue, 12 Mar 2019 21:11:17 +0000 (UTC)
Date:   Tue, 12 Mar 2019 17:11:17 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Miller <davem@davemloft.net>, hch@infradead.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
Message-ID: <20190312211117.GB25147@redhat.com>
References: <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
 <20190311095405-mutt-send-email-mst@kernel.org>
 <20190311.111413.1140896328197448401.davem@davemloft.net>
 <6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
 <20190311235140-mutt-send-email-mst@kernel.org>
 <76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
 <20190312075033-mutt-send-email-mst@kernel.org>
 <1552405610.3083.17.camel@HansenPartnership.com>
 <20190312200450.GA25147@redhat.com>
 <1552424017.14432.11.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552424017.14432.11.camel@HansenPartnership.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 12 Mar 2019 21:11:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 01:53:37PM -0700, James Bottomley wrote:
> I've got to say: optimize what?  What code do we ever have in the
> kernel that kmap's a page and then doesn't do anything with it? You can
> guarantee that on kunmap the page is either referenced (needs
> invalidating) or updated (needs flushing). The in-kernel use of kmap is
> always
> 
> kmap
> do something with the mapped page
> kunmap
> 
> In a very short interval.  It seems just a simplification to make
> kunmap do the flush if needed rather than try to have the users
> remember.  The thing which makes this really simple is that on most
> architectures flush and invalidate is the same operation.  If you
> really want to optimize you can use the referenced and dirty bits on
> the kmapped pte to tell you what operation to do, but if your flush is
> your invalidate, you simply assume the data needs flushing on kunmap
> without checking anything.

Except other archs like arm64 and sparc do the cache flushing on
copy_to_user_page and copy_user_page, not on kunmap.

#define copy_user_page(to,from,vaddr,pg) __cpu_copy_user_page(to, from, vaddr)
void __cpu_copy_user_page(void *kto, const void *kfrom, unsigned long vaddr)
{
	struct page *page = virt_to_page(kto);
	copy_page(kto, kfrom);
	flush_dcache_page(page);
}
#define copy_user_page(to, from, vaddr, page)	\
	do {	copy_page(to, from);		\
		sparc_flush_page_to_ram(page);	\
	} while (0)

And they do nothing on kunmap:

static inline void kunmap(struct page *page)
{
	BUG_ON(in_interrupt());
	if (!PageHighMem(page))
		return;
	kunmap_high(page);
}
void kunmap_high(struct page *page)
{
	unsigned long vaddr;
	unsigned long nr;
	unsigned long flags;
	int need_wakeup;
	unsigned int color = get_pkmap_color(page);
	wait_queue_head_t *pkmap_map_wait;

	lock_kmap_any(flags);
	vaddr = (unsigned long)page_address(page);
	BUG_ON(!vaddr);
	nr = PKMAP_NR(vaddr);

	/*
	 * A count must never go down to zero
	 * without a TLB flush!
	 */
	need_wakeup = 0;
	switch (--pkmap_count[nr]) {
	case 0:
		BUG();
	case 1:
		/*
		 * Avoid an unnecessary wake_up() function call.
		 * The common case is pkmap_count[] == 1, but
		 * no waiters.
		 * The tasks queued in the wait-queue are guarded
		 * by both the lock in the wait-queue-head and by
		 * the kmap_lock.  As the kmap_lock is held here,
		 * no need for the wait-queue-head's lock.  Simply
		 * test if the queue is empty.
		 */
		pkmap_map_wait = get_pkmap_wait_queue_head(color);
		need_wakeup = waitqueue_active(pkmap_map_wait);
	}
	unlock_kmap_any(flags);

	/* do wake-up, if needed, race-free outside of the spin lock */
	if (need_wakeup)
		wake_up(pkmap_map_wait);
}
static inline void kunmap(struct page *page)
{
}

because they already did it just above.


> > Which means after we fix vhost to add the flush_dcache_page after
> > kunmap, Parisc will get a double hit (but it also means Parisc was
> > the only one of those archs needed explicit cache flushes, where
> > vhost worked correctly so far.. so it kinds of proofs your point of
> > giving up being the safe choice).
> 
> What double hit?  If there's no cache to flush then cache flush is a
> no-op.  It's also a highly piplineable no-op because the CPU has the L1
> cache within easy reach.  The only event when flush takes a large
> amount time is if we actually have dirty data to write back to main
> memory.

The double hit is in parisc copy_to_user_page:

#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
do { \
	flush_cache_page(vma, vaddr, page_to_pfn(page)); \
	memcpy(dst, src, len); \
	flush_kernel_dcache_range_asm((unsigned long)dst, (unsigned long)dst + len); \
} while (0)

That is executed just before kunmap:

static inline void kunmap(struct page *page)
{
	flush_kernel_dcache_page_addr(page_address(page));
}

Can't argue about the fact your "safer" kunmap is safer, but we cannot
rely on common code unless we remove some optimization from the common
code abstractions and we make all archs do kunmap like parisc.

Thanks,
Andrea
