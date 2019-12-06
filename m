Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D9AC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D59205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nPFMVBmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfLFJBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:01:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39636 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfLFJBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:01:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so6548200wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 01:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tov1mbhcp+QsiI0VacWBIXeC4BBdyQE6hAedYBCDd8E=;
        b=nPFMVBmJuifGcCiqRG78vP2N+sKADvqey/XG1wU7WJ40c+bzMQIOjUCKoCqZlBgYuF
         e8VlHjY/J5jNnGT/fmHdL+NoyyFvZGO4RuqSE9LpryWkwWB7UlbttIuyaxmJDcpR8szB
         yMQerm0kHNycNZfSZJIRODo/8Soj0OJlpJFZMn/bztbEsQ/Qdx65L3Bo7evvO+vmnEbD
         fUMTlDj+IpqMzCwagyFw0FRLfwZZRzsTqjZlpV3RHnqdRiq03afFkwYJpMaGna5T1Lr8
         2jU4tbwqMQccgxz62OZ7zAPKlVs6CCoW4cyAUdJm+3ip0E1UJtKNjomwuupcCMycXM+L
         s+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tov1mbhcp+QsiI0VacWBIXeC4BBdyQE6hAedYBCDd8E=;
        b=tdywh+B7mJC4sBvMa6l93vXw7IohMBmLfxp+w/2+zP7W/Qh5kRnjBG/Jo9r5AKY3Ge
         VfnXcmyrtG2mqB3dR8a4erS0LE44S9bhv1Wt2MxR4Flhw7zOliN6Alw3s9bnUA3z3xzG
         fMw866VwDwWNDKHE75xMyneptCz8FTJV+nwmAdNmcWRdGaOQSt+3iitWKXrWJPAjcunu
         uU4DYSJfdTUOdIs2C11JP0N2d8KrOMpb06eHZlvCJGnfHAFWejlnrhja9k1dEmWufiEh
         5CgukYZG+axcEktW28jUpUvxxWjTAIRLAhzOwpEBgrwGTOL58rkM0fRkZHr3B83cq0QZ
         BBrw==
X-Gm-Message-State: APjAAAUDISQOplThcdQhcAoq8XOn31HmreOiWHt9utXuvoKOkolvKA58
        W84pxWHqYhEXTWtoEqcHg9UbnATmzbVZXQ==
X-Google-Smtp-Source: APXvYqzozTEc+CeSycLg3r5mCMusfpi9OWnzCWwliv4+2VT/UxNOmnlO3uxk52x4yMZCS99LVEBYOA==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr9201425wmk.37.1575622861300;
        Fri, 06 Dec 2019 01:01:01 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id e18sm17642216wrw.70.2019.12.06.01.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 01:01:00 -0800 (PST)
Date:   Fri, 6 Dec 2019 09:00:59 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RISC-V: Add fragmented config for debug options
Message-ID: <20191206090059.vpwku3gsqjtcubf5@holly.lan>
References: <20191205174902.4935-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205174902.4935-1-anup.patel@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 05:49:18PM +0000, Anup Patel wrote:
> Various Linux kernel DEBUG options have big performance impact so
> these should not be enabled in RISC-V normal defconfigs.
> 
> Instead we should have separate RISC-V fragmented config for enabling
> these DEBUG options. This way Linux RISC-V kernel can be built for
> both non-debug and debug purposes using same defconfig.
> 
> This patch moves additional DEBUG options to extra_debug.config.
> 
> To configure a non-debug RV64 kernel, we use our normal defconfig:
>    $ make O=<linux_build_directory> defconfig
> Wherease to configure a debug RV64 kernel, we use extra_debug.config:
>    $ make O=<linux_build_directory> defconfig extra_debug.config
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
> Changes since v1:
>  - Use fragmented .config instead of separate debug defconfigs.
> ---
>  arch/riscv/configs/defconfig          | 23 -----------------------
>  arch/riscv/configs/extra_debug.config | 21 +++++++++++++++++++++

Might be better to call this rv_debug.config (or riscv_debug.config),
This would imply it is a set of options recommended by riscv
maintainers and also having a suitable prefix means it is less
likely to ever conflict with .config files in kernel/configs .

BTW don't respin the patch on my account. Using a .config file was just
an idea and I'm not sure it reached consensus on the v1 thread.


Daniel.


>  arch/riscv/configs/rv32_defconfig     | 23 -----------------------
>  3 files changed, 21 insertions(+), 46 deletions(-)
>  create mode 100644 arch/riscv/configs/extra_debug.config
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index e2ff95cb3390..f0710d8f50cc 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -101,27 +101,4 @@ CONFIG_CRYPTO_USER_API_HASH=y
>  CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
> -CONFIG_DEBUG_PAGEALLOC=y
> -CONFIG_DEBUG_VM=y
> -CONFIG_DEBUG_VM_PGFLAGS=y
> -CONFIG_DEBUG_MEMORY_INIT=y
> -CONFIG_DEBUG_PER_CPU_MAPS=y
> -CONFIG_SOFTLOCKUP_DETECTOR=y
> -CONFIG_WQ_WATCHDOG=y
> -CONFIG_SCHED_STACK_END_CHECK=y
> -CONFIG_DEBUG_TIMEKEEPING=y
> -CONFIG_DEBUG_RT_MUTEXES=y
> -CONFIG_DEBUG_SPINLOCK=y
> -CONFIG_DEBUG_MUTEXES=y
> -CONFIG_DEBUG_RWSEMS=y
> -CONFIG_DEBUG_ATOMIC_SLEEP=y
> -CONFIG_STACKTRACE=y
> -CONFIG_DEBUG_LIST=y
> -CONFIG_DEBUG_PLIST=y
> -CONFIG_DEBUG_SG=y
>  # CONFIG_RCU_TRACE is not set
> -CONFIG_RCU_EQS_DEBUG=y
> -CONFIG_DEBUG_BLOCK_EXT_DEVT=y
> -# CONFIG_FTRACE is not set
> -# CONFIG_RUNTIME_TESTING_MENU is not set
> -CONFIG_MEMTEST=y
> diff --git a/arch/riscv/configs/extra_debug.config b/arch/riscv/configs/extra_debug.config
> new file mode 100644
> index 000000000000..66c58bb645a4
> --- /dev/null
> +++ b/arch/riscv/configs/extra_debug.config
> @@ -0,0 +1,21 @@
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
> +CONFIG_RCU_EQS_DEBUG=y
> +CONFIG_DEBUG_BLOCK_EXT_DEVT=y
> +CONFIG_MEMTEST=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index eb519407c841..bdec58e6c5f7 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -98,27 +98,4 @@ CONFIG_CRYPTO_USER_API_HASH=y
>  CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
> -CONFIG_DEBUG_PAGEALLOC=y
> -CONFIG_DEBUG_VM=y
> -CONFIG_DEBUG_VM_PGFLAGS=y
> -CONFIG_DEBUG_MEMORY_INIT=y
> -CONFIG_DEBUG_PER_CPU_MAPS=y
> -CONFIG_SOFTLOCKUP_DETECTOR=y
> -CONFIG_WQ_WATCHDOG=y
> -CONFIG_SCHED_STACK_END_CHECK=y
> -CONFIG_DEBUG_TIMEKEEPING=y
> -CONFIG_DEBUG_RT_MUTEXES=y
> -CONFIG_DEBUG_SPINLOCK=y
> -CONFIG_DEBUG_MUTEXES=y
> -CONFIG_DEBUG_RWSEMS=y
> -CONFIG_DEBUG_ATOMIC_SLEEP=y
> -CONFIG_STACKTRACE=y
> -CONFIG_DEBUG_LIST=y
> -CONFIG_DEBUG_PLIST=y
> -CONFIG_DEBUG_SG=y
>  # CONFIG_RCU_TRACE is not set
> -CONFIG_RCU_EQS_DEBUG=y
> -CONFIG_DEBUG_BLOCK_EXT_DEVT=y
> -# CONFIG_FTRACE is not set
> -# CONFIG_RUNTIME_TESTING_MENU is not set
> -CONFIG_MEMTEST=y
> -- 
> 2.17.1
> 
