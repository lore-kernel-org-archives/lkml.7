Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A36C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5787C2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfGXS0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:26:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41523 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfGXS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:26:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so46387440qtj.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=47jnRb/JRiGyeu7VRGBMaSdfmagEfI1RSsTJGA+iCS4=;
        b=Ecy7ZHLIXATtpfcQAaV5jJZlJS66VPgiK4TYzdJyTM5U7z/JtzAyOeUABTTXGL/owK
         RcObXd22hOZYcCmPVJJBGXv8bfnzari73V+cRqCBLbPja2BzReM12hwlwV5FOgpNhCjm
         5uasSNyuLU0MyeoFsZfUE7GQihXLhb6OTcut7VU8huNdpPmdKFhw/ItyXGQ7uXURrrzl
         f5xRl70Tn7naEOXWqCrpZq1vfDUs61hwlofKQ8utBOUF8jk73RdBqxu8hTWf/fbp3sQ0
         v5OSi14ZKDYN7YE1vKfOT13DwRk8mcP3uNPQgo5v5yB6tyWSAwtOgMly9fwHOk50g31A
         bIEQ==
X-Gm-Message-State: APjAAAU8D231f4Zt78Et+DTk6CbRKvxSK0yJkNK/8MAWK+4PX/sPniAy
        jHynOMImIWx7ttPur5ymdbGDOA==
X-Google-Smtp-Source: APXvYqwzliSrA8epYeAr+o2o6Ky/lp4cNdeDzQCES2sBPCPVe5rhDvrrKAuGBvuFcp/RzeYu5u8tYg==
X-Received: by 2002:ac8:303c:: with SMTP id f57mr59008112qte.294.1563992764155;
        Wed, 24 Jul 2019 11:26:04 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id d26sm20464872qkl.97.2019.07.24.11.25.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 11:26:03 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:25:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jglisse@redhat.com,
        keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: WARNING in __mmdrop
Message-ID: <20190724142533-mutt-send-email-mst@kernel.org>
References: <20190723010156-mutt-send-email-mst@kernel.org>
 <124be1a2-1c53-8e65-0f06-ee2294710822@redhat.com>
 <20190723032800-mutt-send-email-mst@kernel.org>
 <e2e01a05-63d8-4388-2bcd-b2be3c865486@redhat.com>
 <20190723062221-mutt-send-email-mst@kernel.org>
 <9baa4214-67fd-7ad2-cbad-aadf90bbfc20@redhat.com>
 <20190723110219-mutt-send-email-mst@kernel.org>
 <e0c91b89-d1e8-9831-00fe-23fe92d79fa2@redhat.com>
 <20190724040238-mutt-send-email-mst@kernel.org>
 <3dfa2269-60ba-7dd8-99af-5aef8552bd98@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dfa2269-60ba-7dd8-99af-5aef8552bd98@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 06:08:05PM +0800, Jason Wang wrote:
> 
> On 2019/7/24 下午4:05, Michael S. Tsirkin wrote:
> > On Wed, Jul 24, 2019 at 10:17:14AM +0800, Jason Wang wrote:
> > > On 2019/7/23 下午11:02, Michael S. Tsirkin wrote:
> > > > On Tue, Jul 23, 2019 at 09:34:29PM +0800, Jason Wang wrote:
> > > > > On 2019/7/23 下午6:27, Michael S. Tsirkin wrote:
> > > > > > > Yes, since there could be multiple co-current invalidation requests. We need
> > > > > > > count them to make sure we don't pin wrong pages.
> > > > > > > 
> > > > > > > 
> > > > > > > > I also wonder about ordering. kvm has this:
> > > > > > > >            /*
> > > > > > > >              * Used to check for invalidations in progress, of the pfn that is
> > > > > > > >              * returned by pfn_to_pfn_prot below.
> > > > > > > >              */
> > > > > > > >             mmu_seq = kvm->mmu_notifier_seq;
> > > > > > > >             /*
> > > > > > > >              * Ensure the read of mmu_notifier_seq isn't reordered with PTE reads in
> > > > > > > >              * gfn_to_pfn_prot() (which calls get_user_pages()), so that we don't
> > > > > > > >              * risk the page we get a reference to getting unmapped before we have a
> > > > > > > >              * chance to grab the mmu_lock without mmu_notifier_retry() noticing.
> > > > > > > >              *
> > > > > > > >              * This smp_rmb() pairs with the effective smp_wmb() of the combination
> > > > > > > >              * of the pte_unmap_unlock() after the PTE is zapped, and the
> > > > > > > >              * spin_lock() in kvm_mmu_notifier_invalidate_<page|range_end>() before
> > > > > > > >              * mmu_notifier_seq is incremented.
> > > > > > > >              */
> > > > > > > >             smp_rmb();
> > > > > > > > 
> > > > > > > > does this apply to us? Can't we use a seqlock instead so we do
> > > > > > > > not need to worry?
> > > > > > > I'm not familiar with kvm MMU internals, but we do everything under of
> > > > > > > mmu_lock.
> > > > > > > 
> > > > > > > Thanks
> > > > > > I don't think this helps at all.
> > > > > > 
> > > > > > There's no lock between checking the invalidate counter and
> > > > > > get user pages fast within vhost_map_prefetch. So it's possible
> > > > > > that get user pages fast reads PTEs speculatively before
> > > > > > invalidate is read.
> > > > > > 
> > > > > > -- 
> > > > > In vhost_map_prefetch() we do:
> > > > > 
> > > > >           spin_lock(&vq->mmu_lock);
> > > > > 
> > > > >           ...
> > > > > 
> > > > >           err = -EFAULT;
> > > > >           if (vq->invalidate_count)
> > > > >                   goto err;
> > > > > 
> > > > >           ...
> > > > > 
> > > > >           npinned = __get_user_pages_fast(uaddr->uaddr, npages,
> > > > >                                           uaddr->write, pages);
> > > > > 
> > > > >           ...
> > > > > 
> > > > >           spin_unlock(&vq->mmu_lock);
> > > > > 
> > > > > Is this not sufficient?
> > > > > 
> > > > > Thanks
> > > > So what orders __get_user_pages_fast wrt invalidate_count read?
> > > 
> > > So in invalidate_end() callback we have:
> > > 
> > > spin_lock(&vq->mmu_lock);
> > > --vq->invalidate_count;
> > >          spin_unlock(&vq->mmu_lock);
> > > 
> > > 
> > > So even PTE is read speculatively before reading invalidate_count (only in
> > > the case of invalidate_count is zero). The spinlock has guaranteed that we
> > > won't read any stale PTEs.
> > > 
> > > Thanks
> > I'm sorry I just do not get the argument.
> > If you want to order two reads you need an smp_rmb
> > or stronger between them executed on the same CPU.
> > 
> > Executing any kind of barrier on another CPU
> > will have no ordering effect on the 1st one.
> > 
> > 
> > So if CPU1 runs the prefetch, and CPU2 runs invalidate
> > callback, read of invalidate counter on CPU1 can bypass
> > read of PTE on CPU1 unless there's a barrier
> > in between, and nothing CPU2 does can affect that outcome.
> > 
> > 
> > What did I miss?
> 
> 
> It doesn't harm if PTE is read before invalidate_count, this is because:
> 
> 1) This speculation is serialized with invalidate_range_end() because of the
> spinlock
> 
> 2) This speculation can only make effect when we read invalidate_count as
> zero.
> 
> 3) This means the speculation is done after the last invalidate_range_end()
> and because of the spinlock, when we enter the critical section of spinlock
> in prefetch, we can not see any stale PTE that was unmapped before.
> 
> Am I wrong?
> 
> Thanks

OK I think you are right. Sorry it took me a while to figure out.

-- 
MST
