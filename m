Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BDAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D485F20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fh7MAytp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfCGSsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:48:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfCGSsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wE1scT41lGtBH9l0UQsxcqywNitQszd2Aj4cYZf7vPI=; b=Fh7MAytpk67zm69D3egREHZM9
        9q3JW8o3kEHkTAC5DJEexlCzbbYFooXQvFOWrlR+5ZenBzcvNDthne7pQunghodMrVk7xo7JsIYHZ
        SwXr4+YJhwvbrMjOs+jNxfd41KViogzezxN2M4QYGLTMAdjBvpj8BBoYSyT16rNb94IK+wWWuLJ92
        YmuTCK3WIh2yghuRc6oJiHYScA1/J5gb9Co1ByGvURxH7UY9tJfG192E2nCW5s1G3Qiue1m79GiUp
        UumSQjYZOGmhUB7c1r0kBYUBe5cH59Wh0b2LcqVqy/fKLenGUd++saSXB5qvC8HPxtReR5argjy3c
        LXqQZA3kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1y40-00033X-Pl; Thu, 07 Mar 2019 18:48:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F407A202A2A1F; Thu,  7 Mar 2019 19:48:13 +0100 (CET)
Date:   Thu, 7 Mar 2019 19:48:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
Message-ID: <20190307184813.GL32477@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
 <20190307174135.GJ32477@hirez.programming.kicks-ass.net>
 <CAHk-=wgGZWXQj-J2xo0DY7150VrXOSqoD5Dj1_LGYaotqA6Z-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgGZWXQj-J2xo0DY7150VrXOSqoD5Dj1_LGYaotqA6Z-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:54:14AM -0800, Linus Torvalds wrote:
> On Thu, Mar 7, 2019 at 9:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > What's the call site that made you go "just add __memset() to the list"?
> >
> > __asan_{,un}poinson_stack_memory()
> >   kasan_{,un}poison_shadow()
> >     __memset()
> 
> Ugh. I think I almost just agree with your decision to just let that
> memset go unchecked.
> 
> I'm not saying it's right, but it doesn't seem to be a fight worth fighting.

One think I could do; is add a filter to each function and only allow
__memset from the kasan code, and not from anywhere else.

Another thing I need to look at is why objtool only found memset_orig
(from __memset) but not memset_erms, which if I read the code right, is
a possible alternative there.

> Because AC vs KASAN in general ends up smelling like "not a fight
> worth fighting" to me. You've done a herculean job, but..

I know,.. I've been so close to doing that so many times, but it
seems like defeat, esp. since I'm so close now :-)

