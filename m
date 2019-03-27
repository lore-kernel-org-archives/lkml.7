Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CEEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D3C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfC0O7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:59:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:62689 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbfC0O7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:59:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 07:59:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="129121665"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2019 07:59:18 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 655E23015ED; Wed, 27 Mar 2019 07:59:18 -0700 (PDT)
Date:   Wed, 27 Mar 2019 07:59:18 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 02/17] x86, lto: Mark all top level asm statements as
 .text
Message-ID: <20190327145918.GU18020@tassilo.jf.intel.com>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-3-andi@firstfloor.org>
 <alpine.DEB.2.21.1903261751490.1789@nanos.tec.linutronix.de>
 <20190326213803.GN18020@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1903262321390.1789@nanos.tec.linutronix.de>
 <20190327005523.bbxxittqf4d5bdz5@two.firstfloor.org>
 <alpine.DEB.2.21.1903270820530.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903270820530.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 03:20:08PM +0100, Thomas Gleixner wrote:
> +void __init foo(void)
> +{
> +       pr_info("foo\n");
> +}
> 
> right before the kretprobe_trampoline and compiling it with GCC 6.
> 
> So one would assume that kretprobe_trampoline now ends up in
> .init.text. But it ends up in the .text section because it's reordered and
> ends up at the top of .text.

You would see the breakage with -fno-toplevel-reorder

> We also need a way to detect such wreckage automatically. This can happen
> again and as the GCC behaviour is random there is no guarantee that it's
> noticed right away. Josh, can objtool help here or do we need some other
> form of checking that?

It would surprise me if objtool could do it generally because the toplevel
assembler could be anything and may not be distinguishable from
C code. I guess it could catch cases of code ending up in initdata,
but it probably wouldn't work for inittext, which could happen too.

Code review is enough hopefully? Just every top level asm needs
a section.

> Because it is NOT text.

Makes sense.

I guess module loading needs it, otherwise it could just be initdata.

> But that's not the only thing which is wrong here. DEF_NATIVE is only used
> in paravirt_patch_32/64.c and the resulting labels are not used outside of
> this either. So why are these labels global and the c declaration __visible
> extern?

LTO needs any C symbols that are referenced from assembler to be global
and visible because the asm statement could end up in a different
assembler file. This is a different issue from the section
problem.

> This clearly shows that it was never analyzed proper and even the current
> patch lacks any form of proper root cause analysis as the "changelog"
> clearly shows:

This wasn't because of the section problem, just the orthogonal 
file reordering problem described above. Given the changelogs could have
been better.  But the root cause is/was clear.

> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -367,11 +367,15 @@ extern struct paravirt_patch_template pv
>  	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
>  
>  /* Simple instruction patching code. */
> -#define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
> +#define NATIVE_LABEL(a,x,b) "\n" a #x "_" #b ":\n\t"
>  
>  #define DEF_NATIVE(ops, name, code)					\
> -	__visible extern const char start_##ops##_##name[], end_##ops##_##name[];	\
> -	asm(NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
> +	static const char start_##ops##_##name[], end_##ops##_##name[]; \

Please don't apply the static/__visible removal hunk, I will just need to
revert it again for LTO.

> +	asm(".pushsection .rodata, \"a\"\n"				\
> +	    NATIVE_LABEL("start_", ops, name)				\
> +	    code							\
> +	    NATIVE_LABEL("end_", ops, name)				\
> +	    ".popsection\n")

That part looks good.


-Andi

