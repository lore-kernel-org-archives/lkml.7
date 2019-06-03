Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C6BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B1827332
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfFCRW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:22:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56362 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbfFCRW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:22:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16F2CA78;
        Mon,  3 Jun 2019 10:22:57 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CDEE3F5AF;
        Mon,  3 Jun 2019 10:22:54 -0700 (PDT)
Date:   Mon, 3 Jun 2019 18:22:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 2/4] x86: simplify _TIF_SYSCALL_EMU handling
Message-ID: <20190603172251.GG63283@arrakis.emea.arm.com>
References: <20190523090618.13410-1-sudeep.holla@arm.com>
 <20190523090618.13410-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523090618.13410-3-sudeep.holla@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:06:16AM +0100, Sudeep Holla wrote:
> The usage of emulated/_TIF_SYSCALL_EMU flags in syscall_trace_enter
> seems to be bit overcomplicated than required. Let's simplify it.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/x86/entry/common.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index a986b3c8294c..0a61705d62ec 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -72,23 +72,18 @@ static long syscall_trace_enter(struct pt_regs *regs)
>  
>  	struct thread_info *ti = current_thread_info();
>  	unsigned long ret = 0;
> -	bool emulated = false;
>  	u32 work;
>  
>  	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>  		BUG_ON(regs != task_pt_regs(current));
>  
> -	work = READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
> +	work = READ_ONCE(ti->flags);
>  
> -	if (unlikely(work & _TIF_SYSCALL_EMU))
> -		emulated = true;
> -
> -	if ((emulated || (work & _TIF_SYSCALL_TRACE)) &&
> -	    tracehook_report_syscall_entry(regs))
> -		return -1L;
> -
> -	if (emulated)
> -		return -1L;
> +	if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
> +		ret = tracehook_report_syscall_entry(regs);
> +		if (ret || (work & _TIF_SYSCALL_EMU))
> +			return -1L;
> +	}

Andy (or the other x86 folk), could I please get an ack on this patch? I
plan to queue this series through the arm64 tree (though if you want to
merge it separately, it looks like an independent clean-up with no
dependencies on the other patches).

Thanks.

-- 
Catalin
