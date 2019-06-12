Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD26C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B876620B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfFLST1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:19:27 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54425 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFLST0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:19:26 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb7qG-0004DB-Ua; Wed, 12 Jun 2019 12:19:25 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb7qF-0000Qn-JJ; Wed, 12 Jun 2019 12:19:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qian Cai <cai@lca.pw>, mingo@redhat.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190612175543.GO32652@zn.tnic> (Borislav Petkov's message of
        "Wed, 12 Jun 2019 19:55:43 +0200")
References: <1559338641-6145-1-git-send-email-cai@lca.pw>
        <20190612175543.GO32652@zn.tnic>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Wed, 12 Jun 2019 13:19:06 -0500
Message-ID: <87a7emy8dh.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hb7qF-0000Qn-JJ;;;mid=<87a7emy8dh.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+7rkvNfWVNsDvrLU2jOC4FkVsErnjkXHU=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH -next] x86/mm: fix an unused variable "tsk" warning
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Fri, May 31, 2019 at 05:37:21PM -0400, Qian Cai wrote:
>> Since the commit "signal: Remove the task parameter from
>> force_sig_fault", "tsk" is only used when MEMORY_FAILURE=y and generates
>> a compilation warning without it.
>> 
>> arch/x86/mm/fault.c: In function 'do_sigbus':
>> arch/x86/mm/fault.c:1017:22: warning: unused variable 'tsk'
>> [-Wunused-variable]
>> 
>> Also, change to use IS_ENABLED() instead.
>> 
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>>  arch/x86/mm/fault.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 46ac96aa7c81..40d70bd3fa84 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -1014,8 +1014,6 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
>>  do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
>>  	  vm_fault_t fault)
>>  {
>> -	struct task_struct *tsk = current;
>> -
>>  	/* Kernel mode? Handle exceptions or die: */
>>  	if (!(error_code & X86_PF_USER)) {
>>  		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
>> @@ -1028,9 +1026,10 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
>>  
>>  	set_signal_archinfo(address, error_code);
>>  
>> -#ifdef CONFIG_MEMORY_FAILURE
>> -	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
>> +	if (IS_ENABLED(CONFIG_MEMORY_FAILURE) &&
>> +	    (fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE))) {
>>  		unsigned lsb = 0;
>> +		struct task_struct *tsk = current;
>>  
>>  		pr_err(
>>  	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
>> @@ -1042,7 +1041,6 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
>>  		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);
>>  		return;
>>  	}
>> -#endif
>>  	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
>>  }
>>  
>> -- 
>
> I was puzzled just like Dave because this code is not in tip.
>
> Turns out there's this in linux-next:
>
> commit 318759b4737c3b3789e2fd64d539f437d52386f5
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Mon Jun 3 10:23:58 2019 -0500
>
>     signal/x86: Move tsk inside of CONFIG_MEMORY_FAILURE in do_sigbus

Since I am removing the tsk parameter from all of the synchrnous signal
sending functions, on all of the architectures it was easier to go
through my own tree than -tip.

The removal of tsk from force_sig_fault is what caused the warning
in do_sigbus.

My apologies I was a little slow in getting that patch added and
generating work for other folks.

Eric
