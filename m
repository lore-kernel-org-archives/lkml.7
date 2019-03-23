Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66870C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A35F218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="cMRLo8EU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfCWLPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 07:15:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42650 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCWLPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 07:15:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so1481573wrx.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKVh9qYR9JrCsh7E8CFx7WgqHzSCvuhqj6pXjebU0Ho=;
        b=cMRLo8EUypIuvd/GfvKnDpu+NxfR9z8X6slb0C9oRtWsLVgzlDsBVnQN0rNA+43Ht8
         GL5V/C6lHcJ4tf62E5CpR6J5fDgtEmEv3UC21A2CYd5fCrx79jPYvlEY7ESsQoPBCsTm
         rmQ567WPodQ1nCJNOCuj4b9HeCejqu07KNnaaR1lf1HKnOX1QRBYaeGDSVl2JX0YRqqT
         kgUpZS1joEyFZ+wdEh/57Uo0c0U1YLu+7MEv2uzJzdjqdPCtDlxesB86dGXuyvZNUKyG
         GCKC8DgtbHVe4J/8wg0FWKT4rlgsYFN4ELMeFwgnLfJy+heP8dGHMeZHaegTJwAVcSpL
         IBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKVh9qYR9JrCsh7E8CFx7WgqHzSCvuhqj6pXjebU0Ho=;
        b=jPV38oVfGbifyptpS4s9NAAjVL3LTudfS31WIqOmc6ncJx1QOM/9J82rlVqXqd5VcQ
         x7iQc+sDPYLSLuebOuNPxUSF3Y+8UZsYEFcCljzsqDJF59Z7RjguPG6NDgMImcBuzPnE
         6PkYSprJ2c6unzRnGji+DixEU4nC2rmMfhu8j1vHk3LVnKvX2fz6Y95KzPcKGOVDa4N5
         /L5G7qgAa0IyUcryZoOu7iqI6vyGrPQrtt1tXXxlvSx/JNffWQNOx360LSflNUZzFymF
         8yaDH0BGtBMLMgoy2IKUCTDE07rqvmT4OrKkDMNUXfAo/dhcsJvtpk0+tuoebUeRsUMG
         gcSw==
X-Gm-Message-State: APjAAAW+jjOUf4r7HOjZOFmTxITC+2/x0ff71wWGaRuhgAA97n8p7NnX
        vpcaZ2VPFfRssMnsI2BnKAothAv1rSAtLhxdXlLYyQ==
X-Google-Smtp-Source: APXvYqw9uWKvVrgJIxlNXmYLy1uYsebw7CCivgGbSqUqeGo24jqUiTDfuYkB3dTVWnh11uTSOSkMc9kqQx+rD4VDgQk=
X-Received: by 2002:a5d:5108:: with SMTP id s8mr8758761wrt.99.1553339723383;
 Sat, 23 Mar 2019 04:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190322215411.19362-1-atish.patra@wdc.com>
In-Reply-To: <20190322215411.19362-1-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 23 Mar 2019 16:45:12 +0530
Message-ID: <CAAhSdy2MNA3A-vYD+WJqZAF9L8nScVjh7ZNQDdPpJNB+=BoWkw@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/riscv: Fix clocksource mask
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <Anup.Patel@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 3:24 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> For all riscv architectures (RV32, RV64 and RV128), the clocksource
> is a 64 bit incrementing counter.
>
> Fix the clock source mask accordingly.
>
> Tested on both 64bit and 32 bit virt machine in QEMU.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  drivers/clocksource/timer-riscv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index e8163693..5e6038fb 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -58,7 +58,7 @@ static u64 riscv_sched_clock(void)
>  static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
>         .name           = "riscv_clocksource",
>         .rating         = 300,
> -       .mask           = CLOCKSOURCE_MASK(BITS_PER_LONG),
> +       .mask           = CLOCKSOURCE_MASK(64),
>         .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
>         .read           = riscv_clocksource_rdtime,
>  };
> @@ -120,8 +120,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>                 return error;
>         }
>
> -       sched_clock_register(riscv_sched_clock,
> -                       BITS_PER_LONG, riscv_timebase);
> +       sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
>
>         error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
>                          "clockevents/riscv/timer:starting",
> --
> 2.21.0
>

Looks good to me.

It would be great if you can add "Fixes:" line and
"Cc: stable@vger.kernel.org"

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
