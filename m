Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44923C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0022D20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CrPRmkbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfCFOfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:35:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43168 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfCFOfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1j1Wl2FLBFBKTP0BeY4Oc90/RV8cLO5oIe173oBbnnY=; b=CrPRmkbltl9OnWmQOWteyWu5A
        ghRJKfz/CWNwDTUrcfjP0hIorfX6ik+y0pN2zh/2BVN6sPGZWXOl+easYjG741Z6LSeqi9BKvG5Da
        jX0qnc78SRvhf7WNs+MzmbSI8c9beFSv5rFxZRf8r++Ju8vbKgYM6A6UodJS5fVIDd+PeYyLrSlkj
        nENLUEWEvd8Uc4eUSk+UtJBmwsrg7CuWxSRovSpUMT65/DPB89QZYgh0Tuy3S2Bc0ZnaoOJkgDvCw
        mu5aQ+6abk9/ieyfa6pkbjbDMflODORCeSH1rUjDw0a4ZStowg5RLl2cdZ6nHD2s9jvvOg4GHTZHa
        e/UbyRDGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1Xd4-0003NM-P4; Wed, 06 Mar 2019 14:34:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA91A299F9597; Wed,  6 Mar 2019 15:34:39 +0100 (CET)
Date:   Wed, 6 Mar 2019 15:34:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
Message-ID: <20190306143439.GY32534@hirez.programming.kicks-ass.net>
References: <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190301144556.GY32477@hirez.programming.kicks-ass.net>
 <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
 <20190301152305.GJ32494@hirez.programming.kicks-ass.net>
 <20190306131347.GX32534@hirez.programming.kicks-ass.net>
 <CACT4Y+YFkDRwTN1MKqLDePfuRis3Qas1kgEF7g5eVR0ijodtkw@mail.gmail.com>
 <20190306135728.GV32477@hirez.programming.kicks-ass.net>
 <CACT4Y+YP+Xn3TxVXrza_LBK8m7CCKBUYWpuGS0+MzFCXEE+Akg@mail.gmail.com>
 <20190306141237.GW32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306141237.GW32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 03:12:37PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 06, 2019 at 03:01:33PM +0100, Dmitry Vyukov wrote:
> > On Wed, Mar 6, 2019 at 2:57 PM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > I've not found callers of __asan_report_load* with AC=1 in the kernel
> > > yet. Under what condtions does GCC emit calls to these functions?
> > 
> > CONFIG_KASAN_INLINE=y
> > Then compiler inlines fast path into generated code and only calls
> > into runtime to report errors (also, faster, this should be a default
> > for anything other than tiny ROM controllers).
> 
> *sigh*, clearly I've not build enough kernels yet... Lemme go try that.

mm/kasan/generic_report.o: warning: objtool: __asan_report_load1_noabort()+0x0: call to __fentry__() with UACCESS enabled

You want to do:

CFLAGS_REMOVE_generic_report.o = -pg

like generic.o has?
