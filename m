Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576ACCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DA420663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dk9z3IKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390715AbfJWJHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:07:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390394AbfJWJHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oKDgB7O1I09/oCMUnXpYyhb3gKOQx5fRjqbW0BZ+hv4=; b=dk9z3IKSwNhchvnAwS0ryAm/L
        hU1dpr1BfYsJE1ob+7o5Azm4TC26qg+GhHJSwZ1hyBlwWvWXT0pZYhZgK5/3v0xuXsL6dua+qcG1O
        kuHT+3zfd6JZaJLZrT49J/ERk/5c92Zy5HdIroeIVXJTwkWdcZyVpD4QpJGbAIlkAYdNldAKEtPtP
        FDHgK75+livj2MmlpjR+mi/ovDD4yhlFUDJ1e38ZuwxcE0fRyD3ganRaBvKCitMCbJ/q/Xt3Ur9QE
        6Z/1aaTVfIw2/6WJh90N3K90B8TFGV5UuMPvlAiwLhIjlMDuI0iLxHRSdah2PGooybOgl9skQGYqx
        tOy35+XnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNCbn-0007eU-HC; Wed, 23 Oct 2019 09:07:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 37C76300C3C;
        Wed, 23 Oct 2019 11:06:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 158C42B1C5851; Wed, 23 Oct 2019 11:07:08 +0200 (CEST)
Date:   Wed, 23 Oct 2019 11:07:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191023090708.GQ1817@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021222110.49044eb5@oasis.local.home>
 <20191022202401.GO1817@hirez.programming.kicks-ass.net>
 <20191022164023.2102fb1a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022164023.2102fb1a@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:40:23PM -0400, Steven Rostedt wrote:
> On Tue, 22 Oct 2019 22:24:01 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > I'm not particularly proud of the "__function__" hack, but it works :/ I
> 
> If anything, that should be defined as a macro:
> 
> #define TRACE_EVENT_FIELD_SPECIAL "__trace_event_special__"
> 
> And use that to test?

Possibly, also, we should probably start with a character that C doesn't
allow in typenames, like '$'.

That way we can have a much shorter string and still be certain it will
never conflict; "$func" comes to mind.

> > couldn't come up with anything else for [uk]probes which seem to have
> > dynamic fields and if we're having it then syscall_enter can also make
> > use of it, the syscall_metadata crud was going to be ugly otherwise.
> > 
> > (also, win on LOC)
> 
> I'm more worried about text/data bloat. But if anything, we may be able
> to deal with that later.

We use almost the exact same data the function would've used, except we
don't have the actual function. I just don't see how it can be more.
