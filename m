Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F080C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322502133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfCHOXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:23:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38268 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHOXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:23:35 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h2GPL-0007Qc-Vx; Fri, 08 Mar 2019 14:23:32 +0000
Date:   Fri, 8 Mar 2019 14:23:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: use KERNEL_DS instead of get_ds()
Message-ID: <20190308142331.GE2217@ZenIV.linux.org.uk>
References: <20190301200835.18286-1-jannh@google.com>
 <20190302034017.GM2217@ZenIV.linux.org.uk>
 <CAHk-=wjJ1vY9Gte01+YhEOuKHbd=u4zwPxRCOfuiHw-kMvE26Q@mail.gmail.com>
 <20190308140142.GA1971@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308140142.GA1971@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 06:01:42AM -0800, Christoph Hellwig wrote:
> On Mon, Mar 04, 2019 at 04:23:06PM -0800, Linus Torvalds wrote:
> > Your script is disgusting, and I will not quote it for posterity for
> > that reason. I will just say that git has a "path exclusion" thing
> > that you can use to make it much more streamlined.
> > 
> > And I ended up going a bit further, and just got rid of it all in
> > commit 736706bee329 ("get rid of legacy 'get_ds()' function")
> 
> Any chance we could just retire the legacy FS/DS names that are
> horribly misleading these days?  E.g. turn the whole thing into:
> 
> 	uaccess_kernel_enable();
> 
> 	...
> 
> 	uaccess_kernel_disable();
> 
> which for now turn into the existing calls with a nesting counter
> in task_struct, with the hopes of cleaning all that mess up
> eventually.

You do realize that nested pairs of that sort are not all there is?
Even leaving m68k aside (there the same registers that select
userland or kernel for that kind of access can be used e.g. for
writeback control, or to switch to accessing sun3 MMU tables, etc.)
there are
	* temporary switches to USER_DS in things like unaligned
access handlers, etc., where the kernel is doing emulation of possibly
userland insns; similar for oops code dumping, etc.
	* use_mm()/unuse_mm() should probably switch to USER_DS and
back, rather than doing that in callers.
	* switch to USER_DS (and no, it's *not* "USER_DS unless we started
with KERNEL_DS" - nested counter is no-go here) for perf callbacks.
	* regular non-paired switches to USER_DS: do_exit() and
flush_old_exec().
