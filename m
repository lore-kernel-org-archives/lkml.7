Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A33C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBB822CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfH3HMR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:12:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:47778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbfH3HMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:12:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB971B6DB;
        Fri, 30 Aug 2019 07:12:14 +0000 (UTC)
Date:   Fri, 30 Aug 2019 09:12:12 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Nicolai Stange <nstange@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Allison Randal <allison@lohutok.net>,
        Firoz Khan <firoz.khan@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 5/5] powerpc/perf: split callchain.c by bitness
Message-ID: <20190830091212.4d1d619f@naga>
In-Reply-To: <20190830084225.527f4265@naga>
References: <c77eec3d99fd0251edf725a3d9e1b79f396eba6e.1567117050.git.msuchanek@suse.de>
        <4d996b0a225ca5b7d287ae46825d7da4a1d6e509.1567146554.git.christophe.leroy@c-s.fr>
        <20190830084225.527f4265@naga>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 08:42:25 +0200
Michal Suchánek <msuchanek@suse.de> wrote:

> On Fri, 30 Aug 2019 06:35:11 +0000 (UTC)
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
> > On 08/29/2019 10:28 PM, Michal Suchanek wrote:  

> >  obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o bhrb.o
> > diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
> > index 0bd4484eddaa..17c43ae03084 100644
> > --- a/arch/powerpc/perf/callchain_32.c
> > +++ b/arch/powerpc/perf/callchain_32.c
> > @@ -15,50 +15,13 @@
> >  #include <asm/sigcontext.h>
> >  #include <asm/ucontext.h>
> >  #include <asm/vdso.h>
> > -#ifdef CONFIG_PPC64
> > -#include "../kernel/ppc32.h"
> > -#endif
> >  #include <asm/pte-walk.h>
> >  
> >  #include "callchain.h"
> >  
> >  #ifdef CONFIG_PPC64
> > -static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
> > -{
> > -	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> > -	    ((unsigned long)ptr & 3))
> > -		return -EFAULT;
> > -
> > -	pagefault_disable();
> > -	if (!__get_user_inatomic(*ret, ptr)) {
> > -		pagefault_enable();
> > -		return 0;
> > -	}
> > -	pagefault_enable();
> > -
> > -	return read_user_stack_slow(ptr, ret, 4);
> > -}
> > -#else /* CONFIG_PPC64 */
> > -/*
> > - * On 32-bit we just access the address and let hash_page create a
> > - * HPTE if necessary, so there is no need to fall back to reading
> > - * the page tables.  Since this is called at interrupt level,
> > - * do_page_fault() won't treat a DSI as a page fault.
> > - */
> > -static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
> > -{
> > -	int rc;
> > -
> > -	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> > -	    ((unsigned long)ptr & 3))
> > -		return -EFAULT;
> > -
> > -	pagefault_disable();
> > -	rc = __get_user_inatomic(*ret, ptr);
> > -	pagefault_enable();
> > -
> > -	return rc;
> > -}
> > +#include "../kernel/ppc32.h"
> > +#else
> >  
> >  #define __SIGNAL_FRAMESIZE32	__SIGNAL_FRAMESIZE
> >  #define sigcontext32		sigcontext
> > @@ -95,6 +58,30 @@ struct rt_signal_frame_32 {
> >  	int			abigap[56];
> >  };
> >  
> > +/*
> > + * On 32-bit we just access the address and let hash_page create a
> > + * HPTE if necessary, so there is no need to fall back to reading
> > + * the page tables.  Since this is called at interrupt level,
> > + * do_page_fault() won't treat a DSI as a page fault.
> > + */
> > +static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
> > +{
> > +	int rc;
> > +
> > +	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> > +	    ((unsigned long)ptr & 3))
> > +		return -EFAULT;
> > +
> > +	pagefault_disable();
> > +	rc = __get_user_inatomic(*ret, ptr);
> > +	pagefault_enable();
> > +
> > +	if (IS_ENABLED(CONFIG_PPC32) || !rc)
> > +		return rc;
> > +
> > +	return read_user_stack_slow(ptr, ret, 4);
> > +}
> > +
> >  static int is_sigreturn_32_address(unsigned int nip, unsigned int fp)
> >  {
> >  	if (nip == fp + offsetof(struct signal_frame_32, mctx.mc_pad))  
> 
> I will leave consolidating this function to somebody who knows what the
> desired semantic is. With a short ifdef section at the top of the file
> it is a low-hanging fruit.

It looks ok if done as a separate patch.

Thanks

Michal
