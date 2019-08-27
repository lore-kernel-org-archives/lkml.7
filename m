Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFCDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8E62173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfH0Fxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:53:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:50354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfH0Fxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:53:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0527ACC1;
        Tue, 27 Aug 2019 05:53:52 +0000 (UTC)
Subject: Re: [RFC PATCH v2 1/3] x86/mm/tlb: Change __flush_tlb_one_user
 interface
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        StefanoStabellini <sstabellini@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190823225248.15597-1-namit@vmware.com>
 <20190823225248.15597-2-namit@vmware.com>
 <edb3a7e8-8fc6-7a55-37c1-3384a8413427@suse.com>
 <41C46D29-A0F3-48AA-BC28-2480F24D60FF@vmware.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <d57b0436-3d98-628c-f45e-1bfc2e496961@suse.com>
Date:   Tue, 27 Aug 2019 07:53:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <41C46D29-A0F3-48AA-BC28-2480F24D60FF@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.08.19 18:38, Nadav Amit wrote:
>> On Aug 26, 2019, at 12:51 AM, Juergen Gross <jgross@suse.com> wrote:
>>
>> On 24.08.19 00:52, Nadav Amit wrote:
>>> __flush_tlb_one_user() currently flushes a single entry, and flushes it
>>> both in the kernel and user page-tables, when PTI is enabled.
>>> Change __flush_tlb_one_user() and related interfaces into
>>> __flush_tlb_range() that flushes a range and does not flush the user
>>> page-table.
>>> This refactoring is needed for the next patch, but regardless makes
>>> sense and has several advantages. First, only Xen-PV, which does not
>>> use PTI, implements the paravirtual interface of flush_tlb_one_user() so
>>> nothing is broken by separating the user and kernel page-table flushes,
>>> and the interface is more intuitive.
>>> Second, INVLPG can flush unrelated mappings, and it is also a
>>> serializing instruction. It is better to have a tight loop that flushes
>>> the entries.
>>> Third, currently __flush_tlb_one_kernel() also flushes the user
>>> page-tables, which is not needed. This allows to avoid this redundant
>>> flush.
>>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>> Cc: Juergen Gross <jgross@suse.com>
>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>> Cc: xen-devel@lists.xenproject.org
>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>> ---
>>>   arch/x86/include/asm/paravirt.h       |  5 ++--
>>>   arch/x86/include/asm/paravirt_types.h |  3 ++-
>>>   arch/x86/include/asm/tlbflush.h       | 24 +++++------------
>>>   arch/x86/kernel/paravirt.c            |  7 ++---
>>>   arch/x86/mm/tlb.c                     | 39 ++++++++++++++++++++++-----
>>>   arch/x86/xen/mmu_pv.c                 | 21 +++++++++------
>>>   6 files changed, 62 insertions(+), 37 deletions(-)
>>
>> ...
>>
>>> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
>>> index 48f7c7eb4dbc..ed68657f5e77 100644
>>> --- a/arch/x86/xen/mmu_pv.c
>>> +++ b/arch/x86/xen/mmu_pv.c
>>> @@ -1325,22 +1325,27 @@ static noinline void xen_flush_tlb(void)
>>>   	preempt_enable();
>>>   }
>>>   -static void xen_flush_tlb_one_user(unsigned long addr)
>>> +static void xen_flush_tlb_range(unsigned long start, unsigned long end,
>>> +				u8 stride_shift)
>>>   {
>>>   	struct mmuext_op *op;
>>>   	struct multicall_space mcs;
>>> -
>>> -	trace_xen_mmu_flush_tlb_one_user(addr);
>>> +	unsigned long addr;
>>>     	preempt_disable();
>>>     	mcs = xen_mc_entry(sizeof(*op));
>>>   	op = mcs.args;
>>> -	op->cmd = MMUEXT_INVLPG_LOCAL;
>>> -	op->arg1.linear_addr = addr & PAGE_MASK;
>>> -	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
>>>   -	xen_mc_issue(PARAVIRT_LAZY_MMU);
>>> +	for (addr = start; addr < end; addr += 1ul << stride_shift) {
>>> +		trace_xen_mmu_flush_tlb_one_user(addr);
>>> +
>>> +		op->cmd = MMUEXT_INVLPG_LOCAL;
>>> +		op->arg1.linear_addr = addr & PAGE_MASK;
>>> +		MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
>>> +
>>> +		xen_mc_issue(PARAVIRT_LAZY_MMU);
>>> +	}
>>
>> For this kind of usage (a loop) you should:
>>
>> - replace the call of xen_mc_entry() with xen_mc_batch()
>> - use xen_extend_mmuext_op() for each loop iteration
>> - call xen_mc_issue() after the loop
>>
>> Additionally I'd like you to replace trace_xen_mmu_flush_tlb_one_user()
>> with trace_xen_mmu_flush_tlb_range() taking all three parameters and
>> keep it where it was (out of the loop).
>>
>> The paravirt parts seem to be okay.
> 
> Thanks for the quick response. I don’t think the preempt_disable/enable() is
> needed in this case, but I kept them. Does the following match what you had
> in mind?

Yes, it does.

BTW, preempt_disable/enable() is needed as xen_mc_batch() ...
xen_mc_issue() is using a percpu buffer.


Juergen

> 
> ---
>   arch/x86/xen/mmu_pv.c      | 25 ++++++++++++++-----------
>   include/trace/events/xen.h | 18 ++++++++++++------
>   2 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 48f7c7eb4dbc..faa01591df36 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -1325,20 +1325,23 @@ static noinline void xen_flush_tlb(void)
>   	preempt_enable();
>   }
>   
> -static void xen_flush_tlb_one_user(unsigned long addr)
> +static void xen_flush_tlb_range(unsigned long start, unsigned long end,
> +				u8 stride_shift)
>   {
> -	struct mmuext_op *op;
> -	struct multicall_space mcs;
> -
> -	trace_xen_mmu_flush_tlb_one_user(addr);
> +	struct mmuext_op op;
> +	unsigned long addr;
>   
>   	preempt_disable();
>   
> -	mcs = xen_mc_entry(sizeof(*op));
> -	op = mcs.args;
> -	op->cmd = MMUEXT_INVLPG_LOCAL;
> -	op->arg1.linear_addr = addr & PAGE_MASK;
> -	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
> +	xen_mc_batch();
> +	op.cmd = MMUEXT_INVLPG_LOCAL;
> +
> +	trace_xen_mmu_flush_tlb_range(start, end, stride_shift);
> +
> +	for (addr = start; addr < end; addr += 1ul << stride_shift) {
> +		op.arg1.linear_addr = addr & PAGE_MASK;
> +		xen_extend_mmuext_op(&op);
> +	}
>   
>   	xen_mc_issue(PARAVIRT_LAZY_MMU);
>   
> @@ -2394,7 +2397,7 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
>   
>   	.flush_tlb_user = xen_flush_tlb,
>   	.flush_tlb_kernel = xen_flush_tlb,
> -	.flush_tlb_one_user = xen_flush_tlb_one_user,
> +	.flush_tlb_range = xen_flush_tlb_range,
>   	.flush_tlb_multi = xen_flush_tlb_multi,
>   	.tlb_remove_table = tlb_remove_table,
>   
> diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
> index 546022acf160..32bf0a94b4d8 100644
> --- a/include/trace/events/xen.h
> +++ b/include/trace/events/xen.h
> @@ -352,14 +352,20 @@ DECLARE_EVENT_CLASS(xen_mmu_pgd,
>   DEFINE_XEN_MMU_PGD_EVENT(xen_mmu_pgd_pin);
>   DEFINE_XEN_MMU_PGD_EVENT(xen_mmu_pgd_unpin);
>   
> -TRACE_EVENT(xen_mmu_flush_tlb_one_user,
> -	    TP_PROTO(unsigned long addr),
> -	    TP_ARGS(addr),
> +TRACE_EVENT(xen_mmu_flush_tlb_range,
> +	    TP_PROTO(unsigned long start, unsigned long end,
> +		     unsigned char stride_shift),
> +	    TP_ARGS(start, end, stride_shift),
>   	    TP_STRUCT__entry(
> -		    __field(unsigned long, addr)
> +		    __field(unsigned long, start)
> +		    __field(unsigned long, end)
> +		    __field(unsigned char, stride_shift)
>   		    ),
> -	    TP_fast_assign(__entry->addr = addr),
> -	    TP_printk("addr %lx", __entry->addr)
> +	    TP_fast_assign(__entry->start = start;
> +			   __entry->end = end;
> +			   __entry->stride_shift = stride_shift),
> +	    TP_printk("start %lx end %lx stride_shift %d", __entry->start,
> +		      __entry->end, __entry->stride_shift)
>   	);
>   
>   TRACE_EVENT(xen_mmu_flush_tlb_multi,
> 

