Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F977CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B7C21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sb0BId1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438837AbfJYJng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:43:36 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38688 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408741AbfJYJnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:43:35 -0400
Received: by mail-ua1-f66.google.com with SMTP id u99so407017uau.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3PJ1YVyTJFvMhEoIkYosgkgBaLCT/JOrQALKa66OJ4=;
        b=sb0BId1/yfrCX+z50q9tkL4zULyiLoZlRkJlJYrlxL1Cy2xp3lExOwyLp1z8Wbizrj
         ydXxVG2lJxE4G8zrim8Y0N7S2h+DfTwqPZc16X+zxqNMS2nh1wLNuvZhScSJwzebuD1C
         rz4DrFxV+G3MIOZl8eN/3+bfNLJc6ylZcZwpUkSWhs4VwoJVT2ywHJt8QR03VqZ1BWUE
         Slqyjs5I5QJ6SwKreiOxqTJ3C0FPkYmiV5WoEvS6O5/WiQosmCdh/KmBndK1ZiJDMoFr
         RBi9x3E63HsAccoZimP01EELqLe5qHMKIwCHzJHjoDx3yD3Ou1AHp8sQorQ24L6q7pxV
         WQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3PJ1YVyTJFvMhEoIkYosgkgBaLCT/JOrQALKa66OJ4=;
        b=Op1EpB4mdLlUKojZL02Os4lw/Edg7QBjfcCq3XbzmkzInAJFu8SosFd7VAZjXLOuQg
         K7+32FvAIisYlh0MMHHKk9reMr/6dYYsVsD2p1gTBo/8eQbAi/4ksesUH21saiH1vlDE
         ObKb920MClcPcg+TLpZ3dggRTxovDK/ER4crLnG2aFSe1U1BjYjXJlwMm0dsM2VNx95x
         8TON1twZZuQduwLD2USY5p+jFOeEtVE0gmrSgVfcfo7Be+euA99bLp7r3BnDoBGFkIL8
         mmEoVsB2TKxDbTwH0+4uvhQfIjeL/veQrC6shbSxm8HS1o4UgPbca/1en2UxdrSDGf/t
         dYaw==
X-Gm-Message-State: APjAAAXwnQ4JvFlK74NXbmZf6Od8nnnIONtE+iwdS4WQizlmuK/LCXyY
        UT1F8izCxxidiTjWE+EdtTQ2I9ivQduE//RqCG0=
X-Google-Smtp-Source: APXvYqzL1ZYR3yoTTIqq/eHaohHEzTwejRq9kyMSCLwrIzVJvVEY+GSI1r+a+v/gxdPJP4zRPI9ye6r8+J47fUg8h7s=
X-Received: by 2002:ab0:5bdb:: with SMTP id z27mr1115284uae.118.1571996614402;
 Fri, 25 Oct 2019 02:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191024162424.38548-1-steven.price@arm.com>
In-Reply-To: <20191024162424.38548-1-steven.price@arm.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 25 Oct 2019 11:43:27 +0200
Message-ID: <CAH9NwWdviH0gohPxZY97izenbSDnbQCL4kLeANg7UeCR7u1UUw@mail.gmail.com>
Subject: Re: [RESEND PATCH v4] drm: Don't free jobs in wait_event_interruptible()
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Sharat Masetty <smasetty@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Erico Nunes <nunes.erico@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do., 24. Okt. 2019 um 18:25 Uhr schrieb Steven Price <steven.price@arm.com>:
>
> drm_sched_cleanup_jobs() attempts to free finished jobs, however because
> it is called as the condition of wait_event_interruptible() it must not
> sleep. Unfortuantly some free callbacks (notibly for Panfrost) do sleep.
>
> Instead let's rename drm_sched_cleanup_jobs() to
> drm_sched_get_cleanup_job() and simply return a job for processing if
> there is one. The caller can then call the free_job() callback outside
> the wait_event_interruptible() where sleeping is possible before
> re-checking and returning to sleep if necessary.
>
> Signed-off-by: Steven Price <steven.price@arm.com>

Tested-by: Christian Gmeiner <christian.gmeiner@gmail.com>

Without this patch I get the following warning:

[  242.935254] ------------[ cut here ]------------
[  242.940044] WARNING: CPU: 2 PID: 109 at kernel/sched/core.c:6731
__might_sleep+0x94/0xa8
[  242.948242] do not call blocking ops when !TASK_RUNNING; state=1
set at [<38751e36>] prepare_to_wait_event+0xa8/0x180
[  242.958923] Modules linked in:
[  242.962010] CPU: 2 PID: 109 Comm: 130000.gpu Not tainted 5.4.0-rc4 #10
[  242.968551] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  242.975112] [<c0113160>] (unwind_backtrace) from [<c010cf34>]
(show_stack+0x10/0x14)
[  242.982879] [<c010cf34>] (show_stack) from [<c0c065ec>]
(dump_stack+0xd8/0x110)
[  242.990213] [<c0c065ec>] (dump_stack) from [<c0128adc>] (__warn+0xc0/0x10c)
[  242.997194] [<c0128adc>] (__warn) from [<c0128f10>]
(warn_slowpath_fmt+0x8c/0xb8)
[  243.004697] [<c0128f10>] (warn_slowpath_fmt) from [<c01598bc>]
(__might_sleep+0x94/0xa8)
[  243.012810] [<c01598bc>] (__might_sleep) from [<c0c246e4>]
(__mutex_lock+0x38/0xa1c)
[  243.020571] [<c0c246e4>] (__mutex_lock) from [<c0c250e4>]
(mutex_lock_nested+0x1c/0x24)
[  243.028600] [<c0c250e4>] (mutex_lock_nested) from [<c064f020>]
(etnaviv_cmdbuf_free+0x40/0x8c)
[  243.037233] [<c064f020>] (etnaviv_cmdbuf_free) from [<c06503a0>]
(etnaviv_submit_put+0x38/0x1c8)
[  243.046042] [<c06503a0>] (etnaviv_submit_put) from [<c064177c>]
(drm_sched_cleanup_jobs+0xc8/0xec)
[  243.055021] [<c064177c>] (drm_sched_cleanup_jobs) from [<c06419b4>]
(drm_sched_main+0x214/0x298)
[  243.063826] [<c06419b4>] (drm_sched_main) from [<c0152890>]
(kthread+0x140/0x158)
[  243.071329] [<c0152890>] (kthread) from [<c01010b4>]
(ret_from_fork+0x14/0x20)
[  243.078563] Exception stack(0xec691fb0 to 0xec691ff8)
[  243.083630] 1fa0:                                     00000000
00000000 00000000 00000000
[  243.091822] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  243.100013] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  243.106795] irq event stamp: 321
[  243.110098] hardirqs last  enabled at (339): [<c0193854>]
console_unlock+0x430/0x620
[  243.117864] hardirqs last disabled at (346): [<c01934cc>]
console_unlock+0xa8/0x620
[  243.125592] softirqs last  enabled at (362): [<c01024e0>]
__do_softirq+0x2c0/0x590
[  243.133232] softirqs last disabled at (373): [<c0130ed0>]
irq_exit+0x100/0x18c
[  243.140517] ---[ end trace 8afcd79e9e2725b2 ]---

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
