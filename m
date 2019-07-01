Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51610C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B87208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QnNqCN5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfGAIXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:23:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hBCJxL8ZUJseIyS7B5DLbWsf3GKr85SKQzEdMWI6/qU=; b=QnNqCN5dHXnibX5TmwhtiXxwc
        rWWP5I/omYU7kI3jbeHOM5a36TDmi1wAj3Y4sfxGfIzMZMZGjTrcM4TaqHheq2ugICwmjHC2elStP
        7Ty1IGiq4Xo0wRqfxRRJ535oiovdDg/9aMdc/MibGr+1V/G5ALcy+9S5azV/sNidv8HBpCLZyXSIO
        UjrVzBU8u4a6VsxT3Q/r5PhqF3zoLkX0sjsDwYO6XSzi6E/Cq0qydu9m+/HP9/Wd2T9KClK2dTNLy
        cjtD/1xs+Tbn+vIWqKHzWeqxFGw+MF3HgTk+NOoiApbwyVf50e8Kx7J/QE+Bko6PgCqmCwYNXiY++
        SoyRlwhvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhrb6-00078L-EC; Mon, 01 Jul 2019 08:23:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37D1E20963E24; Mon,  1 Jul 2019 10:23:34 +0200 (CEST)
Date:   Mon, 1 Jul 2019 10:23:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Yuyang Du <duyuyang@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: clean up #ifdef checks
Message-ID: <20190701082334.GO3402@hirez.programming.kicks-ass.net>
References: <20190628102919.2345242-1-arnd@arndb.de>
 <20190628110353.ijd42pbhqfsdsi2n@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628110353.ijd42pbhqfsdsi2n@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 12:03:54PM +0100, Will Deacon wrote:
> Hi Arnd,
> 
> On Fri, Jun 28, 2019 at 12:29:03PM +0200, Arnd Bergmann wrote:
> > As Will Deacon points out, CONFIG_PROVE_LOCKING implies TRACE_IRQFLAGS,
> > so the conditions I added in the previous patch, and some others in the
> > same file can be simplified by only checking for the former.
> > 
> > No functional change.
> > 
> > Fixes: 886532aee3cd ("locking/lockdep: Move mark_lock() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  kernel/locking/lockdep.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> Thanks for following up on this. I think it makes the code easier to read,
> so:
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks guys!
