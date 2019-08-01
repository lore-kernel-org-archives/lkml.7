Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F08C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06677214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564651229;
	bh=YAamU4kuDlKkJoOK0xd1f7py4FkXYdYnuLBu/5WqDCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NXRQEuDrHsWdIqW3fd9QmZHr01MC7CNCiXoy1ueehBuNWcS09o8/bbmK6sr3tWqdc
	 7KboVgkkVg/ctKelrCZn0KjpJi4/ugl6sI4xJiZU695yPQ+N9R3lcE+sTVOy0Owt1o
	 9xct+8RUVyBEPHoUMNE35EEbLljQ5ucBGrjD3qb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbfHAJU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfHAJU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:20:27 -0400
Received: from localhost (unknown [84.241.203.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92A952087E;
        Thu,  1 Aug 2019 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564651226;
        bh=YAamU4kuDlKkJoOK0xd1f7py4FkXYdYnuLBu/5WqDCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l6ZBYmYM6s01H7FLbD8+3Pp2Ee1BLcOHk8b5C0beouw09r8JDp4Im0ceAVZTM/Nto
         zunV8/flUgg7HmXzcp+DuYu8re24DBq9M5LnUWheThSOZMkSx0b2VXqekbxE8Q6sTB
         z/8o7xO22yXSLUrr3JfNtmsRi40Gf6pwmPbqt/9g=
Date:   Thu, 1 Aug 2019 11:20:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 7/7] n_tty: Provide an informational line on VSTATUS
 receipt
Message-ID: <20190801092020.GB19329@kroah.com>
References: <20190625161153.29811-1-ar@cs.msu.ru>
 <20190625161153.29811-8-ar@cs.msu.ru>
 <20190730161940.GA15798@kroah.com>
 <20190731222359.GA20574@cello>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731222359.GA20574@cello>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 01:23:59AM +0300, Arseny Maslennikov wrote:
> On Tue, Jul 30, 2019 at 06:19:40PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 25, 2019 at 07:11:53PM +0300, Arseny Maslennikov wrote:
> > > If the three termios local flags isig, icanon, iexten are enabled
> > > and the local flag nokerninfo is disabled for a tty governed
> > > by the n_tty line discipline, then on receiving the keyboard status
> > > character n_tty will generate a status message and write it out to
> > > the tty before sending SIGINFO to the tty's foreground process group.
> > > 
> > > This kerninfo line contains information about the current system load
> > > as well as some properties of "the most interesting" process in the
> > > tty's current foreground process group, namely:
> > >  - its PID as seen inside its deepest PID namespace;
> > >    * the whole process group ought to be in a single PID namespace,
> > >      so this is actually deterministic
> > >  - its saved command name truncated to 16 bytes (task_struct::comm);
> > >    * at the time of writing TASK_COMM_LEN == 16
> > >  - its state and some related bits, procps-style;
> > >  - for S and D: its symbolic wait channel, if available; or a short
> > >    description for other process states instead;
> > >  - its user, system and real rusage time values;
> > >  - its resident set size (as well as the high watermark) in kilobytes.
> > 
> > Why is this really all needed as we have the SysRq handlers that report
> > all of this today?
> 
> Different use-cases have different needs; SysRq is targeted at a different
> audience; see below.
> 
> > > The "most interesting" process is chosen as follows:
> > >  - runnables over everything
> > >  - uninterruptibles over everything else
> > >  - among 2 runnables pick the biggest utime + stime
> > >  - any unresolved ties are decided in favour of greatest PID.
> > 
> > This does not feel like something that the tty core code should be doing
> > at all.
> 
> Yes, this selection part is quite clumsy. In defense of it, one could
> argue that we already have the whole n_tty implemented in kernel-space.

One could argue that :)

> One way we could get rid of this is to display a summarized statistic
> for the whole pgrp: pgid, oldest real time, cumulative utime and stime,
> cumulative memory usage. Would this be more acceptable? Are there any
> other ideas?

Given that I really think you are just making something up here that no
one really is needing for their workflow, but would just be "cool to
have", I say do whatever you think is right.

And there is nothing wrong with "cool to have" things, I'm not trying to
dismiss this, it's just that all new features come with the "you must
support this until the end of time" requirement that we must balance it
with.

> > > While the kerninfo line is not very useful for debugging the kernel
> > > itself, since we have much more powerful debugging tools, it still gives
> > > the user behind the terminal some meaningful feedback to a VSTATUS that
> > > works even if no processes respond.
> > 
> > That's what SysRq is for.  If there's a specific set of values that we
> > don't currently report in that facility, why not just add the
> > information there?  It's much simpler and "safer" that way.
> 
> SysRq is intended for the person either administrating the system to be used in
> emergency (e.g. f for the oom kill, the famous s-u-b combo also comes to
> mind) or debugging the kernel, and it indeed does a much better job for
> those purposes.  In both use-cases mentioned the person has access to
> the system console, where the sysrq button handlers produce all their
> output, if any, and to either a physical keyboard / serial console or to
> /proc/sysrq-trigger, whose mode is 0200 (writable by uid 0 only).
> 
> The use-case for this is different: the ^T-line as proposed by this
> patch is for the user that interacts with a system through a terminal, who
> wants to be informed not about the whole system (sort of what SysRq-t
> tells you), but about what they run on that particular tty.

Ok, fair enough, although if you just add a new sysrq option for "what
is running on this tty", would that help resolve this?

> This is much less about "why does my system/kernel seem to hang?" or
> exposing low-level internals (registers, hrtimers, locks, ...), and more
> about "is my SSH terminal session unresponsive?" and "I ran a command,
> it doesn't finish, how's it doing?".
> e.g. A user might want to know if their SSH connection is alive without
> interrupting anything, while having no access both to SysRq and console,
> and no one in fg pgrp actually handles SIGINFO.

If you have access to a tty, you should have access to sysrq, right?

> SysRq is system-wide, whereas this is per-terminal and only cares about
> one tty which the status char is pressed at and its foreground pgrp
> (most likely it's the foreground shell job).
> 
> I hope this is clear enough.

It is, yes.  My big objection is the crazy code I point out above, as
well as the "create a totally new interface when we might be able to use
an existing one" that you need to convince me is really required :)

thanks,

greg k-h
