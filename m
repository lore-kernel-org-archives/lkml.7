Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4CDC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AD8223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q7g8/hNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbfGWJS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:18:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfGWJS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1R2qVL2FwLoBS7z/Jf8svy/wd0xYkPtd4YrOC2qNAxI=; b=q7g8/hNy8aFZ0LMT7ZqZPMk//
        Q0DUxwvVvzOK8PKRTEv3qhxbmWl3rAvcESRwXrYHKFHpBOh6jIiT/NIxKILGoy//vj8RcW30+mxwf
        YA2G3k9eFicpCxP2GMrxkQYUTe5TagQukzxEKIKF2KSRPx63808YO2aeI39Fhn8CevZp/XBlTotUk
        At0x4KIF+6eyPX9dN9/J5+CSi2QVwe5y1MQNyBz6kMSgiOH4hL1s73dyPfWYKs+3TvpowGIAEKNJ/
        SglBCQcW7dO9zu7Omy+PlLEMDIUB3m1IOdHvYXmxZ8M+KmyCn/qIJGtl4orsU8pUQ5Aa+H3KLeec5
        3GrmOQJKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpqwA-0005fs-Cm; Tue, 23 Jul 2019 09:18:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A20B820B9A4F6; Tue, 23 Jul 2019 11:18:20 +0200 (CEST)
Date:   Tue, 23 Jul 2019 11:18:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
Message-ID: <20190723091820.GZ3402@hirez.programming.kicks-ass.net>
References: <20190719170343.GA13680@linux.intel.com>
 <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net>
 <201907221012.41504DCD@keescook>
 <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
 <201907221135.2C2D262D8@keescook>
 <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
 <201907221620.F31B9A082@keescook>
 <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:47:36PM -0700, Andy Lutomirski wrote:

> I don't love this whole concept, but I also don't have a better idea.

Are we really talking about changing the kernel because BPF is expecting
things? That is, did we just elevate everything BPF can observe to ABI?

/me runs for cover.
