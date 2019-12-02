Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC208C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782902073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DjHY3bPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfLBQWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 11:22:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfLBQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KrIeoB6eXu5dDlRf2wZt+U1dAygcO/BvD5fSXChJq8E=; b=DjHY3bPVJwmIxla70oxFpA88U
        WCVuYqWRGQ4t+VO9BfpjnUVA19Vt3nmVaCLOrQmRnLGAxicdwmaT/BGjsjvf76hQX1iXjn9CykVVR
        J7Ive523K9vDAe5kp1n/zPWeheWFv2HY5wleFQQwTVUvu8c8R4T2XNV9Vk3r6fWCNanUfHZp2JviA
        8SYg7c1aSy1z6J6es6jTux57HPRuYSVKgxvnRfCNS71Em267s2NMBxONRWyg0H/VTVHkkymk3N6Ix
        SKG5VaIdgvE8msrJw9y7qQj9nhwIKMaRkcMTVSGByGc49F3KjcYd8V11O+aCICeAiUXMMtjca+2S4
        3sLoDBV/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iboSQ-0003YR-Ol; Mon, 02 Dec 2019 16:21:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78A9B305E42;
        Mon,  2 Dec 2019 17:20:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D064201A401D; Mon,  2 Dec 2019 17:21:52 +0100 (CET)
Date:   Mon, 2 Dec 2019 17:21:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com
Subject: Re: [RFC PATCH 3/8] perf: Init/fini PMU specific data
Message-ID: <20191202162152.GG2827@hirez.programming.kicks-ass.net>
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
 <1574954071-6321-3-git-send-email-kan.liang@linux.intel.com>
 <20191202124055.GC2827@hirez.programming.kicks-ass.net>
 <20191202145957.GM84886@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202145957.GM84886@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 06:59:57AM -0800, Andi Kleen wrote:
> > 
> > This is atricous crap. Also it is completely broken for -RT.
> 
> Well can you please suggest how you would implement it instead?

I don't think that is on me; at best I get to explain why it is
completely unacceptible to have O(nr_tasks) and allocations under a
raw_spinlock_t, but I was thinking you'd already know that.


