Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CD9C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11DD2229A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbfGWFCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 01:02:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34429 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfGWFCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:02:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so41647609wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 22:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JYPoJkQN+XK2UvnSjwNQRenJIQ2ixkhyrsqP4Uhz9H8=;
        b=pqUwSdigHOX208mOoJJl3JwvgAk5MEVPfCEwP8kL/HOZq1buLSaKxVJfBxhhye1zfi
         UhBJmKAetN5bkbAZ83YM+txvRDyQyfEmWCLquMgzQfmp8OVzzXWgkKf01llGa3gAY2mD
         R6DSVP/1b4jmI7Va/ooBSp9DRS/tIjfYOm/PdH2PQw8L/oVeHl0iGBnGfbkvKrBTFNGE
         +d57m34lEcTVxDWNrZ2dDcqIoukMMkLXzVeK8RQitcgXSoef7uwHN0tyfwcDs3ER1OHY
         BkiOM1UFyX5Zc7x/gpnxroi2sT/sVgubNKy7P0r7J4S8B3U4cp1jd5Q13C2IStMUTVrk
         qdKg==
X-Gm-Message-State: APjAAAX1wE3Gdr1+1SUt7u0xsdaqY4+KA3KVjlPUZabylzn2ocC1uXFa
        72YIxkMLSTN0ED2wT3igQnapVA==
X-Google-Smtp-Source: APXvYqyEMTuVBH8zniGTqgl57BX2DcyhG+Wl2kks7XclSYkMvxpBTbWB4yptqSSR2n2cmwFVsaFFzw==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr4657765wrw.138.1563858164654;
        Mon, 22 Jul 2019 22:02:44 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id j10sm70533109wrd.26.2019.07.22.22.02.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 22:02:43 -0700 (PDT)
Date:   Tue, 23 Jul 2019 01:02:39 -0400
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
Message-ID: <20190723010156-mutt-send-email-mst@kernel.org>
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <75c43998-3a1c-676f-99ff-3d04663c3fcc@redhat.com>
 <20190722035657-mutt-send-email-mst@kernel.org>
 <cfcd330d-5f4a-835a-69f7-c342d5d0d52d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfcd330d-5f4a-835a-69f7-c342d5d0d52d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 11:55:28AM +0800, Jason Wang wrote:
> 
> On 2019/7/22 下午4:02, Michael S. Tsirkin wrote:
> > On Mon, Jul 22, 2019 at 01:21:59PM +0800, Jason Wang wrote:
> > > On 2019/7/21 下午6:02, Michael S. Tsirkin wrote:
> > > > On Sat, Jul 20, 2019 at 03:08:00AM -0700, syzbot wrote:
> > > > > syzbot has bisected this bug to:
> > > > > 
> > > > > commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
> > > > > Author: Jason Wang <jasowang@redhat.com>
> > > > > Date:   Fri May 24 08:12:18 2019 +0000
> > > > > 
> > > > >       vhost: access vq metadata through kernel virtual address
> > > > > 
> > > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149a8a20600000
> > > > > start commit:   6d21a41b Add linux-next specific files for 20190718
> > > > > git tree:       linux-next
> > > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=169a8a20600000
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=129a8a20600000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=e58112d71f77113ddb7b
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10139e68600000
> > > > > 
> > > > > Reported-by: syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com
> > > > > Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual
> > > > > address")
> > > > > 
> > > > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > > > OK I poked at this for a bit, I see several things that
> > > > we need to fix, though I'm not yet sure it's the reason for
> > > > the failures:
> > > > 
> > > > 
> > > > 1. mmu_notifier_register shouldn't be called from vhost_vring_set_num_addr
> > > >      That's just a bad hack,
> > > 
> > > This is used to avoid holding lock when checking whether the addresses are
> > > overlapped. Otherwise we need to take spinlock for each invalidation request
> > > even if it was the va range that is not interested for us. This will be very
> > > slow e.g during guest boot.
> > KVM seems to do exactly that.
> > I tried and guest does not seem to boot any slower.
> > Do you observe any slowdown?
> 
> 
> Yes I do.
> 
> 
> > 
> > Now I took a hard look at the uaddr hackery it really makes
> > me nervious. So I think for this release we want something
> > safe, and optimizations on top. As an alternative revert the
> > optimization and try again for next merge window.
> 
> 
> Will post a series of fixes, let me know if you're ok with that.
> 
> Thanks

I'd prefer you to take a hard look at the patch I posted
which makes code cleaner, and ad optimizations on top.
But other ways could be ok too.

> 
> > 
> > 
