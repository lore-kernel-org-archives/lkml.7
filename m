Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D99C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBD120657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbfG3PIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:08:41 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39621 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfG3PIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:08:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so63318999qtu.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HzqScm+MgZUE/z+FZh2jR3LjGduzejNoschvUbrV2xA=;
        b=ljwocNfeQ+MJ47zWI+4U86faZkz8O5kZ3aWd1SLReVU493XLTYf8PHJ4tB1+TQQ1p5
         +EmeVgzKMX9bk9c4irqMApYvbv8Uq7aWkqL+FpsyfcmGOOCd8fpyAhl5OQJA+9FlQcxd
         3ObuhQPi5/D3Ddfj6qFS97ZS3Q8cqOLB/4nDgBQDhVAXOf8Ee2M2Qy5DdRrNb0Kc/Q5H
         Gn2/v9BLT8gRuP/6xc1KQk1WyTsMt+NfOq0cPYC36xvDg+9B3OQat0UcnjHMQIG/y4Xb
         NL6FISxXB7tFpR54lhwJDzYmCdiHqUkYl74wT+ZNHFV+nG4q/mm0U1T7QaUpyyRccecZ
         kmKw==
X-Gm-Message-State: APjAAAU1QkK3BvJprADGzvC7RWBKPmkxRtmdOh9RKE+I59rYB9QGVAX3
        maN+O5C0IP0OJaJRSfrqqt9l0w==
X-Google-Smtp-Source: APXvYqyAEcQ2rI90c7ov4XOcxi/h1Ciz83jV4TqK4E5vsU115tJuJqCFIr/5rf4KY/QKmO1zU9cv0g==
X-Received: by 2002:ac8:2b14:: with SMTP id 20mr84731688qtu.295.1564499319358;
        Tue, 30 Jul 2019 08:08:39 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id z1sm29387735qke.122.2019.07.30.08.08.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 08:08:38 -0700 (PDT)
Date:   Tue, 30 Jul 2019 11:08:30 -0400
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
Message-ID: <20190730110633-mutt-send-email-mst@kernel.org>
References: <5cc94f15-b229-a290-55f3-8295266edb2b@redhat.com>
 <20190726082837-mutt-send-email-mst@kernel.org>
 <ada10dc9-6cab-e189-5289-6f9d3ff8fed2@redhat.com>
 <aaefa93e-a0de-1c55-feb0-509c87aae1f3@redhat.com>
 <20190726094756-mutt-send-email-mst@kernel.org>
 <0792ee09-b4b7-673c-2251-e5e0ce0fbe32@redhat.com>
 <20190729045127-mutt-send-email-mst@kernel.org>
 <4d43c094-44ed-dbac-b863-48fc3d754378@redhat.com>
 <20190729104028-mutt-send-email-mst@kernel.org>
 <96b1d67c-3a8d-1224-e9f0-5f7725a3dc10@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96b1d67c-3a8d-1224-e9f0-5f7725a3dc10@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 03:44:47PM +0800, Jason Wang wrote:
> 
> On 2019/7/29 下午10:44, Michael S. Tsirkin wrote:
> > On Mon, Jul 29, 2019 at 10:24:43PM +0800, Jason Wang wrote:
> > > On 2019/7/29 下午4:59, Michael S. Tsirkin wrote:
> > > > On Mon, Jul 29, 2019 at 01:54:49PM +0800, Jason Wang wrote:
> > > > > On 2019/7/26 下午9:49, Michael S. Tsirkin wrote:
> > > > > > > > Ok, let me retry if necessary (but I do remember I end up with deadlocks
> > > > > > > > last try).
> > > > > > > Ok, I play a little with this. And it works so far. Will do more testing
> > > > > > > tomorrow.
> > > > > > > 
> > > > > > > One reason could be I switch to use get_user_pages_fast() to
> > > > > > > __get_user_pages_fast() which doesn't need mmap_sem.
> > > > > > > 
> > > > > > > Thanks
> > > > > > OK that sounds good. If we also set a flag to make
> > > > > > vhost_exceeds_weight exit, then I think it will be all good.
> > > > > After some experiments, I came up two methods:
> > > > > 
> > > > > 1) switch to use vq->mutex, then we must take the vq lock during range
> > > > > checking (but I don't see obvious slowdown for 16vcpus + 16queues). Setting
> > > > > flags during weight check should work but it still can't address the worst
> > > > > case: wait for the page to be swapped in. Is this acceptable?
> > > > > 
> > > > > 2) using current RCU but replace synchronize_rcu() with vhost_work_flush().
> > > > > The worst case is the same as 1) but we can check range without holding any
> > > > > locks.
> > > > > 
> > > > > Which one did you prefer?
> > > > > 
> > > > > Thanks
> > > > I would rather we start with 1 and switch to 2 after we
> > > > can show some gain.
> > > > 
> > > > But the worst case needs to be addressed.
> > > 
> > > Yes.
> > > 
> > > 
> > > > How about sending a signal to
> > > > the vhost thread?  We will need to fix up error handling (I think that
> > > > at the moment it will error out in that case, handling this as EFAULT -
> > > > and we don't want to drop packets if we can help it, and surely not
> > > > enter any error states.  In particular it might be especially tricky if
> > > > we wrote into userspace memory and are now trying to log the write.
> > > > I guess we can disable the optimization if log is enabled?).
> > > 
> > > This may work but requires a lot of changes.
> > I agree.
> > 
> > > And actually it's the price of
> > > using vq mutex.
> > Not sure what's meant here.
> 
> 
> I mean if we use vq mutex, it means the critical section was increased and
> we need to deal with swapping then.
> 
> 
> > 
> > > Actually, the critical section should be rather small, e.g
> > > just inside memory accessors.
> > Also true.
> > 
> > > I wonder whether or not just do synchronize our self like:
> > > 
> > > static void inline vhost_inc_vq_ref(struct vhost_virtqueue *vq)
> > > {
> > >          int ref = READ_ONCE(vq->ref);
> > > 
> > >          WRITE_ONCE(vq->ref, ref + 1);
> > > smp_rmb();
> > > }
> > > 
> > > static void inline vhost_dec_vq_ref(struct vhost_virtqueue *vq)
> > > {
> > >          int ref = READ_ONCE(vq->ref);
> > > 
> > > smp_wmb();
> > >          WRITE_ONCE(vq->ref, ref - 1);
> > > }
> > > 
> > > static void inline vhost_wait_for_ref(struct vhost_virtqueue *vq)
> > > {
> > >          while (READ_ONCE(vq->ref));
> > > mb();
> > > }
> > Looks good but I'd like to think of a strategy/existing lock that let us
> > block properly as opposed to spinning, that would be more friendly to
> > e.g. the realtime patch.
> 
> 
> Does it make sense to disable preemption in the critical section? Then we
> don't need to block and we have a deterministic time spent on memory
> accssors?

Hmm maybe. I'm getting really nervious at this point - we
seem to be using every trick in the book.

> 
> > 
> > > Or using smp_load_acquire()/smp_store_release() instead?
> > > 
> > > Thanks
> > These are cheaper on x86, yes.
> 
> 
> Will use this.
> 
> Thanks
> 
> 

This looks suspiciously like a seqlock though.
Can that be used somehow?

