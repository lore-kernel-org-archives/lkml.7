Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA8BC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9580218F0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JSZ6PnpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390816AbfGWPOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:14:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbfGWPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZQsVTPSDNSDkcFW9cXj3JbR5Y7NqzGJBRE1PkZOgQkU=; b=JSZ6PnpIJD6Tf8e+dQZEVPK9D+
        NFsTUDdmiXl23ETstYe91SHCcUomsasfk9da7+u2KmA48gUfVpFRNjoPA6jHAeG7ZQt9myQrhsF14
        g+E5B7n7wh83RWBc+DY60kRjreeRj2rbem4He4bvL5rSNgIsNvXkykj0Thyz9pxqBDsCEZVwynkBe
        XcCkqBKMPZkHGCY9lj3CmCPnQbCCVekvYrZ5v81f3DDBjZOT/bcpWoZwTFERELx8vCYK26HbD2ygw
        qlXNmFO63P+oXuCOAk+sJTP9xwVxkvKDDpUTNz5Exm0iZZNKy+nTVn8b/J4wQRg7IirMGjb+PjRPd
        MKNdUk7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpwV7-0000Q7-9p; Tue, 23 Jul 2019 15:14:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A21A201A57EF; Tue, 23 Jul 2019 17:14:47 +0200 (CEST)
Date:   Tue, 23 Jul 2019 17:14:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
Message-ID: <20190723151447.GO3419@hirez.programming.kicks-ass.net>
References: <20190719170343.GA13680@linux.intel.com>
 <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net>
 <201907221012.41504DCD@keescook>
 <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
 <201907221135.2C2D262D8@keescook>
 <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
 <201907221620.F31B9A082@keescook>
 <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
 <20190723091820.GZ3402@hirez.programming.kicks-ass.net>
 <17F255F9-5084-4E30-9AD6-80A4F49BD0D8@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17F255F9-5084-4E30-9AD6-80A4F49BD0D8@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 07:04:46AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Jul 23, 2019, at 2:18 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> >> On Mon, Jul 22, 2019 at 04:47:36PM -0700, Andy Lutomirski wrote:
> >> 
> >> I don't love this whole concept, but I also don't have a better idea.
> > 
> > Are we really talking about changing the kernel because BPF is expecting
> > things? That is, did we just elevate everything BPF can observe to ABI?
> > 
> 
> No, this isn’t about internals in the kernel mode sense.

*phew*, I was scared for a wee moment.

> It’s about the smallish number of cases where the kernel causes user
> code to do a specific syscall and the user has a policy that doesn’t
> allow that syscall.  This is visible to user code via seccomp and
> ptrace.
> 
> Yes, it’s obnoxious.  Do you have any suggestions?

Not really; I think I just demonstrated I don't fully understand the
problem space here :/
