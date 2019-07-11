Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAB7C74A51
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50122206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OWG1gaow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfGKKxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 06:53:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfGKKxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7ksrQx65WxbxMfcbR6gLJTkEG23r7XFCNssMAB6Ttfs=; b=OWG1gaowie5/2O3RkM97Kc9h0
        qevtaYLzWzsdtXNOWK/IT7VTapLydfPZ0wl21n1GHwR5Q3ZT/JU8cIU5elAQPFlB2ELs2zFQJEjcE
        gszRbqOUStZF8Hui7J5vUcDly60nntLCTTrddLajLH4keZmvTO6CoYly/06qHxWtxLRhVE8tgXb2g
        /CklqnCpk4J6nOMha7fuzDHOuabnPQ5qV5IE7veeXp654JNVcsuYl6lCqxonyQyQM8PlvpqQJPCIk
        7XSIx2EAfIHNX4MktDxNJnDC4dNonmZYUsBJCn14m8GjFjROvMuyrEDPmUp4YctevUuQpDRjYmqvk
        xaZ4bYsHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlWhH-0002PS-1i; Thu, 11 Jul 2019 10:53:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7583820B2B4C4; Thu, 11 Jul 2019 12:53:05 +0200 (CEST)
Date:   Thu, 11 Jul 2019 12:53:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Borislav Petkov <bp@suse.de>,
        syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] perf/hw_breakpoint: Fix breakpoint overcommit issue
Message-ID: <20190711105305.GY3402@hirez.programming.kicks-ass.net>
References: <20190709134821.8027-1-frederic@kernel.org>
 <20190710140421.GP3402@hirez.programming.kicks-ass.net>
 <20190710153406.GA18838@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710153406.GA18838@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 05:34:07PM +0200, Frederic Weisbecker wrote:
> On Wed, Jul 10, 2019 at 04:04:21PM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 09, 2019 at 03:48:19PM +0200, Frederic Weisbecker wrote:
> > > 
> > > Syzbot has found a breakpoint overcommit issue:
> > > 
> > > https://lore.kernel.org/lkml/000000000000639f6a0584d11b82@google.com/
> > > 
> > > It took me a long time to find out what the actual root problem was. Also
> > > its reproducer only worked on a few month old kernel but it didn't feel like
> > > the issue was actually solved.
> > > 
> > > I eventually cooked a reproducer that works with latest upstream, see in
> > > the end of this message.
> > > 
> > > The fix is just a few liner but implies to shut down the context swapping
> > > optimization for contexts containing breakpoints.
> > > 
> > > Also I feel like uprobes may be concerned as well as it seems to make use
> > > of event.hw->target after pmu::init().
> > 
> > Can't we simply swizzle event.hw->target along too?
> 
> You mean remove it? But it's still needed by breakpoint code during all the event
> lifecycle (init, destroy and anytime in-between).

No, I meant flip hw->target when we flip the context. It would mean
iterating the events, which I suppose would suck.

> I wish we could use event->ctx->task instead but on pmu::init() there
> is no ctx yet (we could pass the task in parameter though) 

Right, that should be fairly easy.

> and on event->destroy() it's TASK_TOMBSTONE and retrieving the task at
> that time would be non trivial.

Well, right, we can maybe make TOMBSTONE be the LSB instead of the whole
word, then we can recover the task pointer... *yuck* though.
