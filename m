Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AC7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D8D206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfCHTsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:48:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbfCHTst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:48:49 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 473C930B4ACE;
        Fri,  8 Mar 2019 19:48:49 +0000 (UTC)
Received: from sky.random (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DCE01001DDE;
        Fri,  8 Mar 2019 19:48:46 +0000 (UTC)
Date:   Fri, 8 Mar 2019 14:48:45 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190308194845.GC26923@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
 <20190307124700-mutt-send-email-mst@kernel.org>
 <20190307191622.GP23850@redhat.com>
 <e2fad6ed-9257-b53c-394b-bc913fc444c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2fad6ed-9257-b53c-394b-bc913fc444c0@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 08 Mar 2019 19:48:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeson,

On Fri, Mar 08, 2019 at 04:50:36PM +0800, Jason Wang wrote:
> Just to make sure I understand here. For boosting through huge TLB, do 
> you mean we can do that in the future (e.g by mapping more userspace 
> pages to kenrel) or it can be done by this series (only about three 4K 
> pages were vmapped per virtqueue)?

When I answered about the advantages of mmu notifier and I mentioned
guaranteed 2m/gigapages where available, I overlooked the detail you
were using vmap instead of kmap. So with vmap you're actually doing
the opposite, it slows down the access because it will always use a 4k
TLB even if QEMU runs on THP or gigapages hugetlbfs.

If there's just one page (or a few pages) in each vmap there's no need
of vmap, the linearity vmap provides doesn't pay off in such
case.

So likely there's further room for improvement here that you can
achieve in the current series by just dropping vmap/vunmap.

You can just use kmap (or kmap_atomic if you're in preemptible
section, should work from bh/irq).

In short the mmu notifier to invalidate only sets a "struct page *
userringpage" pointer to NULL without calls to vunmap.

In all cases immediately after gup_fast returns you can always call
put_page immediately (which explains why I'd like an option to drop
FOLL_GET from gup_fast to speed it up).

Then you can check the sequence_counter and inc/dec counter increased
by _start/_end. That will tell you if the page you got and you called
put_page to immediately unpin it or even to free it, cannot go away
under you until the invalidate is called.

If sequence counters and counter tells that gup_fast raced with anyt
mmu notifier invalidate you can just repeat gup_fast. Otherwise you're
done, the page cannot go away under you, the host virtual to host
physical mapping cannot change either. And the page is not pinned
either. So you can just set the "struct page * userringpage = page"
where "page" was the one setup by gup_fast.

When later the invalidate runs, you can just call set_page_dirty if
gup_fast was called with "write = 1" and then you clear the pointer
"userringpage = NULL".

When you need to read/write to the memory
kmap/kmap_atomic(userringpage) should work.

In short because there's no hardware involvement here, the established
mapping is just the pointer to the page, there is no need of setting
up any pagetables or to do any TLB flushes (except on 32bit archs if
the page is above the direct mapping but it never happens on 64bit
archs).

Thanks,
Andrea
