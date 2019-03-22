Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EAFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2CD2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfCVO6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:58:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41227 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfCVO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:58:15 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7LcW-0003Xh-8z; Fri, 22 Mar 2019 15:58:08 +0100
Date:   Fri, 22 Mar 2019 15:58:07 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
cc:     John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] timekeeping: Avoid undefined behaviour in
 'ktime_get_with_offset()'
In-Reply-To: <1551259381-15907-1-git-send-email-wangxiongfeng2@huawei.com>
Message-ID: <alpine.DEB.2.21.1903221541060.1729@nanos.tec.linutronix.de>
References: <1551259381-15907-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019, Xiongfeng Wang wrote:

> When I ran Syzkaller testsuite, I got the following call trace.
> ================================================================================
> UBSAN: Undefined behaviour in kernel/time/timekeeping.c:801:8
> signed integer overflow:
> 500152103386 + 9223372036854775807 cannot be represented in type 'long long int'
> CPU: 6 PID: 13904 Comm: syz-executor.0 Not tainted 4.19.25 #5
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xca/0x13e lib/dump_stack.c:113
>  ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
>  handle_overflow+0x193/0x1e2 lib/ubsan.c:190
>  ktime_get_with_offset+0x26a/0x2d0 kernel/time/timekeeping.c:801
>  common_hrtimer_arm+0x14d/0x220 kernel/time/posix-timers.c:817
>  common_timer_set+0x337/0x530 kernel/time/posix-timers.c:863
>  do_timer_settime+0x198/0x290 kernel/time/posix-timers.c:892
>  __do_sys_timer_settime kernel/time/posix-timers.c:918 [inline]
>  __se_sys_timer_settime kernel/time/posix-timers.c:904 [inline]
>  __x64_sys_timer_settime+0x18d/0x260 kernel/time/posix-timers.c:904
>  do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x462eb9
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7968072c58 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
> RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462eb9
> RDX: 00000000200000c0 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f79680736bc
> R13: 00000000004c54cc R14: 0000000000704278 R15: 00000000ffffffff
> ================================================================================
> 
> It it because global variable 'offsets' is set with a very large but still
> valid value. It overflows when we add 'tk->tkr_mono.base' with 'offsets'.

Well, no. First of all offsets is not a global variable. It's an array of
offsets.

The value of the offset used above is valid in the sense that it is a
positive value in 'long long int', but it is not at all valid in terms of
timekeeping.
 
> Because 'ktime_get_with_offset()' is a frequently used function, it may
> effect the performance if we use 'ktime_add_safe()' to avoid this
> undefined behaviour, so we use 'ktime_add_unsafe()' instead.

This is just papering over the real problem and no, we are not going to do
that.

The root cause is that something set CLOCK_REALTIME to have an offset of:

    9223372036854775807 ns ~= 292 years

vs. CLOCK_MONOTONIC.

The real fix is to limit the possible offset in the time setting code to a
sane value which cannot overflow in a reasonable time frame. If we assume a
maximum up time of 30 years, then the limit would be 262 years, which makes
the timekeeping code break either when uptime reaches 30 years or finally
in the year 2232.

Thanks,

	tglx
