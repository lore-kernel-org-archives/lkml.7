Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377A6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048B02063F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfCYLLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:11:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47840 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYLLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:11:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h8NVj-00067u-SM; Mon, 25 Mar 2019 11:11:23 +0000
Date:   Mon, 25 Mar 2019 11:11:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
Message-ID: <20190325111123.GM2217@ZenIV.linux.org.uk>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <717eaff9-1f49-28f3-bbb6-c8f14ebbe03b@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <717eaff9-1f49-28f3-bbb6-c8f14ebbe03b@iogearbox.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:15:40AM +0100, Daniel Borkmann wrote:
> > So we have 5 broken cases, all with the same kind of fix: move freeing
> > into the RCU-delayed part of ->destroy_inode(); for debugfs and bpf
> > that requires adding ->alloc_inode()/->destroy_inode(), rather than
> > relying upon the defaults from fs/inode.c
> 
> I believe I copied that logic from one of the other fs'es back then, sigh.
> Thanks for the analysis and hints for fixing. Would the below (only compile
> tested for now) look reasonable to you? I believe there is no other way
> around than to add our own inode cache, but so be it. The freeing of the
> i_link is then RCU-deferred in bpf_destroy_inode_deferred():

It looks like it would suffice, but it's way too much boilerplate for my
taste ;-/

Most of your headache here comes from messing with slab setup and the
only reason for that is being unable to free stuff into inode_cachep.
So grep for inode_cachep would be a good idea, and it digs up the
following sucker:
void free_inode_nonrcu(struct inode *inode)  
{
        kmem_cache_free(inode_cachep, inode);
}
EXPORT_SYMBOL(free_inode_nonrcu);

IOW, you need nothing on ->alloc_inode() side and for ->destroy_inode()
just do call_rcu() of a callback, that would kfree(inode->link) if
it was a symlink, then call free_inode_nonrcu(inode).

Considerably smaller patch that way...
