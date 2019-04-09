Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3C7C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BD12084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j3xji1JK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDIQoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:44:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33018 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfDIQoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:44:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id h5so5430487pfo.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xgN3naQXpVOCILTavuLanLOPpb06iUfQezeZYDzCD6g=;
        b=j3xji1JKVYHEwoR6E0rbHe3Hj04GjCJXFF7pfIzoaOlkvkekdYPOt4HkqLUdJLhp6N
         fyEFeHimBpCaGazM/FvGovg5FzvmyLxj6xB4eO0ptLYUpdn1ogU5ecrT0mGI0DaFY76h
         w+/mfqHj3nJO3YeR5vJfjxB02Qxkqu4a0lZcNZjZj7xYnTuu51kM88+nwGmUuW9WrGqf
         KJcdVc8GnLnr/sCSyiFUDvNCA2RPiTdU4oFON6DXIBaDx0a+jFfj2zhMLxXWVLiN9XBo
         DCV17mWabJ8lUxw/ZxkWvQdksbrnQENklBjjA1WfRcDyvWgvDLGolZLSlMhTClZ/egrK
         29KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xgN3naQXpVOCILTavuLanLOPpb06iUfQezeZYDzCD6g=;
        b=J6EBDq8rhKBHFVyHjcFH+X+UxBguxaXpzABSyE3lyBo8wzaLL/aHmwH25pWtOIb8jN
         md17fnLAhH7BTcBRpcWK0/Vb7HlGvwd18DxHRY1IebTlskJQjRFfnhDeuXqYtA3Jc2jv
         BH6kz1obxdh2mtSWkHXFfd15TsTdoF2F3CIXbMCvIQNJ1nLc++elluadxV6JckDcqyAn
         gmCJYczuA5ghV9rx0kn2sslw18l/g5yYIkHbpo4eFkaNkVYm1VtX/Bbc7wkltdpJ+3l/
         fdSWvL4j8uIVht7s+ITyzOr3LF3KDACgAWaNEEbwtdfVDZd+lY1EFClknTMQm/Hndgjj
         ehnw==
X-Gm-Message-State: APjAAAVDl+OTddWIXI2Cjqnxml1n6s1lNK55lSLvITvgZmiLB6au08Zk
        U8p+m5sXwqxH6duKjQEYQ6h1Cg==
X-Google-Smtp-Source: APXvYqx8XDsDzi6W8CPGNC0ffD5U3kx5WCbkvmcn7IhbqHuxj4wXpfgTwn7gkO9mxFGVq0iP5CJHtA==
X-Received: by 2002:a63:4f52:: with SMTP id p18mr35313644pgl.333.1554828242739;
        Tue, 09 Apr 2019 09:44:02 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b63sm92422918pfj.54.2019.04.09.09.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:44:01 -0700 (PDT)
Date:   Tue, 09 Apr 2019 09:44:01 -0700 (PDT)
X-Google-Original-Date: Tue, 09 Apr 2019 09:43:56 PDT (-0700)
Subject:     Re: [PATCH 1/3] RISC-V: Add separate defconfig for 32bit systems
In-Reply-To: <20190312220752.128141-2-anup.patel@wdc.com>
CC:     aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-02f905c7-fb28-4997-9769-2cb88c581881@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 15:08:12 PDT (-0700), Anup Patel wrote:
> This patch adds rv32_defconfig for 32bit systems. The only
> difference between rv32_defconfig and defconfig is that
> rv32_defconfig has  CONFIG_ARCH_RV32I=y.

Thanks.  I think it makes sense to have this in 5.1 so I'm going to take it 
into the next RC.

>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/configs/rv32_defconfig | 84 +++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 arch/riscv/configs/rv32_defconfig
>
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> new file mode 100644
> index 000000000000..1a911ed8e772
> --- /dev/null
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -0,0 +1,84 @@
> +CONFIG_SYSVIPC=y
> +CONFIG_POSIX_MQUEUE=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> +CONFIG_CGROUPS=y
> +CONFIG_CGROUP_SCHED=y
> +CONFIG_CFS_BANDWIDTH=y
> +CONFIG_CGROUP_BPF=y
> +CONFIG_NAMESPACES=y
> +CONFIG_USER_NS=y
> +CONFIG_CHECKPOINT_RESTORE=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_EXPERT=y
> +CONFIG_BPF_SYSCALL=y
> +CONFIG_ARCH_RV32I=y
> +CONFIG_SMP=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_UNLOAD=y
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_UNIX=y
> +CONFIG_INET=y
> +CONFIG_IP_MULTICAST=y
> +CONFIG_IP_ADVANCED_ROUTER=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +CONFIG_IP_PNP_BOOTP=y
> +CONFIG_IP_PNP_RARP=y
> +CONFIG_NETLINK_DIAG=y
> +CONFIG_PCI=y
> +CONFIG_PCIEPORTBUS=y
> +CONFIG_PCI_HOST_GENERIC=y
> +CONFIG_PCIE_XILINX=y
> +CONFIG_DEVTMPFS=y
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_VIRTIO_BLK=y
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_BLK_DEV_SR=y
> +CONFIG_ATA=y
> +CONFIG_SATA_AHCI=y
> +CONFIG_SATA_AHCI_PLATFORM=y
> +CONFIG_NETDEVICES=y
> +CONFIG_VIRTIO_NET=y
> +CONFIG_MACB=y
> +CONFIG_E1000E=y
> +CONFIG_R8169=y
> +CONFIG_MICROSEMI_PHY=y
> +CONFIG_INPUT_MOUSEDEV=y
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
> +CONFIG_HVC_RISCV_SBI=y
> +# CONFIG_PTP_1588_CLOCK is not set
> +CONFIG_DRM=y
> +CONFIG_DRM_RADEON=y
> +CONFIG_FRAMEBUFFER_CONSOLE=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_PLATFORM=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_HCD_PLATFORM=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_HCD_PLATFORM=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_UAS=y
> +CONFIG_VIRTIO_MMIO=y
> +CONFIG_SIFIVE_PLIC=y
> +CONFIG_EXT4_FS=y
> +CONFIG_EXT4_FS_POSIX_ACL=y
> +CONFIG_AUTOFS4_FS=y
> +CONFIG_MSDOS_FS=y
> +CONFIG_VFAT_FS=y
> +CONFIG_TMPFS=y
> +CONFIG_TMPFS_POSIX_ACL=y
> +CONFIG_NFS_FS=y
> +CONFIG_NFS_V4=y
> +CONFIG_NFS_V4_1=y
> +CONFIG_NFS_V4_2=y
> +CONFIG_ROOT_NFS=y
> +CONFIG_CRYPTO_USER_API_HASH=y
> +CONFIG_CRYPTO_DEV_VIRTIO=y
> +CONFIG_PRINTK_TIME=y
> +# CONFIG_RCU_TRACE is not set
> -- 
> 2.17.1
