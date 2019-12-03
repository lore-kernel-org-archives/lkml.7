Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51370C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4BC2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="EBogXKR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfLCDGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:06:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37208 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfLCDGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:06:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so1802685wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 19:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbCH5ti3WgkMkBOgo2DeVgGqRNAZsfv1Xo4frH8ttaY=;
        b=EBogXKR7T/7BONpi+EENQ/V0EL8cRhsZe2zmGwkQdue0vzn4CY0piD7aLAxSorCKYN
         BpQ5i3zI7L2XF/4T8Po/sR1AeP7kY6289Wf1FCj1JBuhDWfoZS8/hz/tLJUbNxWtqgjF
         Xr/pqghQtgGtykmXwIDCDGERPuj9pq1JiSohPxqWiMHUtPy1uuZoGnzNIq10dF9HhqvA
         9RuVXAHWkNB5d40duT7VNllrazCLb5AOMYzRoiR4tmAHyxL288nxt6WKQvwaiThhIDs4
         EbJOyJRLNjDddueqvySSFLlcN0YMolSLzRYSuB8aMXhe+57oPqqjnVv/XJC8VFBrUChU
         KN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbCH5ti3WgkMkBOgo2DeVgGqRNAZsfv1Xo4frH8ttaY=;
        b=iihg2DNWqfsqinCfNblxQwUeI2XItbU/ZR3t6pvdWKJ69OQQnTTimoUq9nsmRdgzYO
         WJWMAun5Y6aS+Ia3m/ONk5Aa5NG8Qhomu7ixVnZgzE1WHWGOdmXalM5hQdjfVmAbK16n
         4Af5zzOZBqvgiM9PllwY12nf4OiK0bGNw1gR5qmdW5hpvjj3R5ud0BL1I2jm60dXxyqs
         u2ulwcUASbg8LwgnkbpgssdqRkr4NYSOAU4jCD9WtooZ6fiCmRa4JdqZh4o6NEEXuPSk
         p+KEvDpH06CMH1cbCUflxPjPThbjl2adXy/AH9qn5uWMTdzRKlVl3XoEucMal9/UakDH
         2Zgw==
X-Gm-Message-State: APjAAAWXSvBuQGitHpP2t+B+I6412dJgnlV3Ou8UT5PexX/ELsQ9r3Vc
        QjmsJbg/MsA/U+7vJbLctWCAeXCpi5NAmvwJbV/7tQ==
X-Google-Smtp-Source: APXvYqzNUNSP4cVX59HXAFObvgW6LbUoGAxo45f6uIiy0i+c/bDHKyai2czxSdFyUIIOH7Y8JQwFC7Krum+fvLWUiWc=
X-Received: by 2002:a1c:3105:: with SMTP id x5mr29912268wmx.24.1575342405331;
 Mon, 02 Dec 2019 19:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20191125132147.97111-1-anup.patel@wdc.com> <20191125132147.97111-3-anup.patel@wdc.com>
 <bfd66a0d4f4e5ec112244101bc4173aef9a56286.camel@wdc.com>
In-Reply-To: <bfd66a0d4f4e5ec112244101bc4173aef9a56286.camel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 3 Dec 2019 08:36:35 +0530
Message-ID: <CAAhSdy0V5ANkK1ykW0pr_uX2=fUmAbgfvvUr6aZoMUZQAiCWZw@mail.gmail.com>
Subject: Re: [PATCH 2/4] RISC-V: Enable QEMU virt machine support in defconfigs
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "hch@lst.de" <hch@lst.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:44 AM Atish Patra <Atish.Patra@wdc.com> wrote:
>
> On Mon, 2019-11-25 at 13:22 +0000, Anup Patel wrote:
> > We have kconfig option for QEMU virt machine so let's enable it
> > in RV32 and RV64 defconfigs.
> >
>
> and remove the virt specific configs from defconfig.
>
> Bit more verbose commit text makes more sense here.

The virt specific configs are automatically removed by "savedefconfig"
so I did not mention it in commit message.

I will certainly update commit message like you suggested.

>
>
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/configs/defconfig      | 15 +--------------
> >  arch/riscv/configs/rv32_defconfig | 16 +---------------
> >  2 files changed, 2 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/riscv/configs/defconfig
> > b/arch/riscv/configs/defconfig
> > index 420a0dbef386..2515fe6417e1 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -15,6 +15,7 @@ CONFIG_BLK_DEV_INITRD=y
> >  CONFIG_EXPERT=y
> >  CONFIG_BPF_SYSCALL=y
> >  CONFIG_SOC_SIFIVE=y
> > +CONFIG_SOC_VIRT=y
> >  CONFIG_SMP=y
> >  CONFIG_MODULES=y
> >  CONFIG_MODULE_UNLOAD=y
> > @@ -30,7 +31,6 @@ CONFIG_IP_PNP_BOOTP=y
> >  CONFIG_IP_PNP_RARP=y
> >  CONFIG_NETLINK_DIAG=y
> >  CONFIG_NET_9P=y
> > -CONFIG_NET_9P_VIRTIO=y
> >  CONFIG_PCI=y
> >  CONFIG_PCIEPORTBUS=y
> >  CONFIG_PCI_HOST_GENERIC=y
> > @@ -38,15 +38,12 @@ CONFIG_PCIE_XILINX=y
> >  CONFIG_DEVTMPFS=y
> >  CONFIG_DEVTMPFS_MOUNT=y
> >  CONFIG_BLK_DEV_LOOP=y
> > -CONFIG_VIRTIO_BLK=y
> >  CONFIG_BLK_DEV_SD=y
> >  CONFIG_BLK_DEV_SR=y
> > -CONFIG_SCSI_VIRTIO=y
> >  CONFIG_ATA=y
> >  CONFIG_SATA_AHCI=y
> >  CONFIG_SATA_AHCI_PLATFORM=y
> >  CONFIG_NETDEVICES=y
> > -CONFIG_VIRTIO_NET=y
> >  CONFIG_MACB=y
> >  CONFIG_E1000E=y
> >  CONFIG_R8169=y
> > @@ -57,15 +54,12 @@ CONFIG_SERIAL_8250_CONSOLE=y
> >  CONFIG_SERIAL_OF_PLATFORM=y
> >  CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
> >  CONFIG_HVC_RISCV_SBI=y
> > -CONFIG_VIRTIO_CONSOLE=y
> >  CONFIG_HW_RANDOM=y
> > -CONFIG_HW_RANDOM_VIRTIO=y
> >  CONFIG_SPI=y
> >  CONFIG_SPI_SIFIVE=y
> >  # CONFIG_PTP_1588_CLOCK is not set
> >  CONFIG_DRM=y
> >  CONFIG_DRM_RADEON=y
> > -CONFIG_DRM_VIRTIO_GPU=y
> >  CONFIG_FRAMEBUFFER_CONSOLE=y
> >  CONFIG_USB=y
> >  CONFIG_USB_XHCI_HCD=y
> > @@ -78,12 +72,6 @@ CONFIG_USB_STORAGE=y
> >  CONFIG_USB_UAS=y
> >  CONFIG_MMC=y
> >  CONFIG_MMC_SPI=y
> > -CONFIG_VIRTIO_PCI=y
> > -CONFIG_VIRTIO_BALLOON=y
> > -CONFIG_VIRTIO_INPUT=y
> > -CONFIG_VIRTIO_MMIO=y
> > -CONFIG_RPMSG_CHAR=y
> > -CONFIG_RPMSG_VIRTIO=y
> >  CONFIG_EXT4_FS=y
> >  CONFIG_EXT4_FS_POSIX_ACL=y
> >  CONFIG_AUTOFS4_FS=y
> > @@ -98,6 +86,5 @@ CONFIG_NFS_V4_2=y
> >  CONFIG_ROOT_NFS=y
> >  CONFIG_9P_FS=y
> >  CONFIG_CRYPTO_USER_API_HASH=y
> > -CONFIG_CRYPTO_DEV_VIRTIO=y
> >  CONFIG_PRINTK_TIME=y
> >  # CONFIG_RCU_TRACE is not set
> > diff --git a/arch/riscv/configs/rv32_defconfig
> > b/arch/riscv/configs/rv32_defconfig
> > index 87ee6e62b64b..bbcf14fd6f40 100644
> > --- a/arch/riscv/configs/rv32_defconfig
> > +++ b/arch/riscv/configs/rv32_defconfig
> > @@ -14,6 +14,7 @@ CONFIG_CHECKPOINT_RESTORE=y
> >  CONFIG_BLK_DEV_INITRD=y
> >  CONFIG_EXPERT=y
> >  CONFIG_BPF_SYSCALL=y
> > +CONFIG_SOC_VIRT=y
> >  CONFIG_ARCH_RV32I=y
> >  CONFIG_SMP=y
> >  CONFIG_MODULES=y
> > @@ -30,7 +31,6 @@ CONFIG_IP_PNP_BOOTP=y
> >  CONFIG_IP_PNP_RARP=y
> >  CONFIG_NETLINK_DIAG=y
> >  CONFIG_NET_9P=y
> > -CONFIG_NET_9P_VIRTIO=y
> >  CONFIG_PCI=y
> >  CONFIG_PCIEPORTBUS=y
> >  CONFIG_PCI_HOST_GENERIC=y
> > @@ -38,15 +38,12 @@ CONFIG_PCIE_XILINX=y
> >  CONFIG_DEVTMPFS=y
> >  CONFIG_DEVTMPFS_MOUNT=y
> >  CONFIG_BLK_DEV_LOOP=y
> > -CONFIG_VIRTIO_BLK=y
> >  CONFIG_BLK_DEV_SD=y
> >  CONFIG_BLK_DEV_SR=y
> > -CONFIG_SCSI_VIRTIO=y
> >  CONFIG_ATA=y
> >  CONFIG_SATA_AHCI=y
> >  CONFIG_SATA_AHCI_PLATFORM=y
> >  CONFIG_NETDEVICES=y
> > -CONFIG_VIRTIO_NET=y
> >  CONFIG_MACB=y
> >  CONFIG_E1000E=y
> >  CONFIG_R8169=y
> > @@ -57,13 +54,10 @@ CONFIG_SERIAL_8250_CONSOLE=y
> >  CONFIG_SERIAL_OF_PLATFORM=y
> >  CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
> >  CONFIG_HVC_RISCV_SBI=y
> > -CONFIG_VIRTIO_CONSOLE=y
> >  CONFIG_HW_RANDOM=y
> > -CONFIG_HW_RANDOM_VIRTIO=y
> >  # CONFIG_PTP_1588_CLOCK is not set
> >  CONFIG_DRM=y
> >  CONFIG_DRM_RADEON=y
> > -CONFIG_DRM_VIRTIO_GPU=y
> >  CONFIG_FRAMEBUFFER_CONSOLE=y
> >  CONFIG_USB=y
> >  CONFIG_USB_XHCI_HCD=y
> > @@ -74,13 +68,6 @@ CONFIG_USB_OHCI_HCD=y
> >  CONFIG_USB_OHCI_HCD_PLATFORM=y
> >  CONFIG_USB_STORAGE=y
> >  CONFIG_USB_UAS=y
> > -CONFIG_VIRTIO_PCI=y
> > -CONFIG_VIRTIO_BALLOON=y
> > -CONFIG_VIRTIO_INPUT=y
> > -CONFIG_VIRTIO_MMIO=y
> > -CONFIG_RPMSG_CHAR=y
> > -CONFIG_RPMSG_VIRTIO=y
> > -CONFIG_SIFIVE_PLIC=y
> >  CONFIG_EXT4_FS=y
> >  CONFIG_EXT4_FS_POSIX_ACL=y
> >  CONFIG_AUTOFS4_FS=y
> > @@ -95,6 +82,5 @@ CONFIG_NFS_V4_2=y
> >  CONFIG_ROOT_NFS=y
> >  CONFIG_9P_FS=y
> >  CONFIG_CRYPTO_USER_API_HASH=y
> > -CONFIG_CRYPTO_DEV_VIRTIO=y
> >  CONFIG_PRINTK_TIME=y
> >  # CONFIG_RCU_TRACE is not set
>
> Otherwise, looks good.
>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>

Thanks,
Anup
