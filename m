Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2DAC2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 16:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1ED20726
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 16:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfLOQsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 11:48:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46525 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfLOQsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 11:48:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id g18so5713170otj.13;
        Sun, 15 Dec 2019 08:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyI92hdnfY8PAAUr1dTGVnrFEL80XEUV2Rj9Icj07bk=;
        b=e+cOQt9FRZAB2bj8pdBANZMExyhoP6vLekdVAx9ISF1v7Rrx0pLgrXoFyWB5aKR0d6
         M26vOWm8zLBbdDzEuL36Ipx0g5mKGJRs6yPnj1GOIe58ZBsYFrmfA9nSfAldqJv9bj/Z
         BD6BsAbvVjQQ33Y/soDkV8lJ0Tu24M0N9FgdRzYIUVRgu5zqJygogfMxfbBSoWFfYe9R
         Pu6ZeSBBnEjIEI+OWfBCnC+ayek33b/rmvepbHnOoawz3mZBPW8KNY6rECIRGQ8A7YU9
         Oa3cokgKWfd5SO1R6/nlkIJeHBGpoKw9Sg3OSObIMR5yXcAB3E5vyorwU9mosFJj/KD7
         YSTg==
X-Gm-Message-State: APjAAAVfk1S/Kba+8/1qaDdXg6HBP+C4T2MhdfI0m0QPvPTyXePsxtpQ
        9LQr6ovGe9riRdta9sboQ3rgzNsRU0uBQeM1twecnXEK
X-Google-Smtp-Source: APXvYqwmJdOxqsPVi4f7kKJuUSBxsrpNtrpa2HsLfNb//2maPELqkQETjBaDVVH1cxohsWjE71SufaeBQUF4Qqn0Udk=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr27656640otm.297.1576428502295;
 Sun, 15 Dec 2019 08:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20191124195225.31230-1-jongk@linux-m68k.org> <CAMuHMdVv9FU+kTf7RDd=AFKL12tJxzmGbX4jZZ8Av3VCZUzwhA@mail.gmail.com>
 <20191126144121.kzkujr27ga36gqnf@wittgenstein> <CACz-3riWp1fWCaAJtMgRx9VRVAJ+ktdbAqHBobQUXR9XpHrVcQ@mail.gmail.com>
In-Reply-To: <CACz-3riWp1fWCaAJtMgRx9VRVAJ+ktdbAqHBobQUXR9XpHrVcQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 15 Dec 2019 17:48:10 +0100
Message-ID: <CAMuHMdVLQF_KyWDn=HxmLAp6Vy3jyw=JLDQWryLt809sCecosA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Wire up clone3() syscall
To:     Kars de Jong <jongk@linux-m68k.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kars,

On Tue, Nov 26, 2019 at 4:29 PM Kars de Jong <jongk@linux-m68k.org> wrote:
> Op di 26 nov. 2019 om 15:41 schreef Christian Brauner
> <christian.brauner@ubuntu.com>:
> > On Mon, Nov 25, 2019 at 10:12:25AM +0100, Geert Uytterhoeven wrote:
> > > On Sun, Nov 24, 2019 at 8:52 PM Kars de Jong <jongk@linux-m68k.org> wrote:
> > > > Wire up the clone3() syscall for m68k. The special entry point is done in
> > > > assembler as was done for clone() as well. This is needed because all
> > > > registers need to be saved. The C wrapper then calls the generic
> > > > sys_clone3() with the correct arguments.
> > > >
> > > > Tested on A1200 using the simple test program from:
> > > >
> > > >   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
> >
> > Please note that we now have a growing test-suite for the clone3()
> > syscall under
> > tools/testing/selftests/clone3/*
> >
> > You can test on a suitable kernel with
> >
> > make TARGETS=clone3 kselftest
>
> I'm afraid my user space is almost prehistoric. I have a homebrewn
> root filesystem of about 2001 vintage, and another one with Debian
> 3.1.
> So until I have bootstrapped a more recent one, I'll leave that to others ;-)

With Ubuntu's libc6-m68k-cross installed, the selftest binaries cross-build
fine.  Running them on a very old Debian requires some hackery:

  1. Copy ld.so.1, ld-2.27.so, libc.so.6, and libc-2.27.so from
     /usr/m68k-linux-gnu/lib/ to /tmp/lib on the m68k target,
  2. mkdir /tmp/proc && mount proc /tmp/proc -t proc,
  3. chroot /tmp /tmp/<test-binary>.

Unfortunately some tests failed:

atari:~# chroot /tmp /tmp/clone3
# clone3() syscall supported
TAP version 13
1..17
# [825] Trying clone3() with flags 0 (size 0)
# I am the parent (825). My child's pid is 826
# I am the child, my PID is 826
# [825] clone3() with flags says: 0 expected 0
ok 1 [825] Result (0) matches expectation (0)
# [825] Trying clone3() with flags 0x20000000 (size 0)
# Invalid argument - Failed to create new process
# [825] clone3() with flags says: -22 expected 0
not ok 2 [825] Result (-22) is different than expected (0)
# [825] Trying clone3() with flags 0 (size 64)
# I am the parent (825). My child's pid is 827
# I am the child, my PID is 827
# [825] clone3() with flags says: 0 expected 0
ok 3 [825] Result (0) matches expectation (0)
# [825] Trying clone3() with flags 0 (size 56)
# Invalid argument - Failed to create new process
# [825] clone3() with flags says: -22 expected -22
ok 4 [825] Result (-22) matches expectation (-22)
# [825] Trying clone3() with flags 0 (size 88)
# I am the parent (825). My child's pid is 828
# I am the child, my PID is 828
# [825] clone3() with flags says: 0 expected 0
ok 5 [825] Result (0) matches expectation (0)
# [825] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [825] clone3() with flags says: -22 expected -22
ok 6 [825] Result (-22) matches expectation (-22)
# [825] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [825] clone3() with flags says: -22 expected -22
ok 7 [825] Result (-22) matches expectation (-22)
# [825] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [825] clone3() with flags says: -22 expected -22
ok 8 [825] Result (-22) matches expectation (-22)
# [825] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [825] clone3() with flags says: -22 expected -22
ok 9 [825] Result (-22) matches expectation (-22)
# [825] Trying clone3() with flags 0 (size 88)
# I am the parent (825). My child's pid is 829
# I am the child, my PID is 829
# [825] clone3() with flags says: 0 expected 0
ok 10 [825] Result (0) matches expectation (0)
# [825] Trying clone3() with flags 0 (size 96)
# Argument list too long - Failed to create new process
# [825] clone3() with flags says: -7 expected -7
ok 11 [825] Result (-7) matches expectation (-7)
# [825] Trying clone3() with flags 0 (size 160)
# Argument list too long - Failed to create new process
# [825] clone3() with flags says: -7 expected -7
ok 12 [825] Result (-7) matches expectation (-7)
# [825] Trying clone3() with flags 0 (size 4104)
# Argument list too long - Failed to create new process
# [825] clone3() with flags says: -7 expected -7
ok 13 [825] Result (-7) matches expectation (-7)
# [825] Trying clone3() with flags 0x20000000 (size 64)
# Invalid argument - Failed to create new process
# [825] clone3() with flags says: -22 expected 0
not ok 14 [825] Result (-22) is different than expected (0)
# [825] Trying clone3() with flags 0x20000000 (size 56)
# Invalid argument - Failed to create new process
# [825] clone3() with flags says: -22 expected -22
ok 15 [825] Result (-22) matches expectation (-22)
# [825] Trying clone3() with flags 0x20000000 (size 88)
# Invalid argument - Failed to create new process
# [825] clone3() with flags says: -22 expected 0
not ok 16 [825] Result (-22) is different than expected (0)
# [825] Trying clone3() with flags 0x20000000 (size 4104)
# Argument list too long - Failed to create new process
# [825] clone3() with flags says: -7 expected -7
ok 17 [825] Result (-7) matches expectation (-7)
Bail out!
# Pass 14 Fail 3 Xfail 0 Xpass 0 Skip 0 Error 0
atari:~# chroot /tmp /tmp/clone3_set_tid
TAP version 13
# clone3() syscall supported
1..29
# /proc/sys/kernel/pid_max 32768
# [830] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
ok 1 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
ok 2 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
ok 3 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
ok 4 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
ok 5 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 6 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 7 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 8 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 9 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 10 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
ok 11 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 12 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 13 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to -1 and 0x20000000
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 14 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to 1 and 0x0
# File exists - Failed to create new process
# [830] clone3() with CLONE_SET_TID 1 says :-17 - expected -17
ok 15 [830] Result (-17) matches expectation (-17)
# [830] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID 1 says :-22 - expected 0
not ok 16 [830] Result (-22) is different than expected (0)
# [830] Trying clone3() with CLONE_SET_TID to 32768 and 0x0
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
ok 17 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to 32768 and 0x20000000
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
ok 18 [830] Result (-22) matches expectation (-22)
# Child has PID 831
# [830] Trying clone3() with CLONE_SET_TID to 831 and 0x0
# I am the parent (830). My child's pid is 831
# I am the child, my PID is 831 (expected 831)
# [830] clone3() with CLONE_SET_TID 831 says :0 - expected 0
ok 19 [830] Result (0) matches expectation (0)
# [830] Trying clone3() with CLONE_SET_TID to 831 and 0x20000000
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID 831 says :-22 - expected -22
ok 20 [830] Result (-22) matches expectation (-22)
# [830] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# Invalid argument - Failed to create new process
# [830] clone3() with CLONE_SET_TID 1 says :-22 - expected 0
not ok 21 [830] Result (-22) is different than expected (0)
# unshare PID namespace
Bail out! unshare(CLONE_NEWPID) failed: Invalid argument
# Planned tests != run tests (29 != 21)
# Pass 19 Fail 2 Xfail 0 Xpass 0 Skip 0 Error 0
atari:~# chroot /tmp /tmp/clone3_clear_sighand
TAP version 13
# clone3() syscall supported
1..1
Bail out! Failed to clear signal handler for child process
# Planned tests != run tests (1 != 0)
# Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
atari:~#

So this needs a bit more work?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
