Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762B2C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F2B2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bt0mD2ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfH2JRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:17:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfH2JRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eIzWRNGWJobqw1vcpia7FMnV9L9vEghQ28H7qz8p/sc=; b=Bt0mD2koMaJnTwNtUTNfkl2l+
        SBYE1pgVGkyFMKwYP7Aq2ba552NQ7+vD/jeUXIK2RyPT9ArG3eHYEM90U/1Y44wpu8UsC1Mqy8w/b
        j0YsqziOH+0uHqI/NscSslD1loyN+Pnefrhf0aDYA7atnp+ZhMtj1UT8pTNtdgqHX3hoUkYTue1xY
        WQx78CBsoNJFSF1J2/FgTxVLx6vX4Nop9uppDXYSHomn54Gk6oWxQRgg5MtAXA/OpDq+0gVOzi1UB
        4xYabpGbu9DGdpl00ctUe0N1n3HKKlnh0ZC0PYThpfCBYdOM2czRskat1lyoQNA58H3jPjLjrq5FQ
        JEdUOfFHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3GYQ-0007Ad-O1; Thu, 29 Aug 2019 09:17:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98F0E3075FF;
        Thu, 29 Aug 2019 11:16:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4C1A2022F842; Thu, 29 Aug 2019 11:17:16 +0200 (CEST)
Date:   Thu, 29 Aug 2019 11:17:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
Message-ID: <20190829091716.GO2369@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <20190828151921.GD17205@worktop.programming.kicks-ass.net>
 <20190828161754.GP5447@tassilo.jf.intel.com>
 <20190828162857.GO2332@hirez.programming.kicks-ass.net>
 <20190829031151.GR5447@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829031151.GR5447@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 08:11:51PM -0700, Andi Kleen wrote:
> On Wed, Aug 28, 2019 at 06:28:57PM +0200, Peter Zijlstra wrote:
> > On Wed, Aug 28, 2019 at 09:17:54AM -0700, Andi Kleen wrote:
> > > > This really doesn't make sense to me; if you set FIXED_CTR3 := 0, you'll
> > > > never trigger the overflow there; this then seems to suggest the actual
> > > 
> > > The 48bit counter might overflow in a few hours.
> > 
> > Sure; the point is? Kan said it should not be too big; a full 48bit wrap
> > around must be too big or nothing is.
> 
> We expect users to avoid making it too big, but we cannot rule it out.
> 
> Actually for the common perf stat for a long time case you can make it fairly
> big because the percentages still work out over the complete run time.
> 
> The problem with letting it accumulate too much is mainly if you
> want to use a continuously running metrics counter to time smaller
> regions by taking deltas, for example using RDPMC. 
> 
> In this case the small regions would be too inaccurate after some time.
> 
> But to make the first case work absolutely need to handle the overflow
> case. Otherwise the metrics would just randomly stop at some
> point.

But then you need -max_period, not 0. By using half the period, there is
no ambiguity on overflow.
