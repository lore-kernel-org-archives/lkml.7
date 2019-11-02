Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEACECA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51912080F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfKBMTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 08:19:08 -0400
Received: from foss.arm.com ([217.140.110.172]:46774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfKBMTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 08:19:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BA8B328;
        Sat,  2 Nov 2019 05:19:07 -0700 (PDT)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 785103F718;
        Sat,  2 Nov 2019 05:19:02 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: Re: [PATCHv2 1/8] ftrace: add ftrace_init_nop()
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        deller@gmx.de, duwe@suse.de, James.Bottomley@HansenPartnership.com,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, linux-parisc@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <20191029165832.33606-2-mark.rutland@arm.com>
Message-ID: <daad0785-a33f-3cfb-cf0f-657b6c677257@arm.com>
Date:   Sat, 2 Nov 2019 17:49:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191029165832.33606-2-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 10/29/19 10:28 PM, Mark Rutland wrote:
> Architectures may need to perform special initialization of ftrace
> callsites, and today they do so by special-casing ftrace_make_nop() when
> the expected branch address is MCOUNT_ADDR. In some cases (e.g. for
> patchable-function-entry), we don't have an mcount-like symbol and don't
s/an mcount/a mcount.
> want a synthetic MCOUNT_ADDR, but we may need to perform some
> initialization of callsites.
> 
> To make it possible to separate initialization from runtime
> modification, and to handle cases without an mcount-like symbol, this
Same as above.
> patch adds an optional ftrace_init_nop() function that architectures can
> implement, which does not pass a branch address.
> 
> Where an architecture does not provide ftrace_init_nop(), we will fall
> back to the existing behaviour of calling ftrace_make_nop() with
> MCOUNT_ADDR.
> 
> At the same time, ftrace_code_disable() is renamed to
> ftrace_nop_initialize() to make it clearer that it is intended to
> intialize a callsite into a disabled state, and is not for disabling a
> callsite that has been runtime enabled. The kerneldoc description of rec
> arguments is updated to cover non-mcount callsites.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Torsten Duwe <duwe@suse.de>
> ---
>   include/linux/ftrace.h | 35 ++++++++++++++++++++++++++++++++---
>   kernel/trace/ftrace.c  |  6 +++---
>   2 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 8a8cb3c401b2..9867d90d635e 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -499,7 +499,7 @@ static inline int ftrace_disable_ftrace_graph_caller(void) { return 0; }
>   /**
>    * ftrace_make_nop - convert code into nop
>    * @mod: module structure if called by module load initialization
> - * @rec: the mcount call site record
> + * @rec: the call site record (e.g. mcount/fentry)
>    * @addr: the address that the call site should be calling
>    *
>    * This is a very sensitive operation and great care needs
> @@ -520,9 +520,38 @@ static inline int ftrace_disable_ftrace_graph_caller(void) { return 0; }
>   extern int ftrace_make_nop(struct module *mod,
>   			   struct dyn_ftrace *rec, unsigned long addr);
>   
> +
> +/**
> + * ftrace_init_nop - initialize a nop call site
> + * @mod: module structure if called by module load initialization
> + * @rec: the call site record (e.g. mcount/fentry)
> + *
> + * This is a very sensitive operation and great care needs
> + * to be taken by the arch.  The operation should carefully
> + * read the location, check to see if what is read is indeed
> + * what we expect it to be, and then on success of the compare,
> + * it should write to the location.
> + *
> + * The code segment at @rec->ip should contain the contents created by
> + * the compiler
Nit: Will it be better to write it as "@rec->ip should store the 
adjusted ftrace entry address of the call site" or something like that.
> + *
> + * Return must be:
> + *  0 on success
> + *  -EFAULT on error reading the location
> + *  -EINVAL on a failed compare of the contents
> + *  -EPERM  on error writing to the location
> + * Any other value will be considered a failure.
> + */
> +#ifndef ftrace_init_nop
> +static inline int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
> +{
> +	return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> +}
> +#endif
> +
Now that ftrace_init_nop is also an arch implemented function so it may 
be added in Documentation/trace/ftrace-design.rst along with 
ftrace_make_nop.
In general also, adding some description about patchable-function-entry
in kernel Documentation will be useful.

Thanks,
Amit Daniel
>   /**
>    * ftrace_make_call - convert a nop call site into a call to addr
> - * @rec: the mcount call site record
> + * @rec: the call site record (e.g. mcount/fentry)
>    * @addr: the address that the call site should call
>    *
>    * This is a very sensitive operation and great care needs
> @@ -545,7 +574,7 @@ extern int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr);
>   #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>   /**
>    * ftrace_modify_call - convert from one addr to another (no nop)
> - * @rec: the mcount call site record
> + * @rec: the call site record (e.g. mcount/fentry)
>    * @old_addr: the address expected to be currently called to
>    * @addr: the address to change to
>    *
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f296d89be757..5259d4dea675 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2494,14 +2494,14 @@ struct dyn_ftrace *ftrace_rec_iter_record(struct ftrace_rec_iter *iter)
>   }
>   
>   static int
> -ftrace_code_disable(struct module *mod, struct dyn_ftrace *rec)
> +ftrace_nop_initialize(struct module *mod, struct dyn_ftrace *rec)
>   {
>   	int ret;
>   
>   	if (unlikely(ftrace_disabled))
>   		return 0;
>   
> -	ret = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> +	ret = ftrace_init_nop(mod, rec);
>   	if (ret) {
>   		ftrace_bug_type = FTRACE_BUG_INIT;
>   		ftrace_bug(ret, rec);
> @@ -2943,7 +2943,7 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
>   			 * to the NOP instructions.
>   			 */
>   			if (!__is_defined(CC_USING_NOP_MCOUNT) &&
> -			    !ftrace_code_disable(mod, p))
> +			    !ftrace_nop_initialize(mod, p))
>   				break;
>   
>   			update_cnt++;
> 
