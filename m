Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FDFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50F82087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rfY5Ko44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfDPRlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:41:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48534 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfDPRlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uJX5KL/XHJgsYTL67aKBj+gUCXbmMGwl7EtalEEdM+Y=; b=rfY5Ko44V43CJuRAv9JllGJuu
        nC4k4PUwnSmLT44LkI35P8nHp1pMqKRbJI3zMCX6XUeo/yHNAMo/VrRRuSzyJFQ9s5VkAZk+ZuedV
        kxJlo8WPHM3Ay7LEYj7u9eE7kdDmUqrizFu0ylFevn+PkdVOkP7xbJPZvPRuoCpvjRMyqmf89GK6b
        +xH836D9qCt4cVIa7MZOKMBI1GiSI94vCinczLsGZvpqdGxUbU/aGE8xcAcjDywA27/z34Lh5uHbF
        qqlEErZirjXHjDSmoTuhndEIfcyykfwb5pzlZgWvzak9WNN3ZlNUlXUCBBMPdRo5tjmPstBA0IVbY
        0dblpY5fg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGS51-0004kG-Ku; Tue, 16 Apr 2019 17:41:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A1FA25E4A93C; Tue, 16 Apr 2019 19:41:10 +0200 (CEST)
Date:   Tue, 16 Apr 2019 19:41:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     mingo@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, acme@redhat.com, hpa@zytor.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/core] perf/x86/intel: Force resched when TFA sysctl is
 modified
Message-ID: <20190416174110.GS4038@hirez.programming.kicks-ass.net>
References: <20190408173252.37932-3-eranian@google.com>
 <tip-f447e4eb3ad1e60d173ca997fcb2ef2a66f12574@git.kernel.org>
 <alpine.DEB.2.21.1904161227001.20764@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904161227001.20764@macbook-air>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:28:00PM -0400, Vince Weaver wrote:
> On Tue, 16 Apr 2019, tip-bot for Stephane Eranian wrote:
> 
> > Commit-ID:  f447e4eb3ad1e60d173ca997fcb2ef2a66f12574
> > Gitweb:     https://git.kernel.org/tip/f447e4eb3ad1e60d173ca997fcb2ef2a66f12574
> > Author:     Stephane Eranian <eranian@google.com>
> > AuthorDate: Mon, 8 Apr 2019 10:32:52 -0700
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Tue, 16 Apr 2019 12:19:35 +0200
> > 
> > perf/x86/intel: Force resched when TFA sysctl is modified
> 
> What's TFA?  Tuna-fish-alarm?  Nowhere in the commit or in the code does 
> it ever say what a TFA is or why we'd want to resched when it is modified.

See commit: 400816f60c54 ("perf/x86/intel: Implement support for TSX Force Abort")

Author: Peter Zijlstra (Intel) <peterz@infradead.org>
Date:   Tue Mar 5 22:23:18 2019 +0100

    perf/x86/intel: Implement support for TSX Force Abort
    
    Skylake (and later) will receive a microcode update to address a TSX
    errata. This microcode will, on execution of a TSX instruction
    (speculative or not) use (clobber) PMC3. This update will also provide
    a new MSR to change this behaviour along with a CPUID bit to enumerate
    the presence of this new MSR.
    
    When the MSR gets set; the microcode will no longer use PMC3 but will
    Force Abort every TSX transaction (upon executing COMMIT).
    
    When TSX Force Abort (TFA) is allowed (default); the MSR gets set when
    PMC3 gets scheduled and cleared when, after scheduling, PMC3 is
    unused.
    
    When TFA is not allowed; clear PMC3 from all constraints such that it
    will not get used.
    
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
