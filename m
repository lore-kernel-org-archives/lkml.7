Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A21C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F30D2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbfGXSZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:25:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46677 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387480AbfGXSZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:25:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so46410262qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/8SpAXACt/H0ZjS+gW4ox0Hhxo1Ofk7o0k1709Jn7z0=;
        b=PHwUigojGTITdp4CfOJsh3lXSNr6mbNszISJeROMNqCsVjRob6TzwSghkYBtSvE/7g
         1aJ+LNW7pjgEAF8ZazGeB6Hu8vALnN0TFSoqzOtA+97TFO6vxIjVvq3pBWvzw4pDbe5Q
         5Bk7BJ++FwnuelW0YKLFijm4HEDoLjiG3Ux6BbSP/S7wM+vdjeFj7aFYFbkknbEGvmM9
         2yTxhtbTjAhqHfiSjgXhQZAqrqudDC1aH08op3x+SfCjKjy7uoXA8X0DdMktt8NowpF9
         Aw2hIH50ZpC5My8DmUYKj5LPxDJayV8Wq5IgxWJODfXCkitQ6E3vYXuIz23PeOQqAS+0
         4ElA==
X-Gm-Message-State: APjAAAUjOmA5dWLf3ksZf6S5ZkUVLBHYb4o3HkCaIYq6uE7tWXsR/kwm
        DLguhRK6nLNbXvIl/bPlsh8CHA==
X-Google-Smtp-Source: APXvYqxChd/0aII9lYKOFDT2kMgtEOZZfG9pHDvB+TKQrkk+gyvE7N4AF8TKeYtvP4hnErvwYvbJPQ==
X-Received: by 2002:ac8:74cb:: with SMTP id j11mr54557383qtr.67.1563992725087;
        Wed, 24 Jul 2019 11:25:25 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id z19sm22080696qkg.28.2019.07.24.11.25.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 11:25:24 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:25:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jason Wang <jasowang@redhat.com>,
        syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>,
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
Message-ID: <20190724142417-mutt-send-email-mst@kernel.org>
References: <20190723010156-mutt-send-email-mst@kernel.org>
 <124be1a2-1c53-8e65-0f06-ee2294710822@redhat.com>
 <20190723032800-mutt-send-email-mst@kernel.org>
 <e2e01a05-63d8-4388-2bcd-b2be3c865486@redhat.com>
 <20190723062221-mutt-send-email-mst@kernel.org>
 <9baa4214-67fd-7ad2-cbad-aadf90bbfc20@redhat.com>
 <20190723110219-mutt-send-email-mst@kernel.org>
 <e0c91b89-d1e8-9831-00fe-23fe92d79fa2@redhat.com>
 <20190724040238-mutt-send-email-mst@kernel.org>
 <20190724165317.GD28493@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724165317.GD28493@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 01:53:17PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 24, 2019 at 04:05:17AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 24, 2019 at 10:17:14AM +0800, Jason Wang wrote:
> > > So even PTE is read speculatively before reading invalidate_count (only in
> > > the case of invalidate_count is zero). The spinlock has guaranteed that we
> > > won't read any stale PTEs.
> > 
> > I'm sorry I just do not get the argument.
> > If you want to order two reads you need an smp_rmb
> > or stronger between them executed on the same CPU.
> 
> No, that is only for unlocked algorithms.
> 
> In this case the spinlock provides all the 'or stronger' ordering
> required.
> 
> For invalidate_count going 0->1 the spin_lock ensures that any
> following PTE update during invalidation does not order before the
> spin_lock()
> 
> While holding the lock and observing 1 in invalidate_count the PTE
> values might be changing, but are ignored. C's rules about sequencing
> make this safe.
> 
> For invalidate_count going 1->0 the spin_unlock ensures that any
> preceeding PTE update during invalidation does not order after the
> spin_unlock
> 
> While holding the lock and observing 0 in invalidating_count the PTE
> values cannot be changing.
> 
> Jason

Oh right. So prefetch holds the spinlock the whole time.
Sorry about the noise.

-- 
MST
