Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22CCC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7883F21874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfH3Gma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:42:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:46754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727156AbfH3Gma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:42:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 832E8ACC5;
        Fri, 30 Aug 2019 06:42:27 +0000 (UTC)
Date:   Fri, 30 Aug 2019 08:42:25 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Breno Leitao <leitao@debian.org>,
        Russell Currey <ruscur@russell.cc>,
        Nicolai Stange <nstange@suse.de>,
        Michael Neuling <mikey@neuling.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] powerpc/perf: split callchain.c by bitness
Message-ID: <20190830084225.527f4265@naga>
In-Reply-To: <4d996b0a225ca5b7d287ae46825d7da4a1d6e509.1567146554.git.christophe.leroy@c-s.fr>
References: <c77eec3d99fd0251edf725a3d9e1b79f396eba6e.1567117050.git.msuchanek@suse.de>
        <4d996b0a225ca5b7d287ae46825d7da4a1d6e509.1567146554.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 06:35:11 +0000 (UTC)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> On 08/29/2019 10:28 PM, Michal Suchanek wrote:
> > Building callchain.c with !COMPAT proved quite ugly with all the
> > defines. Splitting out the 32bit and 64bit parts looks better.
> > 
> > Also rewrite current_is_64bit as common function. No other code change
> > intended.  
> 
> Nice result.
> 
> Could look even better by merging both read_user_stack_32(), see below.
> 
> Also a possible cosmetic change to Makefile.
> 
> ---
>  arch/powerpc/perf/Makefile       |  7 ++---
>  arch/powerpc/perf/callchain_32.c | 65 ++++++++++++++++------------------------
>  2 files changed, 29 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
> index e9f3202251d0..53d614e98537 100644
> --- a/arch/powerpc/perf/Makefile
> +++ b/arch/powerpc/perf/Makefile
> @@ -1,9 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -obj-$(CONFIG_PERF_EVENTS)	+= callchain.o perf_regs.o
> -ifdef CONFIG_PERF_EVENTS
> -obj-y				+= callchain_$(BITS).o
> -obj-$(CONFIG_COMPAT)		+= callchain_32.o
> +obj-$(CONFIG_PERF_EVENTS)	+= callchain.o callchain_$(BITS).o perf_regs.o
> +ifdef CONFIG_COMPAT
> +obj-$(CONFIG_PERF_EVENTS)	+= callchain_32.o
>  endif
>  
That looks good.
>  obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o bhrb.o
> diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
> index 0bd4484eddaa..17c43ae03084 100644
> --- a/arch/powerpc/perf/callchain_32.c
> +++ b/arch/powerpc/perf/callchain_32.c
> @@ -15,50 +15,13 @@
>  #include <asm/sigcontext.h>
>  #include <asm/ucontext.h>
>  #include <asm/vdso.h>
> -#ifdef CONFIG_PPC64
> -#include "../kernel/ppc32.h"
> -#endif
>  #include <asm/pte-walk.h>
>  
>  #include "callchain.h"
>  
>  #ifdef CONFIG_PPC64
> -static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
> -{
> -	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> -	    ((unsigned long)ptr & 3))
> -		return -EFAULT;
> -
> -	pagefault_disable();
> -	if (!__get_user_inatomic(*ret, ptr)) {
> -		pagefault_enable();
> -		return 0;
> -	}
> -	pagefault_enable();
> -
> -	return read_user_stack_slow(ptr, ret, 4);
> -}
> -#else /* CONFIG_PPC64 */
> -/*
> - * On 32-bit we just access the address and let hash_page create a
> - * HPTE if necessary, so there is no need to fall back to reading
> - * the page tables.  Since this is called at interrupt level,
> - * do_page_fault() won't treat a DSI as a page fault.
> - */
> -static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
> -{
> -	int rc;
> -
> -	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> -	    ((unsigned long)ptr & 3))
> -		return -EFAULT;
> -
> -	pagefault_disable();
> -	rc = __get_user_inatomic(*ret, ptr);
> -	pagefault_enable();
> -
> -	return rc;
> -}
> +#include "../kernel/ppc32.h"
> +#else
>  
>  #define __SIGNAL_FRAMESIZE32	__SIGNAL_FRAMESIZE
>  #define sigcontext32		sigcontext
> @@ -95,6 +58,30 @@ struct rt_signal_frame_32 {
>  	int			abigap[56];
>  };
>  
> +/*
> + * On 32-bit we just access the address and let hash_page create a
> + * HPTE if necessary, so there is no need to fall back to reading
> + * the page tables.  Since this is called at interrupt level,
> + * do_page_fault() won't treat a DSI as a page fault.
> + */
> +static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
> +{
> +	int rc;
> +
> +	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> +	    ((unsigned long)ptr & 3))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +	rc = __get_user_inatomic(*ret, ptr);
> +	pagefault_enable();
> +
> +	if (IS_ENABLED(CONFIG_PPC32) || !rc)
> +		return rc;
> +
> +	return read_user_stack_slow(ptr, ret, 4);
> +}
> +
>  static int is_sigreturn_32_address(unsigned int nip, unsigned int fp)
>  {
>  	if (nip == fp + offsetof(struct signal_frame_32, mctx.mc_pad))

I will leave consolidating this function to somebody who knows what the
desired semantic is. With a short ifdef section at the top of the file
it is a low-hanging fruit.

Thanks

Michal
