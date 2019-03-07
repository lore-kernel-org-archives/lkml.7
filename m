Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C94C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE08B20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCGV1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:27:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCGV1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:27:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD4F6307CDC7;
        Thu,  7 Mar 2019 21:27:22 +0000 (UTC)
Received: from sky.random (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFA3E60BE5;
        Thu,  7 Mar 2019 21:27:17 +0000 (UTC)
Date:   Thu, 7 Mar 2019 16:27:17 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190307212717.GS23850@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190306092837-mutt-send-email-mst@kernel.org>
 <15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
 <20190307101708-mutt-send-email-mst@kernel.org>
 <20190307190910.GE3835@redhat.com>
 <20190307193838.GQ23850@redhat.com>
 <20190307201722.GG3835@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307201722.GG3835@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 07 Mar 2019 21:27:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jerome,

On Thu, Mar 07, 2019 at 03:17:22PM -0500, Jerome Glisse wrote:
> So for the above the easiest thing is to call set_page_dirty() from
> the mmu notifier callback. It is always safe to use the non locking
> variant from such callback. Well it is safe only if the page was
> map with write permission prior to the callback so here i assume
> nothing stupid is going on and that you only vmap page with write
> if they have a CPU pte with write and if not then you force a write
> page fault.

So if the GUP doesn't set FOLL_WRITE, set_page_dirty simply shouldn't
be called in such case. It only ever makes sense if the pte is
writable.

On a side note, the reason the write bit on the pte enabled avoids the
need of the _lock suffix is because of the stable page writeback
guarantees?

> Basicly from mmu notifier callback you have the same right as zap
> pte has.

Good point.

Related to this I already was wondering why the set_page_dirty is not
done in the invalidate. Reading the patch it looks like the dirty is
marked dirty when the ring wraps around, not in the invalidate, Jeson
can tell if I misread something there.

For transient data passing through the ring, nobody should care if
it's lost. It's not user-journaled anyway so it could hit the disk in
any order. The only reason to flush it to do disk is if there's memory
pressure (to pageout like a swapout) and in such case it's enough to
mark it dirty only in the mmu notifier invalidate like you pointed out
(and only if GUP was called with FOLL_WRITE).

> O_DIRECT can suffer from the same issue but the race window for that
> is small enough that it is unlikely it ever happened. But for device

Ok that clarifies things.

> driver that GUP page for hours/days/weeks/months ... obviously the
> race window is big enough here. It affects many fs (ext4, xfs, ...)
> in different ways. I think ext4 is the most obvious because of the
> kernel log trace it leaves behind.
> 
> Bottom line is for set_page_dirty to be safe you need the following:
>     lock_page()
>     page_mkwrite()
>     set_pte_with_write()
>     unlock_page()

I also wondered why ext4 writepage doesn't recreate the bh if they got
dropped by the VM and page->private is 0. I mean, page->index and
page->mapping are still there, that's enough info for writepage itself
to take a slow path and calls page_mkwrite to find where to write the
page on disk.

> Now when loosing the write permission on the pte you will first get
> a mmu notifier callback so anyone that abide by mmu notifier is fine
> as long as they only write to the page if they found a pte with
> write as it means the above sequence did happen and page is write-
> able until the mmu notifier callback happens.
>
> When you lookup a page into the page cache you still need to call
> page_mkwrite() before installing a write-able pte.
> 
> Here for this vmap thing all you need is that the original user
> pte had the write flag. If you only allow write in the vmap when
> the original pte had write and you abide by mmu notifier then it
> is ok to call set_page_dirty from the mmu notifier (but not after).
> 
> Hence why my suggestion is a special vunmap that call set_page_dirty
> on the page from the mmu notifier.

Agreed, that will solve all issues in vhost context with regard to
set_page_dirty, including the case the memory is backed by VM_SHARED ext4.

Thanks!
Andrea
