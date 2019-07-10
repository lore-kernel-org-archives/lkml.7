Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD99CC73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8968A20693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wx5xqLWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfGJFtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:49:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40613 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfGJFtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:49:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so756057eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 22:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNLQU0fvKqxQOdeOY7h0M4gaPPqFsFH7eX9dZuYhlJo=;
        b=Wx5xqLWopuzrZN6/Fti0L/HiygA8LcbAeuOEgB1MaLtDXVdcAVuu97fpw/JTnnlMZz
         NvAxhx0cPL9GBbxAeIy9TUW2x6Yw5q8CDhRK8nQ+zCyZ2Zq/uMCIrLLhi0fkcoB36CJs
         8k/tSYVi8Mfd1a41oiAkCcv8lmjbXgIrRdtxGGAlSrh3xntE8aYWm7Y57cg9lXAXuTr+
         l7bFLAo7Lvlsj6eed6w3trYXMK+v9fcQnmYQSGeJhj/CIXj3IDmFsInm4cWgPPG/xAzm
         KTBbmrpDFAAAAbNoXObxFn0bRfY3TGkBX7rkv0pjHytlvxb/xoHYSTH3HVut+8JAiPdq
         yJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNLQU0fvKqxQOdeOY7h0M4gaPPqFsFH7eX9dZuYhlJo=;
        b=R+iZbzFO481bnf2m0UioDZGRoInoyy5v93Mwc0xTWnaZKLsdiW6IczvrdJ/vYaIcUN
         Nc1D8PqtZZ32LawmsWFUoWOn/EfAbdLY2D54uGnd/yRpxCzjraATYETrvRgFV/knEEm+
         gvQdR2S+HPuVJMtvy3l2hZ+jsJ5QnQP9uu8O5Q22i+coAC0FQo6ZT7a2JluI2PYoMwWB
         mEuS/gCubBGknPsoSFfuSqQ694p4JOk1B9Fzv1vG7WYf0XCng6iMW2iqGqm8E5fWLA0R
         8OSIZo9q1cVvs5TkvJ3gcBVY/2BQMDvt/gN+IQ2UDGmIrte7y3hm27GKnxsiEYu8qeYU
         l4Jw==
X-Gm-Message-State: APjAAAWflpLqq77FCNJC9HtN87H77rCqUj1Xf6rh5izfcLOVBoGq2C3T
        fWvlfzC3uaKxQ8gegFpTw73eyPgjrCN/B8CxrsA=
X-Google-Smtp-Source: APXvYqx5k1mBwxHKRaGd1as7NViJbwd5PtzsB2OpDgEGGDnqTUDJbGWp6BtFmMPnBGSQKSDdrhHaBPWs7ABr8c4MFmw=
X-Received: by 2002:a50:ec0e:: with SMTP id g14mr2922382edr.210.1562737740861;
 Tue, 09 Jul 2019 22:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190708115349.GA14779@gmail.com>
In-Reply-To: <20190708115349.GA14779@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 9 Jul 2019 22:48:49 -0700
Message-ID: <CANcMJZAYhqdO5sGbwW7GszL9NtNgMy0+uMe+bVSQHqyewQcy_g@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler changes for v5.3
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 9:33 AM Ingo Molnar <mingo@kernel.org> wrote:
> Please pull the latest sched-core-for-linus git tree from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus
....
> Peter Zijlstra (1):
>       sched/core: Optimize try_to_wake_up() for local wakeups

Hey Peter, Ingo,
   Since this change landed in Linus' tree, I've been seeing a lot of
the following dmesg noise when running AOSP on the HiKey960 board.

[  173.162712] CPU: 2 PID: 731 Comm: ndroid.systemui Tainted: G S
          5.2.0-rc5-00110-g6751c43d94d6 #447
[  173.162721] Hardware name: HiKey960 (DT)
[  173.171194] caller is try_to_wake_up+0x3e4/0x788
[  173.179605] Call trace:
[  173.179617]  dump_backtrace+0x0/0x140
[  173.179626]  show_stack+0x14/0x20
[  173.179638]  dump_stack+0x9c/0xc4
[  173.179649]  debug_smp_processor_id+0x148/0x150
[  173.179659]  try_to_wake_up+0x3e4/0x788
[  173.179669]  wake_up_q+0x5c/0x98
[  173.179681]  futex_wake+0x170/0x1a8
[  173.179696]  do_futex+0x560/0xf30
[  173.284541]  __arm64_sys_futex+0xfc/0x148
[  173.288570]  el0_svc_common.constprop.0+0x64/0x188
[  173.293371]  el0_svc_handler+0x28/0x78
[  173.297131]  el0_svc+0x8/0xc
[  173.300045] CPU: 0 PID: 1258 Comm: Binder:363_5 Tainted: G S
        5.2.0-rc5-00110-g6751c43d94d6 #447
[  173.301130] BUG: using smp_processor_id() in preemptible [00000000]
code: ndroid.systemui/731
[  173.310074] Hardware name: HiKey960 (DT)
[  173.310084] Call trace:
[  173.310112]  dump_backtrace+0x0/0x140
[  173.310131]  show_stack+0x14/0x20
[  173.318685] caller is try_to_wake_up+0x3e4/0x788
[  173.322583]  dump_stack+0x9c/0xc4
[  173.322595]  debug_smp_processor_id+0x148/0x150
[  173.322605]  try_to_wake_up+0x3e4/0x788
[  173.322615]  wake_up_q+0x5c/0x98
[  173.322628]  futex_wake+0x170/0x1a8
[  173.322641]  do_futex+0x560/0xf30
[  173.358367]  __arm64_sys_futex+0xfc/0x148
[  173.362397]  el0_svc_common.constprop.0+0x64/0x188
[  173.367199]  el0_svc_handler+0x28/0x78
[  173.370956]  el0_svc+0x8/0xc

Reverting aacedf26fb76 ("sched/core: Optimize try_to_wake_up() for
local wakeups") seems to quiet down these warnings.

I've just bisected this down (and am about to crash for the night), so
I've not had much time to look at what a fix might be, but I wanted to
raise it with you.

If you have suggestions for patches to try, I'll happily do so in the morning!

thanks
-john
