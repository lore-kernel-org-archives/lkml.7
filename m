Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC269C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 23:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A7D20674
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 23:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfDVXKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 19:10:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53358 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfDVXKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 19:10:41 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hIi56-0004ix-Lj; Mon, 22 Apr 2019 23:10:36 +0000
Date:   Tue, 23 Apr 2019 00:10:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 60/62] orangefs: make use of ->free_inode()
Message-ID: <20190422231036.GK2217@ZenIV.linux.org.uk>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
 <20190416175340.21068-60-viro@ZenIV.linux.org.uk>
 <CAOg9mSQppnRWPnSg9eAm0NeW3XEm0LZ74Aw651QTBx0Gm1jpQA@mail.gmail.com>
 <CAHk-=whjK_n2wZX3kZNgkK=wBrw+K5PvMowJ4rYDiDSrmV_aYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whjK_n2wZX3kZNgkK=wBrw+K5PvMowJ4rYDiDSrmV_aYw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 02:56:57PM -0700, Linus Torvalds wrote:
> On Mon, Apr 22, 2019 at 2:14 PM Mike Marshall <hubcap@omnibond.com> wrote:
> >
> > I applied your "new inode method: ->free_inode()" and
> > "orangefs: make use of ->free_inode()" to our pagecache
> > branch (I hope to get it pulled in the next merge window).
> 
> Actually, please don't.
> 
> Exactly because this needs that common vfs patch, I'd really prefer to
> get it all through Al's tree, rather than have individual filesystems
> apply their own copies of the common infrastructure commit, and then
> apply their changes on top of that.
> 
> I can easily handle any trivial conflicts this causes, so that's not a
> reason to have each filesystem do it either.
> 
> So if this is at the top of your tree, can you just "git reset" it
> away and I'll get all the filesystems (and the common infrastructure
> commit) all together from Al.

What's more, seeing the changes in orangefs tree I would rather have
static void orangefs_free_inode(struct inode *inode)
{
	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
	kmem_cache_free(orangefs_inode_cache, orangefs_inode);
}

in that series; not only less noise on merge, but with additional
uses of orangefs_inode in the body from orangefs tree changes
keeping the local variable clearly makes sense...
