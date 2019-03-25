Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDCFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D0F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfCYVOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:14:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55380 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfCYVOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:14:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h8Wv0-0006qr-9Q; Mon, 25 Mar 2019 21:14:06 +0000
Date:   Mon, 25 Mar 2019 21:14:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
Message-ID: <20190325211405.GP2217@ZenIV.linux.org.uk>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 12:18:02PM -0700, Linus Torvalds wrote:
> COMPLETELY UNTESTED. And no filesystems converted to actually use the
> new rcu_destroy_inode() thing.
> 
> Hmm?

Maybe, but we really need to come up with sane documentation on the
entire drop_inode/evict_inode/destroy_inode/rcu_destroy_inode
group ;-/  And I want to understand the writeback-related issues
in ocfs2 and f2fs - the current kludges in those smell fishy.

>  	if (unlikely(inode_init_always(sb, inode))) {
> -		if (inode->i_sb->s_op->destroy_inode)
> +		if (inode->i_sb->s_op->destroy_inode) {
>  			inode->i_sb->s_op->destroy_inode(inode);
> -		else
> +			if (!inode->i_sb->s_op->rcu_destroy_inode)
> +				return NULL;
> +		}
> +		if (!inode->i_sb->s_op->rcu_destroy_inode ||
> +		    !inode->i_sb->s_op->rcu_destroy_inode(inode))
>  			kmem_cache_free(inode_cachep, inode);

ITYM  i_callback(inode); here, possibly suitably renamed.
