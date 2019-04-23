Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2705C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0E221850
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfDWREv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:04:51 -0400
Received: from foss.arm.com ([217.140.101.70]:59960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbfDWREv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:04:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E89980D;
        Tue, 23 Apr 2019 10:04:50 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 390C93F557;
        Tue, 23 Apr 2019 10:04:48 -0700 (PDT)
Date:   Tue, 23 Apr 2019 18:04:45 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Boyang Zhou <zhouby_cn@126.com>, catalin.marinas@arm.com,
        haozhu@nudt.edu.cn, linux@dominikbrodowski.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [PATCH] The patch solves =?utf-8?Q?the?=
 =?utf-8?Q?_type_error__of_the_parameter_=E2=80=9Coff?= =?utf-8?B?4oCd?= in
 syscall mmap on the ARM64 platform.
Message-ID: <20190423170445.GB21047@fuggles.cambridge.arm.com>
References: <1555504525-17962-1-git-send-email-zhouby_cn@126.com>
 <20190418112818.GA31923@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190418112818.GA31923@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:28:18PM +0100, Mark Rutland wrote:
> [adding linux-arch and relevant folk]
> 
> On Wed, Apr 17, 2019 at 08:35:25PM +0800, Boyang Zhou wrote:
> > The error information is that “offset value too large for defined data type”.
> > Reason:
> > On the X86 platform, the data type of “off" is unsigned long; but on the ARM64 platform, the data type is defined as off_t, and off_t is by type long instead of unsigned long.
> > When the off right shifts in the function “sys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT)"on ARM64, high address of off is filled with sign bit 1instead of 0.
> > In our case, we mmap GPU doorbell on both platform. On the x86 platform, the value of off is f009c00000000000, after shift the value becomes f009c00000000; while on the ARM64, the value of off changes from ed35c00000000000 to fffed35c00000000. This value is treated as unsigned long in later functions. So it is too big for off and the error happened.
> > We have tested the patchs in Huawei ARM64 server with a couples of AMD GPUs.
> 
> It looks like the generic mmap uses unsigned long, as do sparc and x86.
> 
> However, arm64, microblase, powerpc and riscv all use off_t.
> 
> Should those all be using unsigned long? If so, that seems like it
> should be a treewide cleanup.

This is more than just a cleanup, since it changes the behaviour of the
system call and I'd much rather each architecture made this choice
themselves. I also don't think we should change the type of the parameter,
so something like the following instead:

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index b44065fb1616..77dc5f006bc4 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -31,8 +31,10 @@
 
 SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 		unsigned long, prot, unsigned long, flags,
-		unsigned long, fd, off_t, off)
+		unsigned long, fd, off_t, pgoff)
 {
+	unsigned long off = pgoff;
+
 	if (offset_in_page(off) != 0)
 		return -EINVAL;
 

> Similar applies to pgoff for mmap2.

Does it? Looks like unsigned long is used consistently there afaict. Did
you spot something I missed?

Will
