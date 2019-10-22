Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FACCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EA721783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A8DP0T8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbfJVMbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:31:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38194 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388066AbfJVMbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cbzjBRCNu064oPbnxwV51wPz82f0A4UhuT/lsEJ7sU4=; b=A8DP0T8HXpZ8QWEfSqsuG6Ova
        F76pB1qsAY0tM7KHGTfJwIRVFa9StYYpj95znyoyLDLI9O/v8gL9TJ0XkF70eO1krOrP6GXCCYvTb
        d6kk4YTnmtFrSBWQZ8XtgtfLSIUAiSgYATA82WeupbmoawGtMerU+REv2V8LTK72UEsTuzfRYSqPq
        M2yc8lLtZLPYhfhBQekUuWuR5Norwc2zaTrLJ13PNb4IBNmYwox279jsZsyy3GPRSiDx67kPcfInK
        tP1L+MpRF60+GTtc8zfS9e1h3rDux0Zd0bzlG34rgLlshFAB1Mh2egzjU95RvoQEdw+k21y/JLoFj
        x0WMEvoog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMtJj-000478-Tc; Tue, 22 Oct 2019 12:31:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D188D300F29;
        Tue, 22 Oct 2019 14:30:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BF1C2042087F; Tue, 22 Oct 2019 14:31:12 +0200 (CEST)
Date:   Tue, 22 Oct 2019 14:31:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191022123112.GI1800@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021135312.jbbxsuipxldocdjk@treble>
 <20191021141402.GI1817@hirez.programming.kicks-ass.net>
 <20191021153425.GB19358@hirez.programming.kicks-ass.net>
 <20191021161135.GD19358@hirez.programming.kicks-ass.net>
 <20191022113116.GA8574@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022113116.GA8574@osiris>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 01:31:16PM +0200, Heiko Carstens wrote:
> On Mon, Oct 21, 2019 at 06:11:35PM +0200, Peter Zijlstra wrote:
> > On Mon, Oct 21, 2019 at 05:34:25PM +0200, Peter Zijlstra wrote:
> > > On Mon, Oct 21, 2019 at 04:14:02PM +0200, Peter Zijlstra wrote:
> > 
> > > So On IRC Josh suggested we use text_poke() for RELA. Since KLP is only
> > > available on Power and x86, and Power does not have STRICT_MODULE_RWX,
> > > the below should be sufficient.
> > > 
> > > Completely untested...
> > 
> > And because s390 also has: HAVE_LIVEPATCH and STRICT_MODULE_RWX the even
> > less tested s390 bits included below.
> > 
> > Heiko, apologies if I completely wrecked it.
> > 
> > The purpose is to remove module_disable_ro()/module_enable_ro() from
> > livepatch/core.c such that:
> > 
> >  - nothing relies on where in the module loading path module text goes RX.
> >  - nothing ever has writable text
> 
> Given that Steven reported a crash, I assume I can wait until you
> repost a new version of the series, which also includes s390 bits?

His crash is somewhat orthogonal, but yes, I will repost once sorted.
