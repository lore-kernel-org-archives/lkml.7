Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DEAC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4965E20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zH8idhIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfCFO4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:56:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfCFO4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xmT55/5WlJ0QFSDA/Ks3ngPR4acCDaeEYEkPGFybcTQ=; b=zH8idhIBNIzYMbCdqZF05au7x
        TU/W656y5T1oedakDgLuLdoTuEtWOzRnA/+3e2IWoa8yIXeA2ZTk2ZAeDRuMbhMU0KKxTNOC/eBEc
        soQ+cN+c55ohekCCsnnY71D6M17az7rN17p6jO/2NU11pCj0vnNW0nz7j8mwa1a1atIBfd3g9IxvH
        IViF62gEiqOo4kFoLfX3qoicLK6MmJ9OnuVEUXH5paVh6yL6te9Qg3sR0czj4XjzgHw+JF5NNHSSy
        EJt34PDQpbewMXvQAiR0eBBNyfdYNM3RJhEzLnX8R+0utR1G1nTnDGSy0vvtHMd4VjzpBK0yqs+7o
        Q4dctlCmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1Xxc-0003RE-Ur; Wed, 06 Mar 2019 14:55:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACD4A29B0D0D8; Wed,  6 Mar 2019 15:55:55 +0100 (CET)
Date:   Wed, 6 Mar 2019 15:55:55 +0100
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
Message-ID: <20190306145555.GX32477@hirez.programming.kicks-ass.net>
References: <20190301144556.GY32477@hirez.programming.kicks-ass.net>
 <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
 <20190301152305.GJ32494@hirez.programming.kicks-ass.net>
 <20190306131347.GX32534@hirez.programming.kicks-ass.net>
 <CACT4Y+YFkDRwTN1MKqLDePfuRis3Qas1kgEF7g5eVR0ijodtkw@mail.gmail.com>
 <20190306135728.GV32477@hirez.programming.kicks-ass.net>
 <CACT4Y+YP+Xn3TxVXrza_LBK8m7CCKBUYWpuGS0+MzFCXEE+Akg@mail.gmail.com>
 <20190306141237.GW32477@hirez.programming.kicks-ass.net>
 <20190306143439.GY32534@hirez.programming.kicks-ass.net>
 <CACT4Y+YmQBc67hU2exY5=tAVG1jWNUeZ7FAm+GGgqDvOH7cu1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YmQBc67hU2exY5=tAVG1jWNUeZ7FAm+GGgqDvOH7cu1A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 03:40:51PM +0100, Dmitry Vyukov wrote:
> On Wed, Mar 6, 2019 at 3:34 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > mm/kasan/generic_report.o: warning: objtool: __asan_report_load1_noabort()+0x0: call to __fentry__() with UACCESS enabled

> But if it makes things simpler for the objtool, then I think we can
> disable function tracer for generic_report.c too.

It's not simpler; it is actually a correctness issue. Those functions
must not call into the tracer with AC=1
