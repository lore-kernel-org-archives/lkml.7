Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE343C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAF32087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562772852;
	bh=u3p6fk/eNzvNwJBVFwrcRvH5vQ9TKbqI7pjV0FMUxXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j1O5w4BKozw0yFF41OV5wypxXB0iy7Ov6bFzZ0Yn0ySRxhCSYt3aOqmlNV0RvHm0w
	 QL8GQfBVWy1X36dvKSKeTxRBIYKniOCl9QLodFnbKbMyfcHEdSBMmbQylI2znBkY28
	 JSi0EOqLLCLwxxm924SA+tBD7TQhG2+wpbRvLecQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfGJPeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfGJPeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:34:11 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C752620844;
        Wed, 10 Jul 2019 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562772850;
        bh=u3p6fk/eNzvNwJBVFwrcRvH5vQ9TKbqI7pjV0FMUxXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xB9CdbEClpPfPI0vPARiZ0gwN6+7iFKMa/Q6vtKPEn+BTk071lxLLim3DRSs5rhGS
         YEMhJDQPf6WlV+/PbkAiF+Emt36Savs17iN3blCrw90XwIX8/5HALkRQchW0YUyLlX
         EhuZwYyyY8wVp/MmFhbfhELslk2Fn6Hd4ryQxDhQ=
Date:   Wed, 10 Jul 2019 17:34:07 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20190710153406.GA18838@lenoir>
References: <20190709134821.8027-1-frederic@kernel.org>
 <20190710140421.GP3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710140421.GP3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 04:04:21PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 09, 2019 at 03:48:19PM +0200, Frederic Weisbecker wrote:
> > 
> > Syzbot has found a breakpoint overcommit issue:
> > 
> > https://lore.kernel.org/lkml/000000000000639f6a0584d11b82@google.com/
> > 
> > It took me a long time to find out what the actual root problem was. Also
> > its reproducer only worked on a few month old kernel but it didn't feel like
> > the issue was actually solved.
> > 
> > I eventually cooked a reproducer that works with latest upstream, see in
> > the end of this message.
> > 
> > The fix is just a few liner but implies to shut down the context swapping
> > optimization for contexts containing breakpoints.
> > 
> > Also I feel like uprobes may be concerned as well as it seems to make use
> > of event.hw->target after pmu::init().
> 
> Can't we simply swizzle event.hw->target along too?

You mean remove it? But it's still needed by breakpoint code during all the event
lifecycle (init, destroy and anytime in-between).

I wish we could use event->ctx->task instead but on pmu::init() there is no ctx yet (we could pass
the task in parameter though) and on event->destroy() it's TASK_TOMBSTONE and retrieving the task
at that time would be non trivial.
