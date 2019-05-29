Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B51C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D77923E30
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lgq3BDti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfE2QrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 12:47:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfE2QrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aAFrvNPaIHUCCL9+ILaUBj24F32k6ot958+og5X/EMI=; b=lgq3BDtilAjGV9zSDUDRWQ9aI
        AWu3itgz+l0TBJzOyhs3eZejWlRmungx79JMNEIgNREagL0PIJxZEdqY4rdZX5fkUlb60RAf/9jN+
        6VwAMFt8J5NAn/YVCWWszoypmPrKNdVm2QA/ec8fyu3C/rQWAyW9s5eJz1rIqH39+5TmkI1PIZqyw
        LR863Lp1V5tj35n62qO81gqCtosWkarF+bbq2GratxtR39jZxGCyz0xJJflcnlRusnRO1HQrKNpl6
        AbG0nDogEf7R7gYLvaFkmo017vjkLy4sQGzCFpRwwZFAucWAiigjpcnBYoZxfkMIegSLTcsbZOuTJ
        nG4J1LGTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW1j6-0004aA-NA; Wed, 29 May 2019 16:46:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 38DB9201CB95E; Wed, 29 May 2019 18:46:55 +0200 (CEST)
Date:   Wed, 29 May 2019 18:46:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 2/9] perf/x86/intel: Basic support for metrics counters
Message-ID: <20190529164655.GB2623@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-3-kan.liang@linux.intel.com>
 <20190528121508.GS2606@hirez.programming.kicks-ass.net>
 <991ef247-8efe-bc21-a988-3d628733d915@linux.intel.com>
 <20190529072855.GX2623@hirez.programming.kicks-ass.net>
 <dfaeb4b4-bf49-593d-b9e4-33dd8c050d4e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfaeb4b4-bf49-593d-b9e4-33dd8c050d4e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:40:52AM -0400, Liang, Kan wrote:
> On 5/29/2019 3:28 AM, Peter Zijlstra wrote:
> > One way would be to make these 48-51 and put BTS as 52, and then you do
> 
> Can we put BTS 47?

Sure, it doesn't matter where you put it. It just needs to be a free bit
position, the rest doesn't matter.
