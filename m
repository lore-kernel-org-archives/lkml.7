Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A6AC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970DC21D82
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jnbLISrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbfKGJNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:13:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58662 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfKGJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=stpQ2ZxVbR6vwFgf2kbMBwfdaXFgcnuA4lpQdxAozKo=; b=jnbLISrUxo7DzyoIX7Dwgcg8y
        bC3qwfzYzuye2C2c6PMptTeYRd37Cl7MMcQwjhBnmwbAoB8QmFMjtWZrsx0cZ56o5VBh/NIdwLkgE
        sIN+e025d509E07PGAEnTAPSCsYJVvQX3UnB0qohMqWKg0qT/tz9QSzRv6/a51yyWtBgDAxAIryGt
        +u+7tZpXt8B+x8ZmlCq+/gQg+DJoeA3aa6tsjsyHQUuYeWptQeePwdCNJjQetywE6/Pt+bJmGO10r
        A0h0nttFg5vbtzuXo2I72B8e3mYoumeScnymEIp/LdKPcZaXI46WDVs4ZEzQdJKNomqCh02NNKzsd
        nsTTLyAOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSdqF-0002Xp-Ry; Thu, 07 Nov 2019 09:12:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61933300692;
        Thu,  7 Nov 2019 10:11:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAC432B13B364; Thu,  7 Nov 2019 10:12:31 +0100 (CET)
Date:   Thu, 7 Nov 2019 10:12:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 4/9] x86/io: Speedup schedule out of I/O bitmap user
Message-ID: <20191107091231.GA4131@hirez.programming.kicks-ass.net>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.133597409@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106202806.133597409@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 08:35:03PM +0100, Thomas Gleixner wrote:
> There is no requirement to update the TSS I/O bitmap when a thread using it is
> scheduled out and the incoming thread does not use it.
> 
> For the permission check based on the TSS I/O bitmap the CPU calculates the memory
> location of the I/O bitmap by the address of the TSS and the io_bitmap_base member
> of the tss_struct. The easiest way to invalidate the I/O bitmap is to switch the
> offset to an address outside of the TSS limit.
> 
> If an I/O instruction is issued from user space the TSS limit causes #GP to be
> raised in the same was as valid I/O bitmap with all bits set to 1 would do.
> 
> This removes the extra work when an I/O bitmap using task is scheduled out
> and puts the burden on the rare I/O bitmap users when they are scheduled
> in.

This also nicely aligns with that the context switch time is accounted
to the next task. So by doing the expensive part on switch-in gets it
all accounted to the task that caused it.
