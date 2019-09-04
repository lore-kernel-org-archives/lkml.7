Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24C7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 02:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9964D208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 02:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfIDCZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 22:25:30 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:17313 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726589AbfIDCZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:25:30 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x842ArUi069839;
        Wed, 4 Sep 2019 10:10:53 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 4 Sep 2019
 10:24:06 +0800
Date:   Wed, 4 Sep 2019 10:24:07 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     Daniel Axtens <dja@axtens.net>
CC:     Christoph Hellwig <hch@infradead.org>,
        Alan Quey-Liang =?utf-8?B?S2FvKOmrmOmtgeiJryk=?= 
        <alankao@andestech.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "glider@google.com" <glider@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "atish.patra@wdc.com" <atish.patra@wdc.com>,
        =?utf-8?B?6Zui6IG3Wm9uZyBab25nLVhpYW4gTGko5p2O5a6X5oayKQ==?= 
        <zong@andestech.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 2/2] riscv: Add KASAN support
Message-ID: <20190904022407.GA14994@andestech.com>
References: <cover.1565161957.git.nickhu@andestech.com>
 <88358ef8f7cfcb7fd01b6b989eccaddbe00a1e57.1565161957.git.nickhu@andestech.com>
 <20190812151050.GJ26897@infradead.org>
 <20190814074417.GA21929@andestech.com>
 <87k1apto1o.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87k1apto1o.fsf@dja-thinkpad.axtens.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x842ArUi069839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Sep 04, 2019 at 01:08:51AM +1000, Daniel Axtens wrote:
> Nick Hu <nickhu@andestech.com> writes:
> 
> > Hi Christoph,
> >
> > Thanks for your reply. I will answer one by one.
> >
> > Hi Alexander,
> >
> > Would you help me for the question about SOFTIRQENTRY_TEXT?
> >
> > On Mon, Aug 12, 2019 at 11:10:50PM +0800, Christoph Hellwig wrote:
> >> > 2. KASAN can't debug the modules since the modules are allocated in VMALLOC
> >> > area. We mapped the shadow memory, which corresponding to VMALLOC area,
> >> > to the kasan_early_shadow_page because we don't have enough physical space
> >> > for all the shadow memory corresponding to VMALLOC area.
> >> 
> >> How do other architectures solve this problem?
> >> 
> > Other archs like arm64 and x86 allocate modules in their module region.
> 
> I've run in to a similar difficulty in ppc64. My approach has been to
> add a generic feature to allow kasan to handle vmalloc areas:
> 
> https://lore.kernel.org/linux-mm/20190903145536.3390-1-dja@axtens.net/
> 
> I link this with ppc64 in this series:
> 
> https://lore.kernel.org/linuxppc-dev/20190806233827.16454-1-dja@axtens.net/
> 
> However, see Christophe Leroy's comments: he thinks I should take a
> different approach in a number of places, including just adding a
> separate module area. I haven't had time to think through all of his
> proposals yet; in particular I'd want to think through what the
> implication of a separate module area is for KASLR.
> 
> Regards,
> Daniel
>
 
Thanks for the advice! I would study on it.

Regards,
Nick

> >
> >> > @@ -54,6 +54,8 @@ config RISCV
> >> >  	select EDAC_SUPPORT
> >> >  	select ARCH_HAS_GIGANTIC_PAGE
> >> >  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> >> > +	select GENERIC_STRNCPY_FROM_USER if KASAN
> >> 
> >> Is there any reason why we can't always enabled this?  Also just
> >> enabling the generic efficient strncpy_from_user should probably be
> >> a separate patch.
> >> 
> > You're right, always enable it would be better.
> >
> >> > +	select HAVE_ARCH_KASAN if MMU
> >> 
> >> Based on your cover letter this should be if MMU && 64BIT
> >> 
> >> >  #define __HAVE_ARCH_MEMCPY
> >> >  extern asmlinkage void *memcpy(void *, const void *, size_t);
> >> > +extern asmlinkage void *__memcpy(void *, const void *, size_t);
> >> >  
> >> >  #define __HAVE_ARCH_MEMMOVE
> >> >  extern asmlinkage void *memmove(void *, const void *, size_t);
> >> > +extern asmlinkage void *__memmove(void *, const void *, size_t);
> >> > +
> >> > +#define memcpy(dst, src, len) __memcpy(dst, src, len)
> >> > +#define memmove(dst, src, len) __memmove(dst, src, len)
> >> > +#define memset(s, c, n) __memset(s, c, n)
> >> 
> >> This looks weird and at least needs a very good comment.  Also
> >> with this we effectively don't need the non-prefixed prototypes
> >> anymore.  Also you probably want to split the renaming of the mem*
> >> routines into a separate patch with a proper changelog.
> >> 
> > I made some mistakes on this porting, this would be better:
> >
> > #define __HAVE_ARCH_MEMSET
> > extern asmlinkage void *memset(void *, int, size_t);
> > extern asmlinkage void *__memset(void *, int, size_t);
> >
> > #define __HAVE_ARCH_MEMCPY
> > extern asmlinkage void *memcpy(void *, const void *, size_t);
> > extern asmlinkage void *__memcpy(void *, const void *, size_t);
> >
> > #define __HAVE_ARCH_MEMMOVE
> > extern asmlinkage void *memmove(void *, const void *, size_t);
> > extern asmlinkage void *__memmove(void *, const void *, size_t);
> >
> > #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> >
> > #define memcpy(dst, src, len) __memcpy(dst, src, len)
> > #define memmove(dst, src, len) __memmove(dst, src, len)
> > #define memset(s, c, n) __memset(s, c, n)
> >
> > #endif
> >
> >> >  #include <asm/tlbflush.h>
> >> >  #include <asm/thread_info.h>
> >> >  
> >> > +#ifdef CONFIG_KASAN
> >> > +#include <asm/kasan.h>
> >> > +#endif
> >> 
> >> Any good reason to not just always include the header?
> >>
> > Nope, I would remove the '#ifdef CONFIG_KASAN', and do the logic in the header
> > instead.
> >
> >> > +
> >> >  #ifdef CONFIG_DUMMY_CONSOLE
> >> >  struct screen_info screen_info = {
> >> >  	.orig_video_lines	= 30,
> >> > @@ -64,12 +68,17 @@ void __init setup_arch(char **cmdline_p)
> >> >  
> >> >  	setup_bootmem();
> >> >  	paging_init();
> >> > +
> >> >  	unflatten_device_tree();
> >> 
> >> spurious whitespace change.
> >> 
> >> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> >> > index 23cd1a9..9700980 100644
> >> > --- a/arch/riscv/kernel/vmlinux.lds.S
> >> > +++ b/arch/riscv/kernel/vmlinux.lds.S
> >> > @@ -46,6 +46,7 @@ SECTIONS
> >> >  		KPROBES_TEXT
> >> >  		ENTRY_TEXT
> >> >  		IRQENTRY_TEXT
> >> > +		SOFTIRQENTRY_TEXT
> >> 
> >> Hmm.  What is the relation to kasan here?  Maybe we should add this
> >> separately with a good changelog?
> >> 
> > There is a commit for it:
> >
> > Author: Alexander Potapenko <glider@google.com>
> > Date:   Fri Mar 25 14:22:05 2016 -0700
> >
> >     arch, ftrace: for KASAN put hard/soft IRQ entries into separate sections
> >
> >     KASAN needs to know whether the allocation happens in an IRQ handler.
> >     This lets us strip everything below the IRQ entry point to reduce the
> >     number of unique stack traces needed to be stored.
> >
> >     Move the definition of __irq_entry to <linux/interrupt.h> so that the
> >     users don't need to pull in <linux/ftrace.h>.  Also introduce the
> >     __softirq_entry macro which is similar to __irq_entry, but puts the
> >     corresponding functions to the .softirqentry.text section.
> >
> > After reading the patch I understand that soft/hard IRQ entries should be
> > separated for KASAN to work, but why?
> >
> > Alexender, do you have any comments on this?
> >
> >> > +++ b/arch/riscv/mm/kasan_init.c
> >> > @@ -0,0 +1,102 @@
> >> > +// SPDX-License-Identifier: GPL-2.0
> >> 
> >> This probably also wants a copyright statement.
> >> 
> >> > +	// init for swapper_pg_dir
> >> 
> >> Please use /* */ style comments.
> >
> > -- 
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190814074417.GA21929%40andestech.com.
