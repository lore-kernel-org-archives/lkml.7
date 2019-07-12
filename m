Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58EEC742C7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AAC20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfGLOwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:52:25 -0400
Received: from foss.arm.com ([217.140.110.172]:58764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfGLOwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:52:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 321FD2B;
        Fri, 12 Jul 2019 07:52:24 -0700 (PDT)
Received: from [10.1.34.155] (e110723.arm.com [10.1.34.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 306493F59C;
        Fri, 12 Jul 2019 07:52:23 -0700 (PDT)
Subject: Re: [PATCH 17/17] riscv: add nommu support
To:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190624054311.30256-1-hch@lst.de>
 <20190624054311.30256-18-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <7b382b7a-41b6-62a5-02ab-189b3da9df70@arm.com>
Date:   Fri, 12 Jul 2019 15:52:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624054311.30256-18-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 6/24/19 6:43 AM, Christoph Hellwig wrote:
> The kernel runs in M-mode without using page tables, and thus can't run
> bare metal without help from additional firmware.
> 
> Most of the patch is just stubbing out code not needed without page
> tables, but there is an interesting detail in the signals implementation:
> 
>  - The normal RISC-V syscall ABI only implements rt_sigreturn as VDSO
>    entry point, but the ELF VDSO is not supported for nommu Linux.
>    We instead copy the code to call the syscall onto the stack.
> 
> In addition to enabling the nommu code a new defconfig for a small
> kernel image that can run in nommu mode on qemu is also provided, to run
> a kernel in qemu you can use the following command line:
> 
> qemu-system-riscv64 -smp 2 -m 64 -machine virt -nographic \
> 	-kernel arch/riscv/boot/loader \
> 	-drive file=rootfs.ext2,format=raw,id=hd0 \
> 	-device virtio-blk-device,drive=hd0
> 
> Contains contributions from Damien Le Moal <Damien.LeMoal@wdc.com>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/Kconfig                      | 24 +++++---
>  arch/riscv/configs/nommu_virt_defconfig | 78 +++++++++++++++++++++++++
>  arch/riscv/include/asm/elf.h            |  4 +-
>  arch/riscv/include/asm/futex.h          |  6 ++
>  arch/riscv/include/asm/io.h             |  4 ++
>  arch/riscv/include/asm/mmu.h            |  3 +
>  arch/riscv/include/asm/page.h           | 12 +++-
>  arch/riscv/include/asm/pgalloc.h        |  2 +
>  arch/riscv/include/asm/pgtable.h        | 38 ++++++++----
>  arch/riscv/include/asm/tlbflush.h       |  7 ++-
>  arch/riscv/include/asm/uaccess.h        |  4 ++
>  arch/riscv/kernel/Makefile              |  3 +-
>  arch/riscv/kernel/entry.S               | 11 ++++
>  arch/riscv/kernel/head.S                |  6 ++
>  arch/riscv/kernel/signal.c              | 17 +++++-
>  arch/riscv/lib/Makefile                 |  8 +--
>  arch/riscv/mm/Makefile                  |  3 +-
>  arch/riscv/mm/cacheflush.c              |  2 +
>  arch/riscv/mm/context.c                 |  2 +
>  arch/riscv/mm/init.c                    |  2 +
>  20 files changed, 200 insertions(+), 36 deletions(-)
>  create mode 100644 arch/riscv/configs/nommu_virt_defconfig
> 

snip...

>  
> diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
> new file mode 100644
> index 000000000000..cf74e179bf90
> --- /dev/null
> +++ b/arch/riscv/configs/nommu_virt_defconfig
> @@ -0,0 +1,78 @@
> +# CONFIG_CPU_ISOLATION is not set
> +CONFIG_LOG_BUF_SHIFT=16
> +CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=12
> +CONFIG_BLK_DEV_INITRD=y
> +# CONFIG_RD_BZIP2 is not set
> +# CONFIG_RD_LZMA is not set
> +# CONFIG_RD_XZ is not set
> +# CONFIG_RD_LZO is not set
> +# CONFIG_RD_LZ4 is not set
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> +CONFIG_EXPERT=y
> +# CONFIG_SYSFS_SYSCALL is not set
> +# CONFIG_FHANDLE is not set
> +# CONFIG_BASE_FULL is not set
> +# CONFIG_EPOLL is not set
> +# CONFIG_SIGNALFD is not set
> +# CONFIG_TIMERFD is not set
> +# CONFIG_EVENTFD is not set
> +# CONFIG_AIO is not set
> +# CONFIG_IO_URING is not set
> +# CONFIG_ADVISE_SYSCALLS is not set
> +# CONFIG_MEMBARRIER is not set
> +# CONFIG_KALLSYMS is not set
> +# CONFIG_VM_EVENT_COUNTERS is not set
> +# CONFIG_COMPAT_BRK is not set
> +CONFIG_SLOB=y
> +# CONFIG_SLAB_MERGE_DEFAULT is not set
> +# CONFIG_MMU is not set
> +CONFIG_MAXPHYSMEM_2GB=y
> +CONFIG_SMP=y
> +CONFIG_CMDLINE="root=/dev/vda rw earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0"
> +CONFIG_CMDLINE_FORCE=y
> +# CONFIG_BLK_DEV_BSG is not set
> +CONFIG_PARTITION_ADVANCED=y
> +# CONFIG_MSDOS_PARTITION is not set
> +# CONFIG_EFI_PARTITION is not set
> +# CONFIG_MQ_IOSCHED_DEADLINE is not set
> +# CONFIG_MQ_IOSCHED_KYBER is not set
> +CONFIG_BINFMT_FLAT=y

IIUC, RISC-V requires stack pointer to be 16 byte aligned, but flat loader would
align stack pointer to max(sizeof(void *), ARCH_SLAB_MINALIGN). So, I think you
might want to define ARCH_SLAB_MINALIGN.

Cheers
Vladimir
