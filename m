Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AE2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9FC218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UC5AR7r9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbfB1PqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:46:05 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47478 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387439AbfB1PqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Dtzelaj0ExtzUtsjFXzvPsNEIL8C/YWrsd0hwiecRGc=; b=UC5AR7r9rtIJdIWqrf7W5EJOI
        QoR5kjwvD73eCdp9zprCF24ZPsXbAiwfwXf5iJ/YdrsO+oUxwh7laoKm/+4lvwvcBNmD9lEVexAGC
        exr0aA+5jwpd9MABvHgRd4i8gAT2odtCjCjbWWBkBg8YglOy4RmHXGWgt+bK89qTH/x4JmD5XuUyn
        3X2cIKz5bZcAxOaMdJrSUdm9Wh0T+rIfR9/CsK7awfmuAak2ZUi/RHLfG/MgfW12hyC/h5aLb3TzM
        eGIWxNgYfBkZf7HuDXXDkNb7jViykj0YwTHLUJhOOzgrAkAp/iMG0Zs6BjJKFOVP5mGjjqGkNl74x
        irzDwPHfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzNse-0006eq-RB; Thu, 28 Feb 2019 15:45:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F26D202C2DAE; Thu, 28 Feb 2019 16:45:51 +0100 (CET)
Date:   Thu, 28 Feb 2019 16:45:51 +0100
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
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
Message-ID: <20190228154551.GE32494@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 04:22:04PM +0100, Dmitry Vyukov wrote:
> On Thu, Feb 28, 2019 at 4:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Because __asan_{load,store}{N,1,2,4,8,16}_noabort() get called from
> > UACCESS context, and kasan_report() is most definitely _NOT_ safe to
> > be called from there, move it into an exception much like BUG/WARN.
> >
> > *compile tested only*
> 
> 
> Please test it by booting KASAN kernel and then loading module
> produced by CONFIG_TEST_KASAN=y. There are too many subtle aspects to
> rely on "compile tested only", reviewers can't catch all of them
> either.

Sure, I'll do that. I just wanted to share the rest of the patches.

A quick test shows it dies _REAAAAAAAALY_ early, as in:

"Booting the kernel."

is the first and very last thing it says... I wonder how I did that :-)

> > +static __always_inline void
> > +kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
> > +{
> > +       unsigned long rdi = addr, rsi = size, rdx = is_write, rcx = ip;
> > +
> > +       _BUG_FLAGS(ASM_UD2, BUGFLAG_KASAN,
> > +                  "D" (rdi), "S" (rsi), "d" (rdx), "c" (rcx));
> 
> Can BUG return?

Yes. Also see the annotate_reachable().

> This should be able to return.
> We also have other tools coming (KMSAN/KTSAN) where distinction
> between fast path that does nothing and slower-paths are very blurred
> and there are dozens of them, I don't think this BUG thunk will be
> sustainable. What does BUG do what a normal call can't do?

It keeps the SMAP validation rules nice and tight. If we were to add
(and allow) things like pushf;clac;call ponies;popf or similar things,
it all becomes complicated real quick.

How would KMSAN/KTSAN interact with SMAP ?

> > +       annotate_reachable();
> > +}
> > @@ -228,7 +228,7 @@ void __asan_unregister_globals(struct ka
> >  EXPORT_SYMBOL(__asan_unregister_globals);
> >
> >  #define DEFINE_ASAN_LOAD_STORE(size)                                   \
> > -       void __asan_load##size(unsigned long addr)                      \
> > +       notrace void __asan_load##size(unsigned long addr)              \
> 
> 
> We already have:
> CFLAGS_REMOVE_generic.o = -pg
> Doesn't it imply notrace for all functions?

Indeed so, I'll make these hunks go away.
