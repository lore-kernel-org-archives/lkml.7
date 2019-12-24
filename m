Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F5C2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 07:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8972020706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 07:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfLXHF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 02:05:56 -0500
Received: from foss.arm.com ([217.140.110.172]:50154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfLXHF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:05:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7957431B;
        Mon, 23 Dec 2019 23:05:55 -0800 (PST)
Received: from [10.163.1.130] (unknown [10.163.1.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2BE43F6CF;
        Mon, 23 Dec 2019 23:08:53 -0800 (PST)
Subject: Re: [PATCH] arm64: Set SSBS for user threads while creation
To:     Srinivas Ramana <sramana@codeaurora.org>, will@kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, will.deacon@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1577106146-8999-1-git-send-email-sramana@codeaurora.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d490d6ce-8b07-ce79-4580-ac80f239312a@arm.com>
Date:   Tue, 24 Dec 2019 12:36:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1577106146-8999-1-git-send-email-sramana@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/23/2019 06:32 PM, Srinivas Ramana wrote:
> Current SSBS implementation takes care of setting the
> SSBS bit in start_thread() for user threads. While this works
> for tasks launched with fork/clone followed by execve, for cases
> where userspace would just call fork (eg, Java applications) this
> leaves the SSBS bit unset. This results in performance
> regression for such tasks.
> 
> It is understood that commit cbdf8a189a66 ("arm64: Force SSBS
> on context switch") masks this issue, but that was done for a
> different reason where heterogeneous CPUs(both SSBS supported
> and unsupported) are present. It is appropriate to take care
> of the SSBS bit for all threads while creation itself.

So this fixes the situation (i.e low performance) from the creation time
of a task with fork() which will never see a subsequent execve, till it
gets context switched for the very first time ?

> 
> Fixes: 8f04e8e6e29c ("arm64: ssbd: Add support for PSTATE.SSBS rather than trapping to EL3")
> Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
> ---
>  arch/arm64/kernel/process.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 71f788cd2b18..a8f05cc39261 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -399,6 +399,13 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  		 */
>  		if (clone_flags & CLONE_SETTLS)
>  			p->thread.uw.tp_value = childregs->regs[3];
> +
> +		if (arm64_get_ssbd_state() != ARM64_SSBD_FORCE_ENABLE) {
> +			if (is_compat_thread(task_thread_info(p)))
> +				set_compat_ssbs_bit(childregs);
> +			else
> +				set_ssbs_bit(childregs);
> +		}
>  	} else {
>  		memset(childregs, 0, sizeof(struct pt_regs));
>  		childregs->pstate = PSR_MODE_EL1h;
> 
