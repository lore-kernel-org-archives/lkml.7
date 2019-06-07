Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6121C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC41208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G2TH77zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbfFGUMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 16:12:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbfFGUMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V+gSVnIv9QBKq1mZboB8NpBLa64Y8lrKysJJF3r5Di4=; b=G2TH77zwcRW+ghgSutS9pXWwx
        q06PFG90kLdW9nSZ8eT0zhsmJkCONTk9ihOiwCD/vOWRCH7+RiVotuRpO+PXMPtB8viY749wFWiHD
        e35WP8ojqL7BLHfJjBicKoWZKTv7dWog/hIuqMTYYTk2e38Bi6ed1zJgJ9LV8EZFY6S7kzQtNbxWR
        dq2EVJjEtvyg+7uncwjU/GfOave+g4SmAyk4QaIqVw/cBAp5JROl4fss5kOmhhd48m/zKN/BT2Kne
        4r7aT25INlQYUt07MKB6e3JiljH56Bv5dF61FNPZ9GAePTzIrq6vFfaE5EIdtGfqYacXVUhZ0+nnV
        aWTdDN8VA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hZLDX-0002mb-5b; Fri, 07 Jun 2019 20:12:03 +0000
Date:   Fri, 7 Jun 2019 13:12:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Konovalov <andreyknvl@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC V3] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
Message-ID: <20190607201202.GA32656@bombadil.infradead.org>
References: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before:

> @@ -46,23 +46,6 @@ kmmio_fault(struct pt_regs *regs, unsigned long addr)
>  	return 0;
>  }
>  
> -static nokprobe_inline int kprobes_fault(struct pt_regs *regs)
> -{
> -	if (!kprobes_built_in())
> -		return 0;
> -	if (user_mode(regs))
> -		return 0;
> -	/*
> -	 * To be potentially processing a kprobe fault and to be allowed to call
> -	 * kprobe_running(), we have to be non-preemptible.
> -	 */
> -	if (preemptible())
> -		return 0;
> -	if (!kprobe_running())
> -		return 0;
> -	return kprobe_fault_handler(regs, X86_TRAP_PF);
> -}

After:

> +++ b/include/linux/kprobes.h
> @@ -458,4 +458,20 @@ static inline bool is_kprobe_optinsn_slot(unsigned long addr)
>  }
>  #endif
>  
> +static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
> +					      unsigned int trap)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * To be potentially processing a kprobe fault and to be allowed
> +	 * to call kprobe_running(), we have to be non-preemptible.
> +	 */
> +	if (kprobes_built_in() && !preemptible() && !user_mode(regs)) {
> +		if (kprobe_running() && kprobe_fault_handler(regs, trap))
> +			ret = 1;
> +	}
> +	return ret;
> +}

Do you really think this is easier to read?

Why not just move the x86 version to include/linux/kprobes.h, and replace
the int with bool?

On Fri, Jun 07, 2019 at 04:04:15PM +0530, Anshuman Khandual wrote:
> Very similar definitions for notify_page_fault() are being used by multiple
> architectures duplicating much of the same code. This attempts to unify all
> of them into a generic implementation, rename it as kprobe_page_fault() and
> then move it to a common header.

I think this description suffers from having been written for v1 of
this patch.  It describes what you _did_, but it's not what this patch
currently _is_.

Why not something like:

Architectures which support kprobes have very similar boilerplate around
calling kprobe_fault_handler().  Use a helper function in kprobes.h to
unify them, based on the x86 code.

This changes the behaviour for other architectures when preemption
is enabled.  Previously, they would have disabled preemption while
calling the kprobe handler.  However, preemption would be disabled
if this fault was due to a kprobe, so we know the fault was not due
to a kprobe handler and can simply return failure.  This behaviour was
introduced in commit a980c0ef9f6d ("x86/kprobes: Refactor kprobes_fault()
like kprobe_exceptions_notify()")

>  arch/arm/mm/fault.c      | 24 +-----------------------
>  arch/arm64/mm/fault.c    | 24 +-----------------------
>  arch/ia64/mm/fault.c     | 24 +-----------------------
>  arch/powerpc/mm/fault.c  | 23 ++---------------------
>  arch/s390/mm/fault.c     | 16 +---------------
>  arch/sh/mm/fault.c       | 18 ++----------------
>  arch/sparc/mm/fault_64.c | 16 +---------------
>  arch/x86/mm/fault.c      | 21 ++-------------------
>  include/linux/kprobes.h  | 16 ++++++++++++++++

What about arc and mips?

