Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69438C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304F0222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxHTnnM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLSRnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:43:51 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44809 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSRnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:43:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id w127so5297644qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMQLOjAc52BEkbIXwe9WEn1rTF5tDPQUn9wNWXoAVgo=;
        b=HxHTnnM778CS0YLIBPbHrShJm+w6KgwHnXc7yhVi9h7vldj0JSQWOJFnVABrm56f2z
         O1q4p72OUQcEdTlU6Q98eDRoka0q/JGdb/7K0U0DBYLOsGANqoCg9olFDWozaniANeNk
         QZSP0k5KzTNLpuuy54jBKyU8V0RDRpiB6WY8H5K7J3u+lWTSCxCRFF9RpS5jmAznRQF8
         89lbzyBnoaBcz8pb1YzPdNmsvEPgr02Fzeo9TGofYsax/BCiOeMOLzUlREuu8AZDFdOn
         b5G6RI3SD/WqR4LusJmQhS3xkx3WX0ulAuh6OLJ79pI4CvpIExQQ5feJ0VbDScTUC7qC
         +mrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMQLOjAc52BEkbIXwe9WEn1rTF5tDPQUn9wNWXoAVgo=;
        b=Rd30oFVPY5/LrAeNH11PXdw6muMq9ke8mIcEhhyiu3FP9OM2j0jXzOF2fBiP8QjlqL
         aBPIXbgURriBs0DepfXmySmfzzeI4A+pODOJNYngj6Ex9zS0OCbSAA/pEarPCdVgrME6
         to/2yii3HIu1wyh3TKzz8GVTGb2NcJIXtdGKrkeWbg2y01VtcUyK1Hb5oRInwrsr8tvu
         W80bcGXv1h+VtuePrFBegJS/PZIGb8A7Fya9Rq6+ARTqd3T7pMvbc4L1+ocA+qdsh12O
         nAywZdOVR52+CNIfX96v6Jsa+IW8uBQff+gONZAz3lw2cvTBU89fOHu5+bOHWR9GwaET
         OFEQ==
X-Gm-Message-State: APjAAAWHtxhTWFkcKFYZnYBrPQjOuljIfu+lW6thUJkuEx0obWd4mzuT
        3T+6wGeflzLs5yC00ovLy3XrMvypiqSKS4cacy6dxg==
X-Google-Smtp-Source: APXvYqwpGKTwI4piH2wyWOdggYlPmifRTXzvtU42hnSKttoWtO+9Ai9tC8XxDn7e+38snSjwjyMjH/hm2jEYK8I+0Hk=
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr9069275qkg.43.1576777428950;
 Thu, 19 Dec 2019 09:43:48 -0800 (PST)
MIME-Version: 1.0
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191216114636.GB1515069@kroah.com> <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
 <20191216201834.GA785904@mit.edu> <46e8f6b3-46ac-6600-ba40-9545b7e44016@i-love.sakura.ne.jp>
 <CACT4Y+ZLaR=GR2nssb_buGC0ULNpQW6jvX0p8NAE-vReDY5fPA@mail.gmail.com> <20191217155206.GA824812@mit.edu>
In-Reply-To: <20191217155206.GA824812@mit.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 Dec 2019 18:43:37 +0100
Message-ID: <CACT4Y+Yb8Lt2V3RB+wmOXLJ4T9VT_MjYaH0T5MkVsYo9=7XW7Q@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 4:52 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Dec 17, 2019 at 09:36:43AM +0100, Dmitry Vyukov wrote:
> > Yes, what Tetsuo says. Only syscall numbers and top-level arguments to
> > syscalls are easy to filter out. When indirect memory is passed to
> > kernel or (fd,ioctl) pairs are involved it boils down to solving the
> > halting problem.
>
> I disagree that it's equivalent to solving the halting problem.
> Otherwise, we couldn't filter in the kernel.  Let's think about ways
> we can solve this.  One is to simply do what valgrind does; this
> handles even self-modifying code, since you're essentially running an
> x86-to-x86 emulator, and then you find an attempted trap to the
> kernel, you can transfer control to a program which vets the arguments
> to the system call.

I don't know where to start :)

1. We don't run/have x86-to-x86 emulator and syzkaller is currently
supported on 6 architectures.
2. Complexity of this is very high (as compared to an if in kernel).
3. Valgrind-like solutions are a source of constant maintenance work
(we maintained valgrind for year at google).
4. Adding new architectures will be much harder.
5. All of this will need to be part of all C reproducers as well
(thousands of lines of intricate code, I think it was you who
complained about the complexity of even current C reproducers).
6. To not make this part of all reproducers we would need to run the
checking ahead of time (but this requires building complete and
precise kernel model and won't handle non-determinism; this is why I
referred to the "halting problem" assuming you don't want this in
reproducers).
7. This won't handle raciness between our checks and what kernel
really observes (i.e. we infer different fd type for ioctl, or we read
different data from memory).
8. This won't solve the problem of trust. If you receive this very
complex piece of code, will you be 100% sure that it's not syzkaller's
fault but a kernel bug that worth your time looking at.

So as far as I see this is both very complex and won't really work.

> Another approach might be to do this filtering in an BPF hook
> installed at syscall entry.  Technically this is being done in the
> kernel, but the advantage of this approach is that the BPF program can
> be distributed alongside Syzkaller, and it can be Syzkaller-specific.
> That way when we need to add a new blacklist entry, it can be done
> without needing to wait for a kernel patch.

This is subject to most of the same problem.
E.g. these BPF programs will need to be part of all reproducers, so
you will need to compile them for your kernel and install before
running reproducers. Also racy wrt what we observe and what kernel
acts on. Again some trust problems (it is still complex). Building and
using syzkaller will be harder.

We need to keep in mind that we are comparing this with is a simple if
in kernel code.


> And note that there may *always* be some ioctls which we will need to
> suppress.  For example, an attempt to send a SANITIZE ERASE to a
> storage device; or an attempt to freeze the root file system, etc.
> And I'm not sure all of these are ones that we can prevent by using
> the lockdown setting.  There may very well be some commands that a
> legitamate system administrator might want to execute that will, when
> executed in the wrong circumstances causes the system to crash.  But
> so long as it doesn't violate the trusted boot semantics which are the
> whole point of lockdown, we would need to allow them.
>
> So I suspect that some kind of filtering which is Syzkaller specific
> is going to be inevitably needed, if you want to throw random binary
> code and see what causes problem, and you insist on allowing these
> random binary bits to be run as root.  Trying to prevent root from
> being able to kill or self-DOS a machine goes way beyond any of our
> current security mechanisms, and is something which is only really
> needed by Fuzzers.  Personally, I suspect some kind of BPF filtering
> is probably your best bet, since it will a bit more architecturally
> portable than using some kind of Valgrind-like approach.  (Although
> Valgrind *does* most of the architectures that I suspect we're going
> to care about.)

We can easily filter out syscall numbers and top level syscall
argument values (executing random binary code aside, as we gave up on
this for now). That's what we use to filter out reboot syscalls and
FIFREEZE ioctl (fortunately the value does not collide with any other
ioctl we have _for now_). This is done by scanning the test case and
fixing it if necessary (all the necessary data is already there).
