Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1918BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF06720684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDCIiK6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfCFBmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:42:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41411 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfCFBmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:42:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id n2so11539444wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 17:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fx+P6z6mIclGkhJ0HEQl/jHfzyyMaXodWbU601BYoEc=;
        b=SDCIiK6u2WXtvBMIIiiUQ3O7Zv9vSvwFO0FJ4hL08rn7DZjBovuTVxk76HbcBwpcrb
         PoPvVy4xtlf81s3pF7DM5LmRnsC/jVPaqTzdZ0ItwzLkBdbdVK/GUMJQfkdtxXoJND8a
         Et2VRtQ78tHrIoDN5MNckmfKCn4InW6UO4rRU1MWfOfCBKaWCvIim4LNfYyeYifm9RVo
         auf6dw4LZawKXdPUmwyzZcCRDxkswLUBJfIHysGwNluwMc853C95XTW64UBOjni/X3VQ
         bqSXnshjiu7QR29bcwe3dlOHxZNTUhz8NCxZB+YszR8GcpEfAcEal69G4aDELhRAQi6K
         /auQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fx+P6z6mIclGkhJ0HEQl/jHfzyyMaXodWbU601BYoEc=;
        b=kectXkXriZ4hJJ1BKffsvDbRZzADB3ets6m7Uae03GdlJgmQlCs7jsBuusW362eb81
         mNkq7XjjHeUaRjVQ670Q0UzpgQ8uiTLTK0hAmIcsHxG4SsrwEyA1nASKlNc1FDpoxTjR
         wDIh3OGJpzUyzcKwUIWEHddf9y+X25CfuRM4VZ1rrwJA/DeQ/vLuAKsb6IjBs/U/FXuv
         woWuMSi3lddjqezFkrb8OzF11Z+TD4s2cn9klLwfwEiE3XsEAr6gErGonv2l7uva+NcV
         5+tjaypYMMEKOllmJw1DTX7Px2c3oeUJnzGo/mWwjUe1F0ITJ4eEBBPH2DemUfGNbMqj
         FMYA==
X-Gm-Message-State: APjAAAWfNjzEIbAEjk9mz2gtLgMZ5L39XdIRu/6iuF/QEzxAe22gRNkk
        vzWKFM2sSuaUTsglrebLm/ptCuyP9yNsnRnLJ6ho7w==
X-Google-Smtp-Source: APXvYqx572+SzrTfZNed1kdbJFdwoZJGqMRpJp25CqwvEZ8p1klaOYUD+qyJJ0rEvPQfwi7UpgGwI0ay5eDA5mDF/Uc=
X-Received: by 2002:a5d:6703:: with SMTP id o3mr1032983wru.75.1551836557026;
 Tue, 05 Mar 2019 17:42:37 -0800 (PST)
MIME-Version: 1.0
References: <1551835710-53773-1-git-send-email-wangxiongfeng2@huawei.com>
In-Reply-To: <1551835710-53773-1-git-send-email-wangxiongfeng2@huawei.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 5 Mar 2019 17:42:25 -0800
Message-ID: <CALAqxLXFGKDzxT-S9DDnjRRYvDB1Qq3T-tHYYGQXg3c47HtTbQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ntp: Avoid undefined behaviour in second_overflow()
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 5:29 PM Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>
> When I ran Syzkaller testsuite, I got the following call trace.
> ================================================================================
> UBSAN: Undefined behaviour in kernel/time/ntp.c:457:16
> signed integer overflow:
> 9223372036854775807 + 500 cannot be represented in type 'long int'
> CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.19.25-dirty #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xca/0x13e lib/dump_stack.c:113
>  ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
>  handle_overflow+0x193/0x1e2 lib/ubsan.c:190
>  second_overflow+0x403/0x540 kernel/time/ntp.c:457
>  accumulate_nsecs_to_secs kernel/time/timekeeping.c:2002 [inline]
>  logarithmic_accumulation kernel/time/timekeeping.c:2046 [inline]
>  timekeeping_advance+0x2bb/0xec0 kernel/time/timekeeping.c:2114
>  tick_do_update_jiffies64.part.2+0x1a0/0x350 kernel/time/tick-sched.c:97
>  tick_do_update_jiffies64 kernel/time/tick-sched.c:1229 [inline]
>  tick_nohz_update_jiffies kernel/time/tick-sched.c:499 [inline]
>  tick_nohz_irq_enter kernel/time/tick-sched.c:1232 [inline]
>  tick_irq_enter+0x1fd/0x240 kernel/time/tick-sched.c:1249
>  irq_enter+0xc4/0x100 kernel/softirq.c:353
>  entering_irq arch/x86/include/asm/apic.h:517 [inline]
>  entering_ack_irq arch/x86/include/asm/apic.h:523 [inline]
>  smp_apic_timer_interrupt+0x20/0x480 arch/x86/kernel/apic/apic.c:1052
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:864
>  </IRQ>
> RIP: 0010:native_safe_halt+0x2/0x10 arch/x86/include/asm/irqflags.h:58
> Code: 01 f0 0f 82 bc fd ff ff 48 c7 c7 c0 21 b1 83 e8 a1 0a 02 ff e9 ab fd ff ff 4c 89 e7 e8 77 b6 a5 fe e9 6a ff ff ff 90 90 fb f4 <c3> 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 f4 c3 90 90 90 90 90 90
> RSP: 0018:ffff888106307d20 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000007 RBX: dffffc0000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8881062e4f1c
> RBP: 0000000000000003 R08: ffffed107c5dc77b R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff848c78a0
> R13: 0000000000000003 R14: 1ffff11020c60fae R15: 0000000000000000
>  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
>  default_idle+0x24/0x2b0 arch/x86/kernel/process.c:561
>  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
>  do_idle+0x2ca/0x420 kernel/sched/idle.c:262
>  cpu_startup_entry+0xcb/0xe0 kernel/sched/idle.c:368
>  start_secondary+0x421/0x570 arch/x86/kernel/smpboot.c:271
>  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
> ================================================================================
>
> It is because time_maxerror is set as 0x7FFFFFFFFFFFFFFF by user. It
> overflows when we add it with 'MAXFREQ / NSEC_PER_USEC' in
> 'second_overflow()'.
>
> This patch add a limit check and saturate it when the user set
> 'time_maxerror'.
>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  kernel/time/ntp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index 36a2bef..38e1b65 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -677,6 +677,8 @@ static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai
>
>         if (txc->modes & ADJ_MAXERROR)
>                 time_maxerror = txc->maxerror;
> +       if (time_maxerror > NTP_PHASE_LIMIT)
> +               time_maxerror = NTP_PHASE_LIMIT;

This looks sane to me.
Acked-by: John Stultz <john.stultz@linaro.org>

Though it makes me wonder a bit more about the sanity checking on the
other parameters passed via adjtimex(), tick_usec for instance looks
like it could be similarly problematic.

thanks
-john
