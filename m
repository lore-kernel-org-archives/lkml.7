Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DF4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEE520842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ow9VBWH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfCEOxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:53:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:32830 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCEOxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CmAIyH+dAiiqoSUSc0kf2M2hNfWk2Q0D9uVzdk9oRNg=; b=ow9VBWH8Yz9vW4jkNKTkmEDkC
        3pGeTCxjp6qSQ5Co5PBJR5tA72XqWlJk+NNz8fcU5K7qmiQJSOAveB4zW3Ngnbqt5VXP14eJAtFsl
        8F+l4UfDE+JvMYi68bv51oWv2Qt/rXqvCYLAzSDiGmec25t2KpWLBrxuE/CbtHqH/gC02xTThKu6z
        R3fN4FCtyPReNnG3+inI9TC0BYR8I7HuNzbGG9yAM/IeNXExXuyHVUiAn7emXl1UGdZi8QybCcLEr
        NpJ8XXt/rr2cCh3OUFtbnSkinTZAH5tB8z3y+D3AlgAL9kTMczWm0SzBjA2ic51AT2B3w+GF9RMxl
        9c6HfcD+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1BRM-0007Bb-RN; Tue, 05 Mar 2019 14:53:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FDD920288BA2; Tue,  5 Mar 2019 15:53:06 +0100 (CET)
Date:   Tue, 5 Mar 2019 15:53:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        g@hirez.programming.kicks-ass.net
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com, lkp@01.org
Subject: Re: [uaccess] 780464aed0:
 WARNING:at_arch/x86/include/asm/uaccess.h:#strnlen_user/0x
Message-ID: <20190305145306.GL32477@hirez.programming.kicks-ass.net>
References: <155136980507.2968.15165201054223875356.stgit@devbox>
 <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com>
 <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
 <20190304101434.8429ffffb17813c0e7930130@kernel.org>
 <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
 <20190304180610.2d4f6f08d9ad89d6abae3597@kernel.org>
 <CAHk-=wiQM84VsAiw92UWyQZTQxr+F032Gm5BiFBXk7tC+LQohQ@mail.gmail.com>
 <20190305113635.18f80ea3b1f4fca54b9d21e4@kernel.org>
 <20190305090729.GF32477@hirez.programming.kicks-ass.net>
 <20190305225801.a63ac8712105ab2e673be1bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305225801.a63ac8712105ab2e673be1bc@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 10:58:01PM +0900, Masami Hiramatsu wrote:

> Could you tell me why WARN_ON_ONCE(!in_task()) is needed in access_ok()?

That came from here:

  lkml.kernel.org/r/20190225145240.GB32534@hirez.programming.kicks-ass.net

Because in-irq usage is dodgy, since we don't actually know what mm or
ds it loaded.

> > I dislike that whole KERNEL_DS thing, but obviously that's not something
> > that's going away.
> > 
> > Would something like:
> > 
> > 	WARN_ON_ONCE(!(in_task || segment_eq(get_fs(), USER_DS)))
> > 
> > Work? Then we allow KERNEL_DS in task context, but for interrupt and
> > others require USER_DS.
> 
> But what would this mean? I can't understand why we limit using
> access_ok() so strictly and narrow the cases.

Because it's been a source of bugs. Any sanity checking we can put in
seems like a good thing at this point.
