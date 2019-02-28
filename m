Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CF3C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA842186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpfUFdX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbfB1EYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 23:24:14 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36107 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfB1EYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 23:24:13 -0500
Received: by mail-it1-f195.google.com with SMTP id v83so13725138itf.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 20:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81eof6++k5NBO6d1q02mkQrIOj5UeKpK1uU8m3BZpcw=;
        b=GpfUFdX6xkKIM4OzgVvxStDKXt7KDFzJ7x6K2SJF3U8KTH5P5JsxGhVu/sSpieuMVJ
         tiPHlyw3/NjbrRiFlKjqzuK43N2joNLu2bOJst9e43H8RKYGctS2P61lDAH62pfuKfNX
         R+bX0xynCynM9OdKvTpKznv/h3SZtkyo5YfEZklAubs3CRLwbvZUoYvXXz68eWBigIRd
         /gqbjS+42h92BpnFpHPZSCRR7sgBdWXcCGe0GpR5KmHsiZdzw4nhnutD6XbBkqHdLNMN
         gwJ4FuYtDfx+XCwnpcKvSQ9Kp7j6MVGUtGKsobwiSq1VeGxhhLIGZFC18DOVaDJSXmsz
         7L3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81eof6++k5NBO6d1q02mkQrIOj5UeKpK1uU8m3BZpcw=;
        b=T9Kcbk4SPpeaZ3RzvLUS6UzFkkCn977D+RSIRFq6JRw25qtZXQ/3ildfar8MhLd1M9
         9E7bf29mvAzdkXxOP+hWaGwBR4szzqVuoaEPHTmaEkrrBv9HNM2q3dqXvpVDiphsnwAB
         ms3VC/kqjhhXsHNuGpl6P7qLg5bUwGzFq7i8lUb3Rz7FcyG/Rbnw6nILBXilG5rh9hZP
         UgOeejr1DxVLwGMPVr+jcSkY4ON6Iqkl+W4yG8b9d2Lp5nfFmkuvpBObHPPe7nULAWPA
         bzJwez9ryDKvzzD1feluFWXWjU5pRbClfUQPDwLPFicCYv2NpdifoG4WLd/oiaJRls9A
         dAAQ==
X-Gm-Message-State: AHQUAuYbeeRKqv9+tPNBNAUFOK1GUjAhlY9qhi16OK74tG3OH679bpIb
        i4bqp/sBgyfmvohUklGEs0AZV0yfqXzP2kzs6iFO/+C64xo=
X-Google-Smtp-Source: AHgI3IYRuBoKgRSl2tlKNOVsudrmQogt8629tvAKSf3jTukDkUhZSP9p94zwVTIh3L312BdBybu9cNqQsetznCcpixU=
X-Received: by 2002:a24:54c5:: with SMTP id t188mr1766210ita.58.1551327852353;
 Wed, 27 Feb 2019 20:24:12 -0800 (PST)
MIME-Version: 1.0
References: <1551253922-3307-1-git-send-email-wangxiongfeng2@huawei.com>
In-Reply-To: <1551253922-3307-1-git-send-email-wangxiongfeng2@huawei.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 27 Feb 2019 20:24:01 -0800
Message-ID: <CABeXuvoJ3oKRp0z=CO_8kPhZ+-AHGwTaDBqzK2FuC_v5t6kU=A@mail.gmail.com>
Subject: Re: [PATCH v2] posix-cpu-timers: Avoid undefined behaviour in timespec64_to_ns()
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:52 PM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> When I ran Syzkaller testsuite, I got the following call trace.
> ================================================================================
> UBSAN: Undefined behaviour in ./include/linux/time64.h:120:27
> signed integer overflow:
> 8243129037239968815 * 1000000000 cannot be represented in type 'long long int'
> CPU: 5 PID: 28854 Comm: syz-executor.1 Not tainted 4.19.24 #4
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xca/0x13e lib/dump_stack.c:113
>  ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
>  handle_overflow+0x193/0x1e2 lib/ubsan.c:190
>  timespec64_to_ns include/linux/time64.h:120 [inline]
>  posix_cpu_timer_set+0x95a/0xb70 kernel/time/posix-cpu-timers.c:687
>  do_timer_settime+0x198/0x2a0 kernel/time/posix-timers.c:892
>  __do_sys_timer_settime kernel/time/posix-timers.c:918 [inline]
>  __se_sys_timer_settime kernel/time/posix-timers.c:904 [inline]
>  __x64_sys_timer_settime+0x18d/0x260 kernel/time/posix-timers.c:904
>  do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x462eb9
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f14e4127c58 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
> RAX: ffffffffffffffda RBX: 000000000073bfa0 RCX: 0000000000462eb9
> RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f14e41286bc
> R13: 00000000004c54cc R14: 0000000000704278 R15: 00000000ffffffff
> ================================================================================
>
> It is because 'it_interval.tv_sec' is larger than 'KTIME_SEC_MAX' and
> 'it_interval.tv_sec * NSEC_PER_SEC' overflows in 'timespec64_to_ns()'.
>
> This patch use 'timespec64_valid_restrict()' to check whether
> 'it_interval.tv_sec' is larger than 'KTIME_SEC_MAX'.
>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  kernel/time/posix-timers.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index 0e84bb7..97b773c 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -853,8 +853,8 @@ static int do_timer_settime(timer_t timer_id, int flags,
>         unsigned long flag;
>         int error = 0;
>
> -       if (!timespec64_valid(&new_spec64->it_interval) ||
> -           !timespec64_valid(&new_spec64->it_value))
> +       if (!timespec64_valid_strict(&new_spec64->it_interval) ||
> +           !timespec64_valid_strict(&new_spec64->it_value))
>                 return -EINVAL;
>
>         if (old_spec64)

sys_timer_settime() is a POSIX interface:
http://pubs.opengroup.org/onlinepubs/7908799/xsh/timer_settime.html

The timer_settime() function will fail if:

[EINVAL] The timerid argument does not correspond to an id returned by
timer_create() but not yet deleted by timer_delete().

[EINVAL] A value structure specified a nanosecond value less than zero
or greater than or equal to 1000 million.

So we cannot return EINVAL here if we want to maintain POSIX compatibility.
Maybe we should check for limit and saturate here at the syscall interface?

-Deepa
