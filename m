Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE21C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFF7206E1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nx1MG/Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLBXc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:32:56 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:42261 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfLBXcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:32:54 -0500
Received: by mail-pj1-f67.google.com with SMTP id o11so555713pjp.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=4vszdq+NhnPiL4jOvg4UiO3rGXCku33xIFQdZUZZMZM=;
        b=nx1MG/Dz9hEy3n451r4boAyChbGNc/A4Q0FN0FbE83P7E/wMULZo7WAlQTd1aAz3AP
         +0d09xrEsi8gR0UxmbqccvpyRUhJGrY8dnyScrhPkleITIK7E3FA51SOSApt5FqUkev3
         RUL4XRta2HfqhW+qtQTsH+j2+UMgtJk53IzKFiSD4FxdfCWHdP5We9DT60fw2xamzZaV
         4BJyHCQZoxvqT2CzDsMf9Ps1IBnF6VGBbriV+hNsAGrPI+nvo8hg9stk8UWZU7oyiQMz
         TRvy2YDgYMZiZnBKIDv2VBOnN8TkRoKffAA0mOe0dhGkPM2KpMJg4d9M+RYwrluxGZ3n
         BhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=4vszdq+NhnPiL4jOvg4UiO3rGXCku33xIFQdZUZZMZM=;
        b=iVHfc3S+PsMIzDeLUXudjcfCnRht4BgKt/CIkQnPwqY3B8KlaTbwNslABQlq7alc9J
         x+eMXLIwEXNLcC7jBEUoscP431Xk0VgX3949T6vcVbE5KFFD3edueccUHmwT2WpJGEEP
         RRcAne/1WDCNI/gzNGZy0a8Cw08HshY0d3cQo+W8NDd3KkeN7r1ZMjWDTcyPZSkald1s
         cEsh/DYnz9F4D9weNnHzsPqd58zw4WBl3O0Ugtw3EuiXJCNlEPwxj8JmxxbEkmCizdnX
         FOPkAPRIQssHTlCdyOzZm356E4NuMZo84K3mVGLH8Hy1ztrYNV9OAVWbGHwlnB//tDh8
         nwSA==
X-Gm-Message-State: APjAAAW5UuUjJoK13vnn3qka90D2dzIdEINKe4FLJoIeyiw16WksXgMD
        5dA7utsLaou8aPDflLQdbl1U/w==
X-Google-Smtp-Source: APXvYqx5OQsfBdGXEwuioOPgtgOCuzFKhaGL40gfb1gxoJrrOgdxqqer0j8gsyOo8olkaCXYAMAG2w==
X-Received: by 2002:a17:902:be02:: with SMTP id r2mr1795049pls.76.1575329574036;
        Mon, 02 Dec 2019 15:32:54 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
        by smtp.gmail.com with ESMTPSA id w10sm680436pgi.47.2019.12.02.15.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 15:32:53 -0800 (PST)
Date:   Mon, 02 Dec 2019 15:32:53 -0800 (PST)
X-Google-Original-Date: Mon, 02 Dec 2019 15:27:58 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH 4/4] RISC-V: Select Goldfish RTC driver for QEMU virt machine
In-Reply-To: <20191125132147.97111-5-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, Anup Patel <Anup.Patel@wdc.com>,
        linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-e177e2bf-9e37-4a3f-ace1-7888435c7b82@palmerdabbelt.mtv.corp.google.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019 05:22:38 PST (-0800), Anup Patel wrote:
> We select Goldfish RTC driver using QEMU virt machine kconfig option
> to access RTC device on QEMU virt machine.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/Kconfig.socs           | 2 ++
>  arch/riscv/configs/defconfig      | 1 +
>  arch/riscv/configs/rv32_defconfig | 1 +
>  3 files changed, 4 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index bae4907b4880..65cf39867c60 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -28,6 +28,8 @@ config SOC_VIRT
>         select VIRTIO_INPUT
>         select POWER_RESET_SYSCON
>         select POWER_RESET_SYSCON_POWEROFF
> +       select GOLDFISH
> +       select RTC_DRV_GOLDFISH
>         select SIFIVE_PLIC
>         help
>           This enables support for QEMU Virt Machine.
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index bf33bd40ee07..c5e04384ec3d 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -73,6 +73,7 @@ CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SPI=y
> +CONFIG_RTC_CLASS=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
>  CONFIG_AUTOFS4_FS=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 234213b4ea74..7972b1d321c1 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -69,6 +69,7 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
> +CONFIG_RTC_CLASS=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
>  CONFIG_AUTOFS4_FS=y

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
