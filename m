Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788E9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABBA2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BWRBoNmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfCHPHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:07:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfCHPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=olEWzuXwpqoUhfTLPOFTjNURzAp9xrKli2NLAnSgj9w=; b=BWRBoNmjrYZoCVrjx8dxgHGbV
        C25/0S+mlSVRLlLzmj+kKtr4WAnosmg4NpuVPpFJbXDUxnlj9+LP8iqbvyY8o+YVo4Cm8VSANLij+
        +f/KPZuhAhZzUnrEb/9LpvFIP5p5Mo+YTyE/XEm0fCOK5pSA7F1ppzWNldxnNBNCnF4m96e+HeCEa
        NwDMbAcu2SLVqWF90d9EFG/0PkacE8o3WQ3oc3YhDt2M9FDqxzQxTkT9nh7nrHQZZIGYojjTR3CoQ
        8sK1JmTfyFW+qQT/6sFvvJIAPS5JGQqCYnvN0wLDnPnLR257Wllo5bpRykRLDWjVnYa2PnM7EWSXr
        grS53/cig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2H5t-0008GC-Fi; Fri, 08 Mar 2019 15:07:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00CFD202631D5; Fri,  8 Mar 2019 16:07:27 +0100 (CET)
Date:   Fri, 8 Mar 2019 16:07:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
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
Message-ID: <20190308150727.GB32494@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
 <20190307174135.GJ32477@hirez.programming.kicks-ass.net>
 <CAHk-=wgGZWXQj-J2xo0DY7150VrXOSqoD5Dj1_LGYaotqA6Z-Q@mail.gmail.com>
 <20190307184813.GL32477@hirez.programming.kicks-ass.net>
 <20190307190313.GA4572@worktop.programming.kicks-ass.net>
 <20190308150111.xciejdvvmphzlb3u@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308150111.xciejdvvmphzlb3u@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 09:01:11AM -0600, Josh Poimboeuf wrote:
> On Thu, Mar 07, 2019 at 08:03:13PM +0100, Peter Zijlstra wrote:

> > Ah.. how about I feed objtool a text file with all these symbol names;
> > and I have Makefile compose file that from fragments.
> > 
> > Then only KASAN builds will have memset whitelisted, and any other build
> > will still flag memset abuse.
> > 
> > Now I only have to figure out how to make Makefile do something like
> > that :-)
> 
> Instead of adding all those additional moving parts, I would much rather
> either:

The problem went away. That is, the problematic part of KASAN just got
removed in this merge window.

Also; I just about had hpa's __memset_kasan implemented when I got that
email.
