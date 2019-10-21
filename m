Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8E5CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD9E2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfJUThC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:37:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43881 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfJUThC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:37:02 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iMdU6-0005N0-Dy; Mon, 21 Oct 2019 19:36:54 +0000
Date:   Mon, 21 Oct 2019 21:36:53 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux@rasmusvillemoes.dk,
        cyphar@cyphar.com, keescook@chromium.org
Subject: Re: linux-next: Tree for Oct 18 (objtool)
Message-ID: <20191021193652.lfccehm37dkkofp7@wittgenstein>
References: <20191018180300.090dbcb9@canb.auug.org.au>
 <40de4e26-450e-b932-3d73-e833c8aeaa2e@infradead.org>
 <20191021123549.GC1817@hirez.programming.kicks-ass.net>
 <20191021131149.GA19358@hirez.programming.kicks-ass.net>
 <20191021131947.yih3wqjbfroaj4dz@wittgenstein>
 <20191021134759.GG1800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191021134759.GG1800@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 03:47:59PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 21, 2019 at 03:19:48PM +0200, Christian Brauner wrote:
> > On Mon, Oct 21, 2019 at 03:11:49PM +0200, Peter Zijlstra wrote:
> 
> > > By popular request; here's that alternative. Completely untested :-)
> > 
> > Am I not getting some mails? :)
> 
> You're not on the 'right' IRC channels :-)

Well, we saw that that wasn't true today. :)

> 
> > I prefer this one as it allows us to avoid working around this in
> > usercopy.c. Should especially make if this potentially helps in other
> > cases as well?
> 
> That was Josh's argument too.
> 
> Personally I think GCC is being a moron here, because with value range
> analysis it should be able to prove the shift-UB cannot happen (the <
> sizeof(unsigned long) conditions on both), but alas, it emits the UBSAN
> calls anyway.

Ok, so I take it you route that patch somehwere through tip?
I'm happy with the ubsan fix:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
