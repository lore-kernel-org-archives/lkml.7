Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824C4C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4315C20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfF0P2h convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:28:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbfF0P2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:28:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RFOf5w039194
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:28:33 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tcyf9m4s3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:28:32 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 16:28:27 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 16:28:24 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RFSDgl40567140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 15:28:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B73B4C046;
        Thu, 27 Jun 2019 15:28:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7A034C044;
        Thu, 27 Jun 2019 15:28:22 +0000 (GMT)
Received: from localhost (unknown [9.199.59.170])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 15:28:22 +0000 (GMT)
Date:   Thu, 27 Jun 2019 20:58:20 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/7] powerpc/ftrace: Additionally nop out the preceding
 mflr with -mprofile-kernel
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
References: <cover.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
        <841386feda429a1f0d4b7442c3ede1ed91466f92.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
        <20190627110819.4892780f@gandalf.local.home>
In-Reply-To: <20190627110819.4892780f@gandalf.local.home>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19062715-0008-0000-0000-000002F7B7B8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062715-0009-0000-0000-00002264F17E
Message-Id: <1561648598.uvetvkj39x.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,
Thanks for the review!

Steven Rostedt wrote:
> On Thu, 27 Jun 2019 16:53:52 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
>> With -mprofile-kernel, gcc emits 'mflr r0', followed by 'bl _mcount' to
>> enable function tracing and profiling. So far, with dynamic ftrace, we
>> used to only patch out the branch to _mcount(). However, mflr is
>> executed by the branch unit that can only execute one per cycle on
>> POWER9 and shared with branches, so it would be nice to avoid it where
>> possible.
>> 
>> We cannot simply nop out the mflr either. When enabling function
>> tracing, there can be a race if tracing is enabled when some thread was
>> interrupted after executing a nop'ed out mflr. In this case, the thread
>> would execute the now-patched-in branch to _mcount() without having
>> executed the preceding mflr.
>> 
>> To solve this, we now enable function tracing in 2 steps: patch in the
>> mflr instruction, use 'smp_call_function(isync);
>> synchronize_rcu_tasks()' to ensure all existing threads make progress,
>> and then patch in the branch to _mcount(). We override
>> ftrace_replace_code() with a powerpc64 variant for this purpose.
> 
> You may want to explain that you do the reverse when patching it out.
> That is, patch out the "bl _mcount" into a nop and then patch out the
> "mflr r0".

Sure. I think we can add:
"When disabling function tracing, we can nop out the two instructions 
without need for any synchronization in between, as long as we nop out 
the branch to ftrace first. The lone 'mflr r0' is harmless. Finally, 
with FTRACE_UPDATE_MODIFY_CALL, no changes are needed since we are 
simply changing where the branch to ftrace goes."

> But interesting, I don't see a synchronize_rcu_tasks() call
> there.

We felt we don't need it in this case. We patch the branch to ftrace 
with a nop first. Other cpus should see that first. But, now that I 
think about it, should we add a memory barrier to ensure the writes get 
ordered properly?

> 
> 
>> 
>> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/trace/ftrace.c | 258 ++++++++++++++++++++++++++---
>>  1 file changed, 236 insertions(+), 22 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
>> index 517662a56bdc..86c2b50dcaa9 100644
>> --- a/arch/powerpc/kernel/trace/ftrace.c
>> +++ b/arch/powerpc/kernel/trace/ftrace.c
>> @@ -125,7 +125,7 @@ __ftrace_make_nop(struct module *mod,
>>  {
>>  	unsigned long entry, ptr, tramp;
>>  	unsigned long ip = rec->ip;
>> -	unsigned int op, pop;
>> +	unsigned int op;
>>  
>>  	/* read where this goes */
>>  	if (probe_kernel_read(&op, (void *)ip, sizeof(int))) {
>> @@ -160,8 +160,6 @@ __ftrace_make_nop(struct module *mod,
>>  
>>  #ifdef CONFIG_MPROFILE_KERNEL
>>  	/* When using -mkernel_profile there is no load to jump over */
>> -	pop = PPC_INST_NOP;
>> -
>>  	if (probe_kernel_read(&op, (void *)(ip - 4), 4)) {
>>  		pr_err("Fetching instruction at %lx failed.\n", ip - 4);
>>  		return -EFAULT;
>> @@ -169,26 +167,23 @@ __ftrace_make_nop(struct module *mod,
>>  
>>  	/* We expect either a mflr r0, or a std r0, LRSAVE(r1) */
>>  	if (op != PPC_INST_MFLR && op != PPC_INST_STD_LR) {
>> -		pr_err("Unexpected instruction %08x around bl _mcount\n", op);
>> +		pr_err("Unexpected instruction %08x before bl _mcount\n", op);
>>  		return -EINVAL;
>>  	}
>> -#else
>> -	/*
>> -	 * Our original call site looks like:
>> -	 *
>> -	 * bl <tramp>
>> -	 * ld r2,XX(r1)
>> -	 *
>> -	 * Milton Miller pointed out that we can not simply nop the branch.
>> -	 * If a task was preempted when calling a trace function, the nops
>> -	 * will remove the way to restore the TOC in r2 and the r2 TOC will
>> -	 * get corrupted.
>> -	 *
>> -	 * Use a b +8 to jump over the load.
>> -	 */
>>  
>> -	pop = PPC_INST_BRANCH | 8;	/* b +8 */
>> +	/* We should patch out the bl to _mcount first */
>> +	if (patch_instruction((unsigned int *)ip, PPC_INST_NOP)) {
>> +		pr_err("Patching NOP failed.\n");
>> +		return -EPERM;
>> +	}
>>  
>> +	/* then, nop out the preceding 'mflr r0' as an optimization */
>> +	if (op == PPC_INST_MFLR &&
>> +		patch_instruction((unsigned int *)(ip - 4), PPC_INST_NOP)) {
>> +		pr_err("Patching NOP failed.\n");
>> +		return -EPERM;
>> +	}
>> +#else
>>  	/*
>>  	 * Check what is in the next instruction. We can see ld r2,40(r1), but
>>  	 * on first pass after boot we will see mflr r0.
>> @@ -202,12 +197,25 @@ __ftrace_make_nop(struct module *mod,
>>  		pr_err("Expected %08x found %08x\n", PPC_INST_LD_TOC, op);
>>  		return -EINVAL;
>>  	}
>> -#endif /* CONFIG_MPROFILE_KERNEL */
>>  
>> -	if (patch_instruction((unsigned int *)ip, pop)) {
>> +	/*
>> +	 * Our original call site looks like:
>> +	 *
>> +	 * bl <tramp>
>> +	 * ld r2,XX(r1)
>> +	 *
>> +	 * Milton Miller pointed out that we can not simply nop the branch.
>> +	 * If a task was preempted when calling a trace function, the nops
>> +	 * will remove the way to restore the TOC in r2 and the r2 TOC will
>> +	 * get corrupted.
>> +	 *
>> +	 * Use a b +8 to jump over the load.
>> +	 */
>> +	if (patch_instruction((unsigned int *)ip, PPC_INST_BRANCH | 8)) {
>>  		pr_err("Patching NOP failed.\n");
>>  		return -EPERM;
>>  	}
>> +#endif /* CONFIG_MPROFILE_KERNEL */
>>  
>>  	return 0;
>>  }
>> @@ -421,6 +429,26 @@ static int __ftrace_make_nop_kernel(struct dyn_ftrace *rec, unsigned long addr)
>>  		return -EPERM;
>>  	}
>>  
>> +#ifdef CONFIG_MPROFILE_KERNEL
> 
> I would think you need to break this up into two parts as well, with a
> synchronize_rcu_tasks() in between.
> 
> Imagine this scenario:
> 
> 	<func>:
> 	nop <-- interrupt comes here, and preempts the task
> 	nop
> 
> First change.
> 
> 	<func>:
> 	mflr	r0
> 	nop
> 
> Second change.
> 
> 	<func>:
> 	mflr	r0
> 	bl	_mcount
> 
> Task returns from interrupt
> 
> 	<func>:
> 	mflr	r0
> 	bl	_mcount <-- executes here
> 
> It never did the mflr r0, because the last command that was executed
> was a nop before it was interrupted. And yes, it can be interrupted
> on a nop!

We are handling this through ftrace_replace_code() and 
__ftrace_make_call_prep() below. For FTRACE_UPDATE_MAKE_CALL, we patch 
in the mflr, followed by smp_call_function(isync) and 
synchronize_rcu_tasks() before we proceed to patch the branch to ftrace.

I don't see any other scenario where we end up in 
__ftrace_make_nop_kernel() without going through ftrace_replace_code().  
For kernel modules, this can happen during module load/init and so, I 
patch out both instructions in __ftrace_make_call() above without any 
synchronization.

Am I missing anything?


Thanks,
Naveen

> 
> -- Steve
> 
> 
>> +	/* Nop out the preceding 'mflr r0' as an optimization */
>> +	if (probe_kernel_read(&op, (void *)(ip - 4), 4)) {
>> +		pr_err("Fetching instruction at %lx failed.\n", ip - 4);
>> +		return -EFAULT;
>> +	}
>> +
>> +	/* We expect either a mflr r0, or a std r0, LRSAVE(r1) */
>> +	if (op != PPC_INST_MFLR && op != PPC_INST_STD_LR) {
>> +		pr_err("Unexpected instruction %08x before bl _mcount\n", op);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (op == PPC_INST_MFLR &&
>> +		patch_instruction((unsigned int *)(ip - 4), PPC_INST_NOP)) {
>> +		pr_err("Patching NOP failed.\n");
>> +		return -EPERM;
>> +	}
>> +#endif
>> +
>>  	return 0;
>>  }
>>  
>> @@ -429,6 +457,7 @@ int ftrace_make_nop(struct module *mod,
>>  {
>>  	unsigned long ip = rec->ip;
>>  	unsigned int old, new;
>> +	int rc;
>>  
>>  	/*
>>  	 * If the calling address is more that 24 bits away,
>> @@ -439,7 +468,34 @@ int ftrace_make_nop(struct module *mod,
>>  		/* within range */
>>  		old = ftrace_call_replace(ip, addr, 1);
>>  		new = PPC_INST_NOP;
>> -		return ftrace_modify_code(ip, old, new);
>> +		rc = ftrace_modify_code(ip, old, new);
>> +#ifdef CONFIG_MPROFILE_KERNEL
>> +		if (rc)
>> +			return rc;
>> +
>> +		/*
>> +		 * For -mprofile-kernel, we patch out the preceding 'mflr r0'
>> +		 * instruction, as an optimization. It is important to nop out
>> +		 * the branch to _mcount() first, as a lone 'mflr r0' is
>> +		 * harmless.
>> +		 */
>> +		if (probe_kernel_read(&old, (void *)(ip - 4), 4)) {
>> +			pr_err("Fetching instruction at %lx failed.\n", ip - 4);
>> +			return -EFAULT;
>> +		}
>> +
>> +		/* We expect either a mflr r0, or a std r0, LRSAVE(r1) */
>> +		if (old != PPC_INST_MFLR && old != PPC_INST_STD_LR) {
>> +			pr_err("Unexpected instruction %08x before bl _mcount\n",
>> +					old);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (old == PPC_INST_MFLR)
>> +			rc = patch_instruction((unsigned int *)(ip - 4),
>> +					PPC_INST_NOP);
>> +#endif
>> +		return rc;
>>  	} else if (core_kernel_text(ip))
>>  		return __ftrace_make_nop_kernel(rec, addr);
>>  
>> @@ -567,6 +623,37 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>>  		return -EINVAL;
>>  	}
>>  
>> +#ifdef CONFIG_MPROFILE_KERNEL
>> +	/*
>> +	 * We could end up here without having called __ftrace_make_call_prep()
>> +	 * if function tracing is enabled before a module is loaded.
>> +	 *
>> +	 * ftrace_module_enable() --> ftrace_replace_code_rec() -->
>> +	 *	ftrace_make_call() --> __ftrace_make_call()
>> +	 *
>> +	 * In this scenario, the previous instruction will be a NOP. It is
>> +	 * safe to patch it with a 'mflr r0' since we know for a fact that
>> +	 * this code is not yet being run.
>> +	 */
>> +	ip -= MCOUNT_INSN_SIZE;
>> +
>> +	/* read where this goes */
>> +	if (probe_kernel_read(op, ip, MCOUNT_INSN_SIZE))
>> +		return -EFAULT;
>> +
>> +	/*
>> +	 * nothing to do if this is using the older -mprofile-kernel
>> +	 * instruction sequence
>> +	 */
>> +	if (op[0] != PPC_INST_NOP)
>> +		return 0;
>> +
>> +	if (patch_instruction((unsigned int *)ip, PPC_INST_MFLR)) {
>> +		pr_err("Patching MFLR failed.\n");
>> +		return -EPERM;
>> +	}
>> +#endif
>> +
>>  	return 0;
>>  }
>>  
>> @@ -863,6 +950,133 @@ void arch_ftrace_update_code(int command)
>>  	ftrace_modify_all_code(command);
>>  }
>>  
>> +#ifdef CONFIG_MPROFILE_KERNEL
>> +/* Returns 1 if we patched in the mflr */
>> +static int __ftrace_make_call_prep(struct dyn_ftrace *rec)
>> +{
>> +	void *ip = (void *)rec->ip - MCOUNT_INSN_SIZE;
>> +	unsigned int op[2];
>> +
>> +	/* read where this goes */
>> +	if (probe_kernel_read(op, ip, sizeof(op)))
>> +		return -EFAULT;
>> +
>> +	if (op[1] != PPC_INST_NOP) {
>> +		pr_err("Unexpected call sequence at %p: %x %x\n",
>> +							ip, op[0], op[1]);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * nothing to do if this is using the older -mprofile-kernel
>> +	 * instruction sequence
>> +	 */
>> +	if (op[0] != PPC_INST_NOP)
>> +		return 0;
>> +
>> +	if (patch_instruction((unsigned int *)ip, PPC_INST_MFLR)) {
>> +		pr_err("Patching MFLR failed.\n");
>> +		return -EPERM;
>> +	}
>> +
>> +	return 1;
>> +}
>> +
>> +static void do_isync(void *info __maybe_unused)
>> +{
>> +	isync();
>> +}
>> +
>> +/*
>> + * When enabling function tracing for -mprofile-kernel that uses a
>> + * 2-instruction sequence of 'mflr r0, bl _mcount()', we use a 2 step process:
>> + * 1. Patch in the 'mflr r0' instruction
>> + * 1a. flush icache on all cpus, so that the updated instruction is seen
>> + * 1b. synchronize_rcu_tasks() to ensure that any cpus that had executed
>> + *     the earlier nop there make progress (and hence do not branch into
>> + *     ftrace without executing the preceding mflr)
>> + * 2. Patch in the branch to ftrace
>> + */
>> +void ftrace_replace_code(int mod_flags)
>> +{
>> +	int enable = mod_flags & FTRACE_MODIFY_ENABLE_FL;
>> +	int schedulable = mod_flags & FTRACE_MODIFY_MAY_SLEEP_FL;
>> +	int ret, failed, make_call = 0;
>> +	struct ftrace_rec_iter *iter;
>> +	struct dyn_ftrace *rec;
>> +
>> +	if (unlikely(!ftrace_enabled))
>> +		return;
>> +
>> +	for_ftrace_rec_iter(iter) {
>> +		rec = ftrace_rec_iter_record(iter);
>> +
>> +		if (rec->flags & FTRACE_FL_DISABLED)
>> +			continue;
>> +
>> +		failed = 0;
>> +		ret = ftrace_test_record(rec, enable);
>> +		if (ret == FTRACE_UPDATE_MAKE_CALL) {
>> +			failed = __ftrace_make_call_prep(rec);
>> +			if (failed < 0) {
>> +				ftrace_bug(failed, rec);
>> +				return;
>> +			} else if (failed == 1)
>> +				make_call++;
>> +		}
>> +
>> +		if (!failed) {
>> +			/* We can patch the record directly */
>> +			failed = ftrace_replace_code_rec(rec, enable);
>> +			if (failed) {
>> +				ftrace_bug(failed, rec);
>> +				return;
>> +			}
>> +		}
>> +
>> +		if (schedulable)
>> +			cond_resched();
>> +	}
>> +
>> +	if (!make_call)
>> +		/* No records needed patching a preceding mflr */
>> +		return;
>> +
>> +	/* Make sure all cpus see the new instruction */
>> +	smp_call_function(do_isync, NULL, 1);
>> +
>> +	/*
>> +	 * We also need to ensure that all cpus make progress:
>> +	 * - With !CONFIG_PREEMPT, we want to be sure that cpus return from
>> +	 *   any interrupts they may be handling, and make progress.
>> +	 * - With CONFIG_PREEMPT, we want to be additionally sure that there
>> +	 *   are no pre-empted tasks that have executed the earlier nop, and
>> +	 *   might end up executing the subsequently patched branch to ftrace.
>> +	 */
>> +	synchronize_rcu_tasks();
>> +
>> +	for_ftrace_rec_iter(iter) {
>> +		rec = ftrace_rec_iter_record(iter);
>> +
>> +		if (rec->flags & FTRACE_FL_DISABLED)
>> +			continue;
>> +
>> +		ret = ftrace_test_record(rec, enable);
>> +		if (ret == FTRACE_UPDATE_MAKE_CALL)
>> +			failed = ftrace_replace_code_rec(rec, enable);
>> +
>> +		if (failed) {
>> +			ftrace_bug(failed, rec);
>> +			return;
>> +		}
>> +
>> +		if (schedulable)
>> +			cond_resched();
>> +	}
>> +
>> +}
>> +#endif
>> +
>>  #ifdef CONFIG_PPC64
>>  #define PACATOC offsetof(struct paca_struct, kernel_toc)
>>  
> 
> 

