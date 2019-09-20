Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17543C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD2320717
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTf1z///"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391070AbfITQrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:47:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37478 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390274AbfITQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:47:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id d2so9415745qtr.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c57hxFA67fRRdSaSzWfUzlK33jYXyRtls9vYGbs8yPA=;
        b=kTf1z///BD0MlbD3Rq+UybgtgBgOdhQqNDPBjwhi5czfm+yHZAia51VUsD6NOdA51U
         fn9iKlq000D27RSHlObzLX9euuS2Zs51aX07i20aT+cbUqJF831KVLz9h1E54Wl41N6K
         W1fdExGxOvUkHItGmKr8ZMAEOA2ClfioaxoHpoYYmydUKCT9sHIhQ0XlOj+/THXd5XUe
         uLMTAyg5k+h7mBgRxV1+aGymigT8661B8mHvX9C/WqT313DImUZRoXPnecKdOP3EvSRH
         r0llfbcTu5gee8p7Z35cYSPf3fYTPXLy0H1DfevFlFhx/XCWQe6Der6DFiZj6cCTb9DG
         8Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c57hxFA67fRRdSaSzWfUzlK33jYXyRtls9vYGbs8yPA=;
        b=gyxFp4M0j2JnaUleNfIYM+d1WwHeUAU6McMkFMLKiqHUX3SswAETJi9xCsxcLe6srQ
         KRxONzAMSn56+L302xiGSh2iIAEnJyBdtlgAtcazXPDnyGOWmyDaiHA4nFGkdT8lM5MV
         IRp/6mbbrvjjVf3ammfSb5vn91Q8w0l++hq1OUaeaqEXwPZ/qMBdcCQZaSOh0VZSLKGg
         5dP1EOkWQYgI3zxw3UeGVmXM8iVw7dPHUjn0Hdp81LVnPD1FQHefxZOjidL96DJCTpd6
         AwDeArxUoxfKV5d/xKkzyo4Rmtrx4U0JFFyDL9YvtH7q4AsZMRf/s3XRehouUUCkNmsa
         L6tw==
X-Gm-Message-State: APjAAAVYwrX+ZXKRwLcLLT/N2hMbMR3xlspOOjjCQ4jPC56qL+dwlA0D
        FST6jSxz8IuI1GRQfQ61j9e9NgQDAI6aUmEw0A/avg==
X-Google-Smtp-Source: APXvYqwRjEAOULXoKZ6CUYnmjU2a0N71ONaqspZQCNLeBC5JZAH1tJTZfOECYYyzvRxr3aSUr9djoP0BW4t5Rf498C8=
X-Received: by 2002:ac8:7646:: with SMTP id i6mr4420523qtr.50.1568998033153;
 Fri, 20 Sep 2019 09:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920163123.GC55224@lakrids.cambridge.arm.com>
In-Reply-To: <20190920163123.GC55224@lakrids.cambridge.arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Sep 2019 18:46:53 +0200
Message-ID: <CACT4Y+ZwyBhR8pB7jON8eVObCGbJ54L8Sbz6Wfmy3foHkPb_fA@mail.gmail.com>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Fri, Sep 20, 2019 at 6:31 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > Hi all,
>
> Hi,
>
> > We would like to share a new data-race detector for the Linux kernel:
> > Kernel Concurrency Sanitizer (KCSAN) --
> > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
>
> Nice!
>
> BTW kcsan_atomic_next() is missing a stub definition in <linux/kcsan.h>
> when !CONFIG_KCSAN:
>
> https://github.com/google/ktsan/commit/a22a093a0f0d0b582c82cdbac4f133a3f61d207c#diff-19d7c475b4b92aab8ba440415ab786ec
>
> ... and I think the kcsan_{begin,end}_atomic() stubs need to be static
> inline too.
>
> It looks like this is easy enough to enable on arm64, with the only real
> special case being secondary_start_kernel() which we might want to
> refactor to allow some portions to be instrumented.
>
> I pushed the trivial patches I needed to get arm64 booting to my arm64/kcsan
> branch:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/kcsan
>
> We have some interesting splats at boot time in stop_machine, which
> don't seem to have been hit/fixed on x86 yet in the kcsan-with-fixes
> branch, e.g.
>
> [    0.237939] ==================================================================
> [    0.239431] BUG: KCSAN: data-race in multi_cpu_stop+0xa8/0x198 and set_state+0x80/0xb0
> [    0.241189]
> [    0.241606] write to 0xffff00001003bd00 of 4 bytes by task 24 on cpu 3:
> [    0.243435]  set_state+0x80/0xb0
> [    0.244328]  multi_cpu_stop+0x16c/0x198
> [    0.245406]  cpu_stopper_thread+0x170/0x298
> [    0.246565]  smpboot_thread_fn+0x40c/0x560
> [    0.247696]  kthread+0x1a8/0x1b0
> [    0.248586]  ret_from_fork+0x10/0x18
> [    0.249589]
> [    0.250006] read to 0xffff00001003bd00 of 4 bytes by task 14 on cpu 1:
> [    0.251804]  multi_cpu_stop+0xa8/0x198
> [    0.252851]  cpu_stopper_thread+0x170/0x298
> [    0.254008]  smpboot_thread_fn+0x40c/0x560
> [    0.255135]  kthread+0x1a8/0x1b0
> [    0.256027]  ret_from_fork+0x10/0x18
> [    0.257036]
> [    0.257449] Reported by Kernel Concurrency Sanitizer on:
> [    0.258918] CPU: 1 PID: 14 Comm: migration/1 Not tainted 5.3.0-00007-g67ab35a199f4-dirty #3
> [    0.261241] Hardware name: linux,dummy-virt (DT)
> [    0.262517] ==================================================================
>
> > To those of you who we mentioned at LPC that we're working on a
> > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > renamed it to KCSAN to avoid confusion with KTSAN).
> > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> >
> > In the coming weeks we're planning to:
> > * Set up a syzkaller instance.
> > * Share the dashboard so that you can see the races that are found.
> > * Attempt to send fixes for some races upstream (if you find that the
> > kcsan-with-fixes branch contains an important fix, please feel free to
> > point it out and we'll prioritize that).
> >
> > There are a few open questions:
> > * The big one: most of the reported races are due to unmarked
> > accesses; prioritization or pruning of races to focus initial efforts
> > to fix races might be required. Comments on how best to proceed are
> > welcome. We're aware that these are issues that have recently received
> > attention in the context of the LKMM
> > (https://lwn.net/Articles/793253/).
>
> I think the big risk here is drive-by "fixes" masking the warnings
> rather than fixing the actual issue. It's easy for people to suppress a
> warning with {READ,WRITE}_ONCE(), so they're liable to do that even the
> resulting race isn't benign.
>
> I don't have a clue how to prevent that, though.

I think this is mostly orthogonal problem. E.g. for some syzbot bugs I
see fixes that also try to simply "shut up" the immediate
manifestation with whatever means, e.g. sprinkling some slinlocks. So
(1) it's not unique to atomics, (2) presence of READ/WRITE_ONCE will
make the reader aware of the fact that this runs concurrently with
something else, and then they may ask themselves why this runs
concurrently with something when the object is supposed to be private
to the thread, and then maybe they re-fix it properly. Whereas if it's
completely unmarked, nobody will even notice that this code accesses
the object concurrently with other code. So even if READ/WRITE_ONCE
was a wrong fix, it's still better to have it rather than not.
