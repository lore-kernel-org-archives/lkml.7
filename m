Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA899C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA9C2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfC1UMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfC1UMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:12:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CEED206BA;
        Thu, 28 Mar 2019 20:12:30 +0000 (UTC)
Date:   Thu, 28 Mar 2019 16:12:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.0 011/262] tracing: kdb: Fix ftdump to not
 sleep
Message-ID: <20190328161228.24f5aabd@gandalf.local.home>
In-Reply-To: <CAD=FV=UzS8qfC2yxep9vhp2QYw9Jy+RHsOgGF5ND2vV1OhYK5Q@mail.gmail.com>
References: <20190327180158.10245-1-sashal@kernel.org>
        <20190327180158.10245-11-sashal@kernel.org>
        <20190328101342.GD19456@atrey.karlin.mff.cuni.cz>
        <CAD=FV=UzS8qfC2yxep9vhp2QYw9Jy+RHsOgGF5ND2vV1OhYK5Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 12:45:18 -0700
Doug Anderson <dianders@chromium.org> wrote:

> > I see solution is simple, but now we have a loop with GFP_ATOMIC
> > allocations inside. How many "tracing spus" is this expected to loop
> > over? Will not it exhaust atomically available pages and reliably fail
> > in common configurations?
> >                                                                 Pavel  
> 
> Each one of these allocations is ~32 bytes and you do one per CPU.
> Even with systems with a lot of CPUs that's not going to be tons.
> ...and you only do it with GFP_ATOMIC when you're actively dropped
> into kdb and debugging.  It seems like going for simplicity is the
> right call here, but of course if Steven or Daniel say that it has to
> be done a different way then they're the true authorities.

I really don't care. The code in question is only affected when we have
CONFIG_KGDB_KDB enabled. But as it gets called from an atomic context,
is it any different than what it was doing before? Except now with
GFP_ATOMIC it is actually safer.

Now, we could add some helper functions in the ring-buffer code to
allow us to pre-allocate the ring_buffer_iter at boot up. Then we could
pass in the per-allocated iters and use them here.

-- Steve
