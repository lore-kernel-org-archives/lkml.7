Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBBF21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ItMpVIhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfCOQDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:03:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbfCOQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LP5lkZWTVO+rvnbJey1IhFmQSFwQJIYDWBEIykBrz2s=; b=ItMpVIhnGwEZCIHFesJlaW7BG
        Ti/VzzErV3K9pcwOVumrFzQoEM1/wz2E/mpZK3TTa3J2JBKO0GHYhVMyJPseXRJQgJop8PRDjN2Ww
        +Ri6YhGDA/NcIiKnyR7/ltWS2oHrfuxLgzEfIpxk/Qj8QHwCz3N4GmmLoaAXZPEOD7TrJDXj5yoV7
        m1KwtUbf696tSuphRpPJs6Vtp+fu7kol61hd/IRtQmPUEBOUkN039Zk+D7ZZYg0q0/TaGFkTZ1plL
        7qcjRZ74QBkXndY3jqAwCdaEWNunHEtIjxox7nqwVTOxXhZzfYLVPo5rtIQbyCIrV2DWcVBdj/Hzd
        BP+W/hZtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4pJE-0003kl-NY; Fri, 15 Mar 2019 16:03:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 223C521422948; Fri, 15 Mar 2019 17:03:47 +0100 (CET)
Date:   Fri, 15 Mar 2019 17:03:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/fair: Limit sched_cfs_period_timer loop to avoid
 hard lockup
Message-ID: <20190315160347.GZ5996@hirez.programming.kicks-ass.net>
References: <20190313150826.16862-1-pauld@redhat.com>
 <20190315101150.GV5996@hirez.programming.kicks-ass.net>
 <20190315153042.GF27131@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315153042.GF27131@pauld.bos.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 11:30:42AM -0400, Phil Auld wrote:

> In my defense here, all the fair.c imbalance pct code also uses 100 :)

Yes, I know, I hate on that too ;-) Just never got around to fixing
that.


> with the below:
> 
> [  117.235804] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 2492, cfs_quota_us = 143554)
> [  117.346807] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 2862, cfs_quota_us = 164863)
> [  117.470569] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 3286, cfs_quota_us = 189335)
> [  117.574883] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 3774, cfs_quota_us = 217439)
> [  117.652907] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 4335, cfs_quota_us = 249716)
> [  118.090535] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 4978, cfs_quota_us = 286783)
> [  122.098009] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 5717, cfs_quota_us = 329352)
> [  126.255209] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 6566, cfs_quota_us = 378240)
> [  126.358060] cfs_period_timer[cpu2]: period too short, scaling up (new cfs_period_us 7540, cfs_quota_us = 434385)
> [  126.538358] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 8660, cfs_quota_us = 498865)
> [  126.614304] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 9945, cfs_quota_us = 572915)
> [  126.817085] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 11422, cfs_quota_us = 657957)
> [  127.352038] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 13117, cfs_quota_us = 755623)
> [  127.598043] cfs_period_timer[cpu9]: period too short, scaling up (new cfs_period_us 15064, cfs_quota_us = 867785)
> 
> 
> Plus on repeats I see an occasional 
> 
> [  152.803384] sched_cfs_period_timer: 9 callbacks suppressed

That should be fine, right? It's a fallback for an edge case and
shouldn't trigger too often anyway.

>> I'll rework the maths in the averaged version and post v2 if that makes sense.
> 
> It may have the extra timer fetch, although maybe I could rework it so that it used the 
> nsstart time the first time and did not need to do it twice in a row. I had originally
> reverted the hrtimer_forward_now() to hrtimer_forward() but put that back. 

Sure; but remember, simpler is often better, esp. for code that
typically 'never' runs.

> Also, fwiw, this was reported earlier by Anton Blanchard in https://lkml.org/lkml/2018/12/3/1047

Bah, yes, I sometimes loose track of things :/
