Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283BCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EC8206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LcgHcSEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKLH5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:57:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLH5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PwJjW7lExnjGC1SqkAjIZfG9XIlJONv22yyeC/eNbfk=; b=LcgHcSEptmIoV0PV9+RTKTumD
        7H2wsa02EZWQGF/c1KxtriklzW4oL9lWtbKXpK1dS7ZXAVFRhIcxhsVvXZ55alpW6fIJoaSxogipq
        F9LdohdhQYqb6LCms/2hol9BDUakXl+lNvVHmT7Z5gOgutwrJiimuc8WNV3MeAYXdt5vblnE4nYPc
        ze3v4e/kR374IrU4i/KWjJDFaBKvv05+kt52aESBzFyxsVMUOtcqPitM+VILVKP/YgLWnllxA197S
        wHcgYHpUYE6Pq+eeFYMGnoN5YHIJjPe7Xhp2oszVAeYYvJq6+I9QqGQtPTPU4fIPWsFRJ6RgT3Pd7
        DOkSFajrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUR3c-0001d8-S6; Tue, 12 Nov 2019 07:57:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A164D30018B;
        Tue, 12 Nov 2019 08:56:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D49E20302EFD; Tue, 12 Nov 2019 08:57:46 +0100 (CET)
Date:   Tue, 12 Nov 2019 08:57:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: Use C int3 selftest but disable KASAN
Message-ID: <20191112075746.GW4131@hirez.programming.kicks-ass.net>
References: <201911111348.7A0A6C3AFD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911111348.7A0A6C3AFD@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 01:51:16PM -0800, Kees Cook wrote:
> Instead of using inline asm for the int3 selftest (which confuses the
> Clang's ThinLTO pass), 

What is that and why do we care?

> this restores the C function but disables KASAN
> (and tracing for good measure) to keep the things simple and avoid
> unexpected side-effects. This attempts to keep the fix from commit
> ecc606103837 ("x86/alternatives: Fix int3_emulate_call() selftest stack
> corruption") without using inline asm.

See, I don't much like that. The selftest basically does a naked CALL
and hard relies on the callee saving everything if required, which is
very much against the C calling convention.

Sure, by disabling KASAN and all the other crap the compiler probably
does the right thing by accident, but it is still a C ABI violation.

We use ASM all over the kernel, why is this one a problem?
