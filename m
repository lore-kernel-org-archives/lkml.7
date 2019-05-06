Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68404C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E3B21019
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEFNRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 09:17:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47787 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfEFNRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:17:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44yNZ20xVWz9s9y;
        Mon,  6 May 2019 23:17:13 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next v10 5/7] powerpc: define syscall_get_error()
In-Reply-To: <20190415234444.GE9384@altlinux.org>
References: <20190415234307.GA9364@altlinux.org> <20190415234444.GE9384@altlinux.org>
Date:   Mon, 06 May 2019 23:17:12 +1000
Message-ID: <87woj3wwmf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> syscall_get_error() is required to be implemented on this
> architecture in addition to already implemented syscall_get_nr(),
> syscall_get_arguments(), syscall_get_return_value(), and
> syscall_get_arch() functions in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Michael, this patch is waiting for ACK since early December.

Sorry, the more I look at our seccomp/ptrace code the more problems I
find :/

This change looks OK to me, given it will only be called by your new
ptrace API.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


> Notes:
>     v10: unchanged
>     v9: unchanged
>     v8: unchanged
>     v7: unchanged
>     v6: unchanged
>     v5: initial revision
>     
>     This change has been tested with
>     tools/testing/selftests/ptrace/get_syscall_info.c and strace,
>     so it's correct from PTRACE_GET_SYSCALL_INFO point of view.
>     
>     This cast doubts on commit v4.3-rc1~86^2~81 that changed
>     syscall_set_return_value() in a way that doesn't quite match
>     syscall_get_error(), but syscall_set_return_value() is out
>     of scope of this series, so I'll just let you know my concerns.
     
Yeah I think you're right. My commit made it work for seccomp but only
on the basis that seccomp calls syscall_set_return_value() and then
immediately goes out via the syscall exit path. And only the combination
of those gets things into the same state that syscall_get_error()
expects.

But with the way the code is currently structured if
syscall_set_return_value() negated the error value, then the syscall
exit path would then store the wrong thing in pt_regs->result. So I
think it needs some more work rather than just reverting 1b1a3702a65c.

But I think fixing that can be orthogonal to this commit going in as the
code does work as it's currently written, the in-between state that
syscall_set_return_value() creates via seccomp should not be visible to
ptrace.

cheers

>     See also https://lore.kernel.org/lkml/874lbbt3k6.fsf@concordia.ellerman.id.au/
>     for more details on powerpc syscall_set_return_value() confusion.
>
>  arch/powerpc/include/asm/syscall.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index a048fed0722f..bd9663137d57 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -38,6 +38,16 @@ static inline void syscall_rollback(struct task_struct *task,
>  	regs->gpr[3] = regs->orig_gpr3;
>  }
>  
> +static inline long syscall_get_error(struct task_struct *task,
> +				     struct pt_regs *regs)
> +{
> +	/*
> +	 * If the system call failed,
> +	 * regs->gpr[3] contains a positive ERRORCODE.
> +	 */
> +	return (regs->ccr & 0x10000000UL) ? -regs->gpr[3] : 0;
> +}
> +
>  static inline long syscall_get_return_value(struct task_struct *task,
>  					    struct pt_regs *regs)
>  {
> -- 
> ldv
