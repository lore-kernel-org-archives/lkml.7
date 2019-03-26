Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592FCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F892070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfCZPNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:13:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZPNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:13:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7FA98046D;
        Tue, 26 Mar 2019 15:12:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.68])
        by smtp.corp.redhat.com (Postfix) with SMTP id 294A9600C8;
        Tue, 26 Mar 2019 15:12:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 26 Mar 2019 16:12:51 +0100 (CET)
Date:   Tue, 26 Mar 2019 16:12:45 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] x86/syscalls: Mark expected switch fall-throughs
Message-ID: <20190326151244.GC16837@redhat.com>
References: <20190228192746.GA13021@embeddedor>
 <alpine.DEB.2.21.1903231457590.1798@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903231457590.1798@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 26 Mar 2019 15:13:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, Thomas Gleixner wrote:
>
> On Thu, 28 Feb 2019, Gustavo A. R. Silva wrote:
> 
> >  arch/x86/include/asm/syscall.h | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> 
> Second thoughts. So this adds 28 /* fall through */ comments. Now I
> appreciate the effort, but can we pretty please look at the code in
> question and figure out whether the implementation makes sense in the first
> place before adding falltrough comments blindly?
> 
> The whole exercise can be simplified. Untested patch below.
> 
> Looking at that stuff makes me wonder about two things:
> 
>  1) The third argument of get/set(), i.e. the argument offset, is 0 on all
>     call sites. Do we need it at all?

Probably "maxargs" can be removed too, Steven sent the patches a long ago, see
https://lore.kernel.org/lkml/20161107212634.529267342@goodmis.org/

>  2) syscall_set_arguments() has been introduced in 2008 and we still have
>     no caller. Instead of polishing it, can it be removed completely or are
>     there plans to actually use it?

I think it can die.

> 
> Thanks,
> 
> 	tglx
> 
> 8<----------------
> 
> arch/x86/include/asm/syscall.h |  174 +++++++++++++++--------------------------
>  1 file changed, 64 insertions(+), 110 deletions(-)
> 
> --- a/arch/x86/include/asm/syscall.h
> +++ b/arch/x86/include/asm/syscall.h
> @@ -114,126 +114,80 @@ static inline int syscall_get_arch(void)
>  
>  #else	 /* CONFIG_X86_64 */
>  
> +static inline unsigned long syscall_get_argreg(struct pt_regs *regs,
> +					       unsigned int idx)
> +{
> +	switch (idx) {
> +	case  0: return regs->di;
> +	case  1: return regs->si;
> +	case  2: return regs->dx;
> +	case  3: return regs->r10;
> +	case  4: return regs->r8;
> +	case  5: return regs->r9;
> +#ifdef CONFIG_IA32_EMULATION
> +	case  6: return regs->bx;
> +	case  7: return regs->cx;
> +	case  8: return regs->dx;
> +	case  9: return regs->si;
> +	case 10: return regs->di;
> +	case 11: return regs->bp;
> +#endif
> +	}
> +	return 0;
> +}
> +
>  static inline void syscall_get_arguments(struct task_struct *task,
>  					 struct pt_regs *regs,
> -					 unsigned int i, unsigned int n,
> +					 unsigned int idx, unsigned int cnt,
>  					 unsigned long *args)
>  {
> -# ifdef CONFIG_IA32_EMULATION
> -	if (task->thread_info.status & TS_COMPAT)
> -		switch (i) {
> -		case 0:
> -			if (!n--) break;
> -			*args++ = regs->bx;
> -		case 1:
> -			if (!n--) break;
> -			*args++ = regs->cx;
> -		case 2:
> -			if (!n--) break;
> -			*args++ = regs->dx;
> -		case 3:
> -			if (!n--) break;
> -			*args++ = regs->si;
> -		case 4:
> -			if (!n--) break;
> -			*args++ = regs->di;
> -		case 5:
> -			if (!n--) break;
> -			*args++ = regs->bp;
> -		case 6:
> -			if (!n--) break;
> -		default:
> -			BUG();
> -			break;
> -		}
> -	else
> -# endif
> -		switch (i) {
> -		case 0:
> -			if (!n--) break;
> -			*args++ = regs->di;
> -		case 1:
> -			if (!n--) break;
> -			*args++ = regs->si;
> -		case 2:
> -			if (!n--) break;
> -			*args++ = regs->dx;
> -		case 3:
> -			if (!n--) break;
> -			*args++ = regs->r10;
> -		case 4:
> -			if (!n--) break;
> -			*args++ = regs->r8;
> -		case 5:
> -			if (!n--) break;
> -			*args++ = regs->r9;
> -		case 6:
> -			if (!n--) break;
> -		default:
> -			BUG();
> -			break;
> -		}
> +	if (WARN_ON((idx + cnt) > 6))
> +		return;
> +
> +	if (IS_ENABLED(CONFIG_IA32_EMULATION) &&
> +	    task->thread_info.status & TS_COMPAT)
> +		idx += 6;
> +
> +	for (; cnt > 0; cnt--)
> +		*args++ = syscall_get_argreg(regs, idx++);
> +}
> +
> +static inline void syscall_set_argreg(struct pt_regs *regs,
> +				      unsigned int idx,
> +				      unsigned long val)
> +{
> +	switch (idx) {
> +	case  0: regs->di  = val; break;
> +	case  1: regs->si  = val; break;
> +	case  2: regs->dx  = val; break;
> +	case  3: regs->r10 = val; break;
> +	case  4: regs->r8  = val; break;
> +	case  5: regs->r9  = val; break;
> +#ifdef CONFIG_IA32_EMULATION
> +	case  6: regs->bx  = val; break;
> +	case  7: regs->cx  = val; break;
> +	case  8: regs->dx  = val; break;
> +	case  9: regs->si  = val; break;
> +	case 10: regs->di  = val; break;
> +	case 11: regs->bp  = val; break;
> +#endif
> +	}
>  }
>  
>  static inline void syscall_set_arguments(struct task_struct *task,
>  					 struct pt_regs *regs,
> -					 unsigned int i, unsigned int n,
> +					 unsigned int idx, unsigned int cnt,
>  					 const unsigned long *args)
>  {
> -# ifdef CONFIG_IA32_EMULATION
> -	if (task->thread_info.status & TS_COMPAT)
> -		switch (i) {
> -		case 0:
> -			if (!n--) break;
> -			regs->bx = *args++;
> -		case 1:
> -			if (!n--) break;
> -			regs->cx = *args++;
> -		case 2:
> -			if (!n--) break;
> -			regs->dx = *args++;
> -		case 3:
> -			if (!n--) break;
> -			regs->si = *args++;
> -		case 4:
> -			if (!n--) break;
> -			regs->di = *args++;
> -		case 5:
> -			if (!n--) break;
> -			regs->bp = *args++;
> -		case 6:
> -			if (!n--) break;
> -		default:
> -			BUG();
> -			break;
> -		}
> -	else
> -# endif
> -		switch (i) {
> -		case 0:
> -			if (!n--) break;
> -			regs->di = *args++;
> -		case 1:
> -			if (!n--) break;
> -			regs->si = *args++;
> -		case 2:
> -			if (!n--) break;
> -			regs->dx = *args++;
> -		case 3:
> -			if (!n--) break;
> -			regs->r10 = *args++;
> -		case 4:
> -			if (!n--) break;
> -			regs->r8 = *args++;
> -		case 5:
> -			if (!n--) break;
> -			regs->r9 = *args++;
> -		case 6:
> -			if (!n--) break;
> -		default:
> -			BUG();
> -			break;
> -		}
> +	if (WARN_ON((idx + cnt) > 6))
> +		return;
> +
> +	if (IS_ENABLED(CONFIG_IA32_EMULATION) &&
> +	    task->thread_info.status & TS_COMPAT)
> +		idx += 6;
> +
> +	for (; cnt > 0; cnt--)
> +		syscall_set_argreg(regs, idx++, *args++);
>  }
>  
>  static inline int syscall_get_arch(void)

