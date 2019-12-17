Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC0AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E971B2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bkG2AteH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfLQIx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:53:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33251 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfLQIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:53:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so6637427qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 00:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNkD7ydP3s/P+FetLy4J67pZ0T8hiY+n2ErAKxQuVEg=;
        b=bkG2AteHw4Jpg1XcJauq7J4nY5gH1TKhZ3WVi8kfM6fLsvsgO6bNC2sdaQxi0c5/pA
         v1C7dfujIlLRNbt+9eJCANTbIP+GD5P6yassTyK7frUrBAT9CnY8ibWbpG1NzgnWq17+
         wggT4eGpcTzVCkXEz6oWCDEVckUxP9WLq99PjE47RcGwq5cBcR4nv3KlXwQNd7J7qbIq
         KgUWacbStzQR2rkHzO9AZigawrc/CJS0UpMiMZYOHfwyDcmKa5QP3VlCvOGsVLhzl+1/
         za7r8lKMw5fNqlyZGvVgBD7Zo0qWgsaYdlnvnLvfMywJ3elkrJ+oVGGK/F1ja2A7S/FK
         bhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNkD7ydP3s/P+FetLy4J67pZ0T8hiY+n2ErAKxQuVEg=;
        b=hNDrTGuKY+MKoNWtrUm2PiG0vJkbGZF+4L+X8aXbs3N3Sks+glDuV7ocY3O5HSHn/0
         xlyShWZpj/ph0suXz8FfATxoN0fcNb3JFOBRl6+QBd4gJeQBLJ1MSnsxRwMyii+qejUV
         QO6Z3oEZJNfFV0QoZ5GznZ1OdCjkoflk7qNf61EEUVdzI7BulcffYLX4lXXzAFOaI0oD
         mmoxOkzPKxxE3OHKnf79VB+wmQnNxLLQyuqhYynUHDevgKr5y/VZg8tFl1PFSCDQubb+
         9EtUOh7A13Zi0Kt/4hn5yjtYsC5pR5gAIJAiy4QDt2ap+3m+BJlV0EKL67BGrsLiao+9
         ki4Q==
X-Gm-Message-State: APjAAAXsGlt974ZhBTxj8y/YHezM4R6IHGGjv1bDDOZ7LBUcOgAJD1PO
        oWCMMEi/BHqY9muMB35nlaxYfzqnQUMFmAl6CkgYDA==
X-Google-Smtp-Source: APXvYqzwIKj2HlrC5Ps/42sQm/GCab8Hi8O3ZXrKhX4W/OpGA6wAQ42L51BFJyup5T3ckn098vmWK456DxicbQZN5Zg=
X-Received: by 2002:ac8:6691:: with SMTP id d17mr3369786qtp.57.1576572834197;
 Tue, 17 Dec 2019 00:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191216114636.GB1515069@kroah.com> <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
 <20191216201834.GA785904@mit.edu> <46e8f6b3-46ac-6600-ba40-9545b7e44016@i-love.sakura.ne.jp>
 <CACT4Y+ZLaR=GR2nssb_buGC0ULNpQW6jvX0p8NAE-vReDY5fPA@mail.gmail.com>
In-Reply-To: <CACT4Y+ZLaR=GR2nssb_buGC0ULNpQW6jvX0p8NAE-vReDY5fPA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Dec 2019 09:53:42 +0100
Message-ID: <CACT4Y+Y1NTsRmifm2QLCnGom_=TnOo5Nf4EzQ=7gCJLYzx9gKA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andi Kleen <ak@linux.intel.com>, matthewgarrett@google.com
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
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

On Tue, Dec 17, 2019 at 9:36 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Dec 16, 2019 at 10:07 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > On 2019/12/17 5:18, Theodore Y. Ts'o wrote:
> > >> this case was too hard to blacklist, as explained at
> > >> https://lore.kernel.org/lkml/4d1a4b51-999b-63c6-5ce3-a704013cecb6@i-love.sakura.ne.jp/ .
> > >> syz_execute_func() can find deeper bug by executing arbitrary binary code, but
> > >> we cannot blacklist specific syscalls/arguments for syz_execute_func() testcases.
> > >> Unless we guard on the kernel side, we won't be able to re-enable syz_execute_func()
> > >> testcases.
> > >
> > > I looked at the reference, but I didn't see the explanation in the
> > > above link about why it was "too hard to blacklist".  In fact, it
> > > looks like a bit earlier in the thread, Dmitry stated that adding this
> > > find of blacklist "is not hard"?
> > >
> > > https://lore.kernel.org/lkml/CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com/
> > >
> >
> > That thread handled two bugs which disabled console output.
> >
> > The former bug (March 2019) was that fuzzer was calling syslog(SYSLOG_ACTION_CONSOLE_LEVEL) and
> > was fixed by blacklisting syslog(SYSLOG_ACTION_CONSOLE_LEVEL). This case was easy to blacklist.
> >
> > The latter bug (May 2019) was that fuzzer was calling binary code (via syz_execute_func()) which
> > emdebbed a system call that changes console loglevel. Since it was too difficult to blacklist,
> > syzkaller gave up use of syz_execute_func().
>
>
> Yes, what Tetsuo says. Only syscall numbers and top-level arguments to
> syscalls are easy to filter out. When indirect memory is passed to
> kernel or (fd,ioctl) pairs are involved it boils down to solving the
> halting problem.
>
> There are some nice benefits of doing this in some form in kernel:
> 1. It makes reported crashes more trustworthy for kernel developers.
> Currently you receive a crash and you don't know if it's a bug, or
> working as intended (as turned out with serial console). It also
> happened with syzkaller learning interesting ways to reach /dev/mem,
> which was directly prohibited, but it managed to reach it via some
> mounts and corrupted file names. Disabling the DEVMEM config in the
> end reliably solved it once and for all.
>
> 2. It avoids duplication across test systems. Doing this in each test
> system is again makes kernel testing hard and imposes duplication.
> Tomorrow somebody runs new version of trinity, triforce, afl, perf
> fuzzer and they hit the same issues, you get the same reports, and
> have the same discussions and they slowly build the same list.
>
> I like the idea of runtime knob that Andi proposed, and in fact this
> looks quite similar to lockdown needs. And in fact it already have
> LOCKDOWN_TIOCSSERIAL (does it does exactly the same as what we need?
> if not, it may be something to improve in lockdown). It seems that any
> fuzzing needs at least LOCKDOWN_INTEGRITY_MAX.
>
> Could we incorporate some of the checks in this patch into lockdown?
> FWIW we've just disabled sysrq entirely:
> https://github.com/google/syzkaller/blob/master/dashboard/config/bits-syzbot.config#L182
> because random packets over usb can trigger a panic sysrq (again
> almost impossible to reliably filter these out on fuzzer side).
>
> Not sure why lockdown prohibits parts of TIOCSSERIAL. Does it want to
> prevent memory corruption, or also prevent turning off console output
> (hiding traces)? If the latter then it may be reasonable to lockdown
> lowering of console_loglevel.
>
> But looks at some of the chunks here, it seems that we want something
> slightly orthogonal to lockdown integrity/confidentiality, which
> liveness/dos-prevention (can't accidentally bring down the whole
> machine). E.g. FIFREEZE or bad SYSRQs.
>
> There was some reason I did not enable lockdown when it was merged.
> Now looking at the list again: LOCKDOWN_DEBUGFS is a no-go for us...

+Matthew for a lockdown question
We are considering [ab]using lockdown (you knew this will happen!) for
fuzzing kernel. LOCKDOWN_DEBUGFS is a no-go for us and we may want a
few other things that may be fuzzing-specific.
The current inflexibility comes from the global ordering of levels:

if (kernel_locked_down >= level)
if (kernel_locked_down >= what) {

Is it done for performance? Or for simplicity?
If it would be more like an arbitrary bitset, then we could pick and
choose what we need and add few options on the side (not part of
integrity/confidentiality).
I see several potential ways to do it:
1. Rework the current code to allow arbitrary sets of options enabled.
2. Leave the current global ordering and checks intact and add a
separate mode that will do bitmask-like checks (e.g. under
CONFIG_LOCK_DOWN_FUZZER).
3. Or hardcode the fuzzer list statically based on config (but then we
can leave the rest of the code intact), e.g.:

#if !CONFIG_LOCK_DOWN_FUZZER
    [LOCKDOWN_DEBUGFS] = "debugfs access",
#endif
#if CONFIG_LOCK_DOWN_FUZZER
    [LOCKDOWN_FIFREEZE] = "FIFREEZE ioctl",
#endif

Thoughts?
