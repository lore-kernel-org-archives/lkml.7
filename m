Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DF0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA8C207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ECTXSl11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCJNQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 09:16:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfCJNQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 09:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9nAbjnqR1YHGPF6LnEc2s+BbzzPNwap/xfIyv2GoGvs=; b=ECTXSl114c4FcWxrtjk42l+V9
        eda8J51xg7a1B7tuh33idBkrumaT4EZ4dd3dUxnLiDeZMExWYk4SpUH+HU0ud84A0QVog/htJdqf4
        HJJX+QSywzdLIU+MMhYpa7UgieIUw6SZ3ZB6Us54iHGknZ5Rgyi408k3hSklAJmOhF1FORrhJz4o3
        9LBqHjhTWsmwuQCoZ/KSToPMGBRsS3gVNvpf96bubAvk/B/kpWdf16n6tKUZU4gT3U9W0N3s6RDCQ
        4FuvLm66HTMVD3cPhZstdIPsGsT8A5oL0E/rddPZpYnVuv13x3WF6evyadYPdo7MlzW3ZMNrMax62
        rQbA5623A==;
Received: from [188.207.104.17] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2yJS-000878-Nw; Sun, 10 Mar 2019 13:16:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B2CC981BBE; Sun, 10 Mar 2019 14:16:20 +0100 (CET)
Date:   Sun, 10 Mar 2019 14:16:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
        Slavomir Kaslev <kaslevs@vmware.com>
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
Message-ID: <20190310131620.GL2482@worktop.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307120317.GD32477@hirez.programming.kicks-ass.net>
 <20190307125526.GB32534@hirez.programming.kicks-ass.net>
 <20190307131312.GC32534@hirez.programming.kicks-ass.net>
 <20190307164705.qbu4ytdfdmsighas@treble>
 <CAHk-=wgfvwn1L7BduXA02rZdDnKGb8ebzm4C--QcfVF+gjHAvQ@mail.gmail.com>
 <20190307171709.dap5hfeof4yo3nsc@treble>
 <20190307173810.GI32477@hirez.programming.kicks-ass.net>
 <CAHk-=wi_vuD9fKk36=_DNG9=+S9rbTRu2FTFe9tECunC8oOtfg@mail.gmail.com>
 <20190307131841.3b5d9e00@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307131841.3b5d9e00@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 01:18:41PM -0500, Steven Rostedt wrote:
> On Thu, 7 Mar 2019 09:45:35 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Thu, Mar 7, 2019 at 9:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Also; it seems to me that something PT, or maybe even simply:
> > >
> > >   perf -e branches -e branch-misses
> > >
> > > would get you similar or sufficient information.  

> I currently have one of my engineers looking at the data and may be
> sending patches soon. It's basically an entry level way to get into
> kernel development. Note, no patch will be sent just because of the
> data from the profiling. The task is to look at and understand the
> code, and see if it can be optimized (with likely/unlikely or flow
> changes). It's a way to get a better understanding of the kernel in
> various locations. It is by no means "profiler said this, lets change
> it." All changes must be rational, and make sense. The profiler is only
> used to help find those places.

Can't you just have those same engineers look at perf data? This seems
like a very expensive and convoluted way of getting something.

