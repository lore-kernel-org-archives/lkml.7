Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A1EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95991206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3TFpu3I5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCFRhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:37:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45134 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCFRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3q/G9TebFVdhg7pZgAg+fZcyfwi245rQAJ0OdBWs7b8=; b=3TFpu3I5BjPxZvj9j1lp/x1TT
        CENB9STh8oyHsnuaEagi5aBx/HNAcdPJcbf69uoYOZEDRyMKQOhzwmoZimbRwBrt+XgcxMq9n3tXY
        fOC4dEJC/ii9b1H424LtqjbzLPW16LfS4Qn4B4kGjANT2YUQvQaX0HlnuhAsb4ClVh7+Mp2qCpq7G
        h6j2SJ9OkaTPMUJJjVzpXz/PDBhDgsFlGA8EP3HmfI02m+gVH1sJksWk6UBcoJqGsIoYAXiRyoCdY
        3++i2RN3rWAklA2qK0rsE6Q8bmT0vqSC4zs2ZEzxr28D6dcfim/IJn0IsOo5OjOs5jKP6PfrI65ZO
        WUeW0FgWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1aTk-0004Mx-QG; Wed, 06 Mar 2019 17:37:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 480FD2029B174; Wed,  6 Mar 2019 18:37:15 +0100 (CET)
Date:   Wed, 6 Mar 2019 18:37:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, jgross@suse.com
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
Message-ID: <20190306173715.GA32534@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190301144556.GY32477@hirez.programming.kicks-ass.net>
 <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
 <20190301152305.GJ32494@hirez.programming.kicks-ass.net>
 <20190306131347.GX32534@hirez.programming.kicks-ass.net>
 <20190306171451.GZ32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306171451.GZ32534@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 06:14:51PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 06, 2019 at 02:13:47PM +0100, Peter Zijlstra wrote:
> > +static __always_inline unsigned long smap_save(void)
> > +{
> > +	unsigned long flags = arch_local_save_flags();
> > +	clac();
> > +	return flags;
> > +}
> > +
> > +static __always_inline void smap_restore(unsigned long flags)
> > +{
> > +	arch_local_irq_restore(flags);
> > +}
> 
> ARGH; the bloody paravirt me harder nonsense makes that pvops calls.
> 
> And that (obviously) explodes.. Anybody got any clue why that Xen
> trainwreck wants to paravirt: "PUSHF;POP" and "PUSH;POPF" !?
> 
> Also; I suppose I can ALTERNATIVE the whole thing, because Xen will not
> be having SMAP in the first place I suppose.

The below seems to 'work'.

--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -46,8 +46,6 @@
 
 #ifdef CONFIG_X86_SMAP
 
-#include <asm/irqflags.h>
-
 static __always_inline void clac(void)
 {
 	/* Note: a barrier is implicit in alternative() */
@@ -62,14 +60,19 @@ static __always_inline void stac(void)
 
 static __always_inline unsigned long smap_save(void)
 {
-	unsigned long flags = arch_local_save_flags();
-	clac();
+	unsigned long flags;
+
+	asm volatile (ALTERNATIVE("", "pushf; pop %0; " __stringify(__ASM_CLAC),
+				  X86_FEATURE_SMAP)
+		      : "=rm" (flags) : : "memory", "cc");
+
 	return flags;
 }
 
 static __always_inline void smap_restore(unsigned long flags)
 {
-	arch_local_irq_restore(flags);
+	asm volatile (ALTERNATIVE("", "push %0; popf", X86_FEATURE_SMAP)
+		      : : "g" (flags) : "memory", "cc");
 }
 
 /* These macros can be used in asm() statements */
