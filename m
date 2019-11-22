Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E42BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B922064B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pj4DGDZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfKVXxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:53:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33575 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKVXxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:53:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id h27so4105315pgn.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 15:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hGAas7kbfHEyduv+qdDvn9qOuG+QbmzDwbHASjA3jcU=;
        b=pj4DGDZ1nbrVcXZWpL8KUkxPGpmLOFPsaxSKDWTo+GotooYRqGqGPkpynSYiRdngOh
         cCSWFvHCasu+bQBjEmLAPbCzqtENh6C/41p+62l4bX73LDW5BeDSGCfvfZfDwNCVcWCE
         RoEcw+qj0Q6X1HCTdeIS32UGXPfXIhYm2dWIpVSwAZRld7EK7pAJeyKOvAJQGRmwuVXE
         VZIbtCsRCJv98LJatgyTpvsH06/PsYZB2O+F73gHe3lgy7eneevuukJLftYHJzCDcD2T
         0t4zwLp8L0q5L6d6XMdz9gLAs67stVDPsT1Q/f82FbrQUEgI/lZGUhS4QMHKZpEjABje
         HafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hGAas7kbfHEyduv+qdDvn9qOuG+QbmzDwbHASjA3jcU=;
        b=PY7KowX2CLQPRqe7Y4pln39Ys0FhbHtxaTv9KVRUgpTA1XcXEyStK/Jxp7hTyud9zV
         how3z1iyMNHkZpnyiJfuUV1oohEypdMcu1F6vEQTzsmMPZYzfk1vuKEikvF46NkG2cWI
         sAil6YwZ8MjS/6fzDZj8tbwC5iRcBhhGTM8dJTfN9JDZIrNlChDsV+A9WPgO22v8XKc0
         SrXRb6+8m7+FytCpQ0K1U1wTCkzyXUMFeusnyxypG/HvHYep7ZTJkG1CBIq+DBYXCF+F
         9RAa3/hHdI0gUMEMYxWBPdd22RPD5sdBHikgdIXVx/mjGWoqNiZScrz544n0dGkWftkW
         9FUQ==
X-Gm-Message-State: APjAAAUz5ysNI4kljjO01yVMr1muVPMWtzpaamFFZ+p4+O/8jpEGdTJT
        JbjgkNa4tlf0AcEmRWIXn/JM1A==
X-Google-Smtp-Source: APXvYqw99JsgPoFTCZ13835v1K37KM8rcO8/jaVQxczy+Przjc8a7wzamUt/r7KH8d14gd9sD7OBhA==
X-Received: by 2002:a62:4d43:: with SMTP id a64mr20955676pfb.197.1574466787744;
        Fri, 22 Nov 2019 15:53:07 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
        by smtp.gmail.com with ESMTPSA id j20sm8374170pff.182.2019.11.22.15.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 15:53:07 -0800 (PST)
Date:   Fri, 22 Nov 2019 15:53:07 -0800 (PST)
X-Google-Original-Date: Fri, 22 Nov 2019 15:37:38 PST (-0800)
Subject:     Re: [PATCH 2/2] riscv: defconfigs: enable more debugging options
In-Reply-To: <20191122225659.21876-3-paul.walmsley@sifive.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-8455ab79-f2b9-437d-81ed-814dd06328a4@palmerdabbelt.mtv.corp.google.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 14:56:59 PST (-0800), Paul Walmsley wrote:
> Enable more debugging options in the RISC-V defconfigs to help kernel
> developers catch problems with patches earlier in the development
> cycle.
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

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
