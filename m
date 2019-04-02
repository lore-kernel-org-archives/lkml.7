Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7478EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2022070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbfDBQuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:50:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45272 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbfDBQui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:50:38 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hBMaG-00037G-7l; Tue, 02 Apr 2019 16:48:24 +0000
Date:   Tue, 2 Apr 2019 17:48:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
Message-ID: <20190402164824.GK2217@ZenIV.linux.org.uk>
References: <20190327051717.23225-1-tobin@kernel.org>
 <20190402094934.5b242dc0@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402094934.5b242dc0@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 09:49:34AM -0600, Jonathan Corbet wrote:
> On Wed, 27 Mar 2019 16:16:53 +1100
> "Tobin C. Harding" <tobin@kernel.org> wrote:
> 
> > Hi Al,
> > 
> > This series converts the VFS file Documentation/filesystems/vfs.txt to
> > reStructuredText format.  Please consider taking this series through
> > your tree as apposed to Jon's tree because this set makes a fair amount
> > of changes to VFS files (and also the VFS tree and docs tree are out of
> > sync right now with the recent work by Mauro and Neil).
> 
> Al, do you have any thoughts on how you want to handle this?  I was about
> to apply Jeff Layton's vfs.txt update, but would rather not create
> conflicts unnecessarily.  Let me know if you'd like me to pick this work
> up.

Frankly, I would rather see that file be eventually replaced by something
saner, and I'm not talking about the format.  Re Jeff's patch... 

+  d_prune: called prior to pruning (i.e. unhashing and killing) a hashed
+       dentry from the dcache.

is flat-out misguiding.  First of all, it *is* called for unhashed dentries,
TYVM.  Furthermore, "prior to" is far too vague.

What really happens: there's a point in state diagram for dentries where
we commit to destroying a dentry and start taking it apart.  That transition
happens with ->d_lock of dentry, ->i_lock of its inode (if any) and
->d_lock of the parent (again, if any) held; ->d_prune() is the last
chance for filesystem to see the (now doomed) dentry still intact.

It doesn't matter whether it's hashed or not, etc.  The locks held
are sufficient to stabilize pretty much everything[1] in dentry and
nothing is destroyed yet.  The only apparent exception is ->d_count,
but that's not real - we are guaranteed that there had been no other
counted references to dentry at the decision point and that none
could've been added.  So this "oh, it's not 0 now, it's gone negative
after lockref_mark_dead() the caller has just done" is a red herring.

->d_prune() must not drop/regain any of the locks held by caller.
It must _not_ free anything attached to dentry - that belongs
later in the shutdown sequence.  If anything, I'm tempted to
make it take const struct dentry * as argument, just to make
that clear.

No new (counted) references can be acquired by that point;
lockless dcache lookup might find our dentry a match, but
result of such lookup is not going to be legitimized - it's
doomed to be thrown out as stale.

It really makes more sense as part of struct dentry lifecycle
description...  

[1] in theory, ->d_time might be changed by overlapping lockless
call of ->d_revalidate().  Up to filesystem - VFS doesn't touch
that field (and AFAICS only NFS uses it these days).
