Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFA1C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06EE20684
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjhqmGAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLBXcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:32:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38875 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLBXcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:32:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id o8so755908pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6tCx0xpaZr/XSR1WIa5s+CeKR3QHvjhI5hsm121lnno=;
        b=VjhqmGAa5cXTvDGcC4jNfN/xABhpCNjayFZR6Dk8dqk5MZw05zB+oOBfLgXe5eO+Zt
         0BfGJXURBpV6AHJDCduhM999tIzdn9aLv2isJJlWuBj9OgK4tNpXsYHz1i03B5b2snZu
         0k7Tab6W+vtM5Ra1ySThKYV0Cz49v+YVhQPKfFvW1w7su2myMlBCkrLSyBetfKnwcfMa
         FomVlywjj64YJgxbQJTcOysMGMcG1WtSYroZhn0vfwWWAoiDD92MSXXyetFGVY+ygpUN
         82PtIiw7BjNpIEVYzcfWLZohCepj35S4pUf+dlOmAFae3IXCPjgQo2BoZ1MH71yCUKKv
         AVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6tCx0xpaZr/XSR1WIa5s+CeKR3QHvjhI5hsm121lnno=;
        b=rIHRqMy0XqSKKmdlFKfZX/5kBmHxmnUJCWRtO0PvSOKMYyB+LytECYwjBS0avmH2P3
         HN/c5ixsosb3felmLUSD3bcZLuM7h/paoCqKJ7MfME58ufteMf3mGq8uQFmaYMkbql7D
         5HnMNFWsF0bfXFwjL4ExfxBvW+IXmdUZs2u01VWimtEuG5nM+YZvmMlPaEoTCNT7qZAM
         cyA5nI+RiWYcFtK36hjIqUmfPAKC9jZBePZGwngRdcoBHg6mW2JUoXTPwKfV5q/b6FTn
         zgPjxaym5jKR4QAkA7mzxfy4125a17GzO6+QMsbUbTdF77Aesxr7mXhVkse8F0Wu3uNO
         BRKA==
X-Gm-Message-State: APjAAAW5uQaQeMCwNvB+0vtcfQfC0HHAQ9AoCnRovQv3sZL/rpY0oDJW
        SrbZhSs0lI6k5J6aHXVtdVvE+A==
X-Google-Smtp-Source: APXvYqydgBmoG6TcLcLG+sVeP6rpWk2NkPEduGd6XFXqGsnsg7Yr2O2DCOQInzRHQ2F7XlDewyDdjA==
X-Received: by 2002:a17:902:7607:: with SMTP id k7mr1797761pll.277.1575329571300;
        Mon, 02 Dec 2019 15:32:51 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
        by smtp.gmail.com with ESMTPSA id a22sm624843pfk.108.2019.12.02.15.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 15:32:50 -0800 (PST)
Date:   Mon, 02 Dec 2019 15:32:50 -0800 (PST)
X-Google-Original-Date: Mon, 02 Dec 2019 15:24:46 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH 2/4] RISC-V: Enable QEMU virt machine support in defconfigs
In-Reply-To: <bfd66a0d4f4e5ec112244101bc4173aef9a56286.camel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@sifive.com,
        Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-4fd4132f-6164-47e0-a713-8fea56c49b99@palmerdabbelt.mtv.corp.google.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 11:14:37 PST (-0800), Atish Patra wrote:
> On Mon, 2019-11-25 at 13:22 +0000, Anup Patel wrote:
>> We have kconfig option for QEMU virt machine so let's enable it
>> in RV32 and RV64 defconfigs.
>>
>
> and remove the virt specific configs from defconfig.
>
> Bit more verbose commit text makes more sense here.
>
>
>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> ---
>>  arch/riscv/configs/defconfig      | 15 +--------------
>>  arch/riscv/configs/rv32_defconfig | 16 +---------------
>>  2 files changed, 2 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/riscv/configs/defconfig
>> b/arch/riscv/configs/defconfig
>> index 420a0dbef386..2515fe6417e1 100644
>> --- a/arch/riscv/configs/defconfig
>> +++ b/arch/riscv/configs/defconfig
>> @@ -15,6 +15,7 @@ CONFIG_BLK_DEV_INITRD=y
>>  CONFIG_EXPERT=y
>>  CONFIG_BPF_SYSCALL=y
>>  CONFIG_SOC_SIFIVE=y
>> +CONFIG_SOC_VIRT=y
>>  CONFIG_SMP=y
>>  CONFIG_MODULES=y
>>  CONFIG_MODULE_UNLOAD=y
>> @@ -30,7 +31,6 @@ CONFIG_IP_PNP_BOOTP=y
>>  CONFIG_IP_PNP_RARP=y
>>  CONFIG_NETLINK_DIAG=y
>>  CONFIG_NET_9P=y
>> -CONFIG_NET_9P_VIRTIO=y
>>  CONFIG_PCI=y
>>  CONFIG_PCIEPORTBUS=y
>>  CONFIG_PCI_HOST_GENERIC=y
>> @@ -38,15 +38,12 @@ CONFIG_PCIE_XILINX=y
>>  CONFIG_DEVTMPFS=y
>>  CONFIG_DEVTMPFS_MOUNT=y
>>  CONFIG_BLK_DEV_LOOP=y
>> -CONFIG_VIRTIO_BLK=y
>>  CONFIG_BLK_DEV_SD=y
>>  CONFIG_BLK_DEV_SR=y
>> -CONFIG_SCSI_VIRTIO=y
>>  CONFIG_ATA=y
>>  CONFIG_SATA_AHCI=y
>>  CONFIG_SATA_AHCI_PLATFORM=y
>>  CONFIG_NETDEVICES=y
>> -CONFIG_VIRTIO_NET=y
>>  CONFIG_MACB=y
>>  CONFIG_E1000E=y
>>  CONFIG_R8169=y
>> @@ -57,15 +54,12 @@ CONFIG_SERIAL_8250_CONSOLE=y
>>  CONFIG_SERIAL_OF_PLATFORM=y
>>  CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>>  CONFIG_HVC_RISCV_SBI=y
>> -CONFIG_VIRTIO_CONSOLE=y
>>  CONFIG_HW_RANDOM=y
>> -CONFIG_HW_RANDOM_VIRTIO=y
>>  CONFIG_SPI=y
>>  CONFIG_SPI_SIFIVE=y
>>  # CONFIG_PTP_1588_CLOCK is not set
>>  CONFIG_DRM=y
>>  CONFIG_DRM_RADEON=y
>> -CONFIG_DRM_VIRTIO_GPU=y
>>  CONFIG_FRAMEBUFFER_CONSOLE=y
>>  CONFIG_USB=y
>>  CONFIG_USB_XHCI_HCD=y
>> @@ -78,12 +72,6 @@ CONFIG_USB_STORAGE=y
>>  CONFIG_USB_UAS=y
>>  CONFIG_MMC=y
>>  CONFIG_MMC_SPI=y
>> -CONFIG_VIRTIO_PCI=y
>> -CONFIG_VIRTIO_BALLOON=y
>> -CONFIG_VIRTIO_INPUT=y
>> -CONFIG_VIRTIO_MMIO=y
>> -CONFIG_RPMSG_CHAR=y
>> -CONFIG_RPMSG_VIRTIO=y
>>  CONFIG_EXT4_FS=y
>>  CONFIG_EXT4_FS_POSIX_ACL=y
>>  CONFIG_AUTOFS4_FS=y
>> @@ -98,6 +86,5 @@ CONFIG_NFS_V4_2=y
>>  CONFIG_ROOT_NFS=y
>>  CONFIG_9P_FS=y
>>  CONFIG_CRYPTO_USER_API_HASH=y
>> -CONFIG_CRYPTO_DEV_VIRTIO=y
>>  CONFIG_PRINTK_TIME=y
>>  # CONFIG_RCU_TRACE is not set
>> diff --git a/arch/riscv/configs/rv32_defconfig
>> b/arch/riscv/configs/rv32_defconfig
>> index 87ee6e62b64b..bbcf14fd6f40 100644
>> --- a/arch/riscv/configs/rv32_defconfig
>> +++ b/arch/riscv/configs/rv32_defconfig
>> @@ -14,6 +14,7 @@ CONFIG_CHECKPOINT_RESTORE=y
>>  CONFIG_BLK_DEV_INITRD=y
>>  CONFIG_EXPERT=y
>>  CONFIG_BPF_SYSCALL=y
>> +CONFIG_SOC_VIRT=y
>>  CONFIG_ARCH_RV32I=y
>>  CONFIG_SMP=y
>>  CONFIG_MODULES=y
>> @@ -30,7 +31,6 @@ CONFIG_IP_PNP_BOOTP=y
>>  CONFIG_IP_PNP_RARP=y
>>  CONFIG_NETLINK_DIAG=y
>>  CONFIG_NET_9P=y
>> -CONFIG_NET_9P_VIRTIO=y
>>  CONFIG_PCI=y
>>  CONFIG_PCIEPORTBUS=y
>>  CONFIG_PCI_HOST_GENERIC=y
>> @@ -38,15 +38,12 @@ CONFIG_PCIE_XILINX=y
>>  CONFIG_DEVTMPFS=y
>>  CONFIG_DEVTMPFS_MOUNT=y
>>  CONFIG_BLK_DEV_LOOP=y
>> -CONFIG_VIRTIO_BLK=y
>>  CONFIG_BLK_DEV_SD=y
>>  CONFIG_BLK_DEV_SR=y
>> -CONFIG_SCSI_VIRTIO=y
>>  CONFIG_ATA=y
>>  CONFIG_SATA_AHCI=y
>>  CONFIG_SATA_AHCI_PLATFORM=y
>>  CONFIG_NETDEVICES=y
>> -CONFIG_VIRTIO_NET=y
>>  CONFIG_MACB=y
>>  CONFIG_E1000E=y
>>  CONFIG_R8169=y
>> @@ -57,13 +54,10 @@ CONFIG_SERIAL_8250_CONSOLE=y
>>  CONFIG_SERIAL_OF_PLATFORM=y
>>  CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>>  CONFIG_HVC_RISCV_SBI=y
>> -CONFIG_VIRTIO_CONSOLE=y
>>  CONFIG_HW_RANDOM=y
>> -CONFIG_HW_RANDOM_VIRTIO=y
>>  # CONFIG_PTP_1588_CLOCK is not set
>>  CONFIG_DRM=y
>>  CONFIG_DRM_RADEON=y
>> -CONFIG_DRM_VIRTIO_GPU=y
>>  CONFIG_FRAMEBUFFER_CONSOLE=y
>>  CONFIG_USB=y
>>  CONFIG_USB_XHCI_HCD=y
>> @@ -74,13 +68,6 @@ CONFIG_USB_OHCI_HCD=y
>>  CONFIG_USB_OHCI_HCD_PLATFORM=y
>>  CONFIG_USB_STORAGE=y
>>  CONFIG_USB_UAS=y
>> -CONFIG_VIRTIO_PCI=y
>> -CONFIG_VIRTIO_BALLOON=y
>> -CONFIG_VIRTIO_INPUT=y
>> -CONFIG_VIRTIO_MMIO=y
>> -CONFIG_RPMSG_CHAR=y
>> -CONFIG_RPMSG_VIRTIO=y
>> -CONFIG_SIFIVE_PLIC=y
>>  CONFIG_EXT4_FS=y
>>  CONFIG_EXT4_FS_POSIX_ACL=y
>>  CONFIG_AUTOFS4_FS=y
>> @@ -95,6 +82,5 @@ CONFIG_NFS_V4_2=y
>>  CONFIG_ROOT_NFS=y
>>  CONFIG_9P_FS=y
>>  CONFIG_CRYPTO_USER_API_HASH=y
>> -CONFIG_CRYPTO_DEV_VIRTIO=y
>>  CONFIG_PRINTK_TIME=y
>>  # CONFIG_RCU_TRACE is not set
>
> Otherwise, looks good.
>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
