Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5AAC06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F38218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGCO1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:27:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49045 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfGCO1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:27:10 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45f3Mv2T8mz9s00; Thu,  4 Jul 2019 00:27:07 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 80e5302e4bc85a6b685b7668c36c6487b5f90e9a
In-Reply-To: <20190626183801.31247-1-naveen.n.rao@linux.vnet.ibm.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount: Fix spurious mcount entries on powerpc
Message-Id: <45f3Mv2T8mz9s00@ozlabs.org>
Date:   Thu,  4 Jul 2019 00:27:07 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-26 at 18:38:01 UTC, "Naveen N. Rao" wrote:
> The recent change enabling HAVE_C_RECORDMCOUNT on powerpc started
> showing the following issue:
> 
>   # modprobe kprobe_example
>    ftrace-powerpc: Not expected bl: opcode is 3c4c0001
>    WARNING: CPU: 0 PID: 227 at kernel/trace/ftrace.c:2001 ftrace_bug+0x90/0x318
>    Modules linked in:
>    CPU: 0 PID: 227 Comm: modprobe Not tainted 5.2.0-rc6-00678-g1c329100b942 #2
>    NIP:  c000000000264318 LR: c00000000025d694 CTR: c000000000f5cd30
>    REGS: c000000001f2b7b0 TRAP: 0700   Not tainted  (5.2.0-rc6-00678-g1c329100b942)
>    MSR:  900000010282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 28228222  XER: 00000000
>    CFAR: c0000000002642fc IRQMASK: 0
>    <snip>
>    NIP [c000000000264318] ftrace_bug+0x90/0x318
>    LR [c00000000025d694] ftrace_process_locs+0x4f4/0x5e0
>    Call Trace:
>    [c000000001f2ba40] [0000000000000004] 0x4 (unreliable)
>    [c000000001f2bad0] [c00000000025d694] ftrace_process_locs+0x4f4/0x5e0
>    [c000000001f2bb90] [c00000000020ff10] load_module+0x25b0/0x30c0
>    [c000000001f2bd00] [c000000000210cb0] sys_finit_module+0xc0/0x130
>    [c000000001f2be20] [c00000000000bda4] system_call+0x5c/0x70
>    Instruction dump:
>    419e0018 2f83ffff 419e00bc 2f83ffea 409e00cc 4800001c 0fe00000 3c62ff96
>    39000001 39400000 386386d0 480000c4 <0fe00000> 3ce20003 39000001 3c62ff96
>    ---[ end trace 4c438d5cebf78381 ]---
>    ftrace failed to modify
>    [<c0080000012a0008>] 0xc0080000012a0008
>     actual:   01:00:4c:3c
>    Initializing ftrace call sites
>    ftrace record flags: 2000000
>     (0)
>     expected tramp: c00000000006af4c
> 
> Looking at the relocation records in __mcount_loc showed a few spurious
> entries:
>   RELOCATION RECORDS FOR [__mcount_loc]:
>   OFFSET           TYPE              VALUE
>   0000000000000000 R_PPC64_ADDR64    .text.unlikely+0x0000000000000008
>   0000000000000008 R_PPC64_ADDR64    .text.unlikely+0x0000000000000014
>   0000000000000010 R_PPC64_ADDR64    .text.unlikely+0x0000000000000060
>   0000000000000018 R_PPC64_ADDR64    .text.unlikely+0x00000000000000b4
>   0000000000000020 R_PPC64_ADDR64    .init.text+0x0000000000000008
>   0000000000000028 R_PPC64_ADDR64    .init.text+0x0000000000000014
> 
> The first entry in each section is incorrect. Looking at the relocation
> records, the spurious entries correspond to the R_PPC64_ENTRY records:
>   RELOCATION RECORDS FOR [.text.unlikely]:
>   OFFSET           TYPE              VALUE
>   0000000000000000 R_PPC64_REL64     .TOC.-0x0000000000000008
>   0000000000000008 R_PPC64_ENTRY     *ABS*
>   0000000000000014 R_PPC64_REL24     _mcount
>   <snip>
> 
> The problem is that we are not validating the return value from
> get_mcountsym() in sift_rel_mcount(). With this entry, mcountsym is 0,
> but Elf_r_sym(relp) also ends up being 0. Fix this by ensuring mcountsym
> is valid before processing the entry.
> 
> Fixes: c7d64b560ce80 ("powerpc/ftrace: Enable C Version of recordmcount")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Tested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/80e5302e4bc85a6b685b7668c36c6487b5f90e9a

cheers
