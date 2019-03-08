Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63C9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E5A2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mx6e1rdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCHQUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:20:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCHQUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ryIi7mBCvETEf47xe88e2rLtmFQWDJRZXDJXWIsd+wI=; b=mx6e1rdzZ+hY3ryv5BfdgugwO
        Wqfvh0eDBCNydTWyBPlae8Qpi/ggW8PbFEDhMcNKDX9tworcVqHMyXNFpNaZhxoEU13ccSWK3FFsD
        +QOLUc4fem8IaMnF7RY7YZLrgX/V4AK9ZmAb41ztSqQc70fj5vQu1IAUJE6mEgv+vEWF0SjCvtka/
        nxriiAhJtdtfKlA7OAPflNGwoMjQHTJedT5A4JnX6mDdP5l/CG4G5V0+mWiZyufNdAiQgUOyaSUT4
        RODRBDAxMsnWsuUwSPMgt/OeDZZDzHFNvoym5+FcmMubWOtI6aaw25WJgmErEcas8f+qT62v+Qnr0
        0yn6rfmww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2IEL-0008Ro-VX; Fri, 08 Mar 2019 16:20:17 +0000
Date:   Fri, 8 Mar 2019 08:20:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: use KERNEL_DS instead of get_ds()
Message-ID: <20190308162017.GA26207@infradead.org>
References: <20190301200835.18286-1-jannh@google.com>
 <20190302034017.GM2217@ZenIV.linux.org.uk>
 <CAHk-=wjJ1vY9Gte01+YhEOuKHbd=u4zwPxRCOfuiHw-kMvE26Q@mail.gmail.com>
 <20190308140142.GA1971@infradead.org>
 <20190308142331.GE2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308142331.GE2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 02:23:31PM +0000, Al Viro wrote:
> You do realize that nested pairs of that sort are not all there is?
> Even leaving m68k aside (there the same registers that select
> userland or kernel for that kind of access can be used e.g. for
> writeback control, or to switch to accessing sun3 MMU tables, etc.)

Yes.  And the whole point is to keep these uses clear and separate.

> there are
> 	* temporary switches to USER_DS in things like unaligned
> access handlers, etc., where the kernel is doing emulation of possibly
> userland insns; similar for oops code dumping, etc.
> 	* use_mm()/unuse_mm() should probably switch to USER_DS and
> back, rather than doing that in callers.
> 	* switch to USER_DS (and no, it's *not* "USER_DS unless we started
> with KERNEL_DS" - nested counter is no-go here) for perf callbacks.
> 	* regular non-paired switches to USER_DS: do_exit() and
> flush_old_exec().

And that is probably the close to full list of callers that want
to explicitly enable access to the user address space, and thus
mark the thread as a user thread (and occasionally clear that in e.g.
unuse_mm).

Unless I'm completely missing something our general rule of thumb
should be:

 - threads are started with uaccess kernel turned on (count = 1)
 - if we execute in userspace we switch to user uaccess (count = 0)
   - same for use_mm style threads that want user access
 - every current random kernel code override increments the refcount
   and drops the reference when done
 - force uaccess cases like do_exit or the validation check on
   return to userspace force it back to 0.

Initially each 1 > 0 transition (decrement or force) will do
set_fs(USER_DS), each 0 > 1 transition will do set_fs(KERNEL_DS).

Then later architectures can kill the set_fs API, and potentially
optimize things by getting rid of the addr_limit field in its current
form.
