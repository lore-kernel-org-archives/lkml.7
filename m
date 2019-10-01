Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB485C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4A32168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krk3Idd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389486AbfJAQOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:14:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43485 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbfJAQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:14:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id n14so13977149ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fQszVmoFI+qBKGvyfZDT2DEtBT4zQpReeld0OxhjLEQ=;
        b=krk3Idd3ooOu7VsBwFh8+DDqpVB/c9mVyaZXY0bnoK+iR/Q2x5DLLkrMp/Pj7bT3bd
         OiPE3mtAj2Oaw6sQ0AhPRegqJIXXcJrylv5PWYlNgthqpspmbog7js68bY4LG5Xm0Hil
         le6z1NYph5a2wGgivMX4E8M2bxMSMMre503KQ0kS8C4mm6XHOc978snuNqx60Meyy0uo
         hP5nk18K4N8qygrHnEnH8V6RDZrl+9UEhB+BUaYT/yn1efVC+amQyMUsoDVCUIxSpS7F
         h9Yo5pPR0pEGatgu/xwYj5pBP4E5hiuedmczj/tAAaH95+IhqgKZAzRrDu9pCAFUqpL4
         uX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fQszVmoFI+qBKGvyfZDT2DEtBT4zQpReeld0OxhjLEQ=;
        b=pB/O67rC5kL8X/5IigO1enptRXcH3eZXVsDyWdiSykMFFUsPvDR4OsYDAbojkEq3os
         02HCt5S2PNuc7advn8H3IIqBr8YSdA2WtHPabNc5gWWxzKVla9E6Hy89AUoYmCY8AAJ+
         kiJXKw/mUzkzx7usHpzGmRE2s9h/cCKomrjx7iEO0SAXKqnA5uLrlguPMGKf2D7mN/BJ
         913rvqPOp/jabQvzY1aKCONnxtVhGdxuCwjthN3DVdYj57R8ATp0qi/Px2zpk5oMKF1y
         c8w1VL8gh2rfqXXU4xaaeQ/JJxeSzQBYW9rf3HHdBrpoDVATl9ZDmbUgmxiEPRIey5WX
         dqtw==
X-Gm-Message-State: APjAAAXROZw17OHJWODKtwE/BCO93vHEoKhPvvSehOV71bRJxyjDUrZB
        Bc2AQJEygbHA8dbBoZjF7VwpzQ4JWNKefmG7PuTAX6nYLDmEVg==
X-Google-Smtp-Source: APXvYqxKw2+Ul7tux0GXMByGyf+irjrC1bKpX+euAeA/NuXtO6bjx7qsYCsKi/aPz5Uw8Lfg7q0SNAVuBVhODO095Ok=
X-Received: by 2002:a2e:63da:: with SMTP id s87mr16082403lje.79.1569946469307;
 Tue, 01 Oct 2019 09:14:29 -0700 (PDT)
MIME-Version: 1.0
From:   Bruce Ashfield <bruce.ashfield@gmail.com>
Date:   Tue, 1 Oct 2019 12:14:18 -0400
Message-ID: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
Subject: ptrace/strace and freezer oddities and v5.2+ kernels
To:     linux-kernel@vger.kernel.org, tj@kernel.org, guro@fb.com
Cc:     Richard Purdie <richard.purdie@linuxfoundation.org>,
        oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The Yocto project has an upcoming release this fall, and I've been trying to
sort through some issues that are happening with kernel 5.2+ .. although
there is a specific yocto kernel, I'm testing and seeing this with
normal / vanilla
mainline kernels as well.

I'm running into an issue that is *very* similar to the one discussed in the
[REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer" (76f969e)
thread from this past may: https://lkml.org/lkml/2019/5/12/272

I can confirm that I have the proposed fix for the initial regression report in
my build (05b2892637 [signal: unconditionally leave the frozen state
in ptrace_stop()]),
but yet I'm still seeing 3 or 4 minute runtimes on a test that used to take 3 or
4 seconds.

This isn't my normal area of kernel hacking, so I've so far come up empty
at either fixing it myself, or figuring out a viable workaround. (well, I can
"fix" it by remove the cgroup_enter_frozen() call in ptrace_stop ...
but obviously,
that is just me trying to figure out what could be causing the issue).

As part of the release, we run tests that come with various applications. The
ptrace test that is causing us issues can be boiled down to this:

$ cd /usr/lib/strace/ptest/tests
$ time ../strace -o log -qq -esignal=none -e/clock ./printpath-umovestr>ttt

(I can provide as many details as needed, but I wanted to keep this initial
email relatively short).

I'll continue to debug and attempt to fix this myself, but I grabbed the
email list from the regression report in May to see if anyone has any ideas
or angles that I haven't covered in my search for a fix.

Cheers,

Bruce



-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II
