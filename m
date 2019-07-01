Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FE3C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C652D20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pqY6wwU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfGAO2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:28:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbfGAO2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GHy9NNL+Jyn04kPe2U7CYxuWzsTauyoNHj5eiS4iDjM=; b=pqY6wwU7P3apWzU++XDnr2uPD
        GP0P5RrXH9xF5ES0mWn4AzjcT/uR4EmNgbh87M9006f3nOs+rWaoyR3uZq8LVbsmFNkKwhbZ/x7fb
        83FENh1PRfHDvQE1w07XVV5O/fOeDiThddmDSO1vJUF6exJmQRczufIMEz5yHuNUp6q/e2TVwIOcG
        BUvSRRLqeRfRNvTT7TnGTco5ywXYPQhOL5f2KNE0ByJ9+4k4TB0iEWsm8dVNn5OYRKh22FPUdzAsQ
        8IS0M9p9ccuRsC0BvESskWnC410pSuftwc/PTnbszC8DE0w5yhyR4OBIX56EEoY8fwO8WQU75fNQN
        o6FmIhROw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhxHp-0007HG-Ik; Mon, 01 Jul 2019 14:28:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE38020A18920; Mon,  1 Jul 2019 16:28:03 +0200 (CEST)
Date:   Mon, 1 Jul 2019 16:28:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, will.deacon@arm.com
Subject: Re: [PATCH v2] perf: Fix exclusive events' grouping
Message-ID: <20190701142803.GA3402@hirez.programming.kicks-ass.net>
References: <20190701110755.24646-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701110755.24646-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 02:07:55PM +0300, Alexander Shishkin wrote:
> So far, we tried to disallow grouping exclusive events for the fear of
> complications they would cause with moving between contexts. Specifically,
> moving a software group to a hardware context would violate the exclusivity
> rules if both groups contain matching exclusive events.
> 
> This attempt was, however, unsuccessful: the check that we have in the
> perf_event_open() syscall is both wrong (looks at wrong PMU) and
> insufficient (group leader may still be exclusive), as can be illustrated
> by running
> 
> $ perf record -e '{intel_pt//,cycles}' uname
> $ perf record -e '{cycles,intel_pt//}' uname
> 
> ultimately successfully.
> 
> Furthermore, we are completely free to trigger the exclusivity violation
> by -e '{cycles,intel_pt//}' -e '{intel_pt//,instructions}', even though
> the helpful perf record will not allow that, the ABI will. The warning
> later in the perf_event_open() path will also not trigger, because it's
> also wrong.
> 
> Fix all this by validating the original group before moving, getting rid
> of broken safeguards and placing a useful one to perf_install_in_context().
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Fixes: bed5b25ad9c8a ("perf: Add a pmu capability for "exclusive" events")

Thanks!
