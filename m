Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EF5C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 09:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFEA214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 09:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576314553;
	bh=KXapgZ5wa/CHWIJkkCqSz3nxqCMnVgdxZgRPpPKDirk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LAViYKC01MZ0HpzJdjKuJtoralWmFatSAieYrYr9GjRkC3yT/+unIG8z90ds/gCb+
	 IHNP8pOMdtbJayStN03miQVSHWJKq432E+/2q4Gvd4VZUhUuz+km8w0DILI1hA/I4I
	 Huojt2rzy+zJdlJRXR/NK0e8Ljj0jeHlooKmgBq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfLNJJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 04:09:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfLNJJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 04:09:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38F5C214AF;
        Sat, 14 Dec 2019 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576314548;
        bh=KXapgZ5wa/CHWIJkkCqSz3nxqCMnVgdxZgRPpPKDirk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJ9RVWIwgqRAYJaW+sAzGE4p9bKbUM1pk1X2KwWduS9/R55jJlDTU4Urs4gK1Nynd
         PqD5aYZjDVT0ECZoIuxgIQvDnquu+nodF94hzd3sJOZBKNs/31WwbHmsHQBvx6sQoj
         OzL3/wcPUMC8PzT8JKG2GMmvwqhdLy7r8pu1ccNk=
Date:   Sat, 14 Dec 2019 10:09:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+f4f1e871965064ae689e@syzkaller.appspotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asierra@xes-inc.com, ext-kimmo.rautkoski@vaisala.com,
        Jiri Slaby <jslaby@suse.com>,
        kai heng feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        mika.westerberg@linux.intel.com, o.barta89@gmail.com,
        paulburton@kernel.org, sr@denx.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yegorslists@googlemail.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 mem_serial_out
Message-ID: <20191214090905.GA3322570@kroah.com>
References: <00000000000053539a0599173973@google.com>
 <20191212105701.GB1476206@kroah.com>
 <CACT4Y+ZeR=z-3CSXFazmngUhs9DqfxgZLKBNhzvfg49Nrw=EzA@mail.gmail.com>
 <20191213093357.GB2135612@kroah.com>
 <CACT4Y+beoeY9XwbQX7nDY_5EPMQwK+j3JZ9E-k6vhiZudEA1LA@mail.gmail.com>
 <74859736-478a-6ad7-f0be-cfe87ec40ff5@i-love.sakura.ne.jp>
 <20191213160700.GA2632926@kroah.com>
 <4f514a5a-af11-e688-8f8d-72bbadadc889@i-love.sakura.ne.jp>
 <20191214075517.GA3314866@kroah.com>
 <8b130791-d48a-6505-f3f1-d08cada23d8d@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b130791-d48a-6505-f3f1-d08cada23d8d@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 05:39:02PM +0900, Tetsuo Handa wrote:
> On 2019/12/14 16:55, Greg KH wrote:
> >>>> That suggestion got no response for two months.
> >>>>
> >>>>   https://lkml.kernel.org/r/3e4e2b6b-7828-54ab-cf28-db1a396d7e20@i-love.sakura.ne.jp
> >>>>
> >>>> Unless we add such kernel config option to upstream kernels, it will become
> >>>> a whack-a-mole game.
> >>>
> >>> It will be a whack-a-mole game no matter what.
> >>>
> >>> Yes, /dev/mem/ makes no sense to fuzz.  Neither does other things (like
> >>> serial port memory addresses.)
> >>
> >> /dev/mem makes sense to fuzz. Ditto for other things.
> > 
> > What?  What are you going to find if you randomly start to write to
> > /dev/mem?  How are we supposed to "fix" that?
> > 
> 
> When did I say "writing to random addresses" ? If you saw my suggestion, you
> will find that "fuzzer will be able to test reading from random addresses,
> writing to safe addresses (in order to find new lock dependency which would
> otherwise be unnoticed)".

I don't remember the suggestion specifically, sorry.  But how would you
figure out what those "safe addresses" really are?  They will change on
every single platform.

And why would this even help anything?  What lock dependency?

> Disabling everything using kernel config option is overkill. What you are saying
> is "never try to fuzz USB drivers" by excluding USB drivers from fuzz targets.

I never said that.

> There is no need to disable whole tests. We need to exclude only stupid operations
> (e.g. forever repeating SysRq-t) from fuzz targets.

Ok, like I said, configuring serial ports as root is a stupid operation
to think it is totally safe :)

> >>> You just will have a list of things that you "do not fuzz as these are
> >>> dangerous".  Nothing new here, any os will have that.
> >>
> >> The list of kernel config options will become too complicated to maintain.
> >> If we can have one kernel config option, we can avoid maintaining
> >> the list of kernel config options (which keeps changing over time).
> > 
> > Use the newly added security_locked_down() call, that gives you a great
> > indication that root can cause problems for those things.
> > 
> 
> No. security_locked_down() is not for fuzz kernels but for real kernels.

Yes, but it gives you a huge hint that this is something that you could
do as root that is "bad" and can harm the system.

> "enum lockdown_reason" is overkill, it just keeps fuzzers away from finding bugs.
> For example, if ftrace code has bugs but ftrace_event_open() prevents from
> fuzzing due to security_locked_down(LOCKDOWN_TRACEFS) ? Fuzz kernels should not
> count on security_locked_down() returning errors. That is no different from
> disabling everything using kernel config options.

They all might not be correct, but again they provide a hint.

> > And it's not a config thing, it's a functionality thing within features,
> > as is explicitly shown by this very thread for the serial port memory
> > location.
> 
> My suggestion is not for real kernels but for fuzz kernels.

So fuzz kernels are not real?  :)
