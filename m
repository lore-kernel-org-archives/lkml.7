Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFBBC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7628B21951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AqJLL2tA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfGVOLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:11:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46926 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbfGVOLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:11:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so38583073qtn.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LtBWSYY5RJyJ5bjGuD8GT1ULGrE6M+cxt5l8yU6kpN0=;
        b=AqJLL2tAQ8qmfza+BbBBA30hBmiEi4pm7Bd30lUGLJdSyVKKuDWuxFlP7RyECIj17b
         XJpeqNQH2wamruofikS+opbhHXR87C/2P4+HHr/txKjdnmmTrCfU3/FvIDauFeGsqdLX
         9N8TDemI/FqJTetBBb+eMeMhgwvnuJ3+QSjcM18BJqZFbPTYbz22jGuEVhjAl1NeRhMe
         gMsST/gm4oj7anPp1NAGwwTiAl7EGdHZhvi9wPgzVP0639DiVRWlp0mKEsh+gaWi/vPE
         9sF4SdwiKYxgei4G8H6O23RQvFqbuu976015rHkp6asEVORyBSYPRzufJqJdiSfpQaVD
         Edlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LtBWSYY5RJyJ5bjGuD8GT1ULGrE6M+cxt5l8yU6kpN0=;
        b=nIBagqAOt4p2ZiHX05hHY195pG9qLeR9ethpnIsp2huBt2OD944YLKGW8ZlgebGjBe
         LXNh/Gw2GliK/7OEo7HOZYQU+fVXe5skDLiTugYz81uBjxQFMfWm4/OZLMMBUdfZwYUa
         cww8hoO4Y9/tPXW9hs5cXX0u/5jyJTqG55NLcrFlb1FBg6C45H6WtqgvbWpGdjcXuoKl
         Je//vDWirefFDUvQGRMhxR3m302OvahRVh0Rz9t+RbCFbC1MXYfWLL/JtmhJAUHEOkzr
         4VQuMzyIXRn66NACSh6LeGgqKH2RcsEjZYEFJEG3ovQWLFh0y6l/FToDdZBCQr2jx4tg
         Zu6Q==
X-Gm-Message-State: APjAAAUIibSvPRP8KCz91Y1N1mIGfSq8qPsYL/sCxRkXq8mgYmAFKTTJ
        ETmfRl2XsudsChO0pxDqsva7cg==
X-Google-Smtp-Source: APXvYqzJhWJh0JG/V+RW4LMQbSCenJcJXUz5oFlysoNrpAnk6aDKO1gmwVookMZq2D7vPB1tr+gYAg==
X-Received: by 2002:ac8:3794:: with SMTP id d20mr49622645qtc.392.1563804713889;
        Mon, 22 Jul 2019 07:11:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x46sm25518922qtx.96.2019.07.22.07.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 07:11:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpZ2e-0003yO-Ou; Mon, 22 Jul 2019 11:11:52 -0300
Date:   Mon, 22 Jul 2019 11:11:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jasowang@redhat.com,
        jglisse@redhat.com, keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: WARNING in __mmdrop
Message-ID: <20190722141152.GA13711@ziepe.ca>
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721044615-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 06:02:52AM -0400, Michael S. Tsirkin wrote:
> On Sat, Jul 20, 2019 at 03:08:00AM -0700, syzbot wrote:
> > syzbot has bisected this bug to:
> > 
> > commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
> > Author: Jason Wang <jasowang@redhat.com>
> > Date:   Fri May 24 08:12:18 2019 +0000
> > 
> >     vhost: access vq metadata through kernel virtual address
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149a8a20600000
> > start commit:   6d21a41b Add linux-next specific files for 20190718
> > git tree:       linux-next
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=169a8a20600000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=129a8a20600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e58112d71f77113ddb7b
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10139e68600000
> > 
> > Reported-by: syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com
> > Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual
> > address")
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> 
> OK I poked at this for a bit, I see several things that
> we need to fix, though I'm not yet sure it's the reason for
> the failures:

This stuff looks quite similar to the hmm_mirror use model and other
places in the kernel. I'm still hoping we can share this code a bit more.

There is another bug, this sequence here:

vhost_vring_set_num_addr()
   mmu_notifier_unregister()
   [..]
   mmu_notifier_register()

Which I think is trying to create a lock to protect dev->vqs..

Has the problem that mmu_notifier_unregister() doesn't guarantee that
invalidate_start/end are fully paired.

So after any unregister the code has to clean up any resulting
unbalanced invalidate_count before it can call mmu_notifier_register
again. ie zero the invalidate_count.

It also seems really weird that vhost_map_prefetch() can fail, ie due
to __get_user_pages_fast needing to block, but that just silently
(permanently?) disables the optimization?? At least the usage here
would be better done with a seqcount lock and a normal blocking call
to get_user_pages_fast()...

Jason
