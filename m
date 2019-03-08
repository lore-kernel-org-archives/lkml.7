Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149E7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9FE20868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfCHPBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:01:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7245 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbfCHPBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:01:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8A18821EF;
        Fri,  8 Mar 2019 15:01:16 +0000 (UTC)
Received: from treble (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC8AE608AC;
        Fri,  8 Mar 2019 15:01:13 +0000 (UTC)
Date:   Fri, 8 Mar 2019 09:01:11 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
Message-ID: <20190308150111.xciejdvvmphzlb3u@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
 <20190307174135.GJ32477@hirez.programming.kicks-ass.net>
 <CAHk-=wgGZWXQj-J2xo0DY7150VrXOSqoD5Dj1_LGYaotqA6Z-Q@mail.gmail.com>
 <20190307184813.GL32477@hirez.programming.kicks-ass.net>
 <20190307190313.GA4572@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307190313.GA4572@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 08 Mar 2019 15:01:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 08:03:13PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 07, 2019 at 07:48:13PM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 07, 2019 at 09:54:14AM -0800, Linus Torvalds wrote:
> > > On Thu, Mar 7, 2019 at 9:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >
> > > > > What's the call site that made you go "just add __memset() to the list"?
> > > >
> > > > __asan_{,un}poinson_stack_memory()
> > > >   kasan_{,un}poison_shadow()
> > > >     __memset()
> > > 
> > > Ugh. I think I almost just agree with your decision to just let that
> > > memset go unchecked.
> > > 
> > > I'm not saying it's right, but it doesn't seem to be a fight worth fighting.
> > 
> > One think I could do; is add a filter to each function and only allow
> > __memset from the kasan code, and not from anywhere else.
> 
> Ah.. how about I feed objtool a text file with all these symbol names;
> and I have Makefile compose file that from fragments.
> 
> Then only KASAN builds will have memset whitelisted, and any other build
> will still flag memset abuse.
> 
> Now I only have to figure out how to make Makefile do something like
> that :-)

Instead of adding all those additional moving parts, I would much rather
either:

a) have kasan call a special whitelisted version of memset (like hpa
   suggested); or

b) just don't use the objtool --uaccess flag for KASAN builds.

-- 
Josh
