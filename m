Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FBAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EB62175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A4bnvovi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfCUUDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:03:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfCUUDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZuyNJW63FOZZdlgNflD/pLNem1v9Mv2DBiEoGNT6+Os=; b=A4bnvoviflFThNF2g7rPoFbk/
        nIIYvP5azNc5SjdKXuvy8tfxEXF3WctFUB9kyhzMdUUzN6zUaHRZtucz93DvmKXiQCZ87wsw31Tpb
        Jnvi/O6hmeW3Sl9JTHkVOPPxewmJycgp6KNkwV1tE7uLnbH4roo6TcwsReQMV0s8Jy3YxbOZLijp3
        hHjXRYjdFjQls0dPejvOFfk4r6TbKwj8HWlsLxAi9IA+B++/E80CrPCrCbLU24HmDUoyGI5x5lvmc
        RIsACBMO3HeE5SEfCD08T/+/N1+0KSYZLV/d1dIs82vWCQqh7ZhFaYaPdORYIUmUBfZrWkZXo7gze
        gD7m11K6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h73uI-0002xC-LJ; Thu, 21 Mar 2019 20:03:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3857984EEA; Thu, 21 Mar 2019 21:03:16 +0100 (CET)
Date:   Thu, 21 Mar 2019 21:03:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321200316.GC2490@worktop.programming.kicks-ass.net>
References: <20190321090241.GL6521@hirez.programming.kicks-ass.net>
 <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home>
 <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
 <20190321141020.641e313f@gandalf.local.home>
 <20190321182830.GV5996@hirez.programming.kicks-ass.net>
 <20190321145551.4c80c3a7@gandalf.local.home>
 <20190321193152.GB2490@worktop.programming.kicks-ass.net>
 <20190321155006.5288345f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321155006.5288345f@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 03:50:06PM -0400, Steven Rostedt wrote:
> On Thu, 21 Mar 2019 20:31:52 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > 
> > > No I didn't. Some users only care about performance, but find memory
> > > cheap.  
> > 
> > Because cache-misses are free?
> 
> If I ever did implement this, I would try to get all the data out of
> line as much as possible, where only a nop would be inserted:

Doesn't make sense; you say data, but then talk code and i$.

Not the point, spinlock_t is 4 bytes, but growns into a monster with
lockdep on. There are plenty locations where the spinlock and the data
it protects fit together into a single cacheline, no longer so with
lockdep on.

Another example is split pte locks, without lockdep they are in struct
page, with lockdep, they're a separate allocation, adding pointer
chases.

Also; I do not, and have never done so, understood the desire to have
this unified kernel. Building another kernel just isn't a problem, esp.
not if you're doing kernel development to begin with.

Making debug code complicated, such that you need to spend more time
debugging the debug code, just doens't make sense to me either.
