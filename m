Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CEBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC3D2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfCHPCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:02:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfCHPCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:02:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C13C821EF;
        Fri,  8 Mar 2019 15:02:45 +0000 (UTC)
Received: from redhat.com (ovpn-124-248.rdu2.redhat.com [10.10.124.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D87C26331;
        Fri,  8 Mar 2019 15:02:39 +0000 (UTC)
Date:   Fri, 8 Mar 2019 10:02:37 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190308150236.GB3661@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
 <20190307124700-mutt-send-email-mst@kernel.org>
 <20190307191720.GF3835@redhat.com>
 <43408100-84d9-a359-3e78-dc65fb7b0ad1@redhat.com>
 <20190308075506-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190308075506-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 08 Mar 2019 15:02:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 07:56:04AM -0500, Michael S. Tsirkin wrote:
> On Fri, Mar 08, 2019 at 04:58:44PM +0800, Jason Wang wrote:
> > 
> > On 2019/3/8 上午3:17, Jerome Glisse wrote:
> > > On Thu, Mar 07, 2019 at 12:56:45PM -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Mar 07, 2019 at 10:47:22AM -0500, Michael S. Tsirkin wrote:
> > > > > On Wed, Mar 06, 2019 at 02:18:12AM -0500, Jason Wang wrote:
> > > > > > +static const struct mmu_notifier_ops vhost_mmu_notifier_ops = {
> > > > > > +	.invalidate_range = vhost_invalidate_range,
> > > > > > +};
> > > > > > +
> > > > > >   void vhost_dev_init(struct vhost_dev *dev,
> > > > > >   		    struct vhost_virtqueue **vqs, int nvqs, int iov_limit)
> > > > > >   {
> > > > > I also wonder here: when page is write protected then
> > > > > it does not look like .invalidate_range is invoked.
> > > > > 
> > > > > E.g. mm/ksm.c calls
> > > > > 
> > > > > mmu_notifier_invalidate_range_start and
> > > > > mmu_notifier_invalidate_range_end but not mmu_notifier_invalidate_range.
> > > > > 
> > > > > Similarly, rmap in page_mkclean_one will not call
> > > > > mmu_notifier_invalidate_range.
> > > > > 
> > > > > If I'm right vhost won't get notified when page is write-protected since you
> > > > > didn't install start/end notifiers. Note that end notifier can be called
> > > > > with page locked, so it's not as straight-forward as just adding a call.
> > > > > Writing into a write-protected page isn't a good idea.
> > > > > 
> > > > > Note that documentation says:
> > > > > 	it is fine to delay the mmu_notifier_invalidate_range
> > > > > 	call to mmu_notifier_invalidate_range_end() outside the page table lock.
> > > > > implying it's called just later.
> > > > OK I missed the fact that _end actually calls
> > > > mmu_notifier_invalidate_range internally. So that part is fine but the
> > > > fact that you are trying to take page lock under VQ mutex and take same
> > > > mutex within notifier probably means it's broken for ksm and rmap at
> > > > least since these call invalidate with lock taken.
> > > > 
> > > > And generally, Andrea told me offline one can not take mutex under
> > > > the notifier callback. I CC'd Andrea for why.
> > > Correct, you _can not_ take mutex or any sleeping lock from within the
> > > invalidate_range callback as those callback happens under the page table
> > > spinlock. You can however do so under the invalidate_range_start call-
> > > back only if it is a blocking allow callback (there is a flag passdown
> > > with the invalidate_range_start callback if you are not allow to block
> > > then return EBUSY and the invalidation will be aborted).
> > > 
> > > 
> > > > That's a separate issue from set_page_dirty when memory is file backed.
> > > If you can access file back page then i suggest using set_page_dirty
> > > from within a special version of vunmap() so that when you vunmap you
> > > set the page dirty without taking page lock. It is safe to do so
> > > always from within an mmu notifier callback if you had the page map
> > > with write permission which means that the page had write permission
> > > in the userspace pte too and thus it having dirty pte is expected
> > > and calling set_page_dirty on the page is allowed without any lock.
> > > Locking will happen once the userspace pte are tear down through the
> > > page table lock.
> > 
> > 
> > Can I simply can set_page_dirty() before vunmap() in the mmu notifier
> > callback, or is there any reason that it must be called within vumap()?
> > 
> > Thanks
> 
> 
> I think this is what Jerome is saying, yes.
> Maybe add a patch to mmu notifier doc file, documenting this?
> 

Better to do in vunmap as you can look at kernel vmap pte to see if
the dirty bit is set and only call set_page_dirty in that case. But
yes you can do it outside vunmap in which case you have to call dirty
for all pages unless you have some other way to know if a page was
written to or not.

Note that if you also need to do that when you tear down the vunmap
through the regular path but with an exclusion from mmu notifier.
So if mmu notifier is running then you can skip the set_page_dirty
if none are running and you hold the lock then you can safely call
set_page_dirty.

Cheers,
Jérôme
