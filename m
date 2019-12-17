Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A394C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D44207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qa6ECd+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLQIg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:36:59 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41675 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfLQIg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:36:58 -0500
Received: by mail-qk1-f195.google.com with SMTP id x129so141942qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 00:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbVfzTZcn3hSbLHjEmH7XZDjdG326YJ/AJHbF11uFvQ=;
        b=qa6ECd+JDm1z6s1gjbpEd22S+ojuuw8S9puxlRQdrmHhabYyQja5qHCOCyj381FSG4
         m9y9AJ9tfOzIh0HwUJd8N8L+qG+tHHvjedslcYJdUVloAiETiJIJvG3EH6+KhdbMJzkh
         XFDsAMsWSEg2uZQC8oeBjuMN0xH2obKG5c49BFfbPOKeVmweT46DglAd08yao9EfYl/L
         1Zy2Yfi3hEaxbUswl90dmqjzTl3j6ZG4OXN6zkDd2PvbVvxw1og1EngoJjh917VcuYxU
         kqurn0j9OuGk8UjM4i/rxoO8OhTp/nGG+NAkMfWgmp9gte0F012GtWTwndT/HcWSB+ko
         z0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbVfzTZcn3hSbLHjEmH7XZDjdG326YJ/AJHbF11uFvQ=;
        b=edoW4RUMaegzuDq5AlxmCPGAKHcbjjAv79Q1ziLQNro97hHssSkNu/+VKKXmp59E/O
         izoU9LYIRVbvdTA6Wyl/6HoNIwwDPhyli3cERIxVTKbEsFB4E7lg/BLBaTVRAcJRwzZF
         urbh4a0i9C7D+O8i32YITa1SfUI0O6oKilJZJIzEP/czDkTi4NlO5Vxw3QHBqC/TReXp
         ZaLPGb2pFWVBlYCBha+vZLtmyQJq4n/Xwk75FWubkm0fXCPbNWBXIRJkP5j5Wwf5c6sH
         0S01/7Q+bHVHDkN6yWo+k5aVKwRQcY7rSLiz0EQxaxuQNHt47C4oYliKPKB9Z5VXxf26
         W77Q==
X-Gm-Message-State: APjAAAW7GNRpnMdt+xOH9eFLvXbC2kEkDhiPzQxwi/pvvV1tCdUC7y2k
        1q6oEw7qqtJ0uvXhs7ZHHmUGtc/3KEgVWOK8EajtaQ==
X-Google-Smtp-Source: APXvYqwMrU+6JevF5OMgLsyF5Ym+c6BW+KDr+ndyJmGhamtDLe9VN/a2g5bRv//EPoX9J6ifQ229wfuCrAZCDiRe6tA=
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr3679145qkg.43.1576571815571;
 Tue, 17 Dec 2019 00:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191216114636.GB1515069@kroah.com> <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
 <20191216201834.GA785904@mit.edu> <46e8f6b3-46ac-6600-ba40-9545b7e44016@i-love.sakura.ne.jp>
In-Reply-To: <46e8f6b3-46ac-6600-ba40-9545b7e44016@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Dec 2019 09:36:43 +0100
Message-ID: <CACT4Y+ZLaR=GR2nssb_buGC0ULNpQW6jvX0p8NAE-vReDY5fPA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andi Kleen <ak@linux.intel.com>
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

On Mon, Dec 16, 2019 at 10:07 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/12/17 5:18, Theodore Y. Ts'o wrote:
> >> this case was too hard to blacklist, as explained at
> >> https://lore.kernel.org/lkml/4d1a4b51-999b-63c6-5ce3-a704013cecb6@i-love.sakura.ne.jp/ .
> >> syz_execute_func() can find deeper bug by executing arbitrary binary code, but
> >> we cannot blacklist specific syscalls/arguments for syz_execute_func() testcases.
> >> Unless we guard on the kernel side, we won't be able to re-enable syz_execute_func()
> >> testcases.
> >
> > I looked at the reference, but I didn't see the explanation in the
> > above link about why it was "too hard to blacklist".  In fact, it
> > looks like a bit earlier in the thread, Dmitry stated that adding this
> > find of blacklist "is not hard"?
> >
> > https://lore.kernel.org/lkml/CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com/
> >
>
> That thread handled two bugs which disabled console output.
>
> The former bug (March 2019) was that fuzzer was calling syslog(SYSLOG_ACTION_CONSOLE_LEVEL) and
> was fixed by blacklisting syslog(SYSLOG_ACTION_CONSOLE_LEVEL). This case was easy to blacklist.
>
> The latter bug (May 2019) was that fuzzer was calling binary code (via syz_execute_func()) which
> emdebbed a system call that changes console loglevel. Since it was too difficult to blacklist,
> syzkaller gave up use of syz_execute_func().


Yes, what Tetsuo says. Only syscall numbers and top-level arguments to
syscalls are easy to filter out. When indirect memory is passed to
kernel or (fd,ioctl) pairs are involved it boils down to solving the
halting problem.

There are some nice benefits of doing this in some form in kernel:
1. It makes reported crashes more trustworthy for kernel developers.
Currently you receive a crash and you don't know if it's a bug, or
working as intended (as turned out with serial console). It also
happened with syzkaller learning interesting ways to reach /dev/mem,
which was directly prohibited, but it managed to reach it via some
mounts and corrupted file names. Disabling the DEVMEM config in the
end reliably solved it once and for all.

2. It avoids duplication across test systems. Doing this in each test
system is again makes kernel testing hard and imposes duplication.
Tomorrow somebody runs new version of trinity, triforce, afl, perf
fuzzer and they hit the same issues, you get the same reports, and
have the same discussions and they slowly build the same list.

I like the idea of runtime knob that Andi proposed, and in fact this
looks quite similar to lockdown needs. And in fact it already have
LOCKDOWN_TIOCSSERIAL (does it does exactly the same as what we need?
if not, it may be something to improve in lockdown). It seems that any
fuzzing needs at least LOCKDOWN_INTEGRITY_MAX.

Could we incorporate some of the checks in this patch into lockdown?
FWIW we've just disabled sysrq entirely:
https://github.com/google/syzkaller/blob/master/dashboard/config/bits-syzbot.config#L182
because random packets over usb can trigger a panic sysrq (again
almost impossible to reliably filter these out on fuzzer side).

Not sure why lockdown prohibits parts of TIOCSSERIAL. Does it want to
prevent memory corruption, or also prevent turning off console output
(hiding traces)? If the latter then it may be reasonable to lockdown
lowering of console_loglevel.

But looks at some of the chunks here, it seems that we want something
slightly orthogonal to lockdown integrity/confidentiality, which
liveness/dos-prevention (can't accidentally bring down the whole
machine). E.g. FIFREEZE or bad SYSRQs.

There was some reason I did not enable lockdown when it was merged.
Now looking at the list again: LOCKDOWN_DEBUGFS is a no-go for us...
