Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE72DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9006921773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfC1PmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:42:13 -0400
Received: from raines.redjes.us ([45.32.221.159]:30549 "EHLO raines.redjes.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfC1PmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:42:11 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Mar 2019 11:42:11 EDT
Received: from localhost (raines.redjes.us [local])
        by raines.redjes.us (OpenSMTPD) with ESMTPA id bd91b4d9;
        Thu, 28 Mar 2019 11:35:29 -0400 (EDT)
Date:   Thu, 28 Mar 2019 11:35:29 -0400 (EDT)
From:   Anthony Coulter <riscv@anthonycoulter.name>
To:     anup@brainfault.org, rppt@linux.ibm.com
Subject: Re: [PATCH v3 4/4] RISC-V: Allow booting kernel from any 4KB aligned address
Cc:     Anup.Patel@wdc.com, aou@eecs.berkeley.edu, Atish.Patra@wdc.com,
        hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, me@anthonycoulter.name,
        palmer@sifive.com, paul.walmsley@sifive.com
Message-ID: <eb83e42f53cec3f1@raines.redjes.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If your goal is to be able to boot from any 4k-aligned address, then
disallowing boots between PAGE_OFFSET and PAGE_OFSSET + vmlinux_size
seems counterproductive, since there are a lot of 4k-aligned addresses
in that range that are now disallowed. (And worse, the specific range
of disallowed addresses now depends on how large the kernel is, which
makes things awkward. What happens if someone downloads a kernel update
that increases the size of vmlinux to a point where their boot loader
configuration is no longer valid? That would be crazy.)

Note that in order to boot from any 4k-aligned address, you will need
set up trampoline_pg_dir to map a single 4k page. The rule is that the
trampoline page tables can map a single page of whatever size you're
working with, and that page needs to be mapped to the same virtual
address that it will have in the final swapper_pg_dir table. Since
swapper_pg_dir cannot use hugepages, trampoline_pg_dir cannot use a
hugepage either.

But that also means you can't do very much work between enabling the
trampoline page tables and switching over to swapper_pg_dir, because
during that period of time only 4k of memory is mapped. You can't call
any functions that live outside those four kilobytes, nor can you
modify any page tables (because the single page you have must cover the
code in _start, so it can't point to any memory that includes page
tables). So you need to set up both the trampoline and swapper page
tables before enabling either of them. The only complexity you can
postpone by splitting up setup_vm is the initialization of the fixmap
tables.

That said: I think that booting from 4k-aligned addresses is probably
still a pretty simple change, though I *also* have doubts about whether
it is worthwhile.

Why is it simple? Because all you have to do is add one extra level to
each of the trampoline and swapper page tables, and both of these
tables have simple structures. The code proposed in the latest draft
is complicated because the function calls have so many layers of
indirection and not enough attention is paid to using the contiguity
of the page tables to reduce work. But that's accidental complexity;
a more careful implementation would be a lot shorter.

Why is it irrelevant? Because a memory-constrained kernel will want to
drop its .init segment after booting, but the memory that this frees up
will all be at the beginning of the kernel image (and not at the end).

Let's be concrete and talk about the HiFive Unleashed board, on which
RAM starts at address 0x80000000. But the problem is that the Berkeley
Boot Loader gets loaded to 0x80000000, so it has to load the Linux
kernel to the next hugepage, at 0x80200000. Now, if you're short on RAM
you will want your kernel to drop its .init segment, which occupies the
first megabyte (?) of kernel space. (I don't know how large the .init
segment is, but I *do* know from the linker script that it's at the
beginning of memory. Let's call it a megabyte.) So Linux releases its
first megabyte of memory to applications, and now the kernel itself
starts somewhere around 0x8030000.

How is the kernel going to make use of the freed-up space between
0x80200000 and 0x8030000? That's a vm-system problem: somewhere in the
virtual memory code there will be data structures and algorithms that
are smart enough to make use of both the space *before* the kernel
image (i.e. before 0x80300000) and the space *after* the kernel (i.e.
all the space from 0x80200000 to 0x8020000 + vmlinux_size). Surely this
code already exists, because some architectures *do* drop their .init
sections after boot.

But, now, if the virtual memory system is already smart enough to make
use of physical memory that is located before the kernel image, then
there's no harm in booting at 0x80200000 because the virtual memory
system can figure out how to use the gap between the end of the boot
loader and the start of the kernel image. This is true whether the
kernel chooses to drop its .init segment or not, because the point is
that the Linux kernel virtual memory data management system is already
designed to make use of free space from before the kernel image.

So the best way to reclaim wasted space before 0x80200000 is probably
going to be to make your boot loader tell the kernel (via the device
tree) how much space is available between boot_loader_end and
vmlinux_start, and to make sure that this space gets used by the
virtual memory framework.

I'm sorry my email is so long, but I've found that long emails lead to
less confusion than short ones.

Regards,
Anthony Coulter
