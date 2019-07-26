Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8554BC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C16022CEB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbfGZNr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:47:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45547 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388347AbfGZNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:47:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id x22so47690434qtp.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 06:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aREd7oX/KjjR1y+/DoK7i/ri4F4zE0JK5o/p5Emjkas=;
        b=GeL5D5WRE4VeG63qp/WUJ5gnKVK/ymeYBtSvh8vkNbfcNSs1nMVjWUWxlNzmrtNlVa
         2XFRsqjplSo6/w/O5Yv4vMUWqva9BN6i/G5BxEq0VFLTbWLSYJT6UCV6esPPIjhOs/nW
         bRI3wOxhOaNSPpa2AlDszb67kTYfr2S28wx2iuYoNifvie/nIKde45twts4wDH2EY64E
         uic/rBEHf6vHfuEiLZdQyr4A9NPyU/t602MDVdv/AF4ensslpDlE9wNFB5KCAqSYg9FW
         KjtQVpt7ejtTV/cn/9iPYp/AF0w73+jLu0jPKch8QLgd7AR+3QNEp3QXx3hsW7wBLHKd
         j6Lw==
X-Gm-Message-State: APjAAAVNGpwLo+ZzX+Xy1cM3hUtmt0xOYrjlloNM4IlbvrQhAyKBh4kz
        z4W6MGRRnTb8KC1Blt1aDAtZMg==
X-Google-Smtp-Source: APXvYqzVdYsizVTGT9hdpWznFaUhHBwNJSFBNQoI8apQUSuT6ROsP77q6nipE0mfzkXGrjdjl9uw3A==
X-Received: by 2002:a0c:ba0b:: with SMTP id w11mr68077058qvf.71.1564148842235;
        Fri, 26 Jul 2019 06:47:22 -0700 (PDT)
Received: from redhat.com ([212.92.104.165])
        by smtp.gmail.com with ESMTPSA id g2sm21326394qkm.31.2019.07.26.06.47.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 06:47:21 -0700 (PDT)
Date:   Fri, 26 Jul 2019 09:47:12 -0400
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
Message-ID: <20190726094353-mutt-send-email-mst@kernel.org>
References: <20190725012149-mutt-send-email-mst@kernel.org>
 <55e8930c-2695-365f-a07b-3ad169654d28@redhat.com>
 <20190725042651-mutt-send-email-mst@kernel.org>
 <84bb2e31-0606-adff-cf2a-e1878225a847@redhat.com>
 <20190725092332-mutt-send-email-mst@kernel.org>
 <11802a8a-ce41-f427-63d5-b6a4cf96bb3f@redhat.com>
 <20190726074644-mutt-send-email-mst@kernel.org>
 <5cc94f15-b229-a290-55f3-8295266edb2b@redhat.com>
 <20190726082837-mutt-send-email-mst@kernel.org>
 <ada10dc9-6cab-e189-5289-6f9d3ff8fed2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ada10dc9-6cab-e189-5289-6f9d3ff8fed2@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 08:53:18PM +0800, Jason Wang wrote:
> 
> On 2019/7/26 下午8:38, Michael S. Tsirkin wrote:
> > On Fri, Jul 26, 2019 at 08:00:58PM +0800, Jason Wang wrote:
> > > On 2019/7/26 下午7:49, Michael S. Tsirkin wrote:
> > > > On Thu, Jul 25, 2019 at 10:25:25PM +0800, Jason Wang wrote:
> > > > > On 2019/7/25 下午9:26, Michael S. Tsirkin wrote:
> > > > > > > Exactly, and that's the reason actually I use synchronize_rcu() there.
> > > > > > > 
> > > > > > > So the concern is still the possible synchronize_expedited()?
> > > > > > I think synchronize_srcu_expedited.
> > > > > > 
> > > > > > synchronize_expedited sends lots of IPI and is bad for realtime VMs.
> > > > > > 
> > > > > > > Can I do this
> > > > > > > on through another series on top of the incoming V2?
> > > > > > > 
> > > > > > > Thanks
> > > > > > > 
> > > > > > The question is this: is this still a gain if we switch to the
> > > > > > more expensive srcu? If yes then we can keep the feature on,
> > > > > I think we only care about the cost on srcu_read_lock() which looks pretty
> > > > > tiny form my point of view. Which is basically a READ_ONCE() + WRITE_ONCE().
> > > > > 
> > > > > Of course I can benchmark to see the difference.
> > > > > 
> > > > > 
> > > > > > if not we'll put it off until next release and think
> > > > > > of better solutions. rcu->srcu is just a find and replace,
> > > > > > don't see why we need to defer that. can be a separate patch
> > > > > > for sure, but we need to know how well it works.
> > > > > I think I get here, let me try to do that in V2 and let's see the numbers.
> > > > > 
> > > > > Thanks
> > > 
> > > It looks to me for tree rcu, its srcu_read_lock() have a mb() which is too
> > > expensive for us.
> > I will try to ponder using vq lock in some way.
> > Maybe with trylock somehow ...
> 
> 
> Ok, let me retry if necessary (but I do remember I end up with deadlocks
> last try).
> 
> 
> > 
> > 
> > > If we just worry about the IPI,
> > With synchronize_rcu what I would worry about is that guest is stalled
> 
> 
> Can this synchronize_rcu() be triggered by guest? If yes, there are several
> other MMU notifiers that can block. Is vhost something special here?

Sorry, let me explain: guests (and tasks in general)
can trigger activity that will
make synchronize_rcu take a long time. Thus blocking
an mmu notifier until synchronize_rcu finishes
is a bad idea.

> 
> > because system is busy because of other guests.
> > With expedited it's the IPIs...
> > 
> 
> The current synchronize_rcu()  can force a expedited grace period:
> 
> void synchronize_rcu(void)
> {
>         ...
>         if (rcu_blocking_is_gp())
> return;
>         if (rcu_gp_is_expedited())
> synchronize_rcu_expedited();
> else
> wait_rcu_gp(call_rcu);
> }
> EXPORT_SYMBOL_GPL(synchronize_rcu);


An admin can force rcu to finish faster, trading
interrupts for responsiveness.

> 
> > > can we do something like in
> > > vhost_invalidate_vq_start()?
> > > 
> > >          if (map) {
> > >                  /* In order to avoid possible IPIs with
> > >                   * synchronize_rcu_expedited() we use call_rcu() +
> > >                   * completion.
> > > */
> > > init_completion(&c.completion);
> > >                  call_rcu(&c.rcu_head, vhost_finish_vq_invalidation);
> > > wait_for_completion(&c.completion);
> > >                  vhost_set_map_dirty(vq, map, index);
> > > vhost_map_unprefetch(map);
> > >          }
> > > 
> > > ?
> > Why would that be faster than synchronize_rcu?
> 
> 
> No faster but no IPI.
> 

Sorry I still don't see the point.
synchronize_rcu doesn't normally do an IPI either.


> > 
> > 
> > > > There's one other thing that bothers me, and that is that
> > > > for large rings which are not physically contiguous
> > > > we don't implement the optimization.
> > > > 
> > > > For sure, that can wait, but I think eventually we should
> > > > vmap large rings.
> > > 
> > > Yes, worth to try. But using direct map has its own advantage: it can use
> > > hugepage that vmap can't
> > > 
> > > Thanks
> > Sure, so we can do that for small rings.
> 
> 
> Yes, that's possible but should be done on top.
> 
> Thanks

Absolutely. Need to fix up the bugs first.

-- 
MST
