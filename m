Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27804C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA2021D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLRJ5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:57:20 -0500
Received: from smtpq3.tb.mail.iss.as9143.net ([212.54.42.166]:53522 "EHLO
        smtpq3.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbfLRJ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:57:20 -0500
Received: from [212.54.42.137] (helo=smtp6.tb.mail.iss.as9143.net)
        by smtpq3.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jongk@linux-m68k.org>)
        id 1ihW4x-00062I-2L; Wed, 18 Dec 2019 10:57:15 +0100
Received: from mail-wr1-f45.google.com ([209.85.221.45])
        by smtp6.tb.mail.iss.as9143.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jongk@linux-m68k.org>)
        id 1ihW4w-0002yY-TS; Wed, 18 Dec 2019 10:57:14 +0100
Received: by mail-wr1-f45.google.com with SMTP id d16so1533715wre.10;
        Wed, 18 Dec 2019 01:57:14 -0800 (PST)
X-Gm-Message-State: APjAAAWvvq6ykMo4UPY05G4n+vQ4ccF5iVc8leQzEYFVp7NhImH2C6z0
        gR1OqCzU8YyHeTHAngH2WX6S6BvsvVw8ELE/px4=
X-Google-Smtp-Source: APXvYqylgQx7y7aSKF+UQvOtqz0PUKcMHFzBa5nguUDbjglV3slUWBtLNNg0MTxYN5MBOBa0vYvj5Hl8dqu8c2mE/dk=
X-Received: by 2002:adf:b60f:: with SMTP id f15mr1698757wre.372.1576663034298;
 Wed, 18 Dec 2019 01:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20191124195225.31230-1-jongk@linux-m68k.org> <CAMuHMdVv9FU+kTf7RDd=AFKL12tJxzmGbX4jZZ8Av3VCZUzwhA@mail.gmail.com>
 <20191126144121.kzkujr27ga36gqnf@wittgenstein> <CACz-3riWp1fWCaAJtMgRx9VRVAJ+ktdbAqHBobQUXR9XpHrVcQ@mail.gmail.com>
 <CAMuHMdVLQF_KyWDn=HxmLAp6Vy3jyw=JLDQWryLt809sCecosA@mail.gmail.com>
In-Reply-To: <CAMuHMdVLQF_KyWDn=HxmLAp6Vy3jyw=JLDQWryLt809sCecosA@mail.gmail.com>
From:   Kars de Jong <jongk@linux-m68k.org>
Date:   Wed, 18 Dec 2019 10:57:03 +0100
X-Gmail-Original-Message-ID: <CACz-3rhmUfxbfhznvA6NOF69SR49NDZwnkZ=Bmhw_cf4SkiadQ@mail.gmail.com>
Message-ID: <CACz-3rhmUfxbfhznvA6NOF69SR49NDZwnkZ=Bmhw_cf4SkiadQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: Wire up clone3() syscall
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-SourceIP: 209.85.221.45
X-Authenticated-Sender: karsdejong@home.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=ZLepZkzb c=1 sm=1 tr=0 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=pxVhFHJ0LMsA:10 a=tBb2bbeoAAAA:8 a=XZkEEhXT8cryS0fe4JEA:9 a=QEXdDO2ut3YA:10 a=Oj-tNtZlA1e06AYgeCfH:22
X-Ziggo-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

Op zo 15 dec. 2019 om 17:48 schreef Geert Uytterhoeven <geert@linux-m68k.org>:
> Unfortunately some tests failed:
>
> atari:~# chroot /tmp /tmp/clone3
> # clone3() syscall supported
> TAP version 13
> 1..17
> # [825] Trying clone3() with flags 0 (size 0)
> # I am the parent (825). My child's pid is 826
> # I am the child, my PID is 826
> # [825] clone3() with flags says: 0 expected 0
> ok 1 [825] Result (0) matches expectation (0)
> # [825] Trying clone3() with flags 0x20000000 (size 0)
> # Invalid argument - Failed to create new process
> # [825] clone3() with flags says: -22 expected 0
> not ok 2 [825] Result (-22) is different than expected (0)
> # [825] Trying clone3() with flags 0 (size 64)
> # I am the parent (825). My child's pid is 827
> # I am the child, my PID is 827
> # [825] clone3() with flags says: 0 expected 0
> ok 3 [825] Result (0) matches expectation (0)
> # [825] Trying clone3() with flags 0 (size 56)
> # Invalid argument - Failed to create new process
> # [825] clone3() with flags says: -22 expected -22
> ok 4 [825] Result (-22) matches expectation (-22)
> # [825] Trying clone3() with flags 0 (size 88)
> # I am the parent (825). My child's pid is 828
> # I am the child, my PID is 828
> # [825] clone3() with flags says: 0 expected 0
> ok 5 [825] Result (0) matches expectation (0)
> # [825] Trying clone3() with flags 0 (size 0)
> # Invalid argument - Failed to create new process
> # [825] clone3() with flags says: -22 expected -22
> ok 6 [825] Result (-22) matches expectation (-22)
> # [825] Trying clone3() with flags 0 (size 0)
> # Invalid argument - Failed to create new process
> # [825] clone3() with flags says: -22 expected -22
> ok 7 [825] Result (-22) matches expectation (-22)
> # [825] Trying clone3() with flags 0 (size 0)
> # Invalid argument - Failed to create new process
> # [825] clone3() with flags says: -22 expected -22
> ok 8 [825] Result (-22) matches expectation (-22)
> # [825] Trying clone3() with flags 0 (size 0)
> # Invalid argument - Failed to create new process
> # [825] clone3() with flags says: -22 expected -22
> ok 9 [825] Result (-22) matches expectation (-22)
> # [825] Trying clone3() with flags 0 (size 88)
> # I am the parent (825). My child's pid is 829
> # I am the child, my PID is 829
> # [825] clone3() with flags says: 0 expected 0
> ok 10 [825] Result (0) matches expectation (0)
> # [825] Trying clone3() with flags 0 (size 96)
> # Argument list too long - Failed to create new process
> # [825] clone3() with flags says: -7 expected -7
> ok 11 [825] Result (-7) matches expectation (-7)
> # [825] Trying clone3() with flags 0 (size 160)
> # Argument list too long - Failed to create new process
> # [825] clone3() with flags says: -7 expected -7
> ok 12 [825] Result (-7) matches expectation (-7)
> # [825] Trying clone3() with flags 0 (size 4104)
> # Argument list too long - Failed to create new process
> # [825] clone3() with flags says: -7 expected -7
> ok 13 [825] Result (-7) matches expectation (-7)
> # [825] Trying clone3() with flags 0x20000000 (size 64)
> # Invalid argument - Failed to create new process
> # [825] clone3() with flags says: -22 expected 0
> not ok 14 [825] Result (-22) is different than expected (0)
> # [825] Trying clone3() with flags 0x20000000 (size 56)
> # Invalid argument - Failed to create new process
> # [825] clone3() with flags says: -22 expected -22
> ok 15 [825] Result (-22) matches expectation (-22)
> # [825] Trying clone3() with flags 0x20000000 (size 88)
> # Invalid argument - Failed to create new process
> # [825] clone3() with flags says: -22 expected 0
> not ok 16 [825] Result (-22) is different than expected (0)
> # [825] Trying clone3() with flags 0x20000000 (size 4104)
> # Argument list too long - Failed to create new process
> # [825] clone3() with flags says: -7 expected -7
> ok 17 [825] Result (-7) matches expectation (-7)
> Bail out!
> # Pass 14 Fail 3 Xfail 0 Xpass 0 Skip 0 Error 0

I created a new environment as described by Adrian (thanks!), built a
5.5.0-rc2 kernel based on Debian config-5.3.0-3-m68k, and ran these
tests too:

kars@q800:/$ sudo ./clone3
# clone3() syscall supported
TAP version 13
1..17
# [406] Trying clone3() with flags 0 (size 0)
# I am the parent (406). My child's pid is 407
# [406] clone3() with flags says: 0 expected 0
ok 1 [406] Result (0) matches expectation (0)
# [406] Trying clone3() with flags 0x20000000 (size 0)
# I am the parent (406). My child's pid is 408
# [406] clone3() with flags says: 0 expected 0
ok 2 [406] Result (0) matches expectation (0)
# [406] Trying clone3() with flags 0 (size 64)
# I am the parent (406). My child's pid is 409
# [406] clone3() with flags says: 0 expected 0
ok 3 [406] Result (0) matches expectation (0)
# [406] Trying clone3() with flags 0 (size 56)
# Invalid argument - Failed to create new process
# [406] clone3() with flags says: -22 expected -22
ok 4 [406] Result (-22) matches expectation (-22)
# [406] Trying clone3() with flags 0 (size 88)
# I am the parent (406). My child's pid is 410
# [406] clone3() with flags says: 0 expected 0
ok 5 [406] Result (0) matches expectation (0)
# [406] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [406] clone3() with flags says: -22 expected -22
ok 6 [406] Result (-22) matches expectation (-22)
# [406] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [406] clone3() with flags says: -22 expected -22
ok 7 [406] Result (-22) matches expectation (-22)
# [406] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [406] clone3() with flags says: -22 expected -22
ok 8 [406] Result (-22) matches expectation (-22)
# [406] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [406] clone3() with flags says: -22 expected -22
ok 9 [406] Result (-22) matches expectation (-22)
# [406] Trying clone3() with flags 0 (size 88)
# I am the parent (406). My child's pid is 411
# [406] clone3() with flags says: 0 expected 0
ok 10 [406] Result (0) matches expectation (0)
# [406] Trying clone3() with flags 0 (size 96)
# Argument list too long - Failed to create new process
# [406] clone3() with flags says: -7 expected -7
ok 11 [406] Result (-7) matches expectation (-7)
# [406] Trying clone3() with flags 0 (size 160)
# Argument list too long - Failed to create new process
# [406] clone3() with flags says: -7 expected -7
ok 12 [406] Result (-7) matches expectation (-7)
# [406] Trying clone3() with flags 0 (size 4104)
# Argument list too long - Failed to create new process
# [406] clone3() with flags says: -7 expected -7
ok 13 [406] Result (-7) matches expectation (-7)
# [406] Trying clone3() with flags 0x20000000 (size 64)
# I am the parent (406). My child's pid is 412
# [406] clone3() with flags says: 0 expected 0
ok 14 [406] Result (0) matches expectation (0)
# [406] Trying clone3() with flags 0x20000000 (size 56)
# Invalid argument - Failed to create new process
# [406] clone3() with flags says: -22 expected -22
ok 15 [406] Result (-22) matches expectation (-22)
# [406] Trying clone3() with flags 0x20000000 (size 88)
# I am the parent (406). My child's pid is 413
# [406] clone3() with flags says: 0 expected 0
ok 16 [406] Result (0) matches expectation (0)
# [406] Trying clone3() with flags 0x20000000 (size 4104)
# Argument list too long - Failed to create new process
# [406] clone3() with flags says: -7 expected -7
ok 17 [406] Result (-7) matches expectation (-7)
# Pass 17 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0

So that works OK.

> atari:~# chroot /tmp /tmp/clone3_set_tid
> TAP version 13
> # clone3() syscall supported
> 1..29
> # /proc/sys/kernel/pid_max 32768
> # [830] Trying clone3() with CLONE_SET_TID to 0 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
> ok 1 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to 0 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
> ok 2 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to 0 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
> ok 3 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to 0 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
> ok 4 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to 0 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
> ok 5 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
> ok 6 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
> ok 7 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
> ok 8 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
> ok 9 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
> ok 10 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to 0 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
> ok 11 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
> ok 12 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to -1 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
> ok 13 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to -1 and 0x20000000
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
> ok 14 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to 1 and 0x0
> # File exists - Failed to create new process
> # [830] clone3() with CLONE_SET_TID 1 says :-17 - expected -17
> ok 15 [830] Result (-17) matches expectation (-17)
> # [830] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID 1 says :-22 - expected 0
> not ok 16 [830] Result (-22) is different than expected (0)
> # [830] Trying clone3() with CLONE_SET_TID to 32768 and 0x0
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
> ok 17 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to 32768 and 0x20000000
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
> ok 18 [830] Result (-22) matches expectation (-22)
> # Child has PID 831
> # [830] Trying clone3() with CLONE_SET_TID to 831 and 0x0
> # I am the parent (830). My child's pid is 831
> # I am the child, my PID is 831 (expected 831)
> # [830] clone3() with CLONE_SET_TID 831 says :0 - expected 0
> ok 19 [830] Result (0) matches expectation (0)
> # [830] Trying clone3() with CLONE_SET_TID to 831 and 0x20000000
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID 831 says :-22 - expected -22
> ok 20 [830] Result (-22) matches expectation (-22)
> # [830] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
> # Invalid argument - Failed to create new process
> # [830] clone3() with CLONE_SET_TID 1 says :-22 - expected 0
> not ok 21 [830] Result (-22) is different than expected (0)
> # unshare PID namespace
> Bail out! unshare(CLONE_NEWPID) failed: Invalid argument
> # Planned tests != run tests (29 != 21)
> # Pass 19 Fail 2 Xfail 0 Xpass 0 Skip 0 Error 0

kars@q800:/$ sudo ./clone3_set_tid
TAP version 13
# clone3() syscall supported
1..29
# /proc/sys/kernel/pid_max 32768
# [435] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
ok 1 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
ok 2 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
ok 3 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
ok 4 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
ok 5 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 6 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 7 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 8 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 9 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 10 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to 0 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID 0 says :-22 - expected -22
ok 11 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 12 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to -1 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 13 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to -1 and 0x20000000
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID -1 says :-22 - expected -22
ok 14 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to 1 and 0x0
# File exists - Failed to create new process
# [435] clone3() with CLONE_SET_TID 1 says :-17 - expected -17
ok 15 [435] Result (-17) matches expectation (-17)
# [435] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# I am the child, my PID is 1 (expected 1)
# I am the parent (435). My child's pid is 436
# [435] clone3() with CLONE_SET_TID 1 says :0 - expected 0
ok 16 [435] Result (0) matches expectation (0)
# [435] Trying clone3() with CLONE_SET_TID to 32768 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
ok 17 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to 32768 and 0x20000000
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
ok 18 [435] Result (-22) matches expectation (-22)
# Child has PID 437
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID 32768 says :-22 - expected -22
ok 18 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to 437 and 0x0
# I am the child, my PID is 437 (expected 437)
# I am the parent (435). My child's pid is 437
# [435] clone3() with CLONE_SET_TID 437 says :0 - expected 0
ok 19 [435] Result (0) matches expectation (0)
# [435] Trying clone3() with CLONE_SET_TID to 437 and 0x20000000
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID 437 says :-22 - expected -22
ok 20 [435] Result (-22) matches expectation (-22)
# [435] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# I am the child, my PID is 1 (expected 1)
# I am the parent (435). My child's pid is 437
# [435] clone3() with CLONE_SET_TID 1 says :0 - expected 0
ok 21 [435] Result (0) matches expectation (0)
# unshare PID namespace
# [435] Trying clone3() with CLONE_SET_TID to 437 and 0x0
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID 437 says :-22 - expected -22
ok 22 [435] Result (-22) matches expectation (-22)
# [1] Trying clone3() with CLONE_SET_TID to 43 and 0x0
# Invalid argument - Failed to create new process
# [1] clone3() with CLONE_SET_TID 43 says :-22 - expected -22
ok 23 [1] Result (-22) matches expectation (-22)
# [1] Trying clone3() with CLONE_SET_TID to 43 and 0x0
# I am the child, my PID is 43 (expected 43)
# I am the parent (1). My child's pid is 43
# [1] clone3() with CLONE_SET_TID 43 says :0 - expected 0
ok 24 [1] Result (0) matches expectation (0)
# Child in PID namespace has PID 1
# [1] Trying clone3() with CLONE_SET_TID to 2 and 0x0
# I am the child, my PID is 2 (expected 2)
# I am the parent (1). My child's pid is 2
# [1] clone3() with CLONE_SET_TID 2 says :0 - expected 0
ok 25 [1] Result (0) matches expectation (0)
# [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# Invalid argument - Failed to create new process
# [1] clone3() with CLONE_SET_TID 1 says :-22 - expected -22
ok 26 [1] Result (-22) matches expectation (-22)
# [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# Invalid argument - Failed to create new process
# [1] clone3() with CLONE_SET_TID 1 says :-22 - expected -22
ok 27 [1] Result (-22) matches expectation (-22)
# [1] Trying clone3() with CLONE_SET_TID to 1 and 0x20000000
# I am the child, my PID is 1 (expected 1)
# [1] Child is ready and waiting
# I am the parent (1). My child's pid is 42
# [1] clone3() with CLONE_SET_TID 1 says :0 - expected 0
ok 28 [1] Result (0) matches expectation (0)
# Invalid argument - Failed to create new process
# [435] clone3() with CLONE_SET_TID 437 says :-22 - expected -22
ok 22 [435] Result (-22) matches expectation (-22)
# [435] Child is ready and waiting
ok 29 PIDs in all namespaces as expected (437,42,1)
# Pass 29 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0

So those all pass too. Maybe your kernel configuration is not suited
for these tests (in which case I would expect them to fail at compile
time by the way, the test should assert that).

> atari:~# chroot /tmp /tmp/clone3_clear_sighand
> TAP version 13
> # clone3() syscall supported
> 1..1
> Bail out! Failed to clear signal handler for child process
> # Planned tests != run tests (1 != 0)
> # Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
> atari:~#

That one fails the same way for me, but I don't think this is actually
a problem with the wiring up of the system call.
I tried debugging it, the child process exits at line 99 (the check
whether the SIGUSR1 signal handler is indeed cleared in the child):

94                      ret = sigaction(SIGUSR1, NULL, &act);
95                      if (ret < 0)
96                              exit(EXIT_FAILURE);
97
98                      if (act.sa_handler != SIG_DFL)
99                              exit(EXIT_FAILURE);          <--- failure point

Oh, I did have problems with gdb and the 'next' and 'nexti' commands,
they did not quite stop where I expected them too, they stopped
somewhere in libc assembly instead.
But that's probably unrelated.

Kind regards,

Kars.
