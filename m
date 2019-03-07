Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27F8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A283F20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YLnKy32p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfCGTD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:03:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55664 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCGTD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZfrfQvfHDXYd3CUHVVspVqjLPuUt9M5N9AH11BPHM8g=; b=YLnKy32poWN/dRGO02MhpChAb
        nR8jFWadgAYChKIXCrolGuBrLqiANl/4XmucMqb841HTSh9JvEtrRmZsCKVIOLIYK5IoG8u9EL6lU
        7mtpEmKTIyoA+GhMmTo935STlgOh6osHmaaGaxAjvlh8cJHB+xvUhWd2AwTqJc22Xy24i30/E721e
        J35Z8cjLXPOcazcccBLSfpalsr3wWEaUsYiKnoYqid3pqp3xIwJyNLH8yJkOjySCHRXHVtUdCIvJq
        w1muLR0v0abdGChhbt78zlg3YSjU000HkhUVD3vUvpPi7zw/5H6qXnU0jy/aNOwQOuS28vclrYRdG
        1EOW1fjFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1yIV-0000i7-42; Thu, 07 Mar 2019 19:03:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C5939837F2; Thu,  7 Mar 2019 20:03:13 +0100 (CET)
Date:   Thu, 7 Mar 2019 20:03:13 +0100
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
Message-ID: <20190307190313.GA4572@worktop.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
 <20190307174135.GJ32477@hirez.programming.kicks-ass.net>
 <CAHk-=wgGZWXQj-J2xo0DY7150VrXOSqoD5Dj1_LGYaotqA6Z-Q@mail.gmail.com>
 <20190307184813.GL32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307184813.GL32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 07:48:13PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 07, 2019 at 09:54:14AM -0800, Linus Torvalds wrote:
> > On Thu, Mar 7, 2019 at 9:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > What's the call site that made you go "just add __memset() to the list"?
> > >
> > > __asan_{,un}poinson_stack_memory()
> > >   kasan_{,un}poison_shadow()
> > >     __memset()
> > 
> > Ugh. I think I almost just agree with your decision to just let that
> > memset go unchecked.
> > 
> > I'm not saying it's right, but it doesn't seem to be a fight worth fighting.
> 
> One think I could do; is add a filter to each function and only allow
> __memset from the kasan code, and not from anywhere else.

Ah.. how about I feed objtool a text file with all these symbol names;
and I have Makefile compose file that from fragments.

Then only KASAN builds will have memset whitelisted, and any other build
will still flag memset abuse.

Now I only have to figure out how to make Makefile do something like
that :-)
