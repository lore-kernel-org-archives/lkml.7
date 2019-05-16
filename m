Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D322C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7E120833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfEPNi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:38:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46180 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfEPNi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:38:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D00A41715;
        Thu, 16 May 2019 06:38:26 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77C223F575;
        Thu, 16 May 2019 06:38:25 -0700 (PDT)
Date:   Thu, 16 May 2019 14:38:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Bad virt_to_phys since commit 54c7a8916a887f35
Message-ID: <20190516133820.GA43059@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since commit:

  54c7a8916a887f35 ("initramfs: free initrd memory if opening /initrd.image fails")

IIUC prior to that commit, we'd only attempt to free an intird if we had
one, whereas now we do so unconditionally. AFAICT, in this case
initrd_start has not been initialized (I'm not using an initrd or
initramfs on my system), so we end up trying virt_to_phys() on a bogus
VA in free_initrd_mem().

Any ideas on the right way to fix this?

Thanks,
Mark.

[    5.251023][    T1] ------------[ cut here ]------------
[    5.252465][    T1] virt_to_phys used for non-linear address: (____ptrval____) (0x0)
[    5.254388][    T1] WARNING: CPU: 0 PID: 1 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0x88/0xb8
[    5.256473][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-11058-g83f3ef3 #4
[    5.258513][    T1] Hardware name: linux,dummy-virt (DT)
[    5.259923][    T1] pstate: 80400005 (Nzcv daif +PAN -UAO)
[    5.261375][    T1] pc : __virt_to_phys+0x88/0xb8
[    5.262623][    T1] lr : __virt_to_phys+0x88/0xb8
[    5.263879][    T1] sp : ffff80000be4fc60
[    5.264941][    T1] x29: ffff80000be4fc60 x28: 0000000040000000 
[    5.266522][    T1] x27: ffff200015445000 x26: 0000000000000000 
[    5.268112][    T1] x25: 0000000000000000 x24: ffff2000163e0000 
[    5.269691][    T1] x23: ffff2000163e0440 x22: ffff2000163e0000 
[    5.271270][    T1] x21: ffff2000163e0400 x20: 0000000000000000 
[    5.272860][    T1] x19: 0000000000000000 x18: ffff200016aa0f80 
[    5.274430][    T1] x17: ffff2000153a0000 x16: 00000000f2000000 
[    5.276018][    T1] x15: 1fffe40002d5560d x14: 1ffff00007716109 
[    5.277596][    T1] x13: ffff200016e17000 x12: ffff040002a83fd9 
[    5.279179][    T1] x11: 1fffe40002a83fd8 x10: ffff040002a83fd8 
[    5.280765][    T1] x9 : 1fffe40002a83fd8 x8 : dfff200000000000 
[    5.282343][    T1] x7 : ffff040002a83fd9 x6 : ffff20001541fec0 
[    5.283929][    T1] x5 : ffff80003b8b0040 x4 : 0000000000000000 
[    5.285509][    T1] x3 : ffff2000102c6504 x2 : ffff1000017c9f54 
[    5.287091][    T1] x1 : 15eab2dadba38000 x0 : 0000000000000000 
[    5.288678][    T1] Call trace:
[    5.289532][    T1]  __virt_to_phys+0x88/0xb8
[    5.290701][    T1]  free_initrd_mem+0x3c/0x50
[    5.291894][    T1]  populate_rootfs+0x2f4/0x358
[    5.293123][    T1]  do_one_initcall+0x568/0xb94
[    5.294349][    T1]  kernel_init_freeable+0xd44/0xe2c
[    5.295695][    T1]  kernel_init+0x14/0x1c0
[    5.296814][    T1]  ret_from_fork+0x10/0x1c
[    5.297947][    T1] irq event stamp: 288672
[    5.299069][    T1] hardirqs last  enabled at (288671): [<ffff2000102c4cac>] console_unlock+0x89c/0xe50
[    5.301521][    T1] hardirqs last disabled at (288672): [<ffff2000100823e0>] do_debug_exception+0x268/0x3e0
[    5.304061][    T1] softirqs last  enabled at (288668): [<ffff2000100835e0>] __do_softirq+0xa38/0xf48
[    5.306457][    T1] softirqs last disabled at (288653): [<ffff2000101ac994>] irq_exit+0x2a4/0x318
[    5.308777][    T1] ---[ end trace 3cf83e3c184a4d3e ]---
