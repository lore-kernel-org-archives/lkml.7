Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25E0C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A9E20C01
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989668;
	bh=ghgHNejQL358r2B/DNFwL3bC0elAyTaTbcMW1ICh5+4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ljVTooI2380+iEMPruElmjJe5fYmbUUZsphkHZhBSM2Vb6kIon7cXnMRsHduZIJCL
	 MGVhxWHVgZkQTd3kKBC5cyUKvZ0UwNBjnEi/vxnR8HecxqD/x6o2HrkLHgO8XcjUEH
	 M7Vpg7sDgXwG75zNaMjlJ2eoRAb0ewlEwDP0Nm28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389994AbfITO1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389727AbfITO1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:27:44 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66BE4207E0;
        Fri, 20 Sep 2019 14:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989663;
        bh=ghgHNejQL358r2B/DNFwL3bC0elAyTaTbcMW1ICh5+4=;
        h=Date:From:To:Cc:Subject:From;
        b=Ej+FZBsVIR5wcjNZ3pTGUkG4OxBzmdx+otHI8uJEC3dcjJq5qq5sCU7NqOW4La/iL
         duMN0fkjzMP+dmgilh0UWWxU0DcE8Y2f65vQ+q7qPo/o6mI0ziadbNQTpdwcy7AvVp
         Dzwgr6rhJwyoGvE42LYHUh5v0912ToHRQ7X6vAh4=
Date:   Fri, 20 Sep 2019 15:27:39 +0100
From:   Will Deacon <will@kernel.org>
To:     vincenzo.frascino@arm.com
Cc:     linux-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, linux@armlinux.org.uk,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com
Subject: Problems with arm64 compat vdso
Message-ID: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincenzo,

I've been running into a few issues with the COMPAT vDSO. Please could
you have a look?

If I do the following:

$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
[...]
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig
[set CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"]
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-

Then I see the following warning:

arch/arm64/Makefile:62: CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built

even though the compat vDSO *has* been built:

$ file arch/arm64/kernel/vdso32/vdso.so
arch/arm64/kernel/vdso32/vdso.so: ELF 32-bit LSB pie executable, ARM, EABI5 version 1 (SYSV), dynamically linked, BuildID[sha1]=c67f6c786f2d2d6f86c71f708595594aa25247f6, stripped

However, I also get some warnings because arm64 headers are being included
in the compat vDSO build:

In file included from ./arch/arm64/include/asm/thread_info.h:17:0,
                 from ./include/linux/thread_info.h:38,
                 from ./arch/arm64/include/asm/preempt.h:5,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from /usr/local/google/home/willdeacon/work/linux/lib/vdso/gettimeofday.c:7,
                 from <command-line>:0:
./arch/arm64/include/asm/memory.h: In function ‘__tag_set’:
./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  u64 __addr = (u64)addr & ~__tag_shifted(0xff);
               ^
In file included from ./arch/arm64/include/asm/pgtable-hwdef.h:8:0,
                 from ./arch/arm64/include/asm/processor.h:34,
                 from ./arch/arm64/include/asm/elf.h:118,
                 from ./include/linux/elf.h:5,
                 from ./include/linux/elfnote.h:62,
                 from arch/arm64/kernel/vdso32/note.c:11:
./arch/arm64/include/asm/memory.h: In function ‘__tag_set’:
./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  u64 __addr = (u64)addr & ~__tag_shifted(0xff);
               ^
Worse, if your compat binutils isn't up-to-date, you'll actually run into
a build failure:

/tmp/ccFCrjUg.s:80: Error: invalid barrier type -- `dmb ishld'
/tmp/ccFCrjUg.s:124: Error: invalid barrier type -- `dmb ishld'

There also appears to be a problem getting the toolchain prefix from Kconfig.
If, for example, I do:

$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
[...]
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig
[set CONFIG_CROSS_COMPILE_COMPAT_VDSO="vincenzo"]
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
arch/arm64/Makefile:64: *** vincenzogcc not found, check CROSS_COMPILE_COMPAT.  Stop.
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig
[set CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"]
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
arch/arm64/Makefile:64: *** vincenzogcc not found, check CROSS_COMPILE_COMPAT.  Stop.
$ grep CONFIG_CROSS_COMPILE_COMPAT_VDSO .config
CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"

which is irritating, because it seems to force a 'mrproper' if you don't
get the prefix right first time.

Cheers,

Will
