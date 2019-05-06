Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237F8C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF636205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfEFW4p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:56:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:19501 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfEFW4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:56:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 15:56:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,439,1549958400"; 
   d="scan'208";a="137572560"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga007.jf.intel.com with ESMTP; 06 May 2019 15:56:44 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 6 May 2019 15:56:44 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.116]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.184]) with mapi id 14.03.0415.000;
 Mon, 6 May 2019 16:56:41 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RESEND PATCH v6 08/12] x86/fsgsbase/64: Use the per-CPU base
 as GSBASE at the paranoid_entry
Thread-Topic: [RESEND PATCH v6 08/12] x86/fsgsbase/64: Use the per-CPU base
 as GSBASE at the paranoid_entry
Thread-Index: AQHU22qy2YcgqOSDVkqDsKh+C1SMYaYcjFAAgELfX4A=
Date:   Mon, 6 May 2019 22:56:41 +0000
Message-ID: <4A00F484-CA9B-4A75-9E33-F38CFD8B9638@intel.com>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
 <1552680405-5265-9-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1903251003090.1798@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903251003090.1798@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.153.227]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F71C7441BA58834E86A1B4B2F5CF212A@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 25, 2019, at 02:44, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Fri, 15 Mar 2019, Chang S. Bae wrote:
> 
>> The FSGSBASE instructions allow fast accesses on GSBASE.  Now, at the
>> paranoid_entry, the per-CPU base value can be always copied to GSBASE.
>> And the original GSBASE value will be restored at the exit.
> 
> Again you are describing WHAT but not the WHY.
> 
>> So far, GSBASE modification has not been directly allowed from userspace.
>> So, swapping GSBASE has been conditionally executed according to the
>> kernel-enforced convention that a negative GSBASE indicates a kernel value.
>> But when FSGSBASE is enabled, userspace can put an arbitrary value in
>> GSBASE. The change will secure a correct GSBASE value with FSGSBASE.
> 
> So that's some WHY, but it should be explained _BEFORE_ explaining the
> change. This changelog style is as bad as top posting. Why?
> 
>  1) FSGSBASE is fast
> 
>  2) Copy GSBASE always on paranoid exit and restore on entry
> 
>  3) Explain the context
> 
> No. You want to explain context first and then explain why this needs a
> change when FSGSBASE is enabled and how that change looks like at the
> conceptual level.
> 
>> Also, factor out the RDMSR-based GSBASE read into a new macro,
>> READ_MSR_GSBASE.
> 
> This new macro is related to this change in what way? None AFAICT. I'm fine
> with the macro itself, but the benefit for a single usage site is dubious.
> 
> Adding this macro and using it should be done with a separate patch before
> this one, so this patch becomes simpler to review.
> 
>> 	/*
>> @@ -1178,9 +1185,38 @@ ENTRY(paranoid_entry)
>> 	 * This is also why CS (stashed in the "iret frame" by the
>> 	 * hardware at entry) can not be used: this may be a return
>> 	 * to kernel code, but with a user CR3 value.
>> +	 *
>> +	 * As long as this PTI macro doesn't depend on kernel GSBASE,
>> +	 * we can do it early. This is because FIND_PERCPU_BASE
>> +	 * references data in kernel space.
> 
> It's not about 'can do it early'. The FSGSBASE handling requires that the
> kernel page tables are switched in.
> 
> And for review and bisectability sake moving the CR3 switch in front of the
> GS handling should be done as a separate preparatory patch.
> 
>> 	 */
>> 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
>> 
>> +	/*
>> +	 * Read GSBASE by RDGSBASE. Kernel GSBASE is found
>> +	 * from the per-CPU offset table with a CPU NR.
> 
> That CPU NR comes out of thin air, right? This code is complex enough by
> itself and does not need further confusion by comments which need a crystal
> ball for decoding.
> 
>> +	 */
> 
> Sigh. I can't see how that comment explains the ALTERNATIVE jump.
> 
>> +	ALTERNATIVE "jmp .Lparanoid_entry_no_fsgsbase",	"",\
>> +		X86_FEATURE_FSGSBASE
> 
> Please separate the above from the below with a new line for readability
> sake.
> 
>> +	rdgsbase	%rbx
>> +	FIND_PERCPU_BASE	%rax
>> +	wrgsbase	%rax
> 
> So this really should be wrapped in a macro like:
> 
>   	SAVE_AND_SET_GSBASE	%rbx, %rax
> 
> which makes it entirely clear what this is about.
> 
>> +	ret
>> +
> 
>> @@ -1194,12 +1230,21 @@ END(paranoid_entry)
>>  * be complicated.  Fortunately, we there's no good reason
>>  * to try to handle preemption here.
>>  *
>> - * On entry, ebx is "no swapgs" flag (1: don't need swapgs, 0: need it)
>> + * On entry,
>> + *	With FSGSBASE,
>> + *		%rbx is original GSBASE that needs to be restored on the exit
>> + *	Without that,
>> + * 		%ebx is "no swapgs" flag (1: don't need swapgs, 0: need it)
>>  */
>> ENTRY(paranoid_exit)
>> 	UNWIND_HINT_REGS
>> 	DISABLE_INTERRUPTS(CLBR_ANY)
>> 	TRACE_IRQS_OFF_DEBUG
>> +	ALTERNATIVE "jmp .Lparanoid_exit_no_fsgsbase",	"nop",\
>> +		X86_FEATURE_FSGSBASE
>> +	wrgsbase	%rbx
>> +	jmp	.Lparanoid_exit_no_swapgs;
> 
> Again. A few newlines would make it more readable.
> 
> This modifies the semantics of paranoid_entry and paranoid_exit. Looking at
> the usage sites there is the following code in the nmi maze:
> 
> 	/*
> 	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
> 	 * as we should not be calling schedule in NMI context.
> 	 * Even with normal interrupts enabled. An NMI should not be
> 	 * setting NEED_RESCHED or anything that normal interrupts and
> 	 * exceptions might do.
> 	 */
> 	call	paranoid_entry
> 	UNWIND_HINT_REGS
> 
> 	/* paranoidentry do_nmi, 0; without TRACE_IRQS_OFF */
> 	movq	%rsp, %rdi
> 	movq	$-1, %rsi
> 	call	do_nmi
> 
> 	/* Always restore stashed CR3 value (see paranoid_entry) */
> 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
> 
> 	testl	%ebx, %ebx			/* swapgs needed? */
> 	jnz	nmi_restore
> nmi_swapgs:
> 	SWAPGS_UNSAFE_STACK
> nmi_restore:
> 	POP_REGS
> 

Oh!, almost miss this bit.  Will be terrifying if leave them like this way.

> I might be missing something, but how is that supposed to work when
> paranoid_entry uses FSGSBASE? I think it's broken, but if it's not then
> there is a big fat comment missing explaining why.
> 

You will see a revision shortly. Thanks 

Chang
