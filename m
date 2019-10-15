Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8348DECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D5520854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tts+80eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389154AbfJOSb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 14:31:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53496 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfJOSb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bjWhRvmBu/9tIPXtTGlEAeo+oND2q0OkwQG+bo937CE=; b=Tts+80eoSLUNV0Kg/vYeeRGfb
        WIg4IRkYCBa2fuaOECG04EmD0G4W1321pfG0wyBH+ssBRgUS9dIeC9DSNMns4QlQXv9VJZLNpGQO2
        6veSBUEWWqxOX81tvwexeAgWM+R8l8lmhAToKQApxJtY/3CXsvzHup9pZIjR5mM6eV6pFYluV2VuL
        +92d/B6WN8Hn8+19IlEmcuCh1vl9SnL3VFTj5UpXQiWUY+KjGXih5dEGs8v2QEf0h+76b8b9TwNl6
        M7Mxy309oiVsN/TFL87XVd5vbub8DMlYqzmypUugYWiP5gqKLdsfe+Zafi2mNFSmUKK5XS/5bRf/9
        XdP8LFVVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKRba-0005Zw-AU; Tue, 15 Oct 2019 18:31:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F817300B8D;
        Tue, 15 Oct 2019 20:30:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0E6129A873DD; Tue, 15 Oct 2019 20:31:30 +0200 (CEST)
Date:   Tue, 15 Oct 2019 20:31:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, rabin@rab.in,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, james.morse@arm.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191015183130.GR2359@hirez.programming.kicks-ass.net>
References: <20191009224135.2dcf7767@oasis.local.home>
 <20191010092054.GR2311@hirez.programming.kicks-ass.net>
 <20191010091956.48fbcf42@gandalf.local.home>
 <20191010140513.GT2311@hirez.programming.kicks-ass.net>
 <20191010115449.22044b53@gandalf.local.home>
 <20191010172819.GS2328@hirez.programming.kicks-ass.net>
 <20191011125903.GN2359@hirez.programming.kicks-ass.net>
 <20191015130739.GA23565@linux-8ccs>
 <20191015135634.GK2328@hirez.programming.kicks-ass.net>
 <20191015144258.GQ2359@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015144258.GQ2359@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 04:42:58PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 15, 2019 at 03:56:34PM +0200, Peter Zijlstra wrote:
> > Right, the problem is set_all_modules_text_*(), that relies on COMING
> > having made the protection changes.
> > 
> > After the x86 changes, there's only 2 more architectures that use that
> > function. I'll work on getting those converted and then we can delete
> > that function and worry no more about it.
> 
> Here's a possible patch for arch/arm, which only leaves arch/nds32/.

*sigh*, so I'd written the patching code for nds32, but then discovered
it doesn't have STRICT_MODULE_RWX and therefore we can simply delete the
thing.
