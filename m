Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED889C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C915A20842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uWf7HwZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbfIFHfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:35:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51332 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfIFHfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qc1A/0vmo5wP4vpvwTJu55z+mim/TKkMRY82VkokPRg=; b=uWf7HwZC/+IfEzfYjKrpXGsBS
        dV8iXCpPucF2YwnrQS+kp6CXHpDlGwGHgBvXlHBCDIKVOt862XnJT5luD34qeLuUWd80qBtaGTkwt
        aij2DPPKlqDp+wV9qhXxxDvxLHyNYhxJHy7WfFuYiHV4ER556QztPNHOcV0Y2KU+3Cmc98ipdcC9g
        2j7qOOLAriTEhUpZAOvG9abuQjS/luDLPFIGe+VNjFGiktwXqcUlcF1MNG6mcmivd5kgD1yGPLua5
        somEbZonUalQeUiM1PUdSv6erPb1viq+FfIsbPYO0yel1ZXLlUkl/2SMb2GB7J+wvbHWaJu7XUoAH
        6TDoTVk0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i68lT-00032P-PI; Fri, 06 Sep 2019 07:34:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8FD33303121;
        Fri,  6 Sep 2019 09:33:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D931F29DE7804; Fri,  6 Sep 2019 09:34:36 +0200 (CEST)
Date:   Fri, 6 Sep 2019 09:34:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20190906073436.GS2349@hirez.programming.kicks-ass.net>
References: <156773433821.31441.2905951246664148487.stgit@devnote2>
 <156773434815.31441.12739136439382289412.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156773434815.31441.12739136439382289412.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 10:45:48AM +0900, Masami Hiramatsu wrote:

> diff --git a/arch/x86/include/asm/xen/interface.h b/arch/x86/include/asm/xen/interface.h
> index 62ca03ef5c65..fe33a9798708 100644
> --- a/arch/x86/include/asm/xen/interface.h
> +++ b/arch/x86/include/asm/xen/interface.h
> @@ -379,12 +379,15 @@ struct xen_pmu_arch {
>   * Prefix forces emulation of some non-trapping instructions.
>   * Currently only CPUID.
>   */
> +#include <asm/xen/prefix.h>
> +
>  #ifdef __ASSEMBLY__
> -#define XEN_EMULATE_PREFIX .byte 0x0f,0x0b,0x78,0x65,0x6e ;
> +#define XEN_EMULATE_PREFIX .byte __XEN_EMULATE_PREFIX ;
>  #define XEN_CPUID          XEN_EMULATE_PREFIX cpuid
>  #else
> -#define XEN_EMULATE_PREFIX ".byte 0x0f,0x0b,0x78,0x65,0x6e ; "
> +#define XEN_EMULATE_PREFIX ".byte " __XEN_EMULATE_PREFIX_STR " ; "
>  #define XEN_CPUID          XEN_EMULATE_PREFIX "cpuid"
> +
>  #endif

Possibly you can do something like:

#define XEN_EMULATE_PREFIX	__ASM_FORM(.byte __XEN_EMULATE_PREFIX ;)
#define XEN_CPUID		XEN_EMULATE_PREFIX __ASM_FORM(cpuid)

>  #endif /* _ASM_X86_XEN_INTERFACE_H */
> diff --git a/arch/x86/include/asm/xen/prefix.h b/arch/x86/include/asm/xen/prefix.h
> new file mode 100644
> index 000000000000..f901be0d7a95
> --- /dev/null
> +++ b/arch/x86/include/asm/xen/prefix.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TOOLS_ASM_X86_XEN_PREFIX_H
> +#define _TOOLS_ASM_X86_XEN_PREFIX_H
> +
> +#include <linux/stringify.h>
> +
> +#define __XEN_EMULATE_PREFIX  0x0f,0x0b,0x78,0x65,0x6e
> +#define __XEN_EMULATE_PREFIX_STR  __stringify(__XEN_EMULATE_PREFIX)
> +
> +#endif

How about we make this asm/virt_prefix.h or something and include:

/*
 * Virt escape sequences to trigger instruction emulation;
 * ideally these would decode to 'whole' instruction and not destroy
 * the instruction stream; sadly this is not true for the 'kvm' one :/
 */

#define __XEN_EMULATE_PREFIX  0x0f,0x0b,0x78,0x65,0x6e  /* ud2 ; .ascii "xen" */
#define __KVM_EMULATE_PREFIX  0x0f,0x0b,0x6b,0x76,0x6d	/* ud2 ; .ascii "kvm" */

> diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> index 0b5862ba6a75..b7eb50187db9 100644
> --- a/arch/x86/lib/insn.c
> +++ b/arch/x86/lib/insn.c

> @@ -58,6 +61,37 @@ void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
>  		insn->addr_bytes = 4;
>  }
>  
> +static const insn_byte_t xen_prefix[] = { __XEN_EMULATE_PREFIX };
> +/* See handle_ud()@arch/x86/kvm/x86.c */
> +static const insn_byte_t kvm_prefix[] = "\xf\xbkvm";

Then you can make this consistent; maybe even something like:

static const insn_byte_t *virt_prefix[] = {
	{ __XEN_EMULATE_PREFIX },
	{ __KVM_EMULATE_PREFIX },
	{ NULL },
};

And then change emulate_prefix_size to emulate_prefix_index ?
