Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB81F21902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ExTsKiAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfCUShw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:37:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38104 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfCUShw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6VaYjeQs3ztnvnR2zRnxFXXmqZ0mf8vhhYUVX1thu2w=; b=ExTsKiAZhNYMdyCWJYWBfM9u/
        IUVSl4aRgPoCTeuP73DDKKZ9VU0vng0XIlYurPNZ5hPJTOu9Iu/1hJ5fcqGd5COSflQSkVhmpibaI
        VxIhDhTXZGjL/3kxJ82Km0c0Lv1rq7a5uUjqbjn9HRvl5yz4YxxfOYbr+B5pmsz9TEDPNgvdi/TWu
        yWrVSt0NV/hKmHahzgHH4KBrv+VvbwCNQCD7VdCGIkHDy/gash3LcLLgAXAMX+A8rARwUNRjmA07B
        PRB16n4ICO2vFl45JhPk0oM6nvpeDOdM/+8po+rnabKT7MpzgrkLKukGE7yVuduGL+E/zOrXqgVtg
        dGH5JRKog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h72Z1-0001da-F0; Thu, 21 Mar 2019 18:37:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9A4D203CBE11; Thu, 21 Mar 2019 19:37:13 +0100 (CET)
Date:   Thu, 21 Mar 2019 19:37:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321183713.GX5996@hirez.programming.kicks-ass.net>
References: <20190320221534.165ab87b@oasis.local.home>
 <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net>
 <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home>
 <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
 <CAHk-=whSeiDXVvhie_bBPqDw99JNJMdTuX8ef82BhNanyo7zRw@mail.gmail.com>
 <CALCETrVaCZKjXj9ZqtvQgLk2DqXwNCh7b5DHvSnNAORsqJXCcQ@mail.gmail.com>
 <CAHk-=wjEHqY1+DxJ-_oNWTuTNQwMPtJKJh_HE=e1F60V+TwUfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjEHqY1+DxJ-_oNWTuTNQwMPtJKJh_HE=e1F60V+TwUfQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:25:44AM -0700, Linus Torvalds wrote:
> On Thu, Mar 21, 2019 at 11:21 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > I dunno.  Lots of people at least use to have serious commercial interest in it.
> 
> Yes, it used to be a big deal. But full virtualization has gotten a
> lot more common and better.
> 
> > Hey Xen folks, how close are we to being able to say "if you want to
> > run a new kernel, you need to switch to PVH or similar"?
> 
> I'd also like to know if we could perhaps at least limit PV to just
> the thing that people care most deeply about.
> 
> For example, maybe people notice that they really deeply care about
> the PV spinlocks because they help a lot for some loads, but don't
> care so much about the low-level CPU PV stuff any more because modern
> CPUs do _those_ things so well these days.
> 
> So it might not be an all-or-nothing thing, but a gradual "let's stop
> supporting xyz under PV, because it causes pain and isn't worth it".

So Juergen recently introduced PARAVIRT_XXL, which are exactly those
bits of PV we can get rid of.

This paravirt-me-harder config does indeed include the CR2 bits.

I recently talked to Andrew Cooper about this, and he said Xen Dom0
still needs all this :/

But yes, I'd _love_ to delete all that in a hurry.
