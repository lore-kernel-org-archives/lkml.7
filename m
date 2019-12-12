Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70290C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3417F22527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXoo+nHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbfLLUxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:53:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33477 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbfLLUxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:53:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id v140so218140oie.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 12:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/kJv8AZtrQ1tJoTlAjQBJyNXaZYs14RTc7efEcCC3c=;
        b=CXoo+nHLTQb5saMEEZxOIXV69+PypiZhz14dMoSY3hEM8jydZwc0lVnHGgp1KmRWCm
         x9Zt1OeDWdpIagyI8VNBztutYR3xYV3nRsPDv5IpbgPHULq5tj9C1d4+P49+dlDwL9kj
         V+YcJ5lnN/rVoK5Wquw6sHWYyTAW4Q6Ny35Tubwvs8ZrVRdovAoR8QYWs0nn1YyJhth2
         EC2w/nWqEo05KLJ5hCjRm/tUA+ivg7BfizrWMAhaKrtZjU/n8caKyIPASx9370KwhGNj
         GD3fA1e6nq01vUdftzjztPKNtanlqb0k39IIK9QTbpI2eSPrJ05SrMBQFYcVlHH+s06g
         hgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/kJv8AZtrQ1tJoTlAjQBJyNXaZYs14RTc7efEcCC3c=;
        b=qesQW39Fa7jn8+XtN08ckUJAswGRt4/LiiuCxreR06B6mTITSCueWo5RZ9OREjmBoE
         kAH1dbL/MieU1Cg29bYNdyJFymbl4z3d0zsQBl1LuNfs/7SrpJKUMxIEfWczuX17Dcsk
         dbpBxy2auXDv6RxTMTuazfiEYbvhvoeafy2dH+YUmTocuBlu/nfO1HhYtQqkBmV6qsF8
         X3wwtI6/WWrnKI9Wdqt4+t3r3leV/eiIeBarK63ygLAdlKc2SBoXQiHXLkAbio2MQTmv
         A3nXL8OIokhQMYkKNKdpmt/t5AmZ6FBbciwJ46/7bpVCiBNb5iI+8QOL+brsxGoJdNFm
         cpng==
X-Gm-Message-State: APjAAAV1O9bKoZBaOnbVvcu9jHWRATkUZqw4DOIny1MI+3j33W9Yf8r/
        NOVTvOrFmmBXdCp1IzX5FGv+GFYs3HQQyvMqBfXU4tmnQtoqDg==
X-Google-Smtp-Source: APXvYqwLn9M6X66Q6fNfNx/dd3PWZBQALsorGQE4axpniDjBXj0CPGfYf3eWRHiScccugxE5pnqobBypgHuMzrh/g94=
X-Received: by 2002:a05:6808:8d5:: with SMTP id k21mr6465600oij.121.1576184020952;
 Thu, 12 Dec 2019 12:53:40 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <CADyx2V6j+do+CmmSYEUr0iP7TUWD7xHLP2ZJPrqB1Y+QEAwzhw@mail.gmail.com>
In-Reply-To: <CADyx2V6j+do+CmmSYEUr0iP7TUWD7xHLP2ZJPrqB1Y+QEAwzhw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Dec 2019 21:53:29 +0100
Message-ID: <CANpmjNOCUF8xW69oG9om91HRKxsj0L5DXSgf5j+D1EK_j29sqQ@mail.gmail.com>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Walter <truhuan@gmail.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019 at 10:57, Walter <truhuan@gmail.com> wrote:
>
> Hi Marco,
>
> Data racing issues always bothers us, we are happy to use this debug tool to
> detect the root cause. So, we need to understand this tool implementation,
> we try to trace your code and have some questions, would you take the free time
> to answer the question.
> Thanks.
>
> Question:
> We assume they access the same variable when use read() and write()
> Below two Scenario are false negative?
>
> ===
> Scenario 1:
>
> CPU 0:                                                                                     CPU 1:
> tsan_read()                                                                               tsan_write()
>   check_access()                                                                         check_access()
>      watchpoint=find_watchpoint() // watchpoint=NULL                     watchpoint=find_watchpoint() // watchpoint=NULL
>      kcsan_setup_watchpoint()                                                          kcsan_setup_watchpoint()
>         watchpoint = insert_watchpoint                                                    watchpoint = insert_watchpoint

Assumption: have more than 1 free slot for the address, otherwise
impossible that both set up a watchpoint.

>         if (!remove_watchpoint(watchpoint)) // no enter, no report           if (!remove_watchpoint(watchpoint)) // no enter, no report

Correct.

> ===
> Scenario 2:
>
> CPU 0:                                                                                    CPU 1:
> tsan_read()
>   check_access()
>     watchpoint=find_watchpoint() // watchpoint=NULL
>     kcsan_setup_watchpoint()
>       watchpoint = insert_watchpoint()
>
> tsan_read()                                                                              tsan_write()
>   check_access()                                                                        check_access()
>     find_watchpoint()
>       if(expect_write && !is_write)
>         continue
>       return NULL
>     kcsan_setup_watchpoint()
>       watchpoint = insert_watchpoint()
>       remove_watchpoint(watchpoint)
>         watchpoint = INVALID_WATCHPOINT
>                                                                                                       watchpoint = find_watchpoint()
>                                                                                                       kcsan_found_watchpoint()

This is a bit incorrect, because if atomically setting watchpoint to
INVALID_WATCHPOINT happened before concurrent find_watchpoint(),
find_watchpoint will not return anything, thus not entering
kcsan_found_watchpoint. If find_watchpoint happened before setting
watchpoint to INVALID_WATCHPOINT, the rest of the trace matches.
Either way,  no reporting will happen.

>                                                                                                           consumed = try_consume_watchpoint() // consumed=false, no report

Correct again, no reporting would happen.  While running, have a look
at /sys/kernel/debug/kcsan and look at the 'report_races' counter;
that counter tells you how often this case actually occurred. In all
our testing with the default config, this case is extremely rare.

As it says on the tin, KCSAN is a *sampling watchpoint* based data
race detector so all the above are expected. If you want to tweak
KCSAN's config to be more aggressive, there are various options
available. The most important ones:

* KCSAN_UDELAY_{TASK,INTERRUPT} -- Watchpoint delay in microseconds
for tasks and interrupts respectively. [Increasing this will make
KCSAN more aggressive.]
* KCSAN_SKIP_WATCH -- Skip instructions before setting up watchpoint.
[Decreasing this will make KCSAN more aggressive.]

Note, however, that making KCSAN more aggressive also implies a
noticeable performance hit.

Also, please find the latest version here:
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=kcsan
-- there have been a number of changes since the initial version from
September/October.

Thanks,
-- Marco
