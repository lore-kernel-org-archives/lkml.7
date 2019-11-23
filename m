Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E6AC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 04:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318CD20719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 04:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="UXtt5ruz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKWE0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 23:26:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34481 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfKWE0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 23:26:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id j18so11656303wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 20:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5vSWA7vo59HSfD1wB9OHpfd47dGzSgPp1svxey2yFs=;
        b=UXtt5ruzhXomYfpYP8oDylutdumHQfqqdrrq+QR/SpluW5+uWsbtMkFIIjVXVRidPF
         93ScDYn08Fi+aVtmFiuB60UHDwgYk3ygD5iosKR/MW4e9caV286VtqbBLF4tMkYuIqrM
         wLBr7w5QDG/GpgsEevljSAuN9r+5NVseGu+kaTQbL4ihGfjzW62VeDanlIs3Vb6gNDDh
         3XFwcNCeKecx5zN0MFYOsLA/q8htzdAUYlOFroQczD3jW8amY5a0G5Oo91oB6tOLeSk7
         xzo8KriEAdwpvDaWGrhIhH5evKIUHg3NTpuPIPctWlt4dfNtFNH2Iaca49JnDXM/cg5s
         XnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5vSWA7vo59HSfD1wB9OHpfd47dGzSgPp1svxey2yFs=;
        b=hgqivdWngO1YIO66vy+FSCX1eSZGf334PBn98h4ugCFdlU9MXHZLtDcq7epG8ZGkV+
         5HNqyOth/KEsX9YQyfz3wPe5DZ5kXxB/oXcRXNxTWdbKfi3tx/9jG+QhJ3pggDgdKfST
         qzF8c/u7a3sVUOptjeLwVkbbYKbq6YGNpsOqkb2smOfNXPVFiIqrSvtWctUMopIIe7A1
         rTbwkGwBm2s2vekMI9/LFc+8Wjg2xFMotWocCC+1PnwPP/EFwveWIm2bY00iDEvPJBNQ
         V6TEBM2VIJPr/kk9RB8ohqYVlbbgxSR3urDCfRXv6P+mEWlxpXHnN1ak7CQzV32cJqIm
         Yxew==
X-Gm-Message-State: APjAAAXmiNx/yuXdnRyvMxl8DkuWKtiZWmvw6PiXFOMwCYXGBJ9AlZXE
        KtUBqrt/OngJkwn2/Qegl+CbuStS7YJDoD67IMUxx27+
X-Google-Smtp-Source: APXvYqy/O8sXPtPirjnApS0WnptOuyrSp1KWPyKKJIpfJTjxz7oHQBkjYV+BCEmsFk3abTPFK+LSiwxkj3t4U79kUV4=
X-Received: by 2002:a1c:30b:: with SMTP id 11mr18226300wmd.171.1574483165276;
 Fri, 22 Nov 2019 20:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20191122225659.21876-1-paul.walmsley@sifive.com> <20191122225659.21876-3-paul.walmsley@sifive.com>
In-Reply-To: <20191122225659.21876-3-paul.walmsley@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 23 Nov 2019 09:55:54 +0530
Message-ID: <CAAhSdy1j0z09tytn0dFVBc7AAVo3EZEJwXRKUFJ9RWbok77bMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: defconfigs: enable more debugging options
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 4:28 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Enable more debugging options in the RISC-V defconfigs to help kernel
> developers catch problems with patches earlier in the development
> cycle.

Lot the debug options enabled by this patch have big performance
impact. I would suggest to have separate debug defconfig for
RV32 and RV64 with debug options enabled instead of enabling
these in regular defconfigs.

>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  arch/riscv/configs/defconfig      | 23 +++++++++++++++++++++++
>  arch/riscv/configs/rv32_defconfig | 23 +++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index f0710d8f50cc..e2ff95cb3390 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -101,4 +101,27 @@ CONFIG_CRYPTO_USER_API_HASH=y
>  CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
> +CONFIG_DEBUG_PAGEALLOC=y
> +CONFIG_DEBUG_VM=y
> +CONFIG_DEBUG_VM_PGFLAGS=y
> +CONFIG_DEBUG_MEMORY_INIT=y
> +CONFIG_DEBUG_PER_CPU_MAPS=y

> +CONFIG_SOFTLOCKUP_DETECTOR=y

This one is fine.

> +CONFIG_WQ_WATCHDOG=y

Is WQ_WATCHDOG as debug option ?

> +CONFIG_SCHED_STACK_END_CHECK=y
> +CONFIG_DEBUG_TIMEKEEPING=y
> +CONFIG_DEBUG_RT_MUTEXES=y
> +CONFIG_DEBUG_SPINLOCK=y
> +CONFIG_DEBUG_MUTEXES=y
> +CONFIG_DEBUG_RWSEMS=y
> +CONFIG_DEBUG_ATOMIC_SLEEP=y
> +CONFIG_STACKTRACE=y
> +CONFIG_DEBUG_LIST=y
> +CONFIG_DEBUG_PLIST=y
> +CONFIG_DEBUG_SG=y

All these debug options reduce kernel performance
in a noticeable way. Please have separate defconfig
for these options.

>  # CONFIG_RCU_TRACE is not set
> +CONFIG_RCU_EQS_DEBUG=y
> +CONFIG_DEBUG_BLOCK_EXT_DEVT=y
> +# CONFIG_FTRACE is not set
> +# CONFIG_RUNTIME_TESTING_MENU is not set
> +CONFIG_MEMTEST=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index bdec58e6c5f7..eb519407c841 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -98,4 +98,27 @@ CONFIG_CRYPTO_USER_API_HASH=y
>  CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
> +CONFIG_DEBUG_PAGEALLOC=y
> +CONFIG_DEBUG_VM=y
> +CONFIG_DEBUG_VM_PGFLAGS=y
> +CONFIG_DEBUG_MEMORY_INIT=y
> +CONFIG_DEBUG_PER_CPU_MAPS=y
> +CONFIG_SOFTLOCKUP_DETECTOR=y
> +CONFIG_WQ_WATCHDOG=y
> +CONFIG_SCHED_STACK_END_CHECK=y
> +CONFIG_DEBUG_TIMEKEEPING=y
> +CONFIG_DEBUG_RT_MUTEXES=y
> +CONFIG_DEBUG_SPINLOCK=y
> +CONFIG_DEBUG_MUTEXES=y
> +CONFIG_DEBUG_RWSEMS=y
> +CONFIG_DEBUG_ATOMIC_SLEEP=y
> +CONFIG_STACKTRACE=y
> +CONFIG_DEBUG_LIST=y
> +CONFIG_DEBUG_PLIST=y
> +CONFIG_DEBUG_SG=y
>  # CONFIG_RCU_TRACE is not set
> +CONFIG_RCU_EQS_DEBUG=y
> +CONFIG_DEBUG_BLOCK_EXT_DEVT=y
> +# CONFIG_FTRACE is not set
> +# CONFIG_RUNTIME_TESTING_MENU is not set
> +CONFIG_MEMTEST=y

Same comments as above.

> --
> 2.24.0.rc0
>

The debug and trace instrumentation although helpful
in development comes with performance overhead. We
should be careful in enabling debug and trace options
by default in defconfigs.

Regards,
Anup
