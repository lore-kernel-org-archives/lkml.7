Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C275FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745C7217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="fxDozUCD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jo1puTGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfDJKf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:35:58 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39845 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726799AbfDJKf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:35:57 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 676A424424;
        Wed, 10 Apr 2019 06:35:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 10 Apr 2019 06:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        bAUBCyh6D+cqg2CCcq7UVCt4VcGNkYg8Bx5jMhE3Ino=; b=fxDozUCDNcYxrBu0
        BojwrTo9Y+wCymDOuFHHMD6ZDMgg7dDMT3XOGWwnzLDSZbZ4w1KyRAW8OIbQOJmj
        cK6FOTPKex3G9javWoj7yjeN/2e7fdO61w+699v8cIrjEz8QNapm8ctbV4clv84Q
        wfc+YruKdEVFezjyyZiaBhs537+WK69cbBt6O7JlNCnBuVkNMv2irhhACyUMu7c0
        pMWCjhYyJzN4k52wATB2v0eJ5RvtgudofAInoFklYtvUs+worqK60hx2wWaK3kyz
        GoPggMsE4bVEPb7dIlc2p5Hw7CPUnCG4X9Gr5l+Pfwegw7Sg4SRoJ6HLsfRdMP62
        WafIZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=bAUBCyh6D+cqg2CCcq7UVCt4VcGNkYg8Bx5jMhE3I
        no=; b=jo1puTGKtJNqsGtUjhhtAprmFduQNJJ3u3zbq/KmjW2Dq9BSxn3uusc9a
        iA9sSstPMegCv8iipIB48rxdqoSYlOTmR6EvtZOQiMFp5ke9LgeNLTJ6xManQ7iM
        Izj7qKI+Kd9eS12qarg0IQssJ0fsZOn+NvYHO2xGSud9ktEaoYd/MP6inR0GnpDD
        HXsDXnGimO+b9wj9/86s+5eZONJyZ+GRfec6a06JffBqmaT+rrgPDGwA2DLJCFy3
        feDS3fZWgq38e+u/p1v3TUhVEK5UmRoRZRVMWo0AHcocGafCCKPVn9usgWxl605U
        3IRlWjDldKIxZtHuEOP27A2qPqHHg==
X-ME-Sender: <xms:C8etXLv8cYoEvJPYzIirBTuLQH97Oplf1eDPAq_VFQOJHU7-0rO77A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudejgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefkuffhvfffjghftgfoggfg
    sehtjeertdertdejnecuhfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmh
    grfidrnhgvtheqnecuffhomhgrihhnpehgohhordhglhdprghpphhsphhothdrtghomhen
    ucfkphepuddukedrvddtkedrieefrddvfedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:C8etXHa8LBHztY64BU-x4mFiMLfY-p_dOZxcuIsaS7tSwSCKo6ywaQ>
    <xmx:C8etXNy4LqCFI594cm9NI2WgylplxgChRTnMdt2RxFLGi7oJofaDxw>
    <xmx:C8etXPhhmF_1qDlv5zuau8YGVh8Qqq5YZyVVKE_DatZrx3kwH0NRjw>
    <xmx:DMetXI8Abw1FbGsi1QwSDOkRpCNhw2dohSNXGIGWg8C30-7uej2xGQ>
Received: from pluto.themaw.net (unknown [118.208.63.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3AD0910316;
        Wed, 10 Apr 2019 06:35:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id B935E1C0094;
        Wed, 10 Apr 2019 18:35:51 +0800 (AWST)
Message-ID: <eb223b47641df91a56fd200188a65d2c0ca4abe1.camel@themaw.net>
Subject: Re: kernel BUG at fs/inode.c:LINE!
From:   Ian Kent <raven@themaw.net>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Wed, 10 Apr 2019 18:35:51 +0800
In-Reply-To: <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
References: <00000000000051e9c2057d31a563@google.com>
         <00000000000036a4a9058619dff3@google.com>
         <20190410002603.GS2217@ZenIV.linux.org.uk>
         <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-10 at 10:27 +0200, Dmitry Vyukov wrote:
> On Wed, Apr 10, 2019 at 2:26 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > On Tue, Apr 09, 2019 at 07:36:00AM -0700, syzbot wrote:
> > > Bisection is inconclusive: the first bad commit could be any of:
> > 
> > [snip the useless pile]
> > 
> > > bisection log:  
> > > https://syzkaller.appspot.com/x/bisect.txt?x=15e1fc2b200000
> > > start commit:   [unknown
> > > git tree:       linux-next
> > > dashboard link: 
> > > https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> > > 
> > > For information about bisection process see: 
> > > https://goo.gl/tpsmEJ#bisection
> > 
> > If I'm not misreading the "crash report" there, it has injected an
> > allocation
> > failure in dentry allocation in d_make_root() from autofs_fill_super() (
> >         root_inode = autofs_get_inode(s, S_IFDIR | 0755);
> >         root = d_make_root(root_inode);
> > ) which has triggered iput() on the inode passed to d_make_root() (as it
> > ought
> > to).  At which point it stepped into some BUG_ON() in fs/inode.c, but I've
> > no idea which one it is - line numbers do not match anything in linux-next
> > or in mainline.  Reported line 1566 is
> >                 if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > in all of them; as the matter of fact, the diff in fs/inode.c between
> > -next and mainline is empty.
> > 
> > There is a BUG_ON() several lines prior, and in 4.20 it used to be line
> > 1566,
> > so _probably_ that's what it is.  With that assumption, it's
> >         BUG_ON(inode->i_state & I_CLEAR);
> > IOW, we'd got I_CLEAR in the inode passed to d_make_root() there.  Which
> > should not happen - the inode must have come from new_inode(), which
> > gets it from new_inode_pseudo(), which zeroes ->i_state.  And I_CLEAR
> > is set only in clear_inode().  For autofs inodes that can come only
> > from autofs_evict_inode(), called as ->evict() from evict_inode().
> > Which should never ever be called for inode with positive ->i_count...
> > 
> > It might be memory corruption; it might be a dangling inode pointer
> > somewhere, it might be something else.
> > 
> > To get any further we really need a confirmation of the identity of
> > triggered BUG_ON().
> > 
> > As an aside, your "sample crash reports" would've been much more useful if
> > they went with commit SHA1 in question, especially when they contain line
> > numbers.
> 
> Hi Al,
> 
> This is the commit for matching lines:
> 
> > HEAD commit:    d14b746c6c1c Add linux-next specific files for 20181214

Are you sure?
what does 20181214 mean?

Looking at current next code (and several branches) it doesn't
appear the problem is possible?

> > git tree:       linux-next

But which branch is it really, master (which doesn't match the
line numbers btw)?

> 
> fs/inode.c:1566 points to:
> 
> void iput(struct inode *inode)
> {
>     ...
>     BUG_ON(inode->i_state & I_CLEAR);
> 
> 
> The dashboard page provides kernel git repository and commit for each crash.

Those links don't seem to make sense to me ...

Help me out here!
Ian


