Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6675AC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372F12173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QFaUc9Ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfGPNuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 09:50:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGPNuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 09:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nRNVG3ngckJGHDTaDN4r3SwJmt11DhvPAF9IOrGs9r0=; b=QFaUc9KsTQPUWkeWXOBYhg6X6
        hZ6GYsmTK6GTDCWU9qWUZDBa7iincMWNqeIgpGJ5MsyBRSxPjxD++L7PzQX4s5d+DW7CZfkoiv/c7
        pW/VGldkzgcXhXaN75TH340U4Rei+Zc4FyHVmXWqAT3WyuwGdAKdOLxb7oHZjbv8B8Xie8rlYxYRz
        O3kYFS13Bi8ExZSaRjSzcPeIOyi5rw7dnUVQxTjZFbTS1t8vlP9IYdAVEYp7s/Bqem2zZ6kzDzlOz
        tqSk8ErZAivXBVRop7mQLKX3XlDAg8+E8IjasrxtIi/tSebbtZItxxJvd9hpfDIVVXOPZraRho/g2
        bwG/e64AQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnNqb-0001cO-5D; Tue, 16 Jul 2019 13:50:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 814782059DEA3; Tue, 16 Jul 2019 15:50:23 +0200 (CEST)
Date:   Tue, 16 Jul 2019 15:50:23 +0200
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
Message-ID: <20190716135023.GD3402@hirez.programming.kicks-ass.net>
References: <20190709134821.8027-1-frederic@kernel.org>
 <20190710140421.GP3402@hirez.programming.kicks-ass.net>
 <20190710153406.GA18838@lenoir>
 <20190711105305.GY3402@hirez.programming.kicks-ass.net>
 <20190715124737.GN3463@hirez.programming.kicks-ass.net>
 <20190716134219.GB4000@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716134219.GB4000@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 03:42:20PM +0200, Frederic Weisbecker wrote:
> On Mon, Jul 15, 2019 at 02:47:37PM +0200, Peter Zijlstra wrote:
> > On Thu, Jul 11, 2019 at 12:53:05PM +0200, Peter Zijlstra wrote:
> > > > I wish we could use event->ctx->task instead but on pmu::init() there
> > > > is no ctx yet (we could pass the task in parameter though) 
> > > 
> > > Right, that should be fairly easy.
> > > 
> > > > and on event->destroy() it's TASK_TOMBSTONE and retrieving the task at
> > > > that time would be non trivial.
> > > 
> > > Well, right, we can maybe make TOMBSTONE be the LSB instead of the whole
> > > word, then we can recover the task pointer... *yuck* though.
> > 
> > Something like the attached, completely untested patches.
> > 
> > I didn't do the hw_breakpoint bit, because I got lost in that, but this
> > basically provides what you asked for I think.
> > 
> 
> Thanks they look good! I can take them and work on top if you like.

please do.
