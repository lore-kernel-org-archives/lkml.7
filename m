Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFF4C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB032083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TXtxbDYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfDLSQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:16:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfDLSQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vLgYVDT49iGyhQ7eAaa1ouryxRYhUiXDgOprm8yEPCE=; b=TXtxbDYuMujQhLK+HaFsZkwEi
        ExxaqmfppeQtbOkWZPOZ2cCRPEV+S8sfIQnDJF5mi941nvZ00/tSkwtBibSXyg8MOvY6p0k6RpNOX
        lwozqoFRxl01U59Jze3IxOcOWGtOmBYKsB2T8WdmwPgOlUEXrO9SgyyR0u7KlZ7q854B9M4hg4v6e
        dLsdE9woWI/1TvbMWk5ksNt2u2XKJK813fNAW3KlIf+VJXfIBQ4iXaVZR18TkYS59DCcSIs66/F12
        QFW2ldsE539CqlBznmHrmdT7CIG8YLL+WdItNlI19A1O5xBfyJUp7uq9AP/90+GBDJWL7uX3RHsb5
        FVkbrZiiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hF0iV-0003m7-Hz; Fri, 12 Apr 2019 18:15:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69C5029B20C3F; Fri, 12 Apr 2019 20:15:57 +0200 (CEST)
Date:   Fri, 12 Apr 2019 20:15:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>, LKP <lkp@01.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: Re: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"): BUG:
 KASAN: stack-out-of-bounds in __change_page_attr_set_clr
Message-ID: <20190412181557.GC12232@hirez.programming.kicks-ass.net>
References: <CAHk-=wieBr3G=_ZGoCndi8XnuG1wtkedaGqkWB+=AVq65=_8sQ@mail.gmail.com>
 <5cae03c4.iIPk2cWlfmzP0Zgy%lkp@intel.com>
 <20190411193906.GA12232@hirez.programming.kicks-ass.net>
 <20190411195424.GL14281@hirez.programming.kicks-ass.net>
 <20190411211348.GA8451@worktop.programming.kicks-ass.net>
 <20190412105633.GM14281@hirez.programming.kicks-ass.net>
 <5890.1555087830@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5890.1555087830@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 05:50:30PM +0100, David Howells wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > We should never have stack alignment bigger than 16 bytes.  And
> > preferably not even that.
> 
> At least one arch I know of (FRV) had instructions that could atomically
> load/store register pairs or register quads, but they had to be pair- or
> quad-aligned (ie. 8- or 16-byte), which made for more efficient code if you
> could use them.
> 
> I don't know whether any arch we currently support has features like this (I
> know some have multi-reg load/stores, but they seem to require only
> word-alignment).

ARC (iirc) has u64 atomics with natural alignment requirements but
alignof(u64)=4 due it being a 32bit arch. Which is awkward.

ARMv7 can also do u64 ops when aligned right, but I forgot if they have
proper alignment or not.
