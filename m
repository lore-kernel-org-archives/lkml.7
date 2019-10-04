Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62BBC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC11222C5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389623AbfJDPLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:11:02 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46942 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389086AbfJDPLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:11:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGPEQ-0004dA-83; Fri, 04 Oct 2019 15:10:58 +0000
Date:   Fri, 4 Oct 2019 16:10:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Varad Gautam <vrd@amazon.de>, stable@vger.kernel.org,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH] devpts: Fix NULL pointer dereference in dcache_readdir()
Message-ID: <20191004151058.GH26530@ZenIV.linux.org.uk>
References: <20191004140503.9817-1-christian.brauner@ubuntu.com>
 <20191004142748.GG26530@ZenIV.linux.org.uk>
 <20191004143301.kfzcut6a6z5owfee@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004143301.kfzcut6a6z5owfee@wittgenstein>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 04:33:02PM +0200, Christian Brauner wrote:
> On Fri, Oct 04, 2019 at 03:27:48PM +0100, Al Viro wrote:
> > On Fri, Oct 04, 2019 at 04:05:03PM +0200, Christian Brauner wrote:
> > > From: Will Deacon <will@kernel.org>
> > > 
> > > Closing /dev/pts/ptmx removes the corresponding pty under /dev/pts/
> > > without synchronizing against concurrent path walkers. This can lead to
> > > 'dcache_readdir()' tripping over a 'struct dentry' with a NULL 'd_inode'
> > > field:
> > 
> > FWIW, vfs.git#fixes (or #next.dcache) ought to deal with that one.
> 
> Is it feasible to backport your changes? Or do we want to merge the one
> here first and backport?

I'm not sure.  The whole pile is backportable, all right (and the first commit
alone should take care of devpts problem).  However, there's a performance
regression on some loads; it *is* possible to get the thing reasonably lockless
without fucking it up (as the original conversion had been).  Still not
in the series, since cifs (ab)use of dcache_readdir() needs to be clarified
to figure out the right way to do it.  Asked CIFS folks, got no reaction
whatsoever, will ask again...

	Al, mostly back after flu, digging through the piles of mail
