Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF916C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7654A217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Rw0IgWoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394293AbfIWQOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:14:37 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54788 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388728AbfIWQOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OJEmNf/6r2qtkXIfVrPmpva5EoufV6jod8KLHG9h6gM=; b=Rw0IgWoW0+9k0wMNQDBPTFk01
        nLcgyOb0SqyfsWOFPedthgYbckCvJ/doCJoXesxesimDVoQiWJBVdglrO2LddCgGVJy6cs6rD+Dtx
        5JOGo+GRM/PR7Z3cyrCj/uXJFHGq55UDbEXhUHI1/zAYd7TZu0mxJ3S9noBmPX/YLC116sFTUuHx3
        xCQR1rFbrtAlL/Ofu53WhFT+3g6oXGQhrf4NcQE2iwmTfsw0IadK/IytKqLRGYTf51h3UyWhlar+w
        B6zjaj21EB+eaariw061nVefGY3TeuX7JKUlQacI+0LRomltvdASsGSKX1cWE08KGLzVLYFKdLUkM
        /xbEWosHA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:43164)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iCQyq-0005FM-5z; Mon, 23 Sep 2019 17:14:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iCQyl-0000RY-Py; Mon, 23 Sep 2019 17:14:23 +0100
Date:   Mon, 23 Sep 2019 17:14:23 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Yu Chen <33988979@163.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yu.chen3@zte.com.cn
Subject: Re: [PATCH] arm: export memblock_reserve()d regions via /proc/iomem
Message-ID: <20190923161423.GU25745@shell.armlinux.org.uk>
References: <1569253374-3631-1-git-send-email-33988979@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569253374-3631-1-git-send-email-33988979@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:42:54PM +0800, Yu Chen wrote:
> From: Yu Chen <yu.chen3@zte.com.cn>
> 
> On Sat, 21 Sep 2019 15:51:38, Russell King - ARM Linux admin wrote:
> > On Sat, Sep 21, 2019 at 09:02:49PM +0800, Yu Chen wrote:
> > > From: Yu Chen <yu.chen3@zte.com.cn> 
> > >  
> > > memblock reserved regions are not reported via /proc/iomem on ARM, kexec's
> > > user-space doesn't know about memblock_reserve()d regions and thus
> > > possible for kexec to overwrite with the new kernel or initrd.
> > 
> > Many reserved regions come from the kernel allocating memory during
> > boot.  We don't want to prevent kexec re-using those regions.
> > 
> > > [    0.000000] Booting Linux on physical CPU 0xf00
> > > [    0.000000] Linux version 4.9.115-rt93-dirty (yuchen@localhost.localdomain) (gcc version 6.2.0 (ZTE Embsys-TSP V3.07.2
> > > 0) ) #62 SMP PREEMPT Fri Sep 20 10:39:29 CST 2019
> > > [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=30c5387d
> > > [    0.000000] CPU: div instructions available: patching division code
> > > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> > > [    0.000000] OF: fdt:Machine model: LS1021A TWR Board
> > > [    0.000000] INITRD: 0x80f7f000+0x03695e40 overlaps in-use memory region - disabling initrd
> > 
> > Is the overlapping region one that is marked as reserved in DT?
> 
> the overlapping region is not reserved in DT.
> 
> > Where is the reserved region that overlaps the initrd coming from?
> 
> I found the reserved region that overlaps the initrd is kernel code & data, 
> with memblock=debug cmdline start new kerne:
> 
> / # kexec -l uImage-ls1021a --ramdisk=ramdisk-ls1021a --dtb=fdt --append="root=/
> dev/ram0 rw console=ttyS0,115200 earlyprintk memblock=debug" -d
> Try gzip decompression.
> Try LZMA decompression.
> lzma_decompress_file: read on uImage-ls1021a of 65536 bytes failed
> kernel: 0xb6c71008 kernel_size: 0x317ab8
> MEMORY RANGES
> 0000000080000000-00000000bfffffff (0)
> 0000000080003000-0000000080007fff (1)
> 0000000080e00000-0000000080ffffff (1)
> 00000000810c45a4-00000000810c4fff (1)
> 0000000081ac4000-0000000085159fff (1)
> 000000008515a000-000000008515ffff (1)
> 0000000088000000-000000008b695fff (1)
> 000000008f000000-000000008f004fff (1)
> 00000000af709000-00000000af7eafff (1)
> 00000000af7ed000-00000000afffbfff (1)
> 00000000afffc000-00000000afffcfff (1)
> 00000000afffd000-00000000afffffff (1)
> 00000000bc000000-00000000bfffffff (1)
> zImage header: 0x016f2818 0x00000000 0x00317a78
> zImage size 0x317a78, file size 0x317a78

I see nothing here that suggests either a new kexec or a sufficiently
new kernel.  Hence, kexec lacks all the information to correctly layout
the images in physical memory.

The kernel was augmented with additional information around the
v4.15 time.  See commits:

c772568788b5 ARM: add additional table to compressed kernel
429f7a062e3b ARM: decompressor: fix BSS size calculation
99cf8f903148 ARM: better diagnostics with missing/corrupt dtb

There may be some others also needed, but I forget now, it was two
years ago.

For kexec, you need at least 2.0.17 (2.0.16 merged the wrong version
of one of my patches.)

> kexec_load: entry = 0x80008000 flags = 0x280000
> nr_segments = 3
> segment[0].buf   = 0xb6c71048
> segment[0].bufsz = 0x317a78
> segment[0].mem   = 0x80008000
> segment[0].memsz = 0x318000
> segment[1].buf   = 0xb35db048
> segment[1].bufsz = 0x3695e40
> segment[1].mem   = 0x80f7f000
> segment[1].memsz = 0x3696000
> segment[2].buf   = 0x100b108
> segment[2].bufsz = 0x5090
> segment[2].mem   = 0x84615000
> segment[2].memsz = 0x6000
> / # kexec -e
> [  126.583598] kexec_core: Starting new kernel
> [  126.587815] Disabling non-boot CPUs ...
> [  126.626917] CPU1: shutdown
> [  126.656344] Retrying again to check for CPU kill
> [  126.660947] CPU1 killed.
> [  126.687585] Bye!
> [    0.000000] Booting Linux on physical CPU 0xf00
> [    0.000000] Linux version 4.9.115-rt93-CGEL-V6.02.10.R4-dirty (yuchen@localhost.localdomain) (gcc version 6.2.0 (ZTE Embsys-TSP V3.07.20) ) #62 SMP PREEMPT Fri Sep 20 10:39:29 CST 2019
> [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=30c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt:Machine model: LS1021A TWR Board
> [    0.000000] memblock_reserve: [0x00000080200000-0x000000810c45a3] flags 0x0 arm_memblock_init+0x44/0x23c
> [    0.000000] INITRD: 0x80f7f000+0x03695e40 overlaps in-use memory region - disabling initrd
> [    0.000000] memblock_reserve: [0x00000080003000-0x00000080007fff] flags 0x0 arm_mm_memblock_reserve+0x2c/0x30
> [    0.000000] memblock_reserve: [0x00000084615000-0x0000008461a08f] flags 0x0 early_init_dt_reserve_memory_arch+0x24/0x28
> [    0.000000] memblock_reserve: [0x0000008f000000-0x0000008f004fff] flags 0x0 early_init_dt_reserve_memory_arch+0x24/0x28
> [    0.000000] memblock_reserve: [0x00000088000040-0x0000008b695e3f] flags 0x0 early_init_dt_reserve_memory_arch+0x24/0x28
> [    0.000000] memblock_reserve: [0x000000bc000000-0x000000bfffffff] flags 0x0 memblock_alloc_range_nid+0x78/0x90
>  ... 
>  ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
> 
> this overlay region is [0x00000080200000-0x000000810c45a3]
> 
> Corresponding kernel source code:
> 264 void __init arm_memblock_init(const struct machine_desc *mdesc)
> 265 {
> 266         /* Register the kernel text, kernel data and initrd with memblock. */
> 267         memblock_reserve(__pa(KERNEL_START), KERNEL_END - KERNEL_START);
> 
> > 
> > Thanks.
> > 
> > --  
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> > According to speedtest.net: 11.9Mbps down 500kbps up
> 
> And Sorry, I sent the wrong arm64 patch. if possible, I will resend the second version of the patch.
> 
> Yu Chen
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
