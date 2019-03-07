Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5F82063F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JGBOdgPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCGRiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:38:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfCGRiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2bjsc85l/P3sWJy9LA97uh1fbTulfsF6oCVTsZ2XWUw=; b=JGBOdgPlxhlu2hgQXSNXAWi9R
        ylm3xDSH5MT9WEPRdMGYxOeWKnU9JS/1Dw/NH+u50mhaV3ZOBCKAv/JQGTFLHbio7o9vwqd2Lgm3s
        T8dqqAztRI4pfKYwY3uw4YeQ3gYi0RsxlvuBiqQC1D7mqQQUMlP/ue5fVYeRaAL/0EZ72lWoEjKbu
        6kkBbWzm53wnNc8fj94a+ZPF1XIifEYYdi4a0ntpLSS9xCRV0pBLkmk2MioI4r3Ewuzyf7UJTkkVS
        LYqkTYVzbu/VCL6eE/IJxAaG2fw1uWhfv1hWFYiqmUmQ6q36IzxYaMlYwQ5mFvW0oej+SQB1AJ3BR
        w6OfjSo6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1wyC-0001VG-9U; Thu, 07 Mar 2019 17:38:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B0AA2029B186; Thu,  7 Mar 2019 18:38:10 +0100 (CET)
Date:   Thu, 7 Mar 2019 18:38:10 +0100
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
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
Message-ID: <20190307173810.GI32477@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307120317.GD32477@hirez.programming.kicks-ass.net>
 <20190307125526.GB32534@hirez.programming.kicks-ass.net>
 <20190307131312.GC32534@hirez.programming.kicks-ass.net>
 <20190307164705.qbu4ytdfdmsighas@treble>
 <CAHk-=wgfvwn1L7BduXA02rZdDnKGb8ebzm4C--QcfVF+gjHAvQ@mail.gmail.com>
 <20190307171709.dap5hfeof4yo3nsc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307171709.dap5hfeof4yo3nsc@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:17:09AM -0600, Josh Poimboeuf wrote:
> On Thu, Mar 07, 2019 at 09:00:49AM -0800, Linus Torvalds wrote:
> > But that macro really is the macro from hell regardless.
> > 
> > Do people really use CONFIG_PROFILE_ALL_BRANCHES?
> 
> IIRC, Steven runs it once a year or so...

That's TRACE_BRANCH_PROFILING; PROFILE_ALL_BRANCHES I don't know, that
mostly just gets in the way I think.

Also; it seems to me that something PT, or maybe even simply:

  perf -e branches -e branch-misses

would get you similar or sufficient information.
