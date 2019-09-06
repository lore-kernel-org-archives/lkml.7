Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0653C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C8E2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567759527;
	bh=AAE6gQwrlz04d9iJfV1epm//tdvLevDGznfUaNeLQvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nrJKi2908UbeVwZtGWmBbRLK7eVFHM3v+6x3zO4F2Dh51Wytt1Ja/yxNhuWq0RD8e
	 okzeNP98O0URgVOUy7Js19jqNVd7LQG2PfugOfmJeUznjVhnZn6ZV9oAVyjCPqU2ux
	 HFKfvuvHUGbiufcuXhWXnNIQ+zrAaQUapU0QqwgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391294AbfIFIp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbfIFIp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:45:26 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 123DD20842;
        Fri,  6 Sep 2019 08:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567759524;
        bh=AAE6gQwrlz04d9iJfV1epm//tdvLevDGznfUaNeLQvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sG5ozf2AVIh9mIR5y3TR1TzYNG8U4+5dDppI/VOIVYTpVGKQ+W4dLMb9efVk/pbMJ
         O0d7MDtEzkcHMINTSO8JKA2zRW06spJGhRSgsat5WZyYvbs3z4gxe5yyC6lWwZc+hT
         vKaBfTlFbNcMkpW/sNKnc7Zg9zhLOLMYz66uGf7w=
Date:   Fri, 6 Sep 2019 17:45:19 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH -tip v3 1/2] x86: xen: insn: Decode Xen and KVM
 emulate-prefix signature
Message-Id: <20190906174519.699b83f08d81b55203212fa1@kernel.org>
In-Reply-To: <20190906073436.GS2349@hirez.programming.kicks-ass.net>
References: <156773433821.31441.2905951246664148487.stgit@devnote2>
        <156773434815.31441.12739136439382289412.stgit@devnote2>
        <20190906073436.GS2349@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019 09:34:36 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Sep 06, 2019 at 10:45:48AM +0900, Masami Hiramatsu wrote:
> 
> > diff --git a/arch/x86/include/asm/xen/interface.h b/arch/x86/include/asm/xen/interface.h
> > index 62ca03ef5c65..fe33a9798708 100644
> > --- a/arch/x86/include/asm/xen/interface.h
> > +++ b/arch/x86/include/asm/xen/interface.h
> > @@ -379,12 +379,15 @@ struct xen_pmu_arch {
> >   * Prefix forces emulation of some non-trapping instructions.
> >   * Currently only CPUID.
> >   */
> > +#include <asm/xen/prefix.h>
> > +
> >  #ifdef __ASSEMBLY__
> > -#define XEN_EMULATE_PREFIX .byte 0x0f,0x0b,0x78,0x65,0x6e ;
> > +#define XEN_EMULATE_PREFIX .byte __XEN_EMULATE_PREFIX ;
> >  #define XEN_CPUID          XEN_EMULATE_PREFIX cpuid
> >  #else
> > -#define XEN_EMULATE_PREFIX ".byte 0x0f,0x0b,0x78,0x65,0x6e ; "
> > +#define XEN_EMULATE_PREFIX ".byte " __XEN_EMULATE_PREFIX_STR " ; "
> >  #define XEN_CPUID          XEN_EMULATE_PREFIX "cpuid"
> > +
> >  #endif
> 
> Possibly you can do something like:
> 
> #define XEN_EMULATE_PREFIX	__ASM_FORM(.byte __XEN_EMULATE_PREFIX ;)
> #define XEN_CPUID		XEN_EMULATE_PREFIX __ASM_FORM(cpuid)

Hmm, OK. But should I split this change from insn decoder change?

> 
> >  #endif /* _ASM_X86_XEN_INTERFACE_H */
> > diff --git a/arch/x86/include/asm/xen/prefix.h b/arch/x86/include/asm/xen/prefix.h
> > new file mode 100644
> > index 000000000000..f901be0d7a95
> > --- /dev/null
> > +++ b/arch/x86/include/asm/xen/prefix.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _TOOLS_ASM_X86_XEN_PREFIX_H
> > +#define _TOOLS_ASM_X86_XEN_PREFIX_H
> > +
> > +#include <linux/stringify.h>
> > +
> > +#define __XEN_EMULATE_PREFIX  0x0f,0x0b,0x78,0x65,0x6e
> > +#define __XEN_EMULATE_PREFIX_STR  __stringify(__XEN_EMULATE_PREFIX)
> > +
> > +#endif
> 
> How about we make this asm/virt_prefix.h or something and include:
> 
> /*
>  * Virt escape sequences to trigger instruction emulation;
>  * ideally these would decode to 'whole' instruction and not destroy
>  * the instruction stream; sadly this is not true for the 'kvm' one :/
>  */
> 
> #define __XEN_EMULATE_PREFIX  0x0f,0x0b,0x78,0x65,0x6e  /* ud2 ; .ascii "xen" */
> #define __KVM_EMULATE_PREFIX  0x0f,0x0b,0x6b,0x76,0x6d	/* ud2 ; .ascii "kvm" */

OK, and in that case I think we should do this in separated patch from
this change.

> 
> > diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> > index 0b5862ba6a75..b7eb50187db9 100644
> > --- a/arch/x86/lib/insn.c
> > +++ b/arch/x86/lib/insn.c
> 
> > @@ -58,6 +61,37 @@ void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
> >  		insn->addr_bytes = 4;
> >  }
> >  
> > +static const insn_byte_t xen_prefix[] = { __XEN_EMULATE_PREFIX };
> > +/* See handle_ud()@arch/x86/kvm/x86.c */
> > +static const insn_byte_t kvm_prefix[] = "\xf\xbkvm";
> 
> Then you can make this consistent; maybe even something like:
> 
> static const insn_byte_t *virt_prefix[] = {
> 	{ __XEN_EMULATE_PREFIX },
> 	{ __KVM_EMULATE_PREFIX },
> 	{ NULL },
> };
> 
> And then change emulate_prefix_size to emulate_prefix_index ?

Hmm, how we can get the length of those emulate prefixes?
For struct insn, since the size information is important, other
sub fields have "nbyte" field so that caller can find the actual
bytes from original byte stream.

Maybe we can have struct emulate_prefix { .nbyte, .type }; and
define enum etc.. but for me, it seems a bit over engineering.
(since no one use that feature)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
