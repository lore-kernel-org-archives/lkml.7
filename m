Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0272320863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfCRRUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:20:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11979 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfCRRU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:20:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6443B3082AEE;
        Mon, 18 Mar 2019 17:20:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7D66860FAB;
        Mon, 18 Mar 2019 17:20:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 18 Mar 2019 18:20:29 +0100 (CET)
Date:   Mon, 18 Mar 2019 18:20:24 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 4/6] powerpc: use common ptrace_syscall_enter hook to
 handle _TIF_SYSCALL_EMU
Message-ID: <20190318172024.GB23521@redhat.com>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-5-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318104925.16600-5-sudeep.holla@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 18 Mar 2019 17:20:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/18, Sudeep Holla wrote:
>
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -3278,35 +3278,29 @@ long do_syscall_trace_enter(struct pt_regs *regs)
>  
>  	user_exit();
>  
> -	flags = READ_ONCE(current_thread_info()->flags) &
> -		(_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
> -
> -	if (flags) {
> -		int rc = tracehook_report_syscall_entry(regs);
> +	if (unlikely(ptrace_syscall_enter(regs))) {
> +		/*
> +		 * A nonzero return code from tracehook_report_syscall_entry()
> +		 * tells us to prevent the syscall execution, but we are not
> +		 * going to execute it anyway.
> +		 *
> +		 * Returning -1 will skip the syscall execution. We want to
> +		 * avoid clobbering any registers, so we don't goto the skip
> +		 * label below.
> +		 */
> +		return -1;
> +	}
>  
> -		if (unlikely(flags & _TIF_SYSCALL_EMU)) {
> -			/*
> -			 * A nonzero return code from
> -			 * tracehook_report_syscall_entry() tells us to prevent
> -			 * the syscall execution, but we are not going to
> -			 * execute it anyway.
> -			 *
> -			 * Returning -1 will skip the syscall execution. We want
> -			 * to avoid clobbering any registers, so we don't goto
> -			 * the skip label below.
> -			 */
> -			return -1;
> -		}
> +	flags = READ_ONCE(current_thread_info()->flags) & _TIF_SYSCALL_TRACE;

Why do we need READ_ONCE() with this change?

And now that we change a single bit "flags" doesn't look like a good name.

Again, to me this patch just makes the code look worse. Honestly, I don't
think that the new (badly named) ptrace_syscall_enter() hook makes any sense.

Oleg.

