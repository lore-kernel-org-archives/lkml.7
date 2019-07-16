Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFDAC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E28B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AmcKwH8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387798AbfGPOU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:20:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59202 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfGPOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 10:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I2Ko8faRg+vaZDBH8bLxhIlf1q9Nq5Ly4jgTbtIqtH8=; b=AmcKwH8L36gtAVtXSl/xDUGnR
        qZCDJ8uxjI4/col/5CmoaAovlizbhod7ZWtKaDLKMK3cbD01tUZQe7W9b2Sjx/5MatSnu+7NtriRT
        UyRX3G8paQOwwCDv94sMvC7niO201uuqWsbkN4lpcCiKRCy7CCpkwQXjpcBWd/2B2B5nS/P4AJPpp
        xqUzhGN2MvZnKl8o5C3E7h0Ht+HSLm1MEFUk3tMqLBV9WMmUXSvQuYLqyIMGyTmxWP6SLNprhaDDL
        Ejh2fLGM3tH4GS/p/ovfDcQUyDaSDeY69q2WoHoG7MIz9r7i4d0NuOFl791+WxpdSj6NRlZQchgKU
        3Iv1zBAFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnOJL-0004b6-Bh; Tue, 16 Jul 2019 14:20:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF744202167B8; Tue, 16 Jul 2019 16:20:05 +0200 (CEST)
Date:   Tue, 16 Jul 2019 16:20:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Will Deacon <will@kernel.org>, rostedt@goodmis.org,
        mingo@redhat.com, corbet@lwn.net, linux@armlinux.org.uk,
        catalin.marinas@arm.com, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tracing/fgraph: support recording function return values
Message-ID: <20190716142005.GE3402@hirez.programming.kicks-ass.net>
References: <20190713121026.11030-1-changbin.du@gmail.com>
 <20190715082930.uyxn2kklgw4yri5l@willie-the-truck>
 <20190715101231.GB3419@hirez.programming.kicks-ass.net>
 <20190716140817.za4rad3hx76efqgp@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716140817.za4rad3hx76efqgp@mail.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:08:18PM +0800, Changbin Du wrote:
> On Mon, Jul 15, 2019 at 12:12:31PM +0200, Peter Zijlstra wrote:

> > Alternatively, we can have recordmcount (or objtool) mark all functions
> > with a return value when the build has DEBUG_INFO on. The dwarves know
> > the function signature.
> >
> We can extend the recordmcount tool to search 'subprogram' tag in the DIE tree.
> In below example, the 'DW_AT_type' is the type of function pidfd_create().
> 
> $ readelf -w kernel/pid.o
>  [...]
>  <1><1b914>: Abbrev Number: 232 (DW_TAG_subprogram)
>     <1b916>   DW_AT_name        : (indirect string, offset: 0x415e): pidfd_create
>     <1b91a>   DW_AT_decl_file   : 1
>     <1b91b>   DW_AT_decl_line   : 471
>     <1b91d>   DW_AT_decl_column : 12
>     <1b91e>   DW_AT_prototyped  : 1
>     <1b91e>   DW_AT_type        : <0xcc>
>     <1b922>   DW_AT_low_pc      : 0x450
>     <1b92a>   DW_AT_high_pc     : 0x50
>     <1b932>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
>     <1b934>   DW_AT_GNU_all_call_sites: 1
>     <1b934>   DW_AT_sibling     : <0x1b9d9>
>  [...]
> 
> To that end, we need to introduce libdw library for recordmcount. I will have a
> try this week.

Right; but only when this config option is set.

> And probably, we can also record the parameters?

The 'fun' part is where to store all this information in the kernel and
how fast you can find it while tracing.
