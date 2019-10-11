Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9616DC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0C8214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfJKL0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:26:48 -0400
Received: from foss.arm.com ([217.140.110.172]:57326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbfJKL0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:26:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 559B828;
        Fri, 11 Oct 2019 04:26:47 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B85E3F703;
        Fri, 11 Oct 2019 04:26:46 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:26:44 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        will@kernel.org
Subject: Re: [PATCH 2/3] arm64: nofpsmid: Clear TIF_FOREIGN_FPSTATE flag for
 early tasks
Message-ID: <20191011112642.GF27757@arm.com>
References: <20191010171517.28782-1-suzuki.poulose@arm.com>
 <20191010171517.28782-3-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010171517.28782-3-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 06:15:16PM +0100, Suzuki K Poulose wrote:
> We detect the absence of FP/SIMD after we boot the SMP CPUs, and by then
> we have kernel threads running already with TIF_FOREIGN_FPSTATE set which
> could be inherited by early userspace applications (e.g, modprobe triggered
> from initramfs). This could end up in the applications stuck in
> do_nofity_resume() as we never clear the TIF flag, once we now know that
> we don't support FP.
> 
> Fix this by making sure that we clear the TIF_FOREIGN_FPSTATE flag
> for tasks which may have them set, as we would have done in the normal
> case, but avoiding touching the hardware state (since we don't support any).
> 
> Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 37d3912cfe06..dfcdd077aeca 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1128,12 +1128,19 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
>   */
>  void fpsimd_restore_current_state(void)
>  {
> -	if (!system_supports_fpsimd())
> -		return;
> -
>  	get_cpu_fpsimd_context();
> -
> -	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> +	/*
> +	 * For the tasks that were created before we detected the absence of
> +	 * FP/SIMD, the TIF_FOREIGN_FPSTATE could be set via fpsimd_thread_switch()
> +	 * and/or could be inherited from the parent(init_task has this set). Even
> +	 * though userspace has not run yet, this could be inherited by the
> +	 * processes forked from one of those tasks (e.g, modprobe from initramfs).
> +	 * If the system doesn't support FP/SIMD, we must clear the flag for the
> +	 * tasks mentioned above, to indicate that the FPSTATE is clean (as we
> +	 * can't have one) to avoid looping for ever to clear the flag.
> +	 */
> +	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE) &&
> +	    system_supports_fpsimd()) {

I'm not too keen on this approach: elsewhere we just stub out all the
FPSIMD handling logic if !system_supports_fpsimd() -- I think we should
be using this test everywhere rather than relying on TIF_FOREIGN_FPSTATE.

Rather, I feel that TIF_FOREIGN_FPSTATE means "if this is a user task
and this task is current() and the system supports FPSIMD at all, this
task's FPSIMD state is not loaded in the cpu".

I think we should ensure that any check on TIF_FOREIGN_FPSTATE is
shadowed by a check on system_supports_fpsimd() somewhere.  This already
exists in many places -- we just need to fill in the missing ones.

fpsimd_save() is a backend function that should only be called if
system_supports_fpsimd(), so that should not need any check internally,
but we should make sure that calls to this function are appropriately
protected with in if (system_supports_fpsimd()).

For other maintenance functions intended for outside callers:

 * fpsimd_bind_task_to_cpu()
 * fpsimd_bind_state_to_cpu()
 * fpsimd_flush_task_state()
 * fpsimd_save_and_flush_cpu_state()

the situation is less clear.  Does is make sense to call these at all
if !system_supports_fpsimd()?  I'm not currently sure.  We could at
least drop some WARN_ON() into these to check, after revieweing their
callsites.

>  		task_fpsimd_load();
>  		fpsimd_bind_task_to_cpu();
>  	}
> @@ -1148,17 +1155,16 @@ void fpsimd_restore_current_state(void)
>   */
>  void fpsimd_update_current_state(struct user_fpsimd_state const *state)
>  {
> -	if (!system_supports_fpsimd())
> -		return;
> -
>  	get_cpu_fpsimd_context();
>  
>  	current->thread.uw.fpsimd_state = *state;
>  	if (system_supports_sve() && test_thread_flag(TIF_SVE))
>  		fpsimd_to_sve(current);

Why should we do this stuff on a system that doesn't support FP?

> -	task_fpsimd_load();
> -	fpsimd_bind_task_to_cpu();
> +	if (system_supports_fpsimd()) {
> +		task_fpsimd_load();
> +		fpsimd_bind_task_to_cpu();
> +	}
>  
>  	clear_thread_flag(TIF_FOREIGN_FPSTATE);

[...]

Not in scope for a stable fix, but:

It would be interesting to try to strip out TIF_FOREIGN_FPSTATE
entirely and do some benchmarks and irq latency measurements:

TIF_FOREIGN_FPSTATE is just a cached copy of the wrong_task || wrong_cpu
condition defined in fpsimd_thread_switch() --

That means we have to do maintenance on it all over the place to keep
it in sync with the condition it represents -- this has proven to be
a source of complexity and subtle bugs, as well as making the code
fragile to maintain.

The only point of all this is so that there is a thread flag for
do_notify_resume() to check.  Now that do_notify_resume() is C it would
be trivial to check the real condition -- there would be a cost
increase and interrupt latency increase here, but maybe not that much.

This wouldn't solve the whole problem, but it might remove a layer of
complexity.

Cheers
---Dave
