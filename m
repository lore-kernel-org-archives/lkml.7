Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DCFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6402087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gx6Zs3x3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCHNfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:35:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33854 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfCHNfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=00hfKE/E7QSgNB45zu00ghT8eHguIg5JcE19KbrZHX0=; b=Gx6Zs3x3YclE4n0E/Is3VYTNm1
        qF2U6hT3ZnMr71i68fBosTUuf28B3LYdPe/bYwVQe3X6oRCeYOxjCAJi4xmK1JY78mxY1dkMuyPsW
        fhOGt2WOBAjAPcxbxcA0rXTGf+8axqjzH8O8A7DSqdz/1MutSvtW18EWt8ByugACyEy1We5gHvFuA
        K775NweKbkwae7Sj6KbcNqF8u3MSuIfAe93tyWy+5OKxyMXoVWL1359y8v3BEF6hD1TlFOV1PXXBe
        BsaC+TQSTF4Elxszeay18Hj8B1999U3VCZ2rGFB29j0WkcYB1h5boiLu1Wbg14mRONQQSsizcHeFb
        63maahPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2Feb-0007Ip-D1; Fri, 08 Mar 2019 13:35:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AF8120298BA7; Fri,  8 Mar 2019 14:35:10 +0100 (CET)
Date:   Fri, 8 Mar 2019 14:35:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/5] x86/percpu: Differentiate this_cpu_{}() and
 __this_cpu_{}()
Message-ID: <20190308133510.GX32494@hirez.programming.kicks-ass.net>
References: <20190227101252.413192716@infradead.org>
 <20190227101544.210748832@infradead.org>
 <CAHk-=wiv6dgJDj81wukpJCJBVhAVn-CYJdhj+o8JGN1LfRwb0g@mail.gmail.com>
 <06F1CFAA-DD80-4DA7-A97C-E57814149CC4@vmware.com>
 <CAHk-=wgfx6rUXpH16A9OAyEEh9nf18pk9mL7Wkz5b6eDc9dPpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgfx6rUXpH16A9OAyEEh9nf18pk9mL7Wkz5b6eDc9dPpA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:41:31AM -0800, Linus Torvalds wrote:
> On Wed, Feb 27, 2019 at 9:57 AM Nadav Amit <namit@vmware.com> wrote:
> >
> > I’ll have a look at some specific function assembly, but overall, the “+m”
> > approach might prevent even more code optimizations than the “volatile” one.
> 
> Ok, that being the case, let's forget that patch.
> 
> I still wonder about the added volatiles to the xadd/cmpxchg cases,
> which already had the "memory" clobber which should make the volatile
> immaterial..

That was mostly me being OCD style consistent; but also notice that the
atomic ops also often have volatile even though they have a memory
clobber.


