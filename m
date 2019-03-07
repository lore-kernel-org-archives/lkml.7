Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158ABC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA9920684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JL05PTTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCGLXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:23:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGLXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D49fxiZzzew1ACx7OtBrAb2Sx6NFo0CjwTFKUZSMwa8=; b=JL05PTTswcupxPD1bSmjGlflY
        llFVwsllc2TOy9hEYO/COZyfKMj2WIGdvy72E10cdLE/9Luw0pC5wcJeXgCFxS2BwvTNmkLo/89Mb
        dOaR27DRWcXzfbXZQBhBUyZXeFMigmEIk46aTo/g7DAk85Y5Gqm9r2AgjNfvicY9L/xdN8X//386e
        UFvGfZjjJoGnvW7nWwcLVQXfbhc3ahuLAqU/LMKva5rM8OIkv1z2VDkJ1HLPFjS8KMaoOOnOEAq2x
        TK9BQ23OO1oK+FGzY6HLFofurHax0u39am0WW41hnlF/1GL3/HLHMkfySVdP+yLVF5mtO2vqZNszu
        EELmyBQ7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1r7q-0008D3-HZ; Thu, 07 Mar 2019 11:23:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6323E2029B186; Thu,  7 Mar 2019 12:23:44 +0100 (CET)
Date:   Thu, 7 Mar 2019 12:23:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Message-ID: <20190307112344.GC32477@hirez.programming.kicks-ass.net>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan>
 <6357319.Iupbu3ldGQ@aspire.rjw.lan>
 <20190305114406.GV32494@hirez.programming.kicks-ass.net>
 <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
 <CAJZ5v0hYU763Jx0Ku0HsNMd261z7E0PhZ88_PH6MT=OLYYUAaQ@mail.gmail.com>
 <20190305173746.p32xolcpueudlzwn@queper01-lin>
 <CAJZ5v0jJxMw6_6Ep=fee8VGEbqpFKQtA2kX5t1scNwX3GhaTTg@mail.gmail.com>
 <20190307110256.padefvq4e52ly3nm@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307110256.padefvq4e52ly3nm@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:02:58AM +0000, Quentin Perret wrote:
> Also on recent big little SoCs, the capacity ratio can be pretty high.
> You can get little CPUs with 300 of capacity or so. The arbitrary 128
> thing is basically gonna go near max freq in one step, although the CPUs
> actually 20 available OPPs or so. And I guess that's a shame.

Ah, but remember; with the latest patch the iowait_boost is scaled on
max. So in order to hit that 300, you first have to hit 1024.

+       boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
+       return max(boost, util);

So iowait_boost goes from 128 to 1024 in 4 wakeups (the first sets 128,
the next 3 get it to 1024), but the effective value is, given @max ==
300:

  128 -> 37
  256 -> 75
  512 -> 150
 1024 -> 300

so irrespective of the number of OPPs and their spread, it takes 4
wakeups to get to max.
