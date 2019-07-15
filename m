Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E5EC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA23E206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ap2JCWPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfGOKMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:12:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfGOKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kAcyOVm59qdRJtG2/iEIXHURMzlURvoUqEQmVMxznZ4=; b=Ap2JCWPd1ucMlufGhT5Kn+WD8
        NGEchrdhHoT0rv3FQgahdfCU5u+mlZdnhiecpT2DXUVgHD026Zt0fFL/7HJxeMDq3DgEAF2IqU6Vi
        M9eIcXeZZ44lBx+CP+WLs38XqzebI837RgLv8b/xUUAh4y1HjtSNJJBK9EgJ0YGdIpyGcYrFkLkeU
        Nl8QbpfpLa9VtGMi38NFbTCv+lAN6gQOELjRljRtwokUIkJdA1WscK529Gx3PrSykBkdvdR4id8Pw
        XmQ2z03V43Y0y8LrZEB4bKS3qXinAUKsvQg2/F/NUt0qN/VTAeoU74QfKQo50doaXXrDat7w8iYz3
        FlWaJQA+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmxyD-0006Hm-PE; Mon, 15 Jul 2019 10:12:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B542520B29100; Mon, 15 Jul 2019 12:12:31 +0200 (CEST)
Date:   Mon, 15 Jul 2019 12:12:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, rostedt@goodmis.org,
        mingo@redhat.com, corbet@lwn.net, linux@armlinux.org.uk,
        catalin.marinas@arm.com, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tracing/fgraph: support recording function return values
Message-ID: <20190715101231.GB3419@hirez.programming.kicks-ass.net>
References: <20190713121026.11030-1-changbin.du@gmail.com>
 <20190715082930.uyxn2kklgw4yri5l@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715082930.uyxn2kklgw4yri5l@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 09:29:30AM +0100, Will Deacon wrote:
> On Sat, Jul 13, 2019 at 08:10:26PM +0800, Changbin Du wrote:
> > This patch adds a new trace option 'funcgraph-retval' and is disabled by
> > default. When this option is enabled, fgraph tracer will show the return
> > value of each function. This is useful to find/analyze a original error
> > source in a call graph.
> > 
> > One limitation is that the kernel doesn't know the prototype of functions.
> > So fgraph assumes all functions have a retvalue of type int. You must ignore
> > the value of *void* function. And if the retvalue looks like an error code
> > then both hexadecimal and decimal number are displayed.
> 
> This seems like quite a significant drawback and I think it could be pretty
> confusing if you have to filter out bogus return values from the trace.
> 
> For example, in your snippet:
> 
> >  3)               |  kvm_vm_ioctl() {
> >  3)               |    mutex_lock() {
> >  3)               |      _cond_resched() {
> >  3)   0.234 us    |        rcu_all_qs(); /* ret=0x80000000 */
> >  3)   0.704 us    |      } /* ret=0x0 */
> >  3)   1.226 us    |    } /* ret=0x0 */
> >  3)   0.247 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
> 
> mutex_unlock() is wrongly listed as returning something.
> 
> How much of this could be achieved from userspace by placing kretprobes on
> non-void functions instead?

Alternatively, we can have recordmcount (or objtool) mark all functions
with a return value when the build has DEBUG_INFO on. The dwarves know
the function signature.

