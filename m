Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35754C74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072772084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mB03XBrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfGJOE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:04:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47000 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfGJOE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GnCQ98akCuR1pV3mAPw0GlCAn1/oJa+wJocAWBtJttM=; b=mB03XBrjuGzr8rTzdrGw9IFSn
        uCl47LoBLyquxrJMCG7rURPrzIiK0ki7BxCy2ecBXka9vkGA/h09Z1e+z52bBuUBWkjo4IqEQtIQZ
        WXSD2pUiKi5NGZazonnf6xJbUNnXyQJ61Ta9Hga1/D+bXKdrbKkHtcdNNvYqYXRzThj+8xM9zasi4
        7TrAbCCx5e2w19WdAuzMzVYb7JmiBuTJI7uF8UkOl8LAulWwK6VyFDJkR/0rqLH2INYBZdhUb+3k4
        4Vj2qKkjmZFbQ5oJUB7w7J9Ge4QBmBgvBGWHilWoJYf6+vUA2UMxyPjUlTPvpUuoslqEWfzimJy4r
        3OOtijY3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlDCp-0002yz-7D; Wed, 10 Jul 2019 14:04:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9ECB720976EE7; Wed, 10 Jul 2019 16:04:21 +0200 (CEST)
Date:   Wed, 10 Jul 2019 16:04:21 +0200
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
Message-ID: <20190710140421.GP3402@hirez.programming.kicks-ass.net>
References: <20190709134821.8027-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709134821.8027-1-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 03:48:19PM +0200, Frederic Weisbecker wrote:
> 
> Syzbot has found a breakpoint overcommit issue:
> 
> https://lore.kernel.org/lkml/000000000000639f6a0584d11b82@google.com/
> 
> It took me a long time to find out what the actual root problem was. Also
> its reproducer only worked on a few month old kernel but it didn't feel like
> the issue was actually solved.
> 
> I eventually cooked a reproducer that works with latest upstream, see in
> the end of this message.
> 
> The fix is just a few liner but implies to shut down the context swapping
> optimization for contexts containing breakpoints.
> 
> Also I feel like uprobes may be concerned as well as it seems to make use
> of event.hw->target after pmu::init().

Can't we simply swizzle event.hw->target along too?
