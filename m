Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26406C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8A32084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="b1vDii/V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fh5O+ggx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfDJL5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:57:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40379 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726776AbfDJL5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:57:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1787D21ECC;
        Wed, 10 Apr 2019 07:57:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 10 Apr 2019 07:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        xKmY3j4ur1+D3uC2vHmadbCuKlltrYWOOCKGxhw7GBw=; b=b1vDii/VeG1ZTgpN
        B5TyoxzMWmnbQbAFUSaOAlKKuRDK4+fUb4KTXOOywlkEorxpR9NyW7QbG9qbq16F
        B4MeA/7Y3dfIKDT9KQw7XDXdfYc8hUw/bgiIbnj/ujoXC7nCz5wuRpZSp2nTEDEX
        qorPuk3isctPSS7nS/8eX+Lro5RFreSD3nO2pRj5JtWa9cFL0uvZG/wEgF2xai0o
        06ecaOz7VfStHQzlLa80hNQaYXAEjo/MORUXfJTV8wvAydN1qA/r9I4CQcGSvuWg
        xhXXMLeztHT60Gpn+4jLvzz3uxHaC8TXXlfLsBFeluOuIvom0sujsbTKI5T4j23l
        Ob1A+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=xKmY3j4ur1+D3uC2vHmadbCuKlltrYWOOCKGxhw7G
        Bw=; b=fh5O+ggxuylloWLbnLWSBNcNtUyEZFrD3HMaQVC3LnVPAteZ6s9StzI/M
        tql96XRpL+K4UAiXA7dCI2j9bIo00HoDAEpuV2U8ut7glQ88PZ8p5ZpN2wK/8zTY
        defe+KHa8ztOJzLNxGHtBjAFxC+EThlFb5u28GqUeeY2fNfI1MgQwk589iAZygyf
        foOh8mFSqHhYRFAjuEreor3koNIvNLS96FTqX1JYciBIRpxm5OoE4TvhbMa6uc5I
        LnM1ZSlCEcObka5eATHO7ptRlCsGIysmdaY4hAqIffN2MIpL8eXb1pdjj0iLHUDY
        YfduREa/4dmj/yW2sACMKGgyjGBcA==
X-ME-Sender: <xms:PdqtXDPzSRyj4eKIfawadxiGtUfJ5ItAr9NsB1nj3REbZHVSzw6J7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudejgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefkuffhvfffjghftgfoggfg
    sehtjeertdertdejnecuhfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmh
    grfidrnhgvtheqnecuffhomhgrihhnpehgohhordhglhdprghpphhsphhothdrtghomhen
    ucfkphepuddukedrvddtkedrieefrddvfedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:PdqtXHdBcSRLBoupf2xf11SJ3tE-3_HauYsYzktAgVXSqKoO-adULw>
    <xmx:PdqtXGj2cAOREkvAz0d8di0ta4Gzhr0uKJi67M1-toUlNFWoqnT3vA>
    <xmx:PdqtXPSk17rI0oO7_6SD6A4CEB8_qM8fXodz39batjh8prrxXLJU_g>
    <xmx:PtqtXGfmhKnNCJpDdK46vE71z8U2ZCb0DfyH4m8FLEnD6_Nvobmbhg>
Received: from pluto.themaw.net (unknown [118.208.63.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id F14B9E4332;
        Wed, 10 Apr 2019 07:57:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 57E551C0070;
        Wed, 10 Apr 2019 19:57:44 +0800 (AWST)
Message-ID: <5c581e6eadc946b965e3138c9daffda75b1fba56.camel@themaw.net>
Subject: Re: kernel BUG at fs/inode.c:LINE!
From:   Ian Kent <raven@themaw.net>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Wed, 10 Apr 2019 19:57:44 +0800
In-Reply-To: <CACT4Y+YdaDdDbRvQZzvqbPofMD6F9cPtGFzcW+db-etJayfaJw@mail.gmail.com>
References: <00000000000051e9c2057d31a563@google.com>
         <00000000000036a4a9058619dff3@google.com>
         <20190410002603.GS2217@ZenIV.linux.org.uk>
         <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
         <eb223b47641df91a56fd200188a65d2c0ca4abe1.camel@themaw.net>
         <CACT4Y+YdaDdDbRvQZzvqbPofMD6F9cPtGFzcW+db-etJayfaJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-10 at 13:40 +0200, Dmitry Vyukov wrote:
> On Wed, Apr 10, 2019 at 12:35 PM Ian Kent <raven@themaw.net> wrote:
> > 
> > On Wed, 2019-04-10 at 10:27 +0200, Dmitry Vyukov wrote:
> > > On Wed, Apr 10, 2019 at 2:26 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > 
> > > > On Tue, Apr 09, 2019 at 07:36:00AM -0700, syzbot wrote:
> > > > > Bisection is inconclusive: the first bad commit could be any of:
> > > > 
> > > > [snip the useless pile]
> > > > 
> > > > > bisection log:
> > > > > https://syzkaller.appspot.com/x/bisect.txt?x=15e1fc2b200000
> > > > > start commit:   [unknown
> > > > > git tree:       linux-next
> > > > > dashboard link:
> > > > > https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> > > > > syz repro:      
> > > > > https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> > > > > C reproducer:   
> > > > > https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> > > > > 
> > > > > For information about bisection process see:
> > > > > https://goo.gl/tpsmEJ#bisection
> > > > 
> > > > If I'm not misreading the "crash report" there, it has injected an
> > > > allocation
> > > > failure in dentry allocation in d_make_root() from autofs_fill_super() (
> > > >         root_inode = autofs_get_inode(s, S_IFDIR | 0755);
> > > >         root = d_make_root(root_inode);
> > > > ) which has triggered iput() on the inode passed to d_make_root() (as it
> > > > ought
> > > > to).  At which point it stepped into some BUG_ON() in fs/inode.c, but
> > > > I've
> > > > no idea which one it is - line numbers do not match anything in linux-
> > > > next
> > > > or in mainline.  Reported line 1566 is
> > > >                 if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > > > in all of them; as the matter of fact, the diff in fs/inode.c between
> > > > -next and mainline is empty.
> > > > 
> > > > There is a BUG_ON() several lines prior, and in 4.20 it used to be line
> > > > 1566,
> > > > so _probably_ that's what it is.  With that assumption, it's
> > > >         BUG_ON(inode->i_state & I_CLEAR);
> > > > IOW, we'd got I_CLEAR in the inode passed to d_make_root() there.  Which
> > > > should not happen - the inode must have come from new_inode(), which
> > > > gets it from new_inode_pseudo(), which zeroes ->i_state.  And I_CLEAR
> > > > is set only in clear_inode().  For autofs inodes that can come only
> > > > from autofs_evict_inode(), called as ->evict() from evict_inode().
> > > > Which should never ever be called for inode with positive ->i_count...
> > > > 
> > > > It might be memory corruption; it might be a dangling inode pointer
> > > > somewhere, it might be something else.
> > > > 
> > > > To get any further we really need a confirmation of the identity of
> > > > triggered BUG_ON().
> > > > 
> > > > As an aside, your "sample crash reports" would've been much more useful
> > > > if
> > > > they went with commit SHA1 in question, especially when they contain
> > > > line
> > > > numbers.
> > > 
> > > Hi Al,
> > > 
> > > This is the commit for matching lines:
> > > 
> > > > HEAD commit:    d14b746c6c1c Add linux-next specific files for 20181214
> > 
> > Are you sure?
> > what does 20181214 mean?
> 
> Yes, I just copy-pasted from the report. "d14b746c6c1c" is the commit
> hash. "Add linux-next specific files for 20181214" is the commit
> subject.
> 
> 
> > Looking at current next code (and several branches) it doesn't
> > appear the problem is possible?
> > 
> > > > git tree:       linux-next
> > 
> > But which branch is it really, master (which doesn't match the
> > line numbers btw)?
> 
> This is d14b746c6c1c commit hash. I don't know if there is a branch
> with HEAD pointing to this commit or not, but it seems unimportant.
> Tree+commit is the identity of code state.
> 
> 
> > > fs/inode.c:1566 points to:
> > > 
> > > void iput(struct inode *inode)
> > > {
> > >     ...
> > >     BUG_ON(inode->i_state & I_CLEAR);
> > > 
> > > 
> > > The dashboard page provides kernel git repository and commit for each
> > > crash.
> > 
> > Those links don't seem to make sense to me ...
> > 
> > Help me out here!
> 
> There is git repo name provided and commit hash. It's meant to be
> self-explanatory. What exactly is unclear?

I'm unable to find a branch matching the line numbers.

Given that, on the face of it, the scenario is impossible I'm
seeking clarification on what linux-next to look at for the
sake of accuracy.

So I'm wondering if this testing done using the master branch
or one of the daily branches one would use to check for conflicts
before posting?

Or perhaps the master branch has been updated and the testing was
done on something different.

Ian

