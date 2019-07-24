Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E544C76194
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC26229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfGXIF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:05:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37772 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfGXIF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:05:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so44598141qto.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=474FJ4CjTLJhnSN+huYP4Jd3bf8v5qgo4+UVMvlOmIY=;
        b=ZN3p8cjMgi4XrmiR7hB2gR3EYNiekZtSJqksIbrih0ldFBlV8hMJCNy+73ZYFWGLaz
         7cwYsda03q1ZISW82+Qw9sK6bJ2+IJbbHtlSZKNOK7JOOf6yuFcbaKJBhyT4atiWXWmu
         zATcVlZ8GfDfKhXwd/a0MCHDs72unuqvndy7EM38dWPutIdoRC83hz3eZYXeqPIbHLqh
         KVpm42JXIgpfmXX4dJ7feiUa8SzwcaVQpDEkYC4HcEgvhrlxKtkPqMzGcv6+UXo7iQk3
         56vy2bRF7sd9bBXpaKCwW35SjyojCdDXgQlWwDaomUb2z7WXe8y4f0xiXQH1ZdolehWW
         /tSQ==
X-Gm-Message-State: APjAAAW0fT1lc1KlwoShepgjIUwNQy8VNKQuOmsQ6Rg/C90jQw185SzC
        +mUx4dalMX+QxAaC8KLKRhAwRQ==
X-Google-Smtp-Source: APXvYqw6ZQ1xEgGDaGfr+FokaUeYzIX8sH8l8tvdJOvhZHCA1+JFXeX8ZY5yCCc6YIRs25mpDti6IA==
X-Received: by 2002:ac8:1106:: with SMTP id c6mr4002540qtj.332.1563955526892;
        Wed, 24 Jul 2019 01:05:26 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id u11sm19337738qkk.76.2019.07.24.01.05.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 01:05:25 -0700 (PDT)
Date:   Wed, 24 Jul 2019 04:05:17 -0400
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
Message-ID: <20190724040238-mutt-send-email-mst@kernel.org>
References: <20190722035657-mutt-send-email-mst@kernel.org>
 <cfcd330d-5f4a-835a-69f7-c342d5d0d52d@redhat.com>
 <20190723010156-mutt-send-email-mst@kernel.org>
 <124be1a2-1c53-8e65-0f06-ee2294710822@redhat.com>
 <20190723032800-mutt-send-email-mst@kernel.org>
 <e2e01a05-63d8-4388-2bcd-b2be3c865486@redhat.com>
 <20190723062221-mutt-send-email-mst@kernel.org>
 <9baa4214-67fd-7ad2-cbad-aadf90bbfc20@redhat.com>
 <20190723110219-mutt-send-email-mst@kernel.org>
 <e0c91b89-d1e8-9831-00fe-23fe92d79fa2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0c91b89-d1e8-9831-00fe-23fe92d79fa2@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:17:14AM +0800, Jason Wang wrote:
> 
> On 2019/7/23 下午11:02, Michael S. Tsirkin wrote:
> > On Tue, Jul 23, 2019 at 09:34:29PM +0800, Jason Wang wrote:
> > > On 2019/7/23 下午6:27, Michael S. Tsirkin wrote:
> > > > > Yes, since there could be multiple co-current invalidation requests. We need
> > > > > count them to make sure we don't pin wrong pages.
> > > > > 
> > > > > 
> > > > > > I also wonder about ordering. kvm has this:
> > > > > >           /*
> > > > > >             * Used to check for invalidations in progress, of the pfn that is
> > > > > >             * returned by pfn_to_pfn_prot below.
> > > > > >             */
> > > > > >            mmu_seq = kvm->mmu_notifier_seq;
> > > > > >            /*
> > > > > >             * Ensure the read of mmu_notifier_seq isn't reordered with PTE reads in
> > > > > >             * gfn_to_pfn_prot() (which calls get_user_pages()), so that we don't
> > > > > >             * risk the page we get a reference to getting unmapped before we have a
> > > > > >             * chance to grab the mmu_lock without mmu_notifier_retry() noticing.
> > > > > >             *
> > > > > >             * This smp_rmb() pairs with the effective smp_wmb() of the combination
> > > > > >             * of the pte_unmap_unlock() after the PTE is zapped, and the
> > > > > >             * spin_lock() in kvm_mmu_notifier_invalidate_<page|range_end>() before
> > > > > >             * mmu_notifier_seq is incremented.
> > > > > >             */
> > > > > >            smp_rmb();
> > > > > > 
> > > > > > does this apply to us? Can't we use a seqlock instead so we do
> > > > > > not need to worry?
> > > > > I'm not familiar with kvm MMU internals, but we do everything under of
> > > > > mmu_lock.
> > > > > 
> > > > > Thanks
> > > > I don't think this helps at all.
> > > > 
> > > > There's no lock between checking the invalidate counter and
> > > > get user pages fast within vhost_map_prefetch. So it's possible
> > > > that get user pages fast reads PTEs speculatively before
> > > > invalidate is read.
> > > > 
> > > > -- 
> > > 
> > > In vhost_map_prefetch() we do:
> > > 
> > >          spin_lock(&vq->mmu_lock);
> > > 
> > >          ...
> > > 
> > >          err = -EFAULT;
> > >          if (vq->invalidate_count)
> > >                  goto err;
> > > 
> > >          ...
> > > 
> > >          npinned = __get_user_pages_fast(uaddr->uaddr, npages,
> > >                                          uaddr->write, pages);
> > > 
> > >          ...
> > > 
> > >          spin_unlock(&vq->mmu_lock);
> > > 
> > > Is this not sufficient?
> > > 
> > > Thanks
> > So what orders __get_user_pages_fast wrt invalidate_count read?
> 
> 
> So in invalidate_end() callback we have:
> 
> spin_lock(&vq->mmu_lock);
> --vq->invalidate_count;
>         spin_unlock(&vq->mmu_lock);
> 
> 
> So even PTE is read speculatively before reading invalidate_count (only in
> the case of invalidate_count is zero). The spinlock has guaranteed that we
> won't read any stale PTEs.
> 
> Thanks

I'm sorry I just do not get the argument.
If you want to order two reads you need an smp_rmb
or stronger between them executed on the same CPU.

Executing any kind of barrier on another CPU
will have no ordering effect on the 1st one.


So if CPU1 runs the prefetch, and CPU2 runs invalidate
callback, read of invalidate counter on CPU1 can bypass
read of PTE on CPU1 unless there's a barrier
in between, and nothing CPU2 does can affect that outcome.


What did I miss?

> 
> > 
