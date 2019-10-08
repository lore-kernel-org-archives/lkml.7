Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2116C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B43420815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lqo7vuBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfJHQc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:32:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJHQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OhTk70pC2yeqZMH2DCqssp5aW9RjIdmRi6GGW14xL2o=; b=Lqo7vuBvpHV39cxpR+QIsnt+j
        ksqjOmU1URr2lht7+OewDVvHhNHcTnQMkNLYY6LW/Mib3x5yJggtduk1P+6rQ9RKIspXNa3uXDp1m
        KoJVKwtViZ8Y2X1kHtUrTsyzqwJNpc34sVXTZTDRLtZeQ/AAvsDZHxGy4gsvwDsgL3papYpuqGxni
        guPnlvl/gB+JcEoBzYjGmjwOULCtZqKm3AbUaJVSWava8bIT0gLwLCj+GRwQsZN6RIwZOlb1IFMck
        CpkeyWfpRZuMjTGq7jX0mvcgJ9b1k0Yky+/Pbrs8SuxCTrE9pmkIYccnPzm/R49GnDf3lBDkommYt
        Nn7O+l/cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHsPS-0000rl-7p; Tue, 08 Oct 2019 16:32:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5468030034F;
        Tue,  8 Oct 2019 18:31:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9579220247CA6; Tue,  8 Oct 2019 18:32:23 +0200 (CEST)
Date:   Tue, 8 Oct 2019 18:32:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com
Subject: Re: [PATCH 01/10] perf/core, x86: Add PERF_SAMPLE_LBR_TOS
Message-ID: <20191008163223.GE2328@hirez.programming.kicks-ass.net>
References: <20191007175910.2805-1-kan.liang@linux.intel.com>
 <20191007175910.2805-2-kan.liang@linux.intel.com>
 <20191008083141.GH2294@hirez.programming.kicks-ass.net>
 <3ac026c3-6b9c-a6c1-2c2b-c7ecdbb22b1d@linux.intel.com>
 <20191008143850.GB2328@hirez.programming.kicks-ass.net>
 <e481af49-8237-56bb-b9b5-2697a0962d37@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e481af49-8237-56bb-b9b5-2697a0962d37@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 11:25:01AM -0400, Liang, Kan wrote:
> > The perf tool bloody sets the perf_event_attr::branch_sample_type value!
> > Of course it knows to expect the TOS field when it asks for it in the
> > first place.
> > 
> 
> Users may generate the perf.data on one machine, and parse the data on
> another machine.
> If the perf.data is from a new kernel with a new perf tool on one machine,
> but users have an old perf tool on another machine to parse it. The old perf
> tool doesn't know the exists of TOS field.

Feh, the tool should check for unknown input bits in attr.

Anyway, the proposed API is horrendous crap, that's just not going to
happen.
