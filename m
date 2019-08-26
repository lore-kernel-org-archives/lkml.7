Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89516C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549DF22CF5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfHZHvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:51:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:34864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728198AbfHZHvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:51:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77D43AF11;
        Mon, 26 Aug 2019 07:51:20 +0000 (UTC)
Subject: Re: [RFC PATCH v2 1/3] x86/mm/tlb: Change __flush_tlb_one_user
 interface
To:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20190823225248.15597-1-namit@vmware.com>
 <20190823225248.15597-2-namit@vmware.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <edb3a7e8-8fc6-7a55-37c1-3384a8413427@suse.com>
Date:   Mon, 26 Aug 2019 09:51:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823225248.15597-2-namit@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.19 00:52, Nadav Amit wrote:
> __flush_tlb_one_user() currently flushes a single entry, and flushes it
> both in the kernel and user page-tables, when PTI is enabled.
> 
> Change __flush_tlb_one_user() and related interfaces into
> __flush_tlb_range() that flushes a range and does not flush the user
> page-table.
> 
> This refactoring is needed for the next patch, but regardless makes
> sense and has several advantages. First, only Xen-PV, which does not
> use PTI, implements the paravirtual interface of flush_tlb_one_user() so
> nothing is broken by separating the user and kernel page-table flushes,
> and the interface is more intuitive.
> 
> Second, INVLPG can flush unrelated mappings, and it is also a
> serializing instruction. It is better to have a tight loop that flushes
> the entries.
> 
> Third, currently __flush_tlb_one_kernel() also flushes the user
> page-tables, which is not needed. This allows to avoid this redundant
> flush.
> 
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>   arch/x86/include/asm/paravirt.h       |  5 ++--
>   arch/x86/include/asm/paravirt_types.h |  3 ++-
>   arch/x86/include/asm/tlbflush.h       | 24 +++++------------
>   arch/x86/kernel/paravirt.c            |  7 ++---
>   arch/x86/mm/tlb.c                     | 39 ++++++++++++++++++++++-----
>   arch/x86/xen/mmu_pv.c                 | 21 +++++++++------
>   6 files changed, 62 insertions(+), 37 deletions(-)

...

> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 48f7c7eb4dbc..ed68657f5e77 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -1325,22 +1325,27 @@ static noinline void xen_flush_tlb(void)
>   	preempt_enable();
>   }
>   
> -static void xen_flush_tlb_one_user(unsigned long addr)
> +static void xen_flush_tlb_range(unsigned long start, unsigned long end,
> +				u8 stride_shift)
>   {
>   	struct mmuext_op *op;
>   	struct multicall_space mcs;
> -
> -	trace_xen_mmu_flush_tlb_one_user(addr);
> +	unsigned long addr;
>   
>   	preempt_disable();
>   
>   	mcs = xen_mc_entry(sizeof(*op));
>   	op = mcs.args;
> -	op->cmd = MMUEXT_INVLPG_LOCAL;
> -	op->arg1.linear_addr = addr & PAGE_MASK;
> -	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
>   
> -	xen_mc_issue(PARAVIRT_LAZY_MMU);
> +	for (addr = start; addr < end; addr += 1ul << stride_shift) {
> +		trace_xen_mmu_flush_tlb_one_user(addr);
> +
> +		op->cmd = MMUEXT_INVLPG_LOCAL;
> +		op->arg1.linear_addr = addr & PAGE_MASK;
> +		MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
> +
> +		xen_mc_issue(PARAVIRT_LAZY_MMU);
> +	}

For this kind of usage (a loop) you should:

- replace the call of xen_mc_entry() with xen_mc_batch()
- use xen_extend_mmuext_op() for each loop iteration
- call xen_mc_issue() after the loop

Additionally I'd like you to replace trace_xen_mmu_flush_tlb_one_user()
with trace_xen_mmu_flush_tlb_range() taking all three parameters and
keep it where it was (out of the loop).

The paravirt parts seem to be okay.


Juergen
