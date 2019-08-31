Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFACC3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 09:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1EB23426
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 09:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fVJw8Gsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfHaJTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 05:19:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfHaJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 05:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=we5Tr511phlcjEEmThH3qVv+D23i8ugbd1UVU1aMdkQ=; b=fVJw8GslMP00MVMjqcpSTMy9Y
        EpP8Mng7pwd0r59ORAZfNPUvGMF0YfTEUC7oEyITWyPChjJbZMhMbJp9yfm7hCJtHUHDfaPf9LZ5K
        AdqBcD7QSjsmL/H/AIW6t3xLCdNPCXovuVWWloqDvP06kAAiijicH8VEL8+CU2Z4q8j23x5a3k6cI
        02WEUhkath+cw4MjKDTIVfg0RF72D6gbf/BojeDRhqUrwu8Mn91oGMUZEyAS620PAa63MPrrcRuB+
        1dwS8NnjmfUdCdgBr1vMLIhT3bN+xa4YNWUgtJJKogORAnKPVBNwMWhDX7jLBhI/c5EU6xsQJUsbW
        sdMNLRIYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3zXh-0001kr-9U; Sat, 31 Aug 2019 09:19:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 955BB301747;
        Sat, 31 Aug 2019 11:18:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89F8529B2CD17; Sat, 31 Aug 2019 11:19:31 +0200 (CEST)
Date:   Sat, 31 Aug 2019 11:19:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
Message-ID: <20190831091931.GJ2369@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <20190828150238.GC17205@worktop.programming.kicks-ass.net>
 <20190828190445.GQ5447@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828190445.GQ5447@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 12:04:45PM -0700, Andi Kleen wrote:

> > > NMI
> > > ======
> > > 
> > > The METRICS register may be overflow. The bit 48 of STATUS register
> > > will be set. If so, update all active slots and metrics events.
> > 
> > that happen? It would be useful to get that METRIC_OVF (can we please
> 
> This happens when the internal counters that feed the metrics
> overflow.
> 
> > If this is so; then we can use this to update/reset PERF_METRICS and
> > nothing else.
> 
> It has to be handled in the PMI.

That's what I wrote; Overflow is always NMI.

> > Then there is no mucking about with that odd counter/metrics msr pair
> > reset nonsense. Becuase that really stinks.
> 
> You have to write them to reset the internal counters.

But not for ever read, only on METRIC_OVF.
