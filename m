Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747BFC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A31E20684
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFNWfDDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfLBXdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:33:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45125 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfLBXcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:32:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so639583pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=AuYdYQOqVjZOMTwcbGbtEItUVQpJS/UeiwXcdeGYymo=;
        b=PFNWfDDnNNFEm2kwi9s7n16kEz6A210TtiSuJuZYIhrMhtnpoYmG71OxXcE1zDFjH5
         SF4wAvHkndVHU1XEIFQUiktKEmf1Y8XfBc7ol07fHA7jcKuq0OfFtF7p8FVBLS5Oemxc
         Rf6hG1zkJXKBbHzt4+oCbrrUAR/Dsz1zahN3kNvIh+wpkb50ISe95QqkgTBkG9Kj2tNu
         C6PCIZuLVGMo6kA1pq1STe0cvjki2ZrsJvd6L8H+PEVTzmsiF4VfKb8G/kpgun8d+6rY
         6lDMnmjVKR8w8byJ/JizyzpEvoYKS+X6KvuGfJYWhnSFUlPQwHzktiyFc5NG7hLI/JYf
         3Nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=AuYdYQOqVjZOMTwcbGbtEItUVQpJS/UeiwXcdeGYymo=;
        b=oSx/Mo04VYywxotMJW8KUYD4b7CXpk5eJpgLaZo9s3JE3m+oh/pJ2R/lrHFYu+A7YI
         L0q5NKnwIC2eCFmre5q3TkQuSEUrv4IN98rn1FaSgaTF4NNdGyInQUNvZOwpl4H/uX1Z
         wMELFqcMMS31xPyYWDiqWMxTTYjzsrmYw9MCmumLFsRs4boW0IAIwIJpW18QSeBhf+jQ
         KOarEWvSXO8ZwJdFgQ/e7SdENPc2wCQtQo0KCXYQMCBdBIBzPa9ft+Jl6JUVDcyoLpke
         b9WX4vjIljeXxXDTW78zS8ta6HE/bgvzvV94RlnHj3s47eRU2pV+gztMp6sd6D46Na2T
         QeCg==
X-Gm-Message-State: APjAAAUN2PC2Ny+R3UArcmZkFKg0vU1pgFCW6uC2j9+kyYTJA55KLWrD
        uCG5TPykhcSLqwihP35fop9Aww==
X-Google-Smtp-Source: APXvYqyR9ul/jT1p2KfOlJ+gOratNSumaQtcJqIXUnodMSdnelCIQwRPISibeBYTSEjBNKke6Mexaw==
X-Received: by 2002:a65:6209:: with SMTP id d9mr1899204pgv.22.1575329572670;
        Mon, 02 Dec 2019 15:32:52 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
        by smtp.gmail.com with ESMTPSA id e16sm580681pff.181.2019.12.02.15.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 15:32:52 -0800 (PST)
Date:   Mon, 02 Dec 2019 15:32:52 -0800 (PST)
X-Google-Original-Date: Mon, 02 Dec 2019 15:27:26 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH 3/4] RISC-V: Select SYSCON Reboot and Poweroff for QEMU virt machine
In-Reply-To: <20191125132147.97111-4-anup.patel@wdc.com>
CC:     palmer@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        Anup Patel <Anup.Patel@wdc.com>, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-b024f0a2-a9cc-421a-aae0-997d024e6c9c@palmerdabbelt.mtv.corp.google.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019 05:22:33 PST (-0800), Anup Patel wrote:
> The SYSCON Reboot and Poweroff drivers can be used on QEMU virt machine
> to reboot or poweroff the system hence we select these drivers using
> QEMU virt machine kconfig option.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/Kconfig.socs           | 2 ++
>  arch/riscv/configs/defconfig      | 1 +
>  arch/riscv/configs/rv32_defconfig | 1 +
>  3 files changed, 4 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 62383951bf2e..bae4907b4880 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -26,6 +26,8 @@ config SOC_VIRT
>         select RPMSG_VIRTIO
>         select CRYPTO_DEV_VIRTIO
>         select VIRTIO_INPUT
> +       select POWER_RESET_SYSCON
> +       select POWER_RESET_SYSCON_POWEROFF
>         select SIFIVE_PLIC
>         help
>           This enables support for QEMU Virt Machine.
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 2515fe6417e1..bf33bd40ee07 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -58,6 +58,7 @@ CONFIG_HW_RANDOM=y
>  CONFIG_SPI=y
>  CONFIG_SPI_SIFIVE=y
>  # CONFIG_PTP_1588_CLOCK is not set
> +CONFIG_POWER_RESET=y
>  CONFIG_DRM=y
>  CONFIG_DRM_RADEON=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index bbcf14fd6f40..234213b4ea74 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -56,6 +56,7 @@ CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>  CONFIG_HVC_RISCV_SBI=y
>  CONFIG_HW_RANDOM=y
>  # CONFIG_PTP_1588_CLOCK is not set
> +CONFIG_POWER_RESET=y
>  CONFIG_DRM=y
>  CONFIG_DRM_RADEON=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
