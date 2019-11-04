Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A4BCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D7421E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfKDMkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:40:23 -0500
Received: from foss.arm.com ([217.140.110.172]:41974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbfKDMkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 07:40:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EE251FB;
        Mon,  4 Nov 2019 04:40:22 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 433CB3F6C4;
        Mon,  4 Nov 2019 04:40:20 -0800 (PST)
Date:   Mon, 4 Nov 2019 12:40:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/17] scs: add support for stack usage debugging
Message-ID: <20191104124017.GD45140@lakrids.cambridge.arm.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com>
 <20191101221150.116536-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101221150.116536-8-samitolvanen@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 03:11:40PM -0700, Sami Tolvanen wrote:
> Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks. When enabled,
> also prints out the highest shadow stack usage per process.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  kernel/scs.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/kernel/scs.c b/kernel/scs.c
> index 7780fc4e29ac..67c43af627d1 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -167,6 +167,44 @@ int scs_prepare(struct task_struct *tsk, int node)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_DEBUG_STACK_USAGE
> +static inline unsigned long scs_used(struct task_struct *tsk)
> +{
> +	unsigned long *p = __scs_base(tsk);
> +	unsigned long *end = scs_magic(tsk);
> +	uintptr_t s = (uintptr_t)p;

As previously, please use unsigned long for consistency.

> +
> +	while (p < end && *p)
> +		p++;

I think this is the only place where we legtimately access the shadow
call stack directly. When using SCS and KASAN, are the
compiler-generated accesses to the SCS instrumented?

If not, it might make sense to make this:

	while (p < end && READ_ONCE_NOCKECK(*p))

... and poison the allocation from KASAN's PoV, so that we can find
unintentional accesses more easily. 

Mark.

> +
> +	return (uintptr_t)p - s;
> +}
> +
> +static void scs_check_usage(struct task_struct *tsk)
> +{
> +	static DEFINE_SPINLOCK(lock);
> +	static unsigned long highest;
> +	unsigned long used = scs_used(tsk);
> +
> +	if (used <= highest)
> +		return;
> +
> +	spin_lock(&lock);
> +
> +	if (used > highest) {
> +		pr_info("%s: highest shadow stack usage %lu bytes\n",
> +			__func__, used);
> +		highest = used;
> +	}
> +
> +	spin_unlock(&lock);
> +}
> +#else
> +static inline void scs_check_usage(struct task_struct *tsk)
> +{
> +}
> +#endif
> +
>  bool scs_corrupted(struct task_struct *tsk)
>  {
>  	return *scs_magic(tsk) != SCS_END_MAGIC;
> @@ -181,6 +219,7 @@ void scs_release(struct task_struct *tsk)
>  		return;
>  
>  	WARN_ON(scs_corrupted(tsk));
> +	scs_check_usage(tsk);
>  
>  	scs_account(tsk, -1);
>  	task_set_scs(tsk, NULL);
> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 
