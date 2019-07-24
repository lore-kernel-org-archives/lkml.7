Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410C8C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A0421BF6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ymnAVmy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfGXHrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:47:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53564 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGXHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=abkHvxAJvwMKBCZu1/vRafgARA6Z23deu9xdjglWdiM=; b=ymnAVmy56nkJuvRLehjBGx9s/
        7CYuMmooDqv0cOw/CHYffsuX4ilCUi+CJsBWYX5Ze2WKn+RWQw70I0Q+ceLPO2hjLhWYNvwlfrpRt
        vdHEaWGa0kxpBV41dEEX0Rig5NU/dTZaXn/R0ZtGsAfDYSK8LVbaUxTzsJ/RWpykiksU3vEEHlZrI
        B9pb7TkVxtFPDKGLvWy0bCPBgRgYsEzrfKbHwKzMnsrSuTX2bquMflrBKcqdv7sZcOIHtiEpScZ3e
        hR7jCRFXXQFZBz/XWyBvVmQyjM4igWnkfEPWFgceoGIxz/LcdZm0QgqgbYxXLHzuU4uEPdqLamMQe
        iszgh61tA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqBzq-0001bb-2N; Wed, 24 Jul 2019 07:47:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4B4A20A5F8E5; Wed, 24 Jul 2019 09:47:32 +0200 (CEST)
Date:   Wed, 24 Jul 2019 09:47:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 - clang / objtool status
Message-ID: <20190724074732.GJ3402@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <20190724023946.yxsz5im22fz4zxrn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724023946.yxsz5im22fz4zxrn@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 09:43:24PM -0500, Josh Poimboeuf wrote:
> On Thu, Jul 18, 2019 at 10:40:09PM +0200, Thomas Gleixner wrote:
> 
> >   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x86: redundant UACCESS disable
> 
> Looking at this one, I think I agree with objtool.
> 
> PeterZ, Linus, I know y'all discussed this code a few months ago.
> 
> __copy_from_user() already does a CLAC in its error path.  So isn't the
> user_access_end() redundant for the __copy_from_user() error path?

Hmm, is this a result of your c705cecc8431 ("objtool: Track original function across branches") ?

I'm thinking it might've 'overlooked' the CLAC in the error path before
(because it didn't have a related function) and now it sees it and
worries about it.

Then again, I'm not seeing this warning on my GCC builds; so what's
happening?
