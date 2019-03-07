Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4073C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C68920854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfCGTR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:17:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfCGTR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:17:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3B5B30718CB;
        Thu,  7 Mar 2019 19:17:27 +0000 (UTC)
Received: from redhat.com (ovpn-125-54.rdu2.redhat.com [10.10.125.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA17B19C65;
        Thu,  7 Mar 2019 19:17:22 +0000 (UTC)
Date:   Thu, 7 Mar 2019 14:17:20 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190307191720.GF3835@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
 <20190307124700-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190307124700-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 07 Mar 2019 19:17:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 12:56:45PM -0500, Michael S. Tsirkin wrote:
> On Thu, Mar 07, 2019 at 10:47:22AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Mar 06, 2019 at 02:18:12AM -0500, Jason Wang wrote:
> > > +static const struct mmu_notifier_ops vhost_mmu_notifier_ops = {
> > > +	.invalidate_range = vhost_invalidate_range,
> > > +};
> > > +
> > >  void vhost_dev_init(struct vhost_dev *dev,
> > >  		    struct vhost_virtqueue **vqs, int nvqs, int iov_limit)
> > >  {
> > 
> > I also wonder here: when page is write protected then
> > it does not look like .invalidate_range is invoked.
> > 
> > E.g. mm/ksm.c calls
> > 
> > mmu_notifier_invalidate_range_start and
> > mmu_notifier_invalidate_range_end but not mmu_notifier_invalidate_range.
> > 
> > Similarly, rmap in page_mkclean_one will not call
> > mmu_notifier_invalidate_range.
> > 
> > If I'm right vhost won't get notified when page is write-protected since you
> > didn't install start/end notifiers. Note that end notifier can be called
> > with page locked, so it's not as straight-forward as just adding a call.
> > Writing into a write-protected page isn't a good idea.
> > 
> > Note that documentation says:
> > 	it is fine to delay the mmu_notifier_invalidate_range
> > 	call to mmu_notifier_invalidate_range_end() outside the page table lock.
> > implying it's called just later.
> 
> OK I missed the fact that _end actually calls
> mmu_notifier_invalidate_range internally. So that part is fine but the
> fact that you are trying to take page lock under VQ mutex and take same
> mutex within notifier probably means it's broken for ksm and rmap at
> least since these call invalidate with lock taken.
> 
> And generally, Andrea told me offline one can not take mutex under
> the notifier callback. I CC'd Andrea for why.

Correct, you _can not_ take mutex or any sleeping lock from within the
invalidate_range callback as those callback happens under the page table
spinlock. You can however do so under the invalidate_range_start call-
back only if it is a blocking allow callback (there is a flag passdown
with the invalidate_range_start callback if you are not allow to block
then return EBUSY and the invalidation will be aborted).


> 
> That's a separate issue from set_page_dirty when memory is file backed.

If you can access file back page then i suggest using set_page_dirty
from within a special version of vunmap() so that when you vunmap you
set the page dirty without taking page lock. It is safe to do so
always from within an mmu notifier callback if you had the page map
with write permission which means that the page had write permission
in the userspace pte too and thus it having dirty pte is expected
and calling set_page_dirty on the page is allowed without any lock.
Locking will happen once the userspace pte are tear down through the
page table lock.

> It's because of all these issues that I preferred just accessing
> userspace memory and handling faults. Unfortunately there does not
> appear to exist an API that whitelists a specific driver along the lines
> of "I checked this code for speculative info leaks, don't add barriers
> on data path please".

Maybe it would be better to explore adding such helper then remapping
page into kernel address space ?

Cheers,
Jérôme
