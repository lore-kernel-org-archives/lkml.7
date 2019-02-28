Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D9CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EDA2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o+yMb32y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbfB1Jk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:40:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfB1Jk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1X8rm+mkHYV5hDNCom+woWNoJIpi3EPhQTeOVRpuf38=; b=o+yMb32y6odrMIS2EOIJ7nCS3W
        ZD9SXv8TvDr2VyeGfG/36sYaVBzMbvZT/rRgd2WizW8zi5gpni9Ig5y6TQUA0xdasd5KLI5X1+TJX
        V7IJVAS7OvwKnHmQT+CPLk7bceYda5G0T2hMXM3mkkoH/KY8oTE7yzEIsfOZCcqfcO7SMwucj1HI7
        8czyUogWDqHsjj4CkEiFVT+eYzxQmYQXHk8B8rxr0YtSnBdGZLd/s8A8HKgbHTilkrwYFGTKXU4jY
        MRQno6T3CSptzHbo9XJzaQXm0jmBxhBxluJEULBFq08F2Vtgdcn/my82vfs8ExGbqGJ0WjnVPz1Mi
        o1Mkyoww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzIAk-0005lo-Ij; Thu, 28 Feb 2019 09:40:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7116202CD43E; Thu, 28 Feb 2019 10:40:08 +0100 (CET)
Date:   Thu, 28 Feb 2019 10:40:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
Message-ID: <20190228094008.GN32534@hirez.programming.kicks-ass.net>
References: <20190225124330.613028745@infradead.org>
 <20190225125232.191698923@infradead.org>
 <20190227140830.GP32494@hirez.programming.kicks-ass.net>
 <19b35cb1-9527-2e15-6deb-9ce7c1ef1d66@virtuozzo.com>
 <20190227142623.GR32494@hirez.programming.kicks-ass.net>
 <20190227143313.GK32534@hirez.programming.kicks-ass.net>
 <CACT4Y+a9yJvwzwVcjhyOkJUdMp05mxW1++EduLLa2M_buQ7OhA@mail.gmail.com>
 <20190227172816.GT32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190227172816.GT32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 06:28:16PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 27, 2019 at 04:40:28PM +0100, Dmitry Vyukov wrote:
> > On Wed, Feb 27, 2019 at 3:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Urgh, kasan_report() is definitely unsafe. Now, admitedly we should
> > > 'never' hit that, but it does leave us up a creek without a paddle.
> 
> > If SMAP detects additional bugs, then it would be pity to disable it
> > with KASAN (detect bugs in production but not during testing).
> > 
> > You mentioned that exception save/restore the UACCESS state. Is it
> > possible to do the same in kasan_report? At the very least we need to
> > survive report printing, what happens after that does not matter much
> > (we've corrupted memory by now anyway).
> 
> Ideally we'll put all of kasan_report() in an exception, much like we do
> for WARN. But there's a distinct lack of arch hooks there to play with.
> I suppose I can try and create some.
> 
> On top of that we'll have to mark these __asan functions with notrace.
> 
> Maybe a little something horrible like so... completely untested.

OK, I got that to compile; the next problem is:

../include/linux/kasan.h:90:1: error: built-in function ‘__asan_loadN_noabort’ must be directly called
UACCESS_SAFE(__asan_loadN_noabort);

Which doesn't make any sense; since we actually generated that symbol,
it clearly is not built-in. What gives?


