Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5D9C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C428208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfF3Ihm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 04:37:42 -0400
Received: from ozlabs.org ([203.11.71.1]:58637 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfF3Iha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 04:37:30 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45c3lq3P7hz9sCJ; Sun, 30 Jun 2019 18:37:27 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f474c28fbcbe42faca4eb415172c07d76adcb819
X-Patchwork-Hint: ignore
In-Reply-To: <20190613033014.17496-1-ravi.bangoria@linux.ibm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org,
        linux-kernel@vger.kernel.org, npiggin@gmail.com, paulus@samba.org,
        aneesh.kumar@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] Powerpc/Watchpoint: Restore nvgprs while returning from exception
Message-Id: <45c3lq3P7hz9sCJ@ozlabs.org>
Date:   Sun, 30 Jun 2019 18:37:27 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-13 at 03:30:14 UTC, Ravi Bangoria wrote:
> Powerpc hw triggers watchpoint before executing the instruction. To
> make trigger-after-execute behavior, kernel emulates the instruction.
> If the instruction is 'load something into non-volatile register',
> exception handler should restore emulated register state while
> returning back, otherwise there will be register state corruption.
> Ex, Adding a watchpoint on a list can corrput the list:
> 
>   # cat /proc/kallsyms | grep kthread_create_list
>   c00000000121c8b8 d kthread_create_list
> 
> Add watchpoint on kthread_create_list->prev:
> 
>   # perf record -e mem:0xc00000000121c8c0
> 
> Run some workload such that new kthread gets invoked. Ex, I just
> logged out from console:
> 
>   list_add corruption. next->prev should be prev (c000000001214e00), \
> 	but was c00000000121c8b8. (next=c00000000121c8b8).
>   WARNING: CPU: 59 PID: 309 at lib/list_debug.c:25 __list_add_valid+0xb4/0xc0
>   CPU: 59 PID: 309 Comm: kworker/59:0 Kdump: loaded Not tainted 5.1.0-rc7+ #69
>   ...
>   NIP __list_add_valid+0xb4/0xc0
>   LR __list_add_valid+0xb0/0xc0
>   Call Trace:
>   __list_add_valid+0xb0/0xc0 (unreliable)
>   __kthread_create_on_node+0xe0/0x260
>   kthread_create_on_node+0x34/0x50
>   create_worker+0xe8/0x260
>   worker_thread+0x444/0x560
>   kthread+0x160/0x1a0
>   ret_from_kernel_thread+0x5c/0x70
> 
> List corruption happened because it uses 'load into non-volatile
> register' instruction:
> 
> Snippet from __kthread_create_on_node:
> 
>   c000000000136be8:     addis   r29,r2,-19
>   c000000000136bec:     ld      r29,31424(r29)
>         if (!__list_add_valid(new, prev, next))
>   c000000000136bf0:     mr      r3,r30
>   c000000000136bf4:     mr      r5,r28
>   c000000000136bf8:     mr      r4,r29
>   c000000000136bfc:     bl      c00000000059a2f8 <__list_add_valid+0x8>
> 
> Register state from WARN_ON():
> 
>   GPR00: c00000000059a3a0 c000007ff23afb50 c000000001344e00 0000000000000075
>   GPR04: 0000000000000000 0000000000000000 0000001852af8bc1 0000000000000000
>   GPR08: 0000000000000001 0000000000000007 0000000000000006 00000000000004aa
>   GPR12: 0000000000000000 c000007ffffeb080 c000000000137038 c000005ff62aaa00
>   GPR16: 0000000000000000 0000000000000000 c000007fffbe7600 c000007fffbe7370
>   GPR20: c000007fffbe7320 c000007fffbe7300 c000000001373a00 0000000000000000
>   GPR24: fffffffffffffef7 c00000000012e320 c000007ff23afcb0 c000000000cb8628
>   GPR28: c00000000121c8b8 c000000001214e00 c000007fef5b17e8 c000007fef5b17c0
> 
> Watchpoint hit at 0xc000000000136bec.
> 
>   addis   r29,r2,-19
>    => r29 = 0xc000000001344e00 + (-19 << 16)
>    => r29 = 0xc000000001214e00
> 
>   ld      r29,31424(r29)
>    => r29 = *(0xc000000001214e00 + 31424)
>    => r29 = *(0xc00000000121c8c0)
> 
> 0xc00000000121c8c0 is where we placed a watchpoint and thus this
> instruction was emulated by emulate_step. But because handle_dabr_fault
> did not restore emulated register state, r29 still contains stale
> value in above register state.
> 
> Fixes: 5aae8a5370802 ("powerpc, hw_breakpoints: Implement hw_breakpoints for 64-bit server processors")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Cc: stable@vger.kernel.org # 2.6.36+

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f474c28fbcbe42faca4eb415172c07d76adcb819

cheers
