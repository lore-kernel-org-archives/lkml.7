Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1783EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7C92146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCudI/JC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfLRV4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:56:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45161 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfLRVzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:55:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so4270108otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2UwPzd2e+JnH6ssOXgfC4uB+eN483cl8wOJHT+wP8M=;
        b=XCudI/JCQe7VEnt5Em/Pipw1qi0JG1eyb3RwjBUFAkJKOxbTsaUcmzTN0s+Ny9ZT5s
         WL8o318kiqnC9J4dj7/6qblgiquZ2ALWvjojChr4yxRsH96q4N6hb06FNWTQOtWkp9z2
         APAtiZfM1mQiQZqshcoH+c3sU491IxNVVqOAqJGD4QsREJGVLtkLN8FE2ZdTHL3W765H
         5tAmWBPpgqAnnUHqpPdMcp0yCDUZA/JIuVtSJ0pt+PKjr7FMCpZRYZArLaoiwN4EZl4j
         MQUwVZ2f6Oit4/hZ1PDQSJMk2AJbcsn5snNd0t2BVcbpN0UNyuUgGdspdS0FMcmGB3kP
         PzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2UwPzd2e+JnH6ssOXgfC4uB+eN483cl8wOJHT+wP8M=;
        b=X+lwSSa7/76vih1COc1jRdt854e0rAVDX0Ue0G9M3Km8mYTlbLz2y7U7optJqNhuD6
         LJJPsVubuWrVIQNpwKT1K1UWrs+BkwYCWXXQU/sIj4nYSb6+6luysI+PeFqnurJCmIRW
         vOhgVZZ1Ql/Ro5g3vd4phV5fHOI6wCX1om4U7J/WYNARQ0NUqjeZuiknSbEFN1zoG4xd
         Rim6txcF0nSOmwEk7y/jWWgeHR+M7mHMXSpSabIR+OTZxhCpbwF//Ui4uUSLnwgKfcT3
         uTVC2j0gYJYzFiJeQqu/MaZoMwUAL8VVyO4jta7lgwxDHduyufvoGby7Fd7hCZ0lWyCl
         qwXg==
X-Gm-Message-State: APjAAAUhMps5QVQGpezsnWUXunAg5uKENBHOE+1fVjG/g1glY4UY/SoE
        FdFj05P/ODMdiMboj8I+WMwg86JAVujZGAqBactKGQ==
X-Google-Smtp-Source: APXvYqwZUpR2pOb+7NtUAAWPh39PS4a/L1DlmezGGneYI0CeI3eZxyiX0c86zqIx1K0Px2o89RD/z24Uc6nXitzTGlI=
X-Received: by 2002:a9d:6481:: with SMTP id g1mr5082817otl.180.1576706154945;
 Wed, 18 Dec 2019 13:55:54 -0800 (PST)
MIME-Version: 1.0
References: <20191209143120.60100-1-jannh@google.com> <20191209143120.60100-2-jannh@google.com>
 <20191211170632.GD14821@zn.tnic>
In-Reply-To: <20191211170632.GD14821@zn.tnic>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 18 Dec 2019 22:55:28 +0100
Message-ID: <CAG48ez2qGOAPBKiXDBL56_+QqR_bGRrtBSCT73VnKQ3xYsjAEA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] x86/traps: Print address on #GP
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 6:06 PM Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Dec 09, 2019 at 03:31:18PM +0100, Jann Horn wrote:
> >     I have already sent a patch to syzkaller that relaxes their parsing of GPF
> >     messages (https://github.com/google/syzkaller/commit/432c7650) such that
> >     changes like the one in this patch don't break it.
> >     That patch has already made its way into syzbot's syzkaller instances
> >     according to <https://syzkaller.appspot.com/upstream>.
>
> Ok, cool.
>
> I still think we should do the oops number marking, though, as it has
> more benefits than just syzkaller scanning for it. The first oops has always
> been of crucial importance so having the number in there:
>
> [    2.542218] [1] general protection fault while derefing a non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
>                 ^
>
> would make eyeballing oopses even easier. Basically the same reason why
> you're doing this enhancement. :)
>
> So let me know if you don't have time to do it or you don't care about
> it etc, and I'll have a look.

I don't think I have time to do this in the near future. Feel free to
implement this.
