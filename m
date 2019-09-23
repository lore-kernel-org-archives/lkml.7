Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E111C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D0020882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U5VAr7CE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbfIWPnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:43:33 -0400
Received: from m12-11.163.com ([220.181.12.11]:45892 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732195AbfIWPnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=UXtouNp0rH6zNZolZM
        9J5wev9N1CF60dHBAoT9diwwo=; b=U5VAr7CEL+mo9Y0wSZSYHP+j7+j2FUgLKJ
        yITkxRm4pZoLBe/EFKZ5WI2k7k7s7iyPoU1ZIy8/37HlEFvT6aM/qGW6t35b5ca8
        RNKJ+WGl0H5I2qUL5sJjcqh25XZn/tU2OaZkv9bWP/2JCn+DR5VBG1n3repwrLGn
        Nlv242OQ4=
Received: from localhost.localdomain (unknown [117.173.227.76])
        by smtp7 (Coremail) with SMTP id C8CowADn77v854hdtt3BOQ--.4942S2;
        Mon, 23 Sep 2019 23:42:59 +0800 (CST)
From:   Yu Chen <33988979@163.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yu.chen3@zte.com.cn
Subject: Re: [PATCH] arm: export memblock_reserve()d regions via /proc/iomem
Date:   Mon, 23 Sep 2019 23:42:54 +0800
Message-Id: <1569253374-3631-1-git-send-email-33988979@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: C8CowADn77v854hdtt3BOQ--.4942S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF4DuFyxCrykKF17Kr1Dtrb_yoW7Ar17pF
        W5Xr15Wr48tF1UXF4xJr1Uuw4vva1Fyay7Ar13CrnrZFW8GFnrJ348t34UWFy5tr45trnF
        qFs7J3sF9w1UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UuxRgUUUUU=
X-Originating-IP: [117.173.227.76]
X-CM-SenderInfo: attzmmqzxzqiywtou0bp/1tbiKwM5slQHRWf+RAAAso
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <yu.chen3@zte.com.cn>

On Sat, 21 Sep 2019 15:51:38, Russell King - ARM Linux admin wrote:
> On Sat, Sep 21, 2019 at 09:02:49PM +0800, Yu Chen wrote:
> > From: Yu Chen <yu.chen3@zte.com.cn> 
> >  
> > memblock reserved regions are not reported via /proc/iomem on ARM, kexec's
> > user-space doesn't know about memblock_reserve()d regions and thus
> > possible for kexec to overwrite with the new kernel or initrd.
> 
> Many reserved regions come from the kernel allocating memory during
> boot.  We don't want to prevent kexec re-using those regions.
> 
> > [    0.000000] Booting Linux on physical CPU 0xf00
> > [    0.000000] Linux version 4.9.115-rt93-dirty (yuchen@localhost.localdomain) (gcc version 6.2.0 (ZTE Embsys-TSP V3.07.2
> > 0) ) #62 SMP PREEMPT Fri Sep 20 10:39:29 CST 2019
> > [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=30c5387d
> > [    0.000000] CPU: div instructions available: patching division code
> > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> > [    0.000000] OF: fdt:Machine model: LS1021A TWR Board
> > [    0.000000] INITRD: 0x80f7f000+0x03695e40 overlaps in-use memory region - disabling initrd
> 
> Is the overlapping region one that is marked as reserved in DT?

the overlapping region is not reserved in DT.

> Where is the reserved region that overlaps the initrd coming from?

I found the reserved region that overlaps the initrd is kernel code & data, 
with memblock=debug cmdline start new kerne:

/ # kexec -l uImage-ls1021a --ramdisk=ramdisk-ls1021a --dtb=fdt --append="root=/
dev/ram0 rw console=ttyS0,115200 earlyprintk memblock=debug" -d
Try gzip decompression.
Try LZMA decompression.
lzma_decompress_file: read on uImage-ls1021a of 65536 bytes failed
kernel: 0xb6c71008 kernel_size: 0x317ab8
MEMORY RANGES
0000000080000000-00000000bfffffff (0)
0000000080003000-0000000080007fff (1)
0000000080e00000-0000000080ffffff (1)
00000000810c45a4-00000000810c4fff (1)
0000000081ac4000-0000000085159fff (1)
000000008515a000-000000008515ffff (1)
0000000088000000-000000008b695fff (1)
000000008f000000-000000008f004fff (1)
00000000af709000-00000000af7eafff (1)
00000000af7ed000-00000000afffbfff (1)
00000000afffc000-00000000afffcfff (1)
00000000afffd000-00000000afffffff (1)
00000000bc000000-00000000bfffffff (1)
zImage header: 0x016f2818 0x00000000 0x00317a78
zImage size 0x317a78, file size 0x317a78
kexec_load: entry = 0x80008000 flags = 0x280000
nr_segments = 3
segment[0].buf   = 0xb6c71048
segment[0].bufsz = 0x317a78
segment[0].mem   = 0x80008000
segment[0].memsz = 0x318000
segment[1].buf   = 0xb35db048
segment[1].bufsz = 0x3695e40
segment[1].mem   = 0x80f7f000
segment[1].memsz = 0x3696000
segment[2].buf   = 0x100b108
segment[2].bufsz = 0x5090
segment[2].mem   = 0x84615000
segment[2].memsz = 0x6000
/ # kexec -e
[  126.583598] kexec_core: Starting new kernel
[  126.587815] Disabling non-boot CPUs ...
[  126.626917] CPU1: shutdown
[  126.656344] Retrying again to check for CPU kill
[  126.660947] CPU1 killed.
[  126.687585] Bye!
[    0.000000] Booting Linux on physical CPU 0xf00
[    0.000000] Linux version 4.9.115-rt93-CGEL-V6.02.10.R4-dirty (yuchen@localhost.localdomain) (gcc version 6.2.0 (ZTE Embsys-TSP V3.07.20) ) #62 SMP PREEMPT Fri Sep 20 10:39:29 CST 2019
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=30c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: LS1021A TWR Board
[    0.000000] memblock_reserve: [0x00000080200000-0x000000810c45a3] flags 0x0 arm_memblock_init+0x44/0x23c
[    0.000000] INITRD: 0x80f7f000+0x03695e40 overlaps in-use memory region - disabling initrd
[    0.000000] memblock_reserve: [0x00000080003000-0x00000080007fff] flags 0x0 arm_mm_memblock_reserve+0x2c/0x30
[    0.000000] memblock_reserve: [0x00000084615000-0x0000008461a08f] flags 0x0 early_init_dt_reserve_memory_arch+0x24/0x28
[    0.000000] memblock_reserve: [0x0000008f000000-0x0000008f004fff] flags 0x0 early_init_dt_reserve_memory_arch+0x24/0x28
[    0.000000] memblock_reserve: [0x00000088000040-0x0000008b695e3f] flags 0x0 early_init_dt_reserve_memory_arch+0x24/0x28
[    0.000000] memblock_reserve: [0x000000bc000000-0x000000bfffffff] flags 0x0 memblock_alloc_range_nid+0x78/0x90
 ... 
 ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)

this overlay region is [0x00000080200000-0x000000810c45a3]

Corresponding kernel source code:
264 void __init arm_memblock_init(const struct machine_desc *mdesc)
265 {
266         /* Register the kernel text, kernel data and initrd with memblock. */
267         memblock_reserve(__pa(KERNEL_START), KERNEL_END - KERNEL_START);

> 
> Thanks.
> 
> --  
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

And Sorry, I sent the wrong arm64 patch. if possible, I will resend the second version of the patch.

Yu Chen

