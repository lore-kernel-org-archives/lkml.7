Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254C5C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DB22064B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfGBNV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:21:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49026 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfGBNV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:21:59 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hiIjD-00044l-Ed; Tue, 02 Jul 2019 13:21:47 +0000
Date:   Tue, 2 Jul 2019 14:21:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+d88a977731a9888db7ba@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: kernel panic: corrupted stack end in dput
Message-ID: <20190702132147.GG17978@ZenIV.linux.org.uk>
References: <000000000000a5d3cb058c9a64f0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a5d3cb058c9a64f0@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 05:21:26PM +0800, Hillf Danton wrote:

> Hello,

> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -673,14 +673,11 @@ static struct dentry *dentry_kill(struct dentry *dentry)
> 	if (!IS_ROOT(dentry)) {
> 		parent = dentry->d_parent;
> 		if (unlikely(!spin_trylock(&parent->d_lock))) {
> -			parent = __lock_parent(dentry);
> -			if (likely(inode || !dentry->d_inode))
> -				goto got_locks;
> -			/* negative that became positive */
> -			if (parent)
> -				spin_unlock(&parent->d_lock);
> -			inode = dentry->d_inode;
> -			goto slow_positive;
> +			/*
> +			 * fine if peer is busy either populating or
> +			 * cleaning up parent
> +			 */
> +			parent = NULL;
> 		}
> 	}
> 	__dentry_kill(dentry);

This is very much *NOT* fine.
	1) trylock can fail from any number of reasons, starting
with "somebody is going through the hash chain doing a lookup on
something completely unrelated"
	2) whoever had been holding the lock and whatever they'd
been doing might be over right after we get the return value from
spin_trylock().
	3) even had that been really somebody adding children in
the same parent *AND* even if they really kept doing that, rather
than unlocking and buggering off, would you care to explain why
dentry_unlist() called by __dentry_kill() and removing the victim
from the list of children would be safe to do in parallel with that?

NAK, in case it's not obvious from the above.
