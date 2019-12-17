Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E507C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1CA2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLQW5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:57:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52422 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfLQW5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:57:48 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihLmh-0002V7-8m; Tue, 17 Dec 2019 22:57:43 +0000
Date:   Tue, 17 Dec 2019 22:57:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jesse Barnes <jsbarnes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] remove ksys_mount() and ksys_dup()
Message-ID: <20191217225743.GD4203@ZenIV.linux.org.uk>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <157644301187.32474.6697415383792507785.pr-tracker-bot@kernel.org>
 <CAJmaN=ksaH5AgRUdVPGWKZzjEinU+goaCqedH1PW6OmKYc_TuA@mail.gmail.com>
 <CAHk-=wgjNqEfaVssn1Bd897dGFMVAjeg3tiDWZ7-z886fBCTLA@mail.gmail.com>
 <CAJmaN=mNVJVGPkwYvE6PmQSgT8o3Uo3=1iQm2NFicZ2fFC6Pxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmaN=mNVJVGPkwYvE6PmQSgT8o3Uo3=1iQm2NFicZ2fFC6Pxw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 02:21:03PM -0800, Jesse Barnes wrote:
> > and yes,that particular problem only triggers when you have some odd
> > root filesystem without a /dev/console. Or a kernel config that
> > doesn't have those devices enabled at all.
> >
> > I delayed pulling it for a couple of days, but the branch was not in
> > linux-next, so my delay didn't make any difference, and all these
> > things only became obvious after I pulled. And while it was all
> > horribly buggy, it was only buggy for the "these cases don't happen in
> > a normal distro" case, so the regular use didn't show them.
> >
> > My bad. I shouldn't have pulled this, but it all looked very obvious
> > and trivial.
> 
> Oh I should have caught that too, I was looking right at it...
> 
> But anyway it looks like a nice cleanup with a few more fixes.
> Hopefully we can get there soon...

FWIW, this is precisely what I'd been talking about[*] - instead of
a plain "we are reusing the damn syscall, with fixed interface and
debugged by userland all the time" we'd got an open-coded analogue
that will be a headache (and a source of bitrot) for years.

It's not a normal part of the kernel, and I bloody well remember
what kind of headache it had been before it got massaged to use
of plain syscalls.  Constant need to remember that a change in
VFS guts might break something in the code that is hell to
debug - getting test coverage for it is not fun at all.  As we
are seeing right now...

Seriously, these parts of init/* ought to be treated as userland code
that runs in kernel mode mostly because it's too much PITA to arrange
building a static ELF binary and linking it into the image.


[*] "IMO it's not a good idea.  Exposing the guts of fs/namespace.c to
what's essentially a userland code that happens to run in kernel thread
is asking for trouble - we'd been there and it had been hell to untangle."

My fault, I guess - should've been more specific than that ;-/
