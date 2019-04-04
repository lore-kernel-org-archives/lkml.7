Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF70C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D76206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbfDDN3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:29:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60357 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbfDDN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:29:48 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D679380402; Thu,  4 Apr 2019 15:29:38 +0200 (CEST)
Date:   Thu, 4 Apr 2019 15:22:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.0 011/262] tracing: kdb: Fix ftdump to not sleep
Message-ID: <20190404132202.GC6124@xo-6d-61-c0.localdomain>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-11-sashal@kernel.org>
 <20190328101342.GD19456@atrey.karlin.mff.cuni.cz>
 <CAD=FV=UzS8qfC2yxep9vhp2QYw9Jy+RHsOgGF5ND2vV1OhYK5Q@mail.gmail.com>
 <20190328161228.24f5aabd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328161228.24f5aabd@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-03-28 16:12:28, Steven Rostedt wrote:
> On Thu, 28 Mar 2019 12:45:18 -0700
> Doug Anderson <dianders@chromium.org> wrote:
> 
> > > I see solution is simple, but now we have a loop with GFP_ATOMIC
> > > allocations inside. How many "tracing spus" is this expected to loop
> > > over? Will not it exhaust atomically available pages and reliably fail
> > > in common configurations?
> > >                                                                 Pavel  
> > 
> > Each one of these allocations is ~32 bytes and you do one per CPU.
> > Even with systems with a lot of CPUs that's not going to be tons.
> > ...and you only do it with GFP_ATOMIC when you're actively dropped
> > into kdb and debugging.  It seems like going for simplicity is the
> > right call here, but of course if Steven or Daniel say that it has to
> > be done a different way then they're the true authorities.
> 
> I really don't care. The code in question is only affected when we have
> CONFIG_KGDB_KDB enabled. But as it gets called from an atomic context,
> is it any different than what it was doing before? Except now with
> GFP_ATOMIC it is actually safer.
> 
> Now, we could add some helper functions in the ring-buffer code to
> allow us to pre-allocate the ring_buffer_iter at boot up. Then we could
> pass in the per-allocated iters and use them here.

Ok, I guess 32 bytes is small enough, I somehow imagined it would be bigger...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
