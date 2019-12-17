Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A4C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905A92146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfLQPyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:54:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34465 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726925AbfLQPyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:54:46 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBHFq7oS013359
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 10:52:08 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D856A420821; Tue, 17 Dec 2019 10:52:06 -0500 (EST)
Date:   Tue, 17 Dec 2019 10:52:06 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
Message-ID: <20191217155206.GA824812@mit.edu>
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191216114636.GB1515069@kroah.com>
 <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
 <20191216201834.GA785904@mit.edu>
 <46e8f6b3-46ac-6600-ba40-9545b7e44016@i-love.sakura.ne.jp>
 <CACT4Y+ZLaR=GR2nssb_buGC0ULNpQW6jvX0p8NAE-vReDY5fPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZLaR=GR2nssb_buGC0ULNpQW6jvX0p8NAE-vReDY5fPA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 09:36:43AM +0100, Dmitry Vyukov wrote:
> Yes, what Tetsuo says. Only syscall numbers and top-level arguments to
> syscalls are easy to filter out. When indirect memory is passed to
> kernel or (fd,ioctl) pairs are involved it boils down to solving the
> halting problem.

I disagree that it's equivalent to solving the halting problem.
Otherwise, we couldn't filter in the kernel.  Let's think about ways
we can solve this.  One is to simply do what valgrind does; this
handles even self-modifying code, since you're essentially running an
x86-to-x86 emulator, and then you find an attempted trap to the
kernel, you can transfer control to a program which vets the arguments
to the system call.

Another approach might be to do this filtering in an BPF hook
installed at syscall entry.  Technically this is being done in the
kernel, but the advantage of this approach is that the BPF program can
be distributed alongside Syzkaller, and it can be Syzkaller-specific.
That way when we need to add a new blacklist entry, it can be done
without needing to wait for a kernel patch.

And note that there may *always* be some ioctls which we will need to
suppress.  For example, an attempt to send a SANITIZE ERASE to a
storage device; or an attempt to freeze the root file system, etc.
And I'm not sure all of these are ones that we can prevent by using
the lockdown setting.  There may very well be some commands that a
legitamate system administrator might want to execute that will, when
executed in the wrong circumstances causes the system to crash.  But
so long as it doesn't violate the trusted boot semantics which are the
whole point of lockdown, we would need to allow them.

So I suspect that some kind of filtering which is Syzkaller specific
is going to be inevitably needed, if you want to throw random binary
code and see what causes problem, and you insist on allowing these
random binary bits to be run as root.  Trying to prevent root from
being able to kill or self-DOS a machine goes way beyond any of our
current security mechanisms, and is something which is only really
needed by Fuzzers.  Personally, I suspect some kind of BPF filtering
is probably your best bet, since it will a bit more architecturally
portable than using some kind of Valgrind-like approach.  (Although
Valgrind *does* most of the architectures that I suspect we're going
to care about.)

						- Ted
