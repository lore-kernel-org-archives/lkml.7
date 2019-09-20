Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F25C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602472086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391970AbfITQbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:31:31 -0400
Received: from foss.arm.com ([217.140.110.172]:47182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387631AbfITQbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:31:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0090337;
        Fri, 20 Sep 2019 09:31:30 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C4CE3F575;
        Fri, 20 Sep 2019 09:31:28 -0700 (PDT)
Date:   Fri, 20 Sep 2019 17:31:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>, paulmck@linux.ibm.com,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        stern@rowland.harvard.edu, akiyks@gmail.com, npiggin@gmail.com,
        boqun.feng@gmail.com, dlustig@nvidia.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20190920163123.GC55224@lakrids.cambridge.arm.com>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> Hi all,

Hi,

> We would like to share a new data-race detector for the Linux kernel:
> Kernel Concurrency Sanitizer (KCSAN) --
> https://github.com/google/ktsan/wiki/KCSAN  (Details:
> https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)

Nice!

BTW kcsan_atomic_next() is missing a stub definition in <linux/kcsan.h>
when !CONFIG_KCSAN:

https://github.com/google/ktsan/commit/a22a093a0f0d0b582c82cdbac4f133a3f61d207c#diff-19d7c475b4b92aab8ba440415ab786ec

... and I think the kcsan_{begin,end}_atomic() stubs need to be static
inline too.

It looks like this is easy enough to enable on arm64, with the only real
special case being secondary_start_kernel() which we might want to
refactor to allow some portions to be instrumented.

I pushed the trivial patches I needed to get arm64 booting to my arm64/kcsan
branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/kcsan

We have some interesting splats at boot time in stop_machine, which
don't seem to have been hit/fixed on x86 yet in the kcsan-with-fixes
branch, e.g.

[    0.237939] ==================================================================
[    0.239431] BUG: KCSAN: data-race in multi_cpu_stop+0xa8/0x198 and set_state+0x80/0xb0
[    0.241189] 
[    0.241606] write to 0xffff00001003bd00 of 4 bytes by task 24 on cpu 3:
[    0.243435]  set_state+0x80/0xb0
[    0.244328]  multi_cpu_stop+0x16c/0x198
[    0.245406]  cpu_stopper_thread+0x170/0x298
[    0.246565]  smpboot_thread_fn+0x40c/0x560
[    0.247696]  kthread+0x1a8/0x1b0
[    0.248586]  ret_from_fork+0x10/0x18
[    0.249589] 
[    0.250006] read to 0xffff00001003bd00 of 4 bytes by task 14 on cpu 1:
[    0.251804]  multi_cpu_stop+0xa8/0x198
[    0.252851]  cpu_stopper_thread+0x170/0x298
[    0.254008]  smpboot_thread_fn+0x40c/0x560
[    0.255135]  kthread+0x1a8/0x1b0
[    0.256027]  ret_from_fork+0x10/0x18
[    0.257036] 
[    0.257449] Reported by Kernel Concurrency Sanitizer on:
[    0.258918] CPU: 1 PID: 14 Comm: migration/1 Not tainted 5.3.0-00007-g67ab35a199f4-dirty #3
[    0.261241] Hardware name: linux,dummy-virt (DT)
[    0.262517] ==================================================================

> To those of you who we mentioned at LPC that we're working on a
> watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> renamed it to KCSAN to avoid confusion with KTSAN).
> [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> 
> In the coming weeks we're planning to:
> * Set up a syzkaller instance.
> * Share the dashboard so that you can see the races that are found.
> * Attempt to send fixes for some races upstream (if you find that the
> kcsan-with-fixes branch contains an important fix, please feel free to
> point it out and we'll prioritize that).
> 
> There are a few open questions:
> * The big one: most of the reported races are due to unmarked
> accesses; prioritization or pruning of races to focus initial efforts
> to fix races might be required. Comments on how best to proceed are
> welcome. We're aware that these are issues that have recently received
> attention in the context of the LKMM
> (https://lwn.net/Articles/793253/).

I think the big risk here is drive-by "fixes" masking the warnings
rather than fixing the actual issue. It's easy for people to suppress a
warning with {READ,WRITE}_ONCE(), so they're liable to do that even the
resulting race isn't benign.

I don't have a clue how to prevent that, though.

> * How/when to upstream KCSAN?

I would love to see this soon!

Thanks,
Mark.
