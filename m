Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F78C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED98B208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="doWrYOHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfFYX6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:58:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43172 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYX6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:58:22 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so979684ios.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 16:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X10CEmTyvmwap+mWmXerOzteu8YFsqoourzADX4/hog=;
        b=doWrYOHe0blD25nTaUdjWNVLPQptm83C4IQR4ubJmYx24JF+h7eLoDx/4t0QF+9OQr
         11bp/AlXxLjuxFD+Wm9Ianlk2D3UdFsG9x/OFccwb3PGD7vwF+K+9m2ThDCkSqLnkH6s
         LxdF1uX/7Nh9dSuyRSNs04MBUzQyjhr+jrs/qvRd9KfE45LDerhCZ9pUvMghgDmF4UUe
         ZRlymZT4F/M9u1/1r2zqmhngQddJcZwFNhWSnrU5FITvgzZoYlEMj/olDAW3j/vYbuga
         aiRUgQd5TQ26RYXkE6KRLYH3S58Xk6O2TWMzOaWEilwKfR1VzwspGvpp2QBDHGbWlBIl
         9Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X10CEmTyvmwap+mWmXerOzteu8YFsqoourzADX4/hog=;
        b=dg3vx5LaOnWy2ZGQEXz5s2LnUII/v+T/1G4aFcD5sC+t37KPd4hKPeWpQGiPUyaQGj
         lKblrlVumHaBTcBUBU4b+L/DsN2ujVUVqm5Q3ijFwL7EVeGZeSKBFgbKnmZAVGme/MKU
         1tPeAFrUdcaNz/E+hvLRzTlZiRqMkmn8n+fhtF/bJs4ViX5vQJ920hugRNtQOL6LDvz4
         E6kLxZGdR0p3FUttHRrD5qLz0ZtM2WybCXIUJ3BF8rz3rqKZDkC0ip/uifhk3SNr9Y31
         dknmrIWqQ3r9EXS+yqSoKTXiiN76sGfv12r9Q8hbbPrXLmxV0MO49A+72bTaJhVJq3C4
         h7FA==
X-Gm-Message-State: APjAAAUYeipsT6wGeOEOdZJTOVUw9f3urFsQR7Zs4FF4m7t8iQYqYpqq
        yfyrVGSqVnmsHkFPQM9YWFQT2Q==
X-Google-Smtp-Source: APXvYqy7wM3KxWMf/5KpPe9u0wUBChNk/HNgz2aZE4W8C2Zl9QnXBvy58DFBYCTt+fJnrDiUz29Qvw==
X-Received: by 2002:a6b:d81a:: with SMTP id y26mr1590944iob.126.1561507101402;
        Tue, 25 Jun 2019 16:58:21 -0700 (PDT)
Received: from crackbook-pro.lan (206-55-177-132.fttp.usinternet.com. [206.55.177.132])
        by smtp.gmail.com with ESMTPSA id f17sm33444111ioc.2.2019.06.25.16.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 16:58:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] RISC-V: defconfig: enable MMC & SPI for RISC-V
From:   Troy Benjegerdes <troy.benjegerdes@sifive.com>
In-Reply-To: <20190625225636.9288-1-atish.patra@wdc.com>
Date:   Tue, 25 Jun 2019 18:58:20 -0500
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Olof Johansson <olof@lixom.net>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: 7bit
Message-Id: <6D4D90AF-59F9-4523-A916-7CFAC8E43C45@sifive.com>
References: <20190625225636.9288-1-atish.patra@wdc.com>
To:     Atish Patra <atish.patra@wdc.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 25, 2019, at 5:56 PM, Atish Patra <atish.patra@wdc.com> wrote:
> 
> Currently, riscv upstream defconfig doesn't let you boot
> through userspace if rootfs is on the SD card.
> 
> Let's enable MMC & SPI drivers as well so that one can boot
> to the user space using default config in upstream kernel.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
> arch/riscv/configs/defconfig | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 4f02967e55de..04944fb4fa7a 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -69,6 +69,7 @@ CONFIG_VIRTIO_MMIO=y
> CONFIG_CLK_SIFIVE=y
> CONFIG_CLK_SIFIVE_FU540_PRCI=y
> CONFIG_SIFIVE_PLIC=y
> +CONFIG_SPI_SIFIVE=y
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_AUTOFS4_FS=y
> @@ -84,4 +85,8 @@ CONFIG_ROOT_NFS=y
> CONFIG_CRYPTO_USER_API_HASH=y
> CONFIG_CRYPTO_DEV_VIRTIO=y
> CONFIG_PRINTK_TIME=y
> +CONFIG_SPI=y
> +CONFIG_MMC_SPI=y
> +CONFIG_MMC=y
> +CONFIG_DEVTMPFS_MOUNT=y
> # CONFIG_RCU_TRACE is not set
> -- 
> 2.21.0

While we are doing this, can we add and test the /dev/mtd device?

I tried adding the following but I am missing something

CONFIG_MTD=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK_RO=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_M25P80=y
CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y

and I see this in the log

[    1.106626] m25p80 spi0.0: unrecognized JEDEC id bytes: 9d 70 19 9d 70 19


