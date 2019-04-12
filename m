Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2CAC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4829920869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SyI3VINw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDLSTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:19:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48146 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfDLSTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KpJsBc8SapSFzeXew9+sq3mf1ByhcdS4G0yhgcMADv4=; b=SyI3VINwNFgLzvaWksaXcp57z
        OrBAd86qQeWRtn4Gdt9uziZE4aq7ToC5Tnfpu4N3NXuW6PMlNq3fWO4f03wLNaSMRjUwBvJEnCCfg
        CtUaHXVvyjRBs+NvtqLt1apQ51+dZYEAXA8xEAyizv4v9KVsHjaekuqY9U+spyCcS1UwGB8BbzMGR
        APuailpptjRAjn8LmBLLairGX37lhLp1cNkd7D/0MaWUqLYPRH1Keb9QJ/dr1aaC+nqgNrVrbWmfD
        +lWdvRcIjVM/Oten7rbKgGYRENjKF8J0TtOJ9enf+7e2vrpvkq8WrFIhCbPAZnHeHca+meF6XC9JO
        +uq7yLbsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hF0lv-0003Q9-NP; Fri, 12 Apr 2019 18:19:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73C1529B20C3F; Fri, 12 Apr 2019 20:19:30 +0200 (CEST)
Date:   Fri, 12 Apr 2019 20:19:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     kernel test robot <lkp@intel.com>, LKP <lkp@01.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"):  BUG:
 KASAN: stack-out-of-bounds in __change_page_attr_set_clr
Message-ID: <20190412181930.GD12232@hirez.programming.kicks-ass.net>
References: <5cae03c4.iIPk2cWlfmzP0Zgy%lkp@intel.com>
 <20190411193906.GA12232@hirez.programming.kicks-ass.net>
 <20190411195424.GL14281@hirez.programming.kicks-ass.net>
 <20190411211348.GA8451@worktop.programming.kicks-ass.net>
 <20190412105633.GM14281@hirez.programming.kicks-ass.net>
 <20190412111756.GO14281@hirez.programming.kicks-ass.net>
 <F18AF0D5-D8B4-4F4B-8469-F9DEC49683C7@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F18AF0D5-D8B4-4F4B-8469-F9DEC49683C7@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 03:11:22PM +0000, Nadav Amit wrote:
> > On Apr 12, 2019, at 4:17 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > To clarify, 'that' is Nadav's patch:
> > 
> >  515ab7c41306 ("x86/mm: Align TLB invalidation info")
> > 
> > which turns out to be the real problem.
> 
> Sorry for that. I still think it should be aligned, especially with all the
> effort the Intel puts around to avoid bus-locking on unaligned atomic
> operations.

No atomics anywhere in sight, so that's not a concern.

> So the right solution seems to me as putting this data structure off stack.
> It would prevent flush_tlb_mm_range() from being reentrant, so we can keep a
> few entries for this matter and atomically increase the entry number every
> time we enter flush_tlb_mm_range().
> 
> But my question is - should flush_tlb_mm_range() be reentrant, or can we
> assume no TLB shootdowns are initiated in interrupt handlers and #MC
> handlers?

There _should_ not be, but then don't look at those XPFO patches that
were posted (they're broken anyway).

